from flask import Flask, render_template, request, redirect, session, flash
import mysql.connector
import bcrypt

app = Flask(__name__)
app.secret_key = "minha_chave_secreta"

def get_db():
    return mysql.connector.connect(
        host="localhost", user="root", password="", database="sistema_usuarios"
    )

# --- ROTAS DE USUÁRIO ---
@app.route('/')
def index(): return redirect('/login')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email, senha = request.form['email'], request.form['senha']
        db = get_db(); cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM usuarios WHERE email = %s", (email,))
        user = cursor.fetchone()
        if user and bcrypt.checkpw(senha.encode('utf-8'), user['senha_hash'].encode('utf-8')):
            session['usuario_id'], session['nome'] = user['id'], user['nome']
            return redirect('/dashboard')
        flash("Dados inválidos!")
    return render_template('login.html')

# --- CRUD LIVROS & AUTORES ---
@app.route('/dashboard')
def dashboard():
    if 'usuario_id' not in session: return redirect('/login')
    db = get_db(); cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT l.id, l.titulo, a.nome as autor, l.status FROM livros l JOIN autores a ON l.id_autor = a.id")
    livros = cursor.fetchall()
    cursor.execute("SELECT * FROM autores"); autores = cursor.fetchall()
    return render_template('dashboard.html', livros=livros, autores=autores)

@app.route('/cadastrar_livro', methods=['POST'])
def cadastrar_livro():
    db = get_db(); cursor = db.cursor()
    cursor.execute("INSERT INTO livros (titulo, id_autor) VALUES (%s, %s)", (request.form['titulo'], request.form['id_autor']))
    db.commit(); return redirect('/dashboard')

@app.route('/autores', methods=['GET', 'POST'])
def gerenciar_autores():
    db = get_db(); cursor = db.cursor(dictionary=True)
    if request.method == 'POST':
        cursor.execute("INSERT INTO autores (nome) VALUES (%s)", (request.form['nome_autor'],))
        db.commit(); return redirect('/autores')
    cursor.execute("SELECT * FROM autores"); autores = cursor.fetchall()
    return render_template('autores.html', autores=autores)

@app.route('/logout')
def logout(): session.clear(); return redirect('/login')

if __name__ == '__main__':
    app.run(debug=True)
