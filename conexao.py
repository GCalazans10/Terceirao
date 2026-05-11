import sqlite3

def executar_crud():
    # Conecta ao banco de dados (cria se não existir)
    conn = sqlite3.connect('foodflex.db')
    cursor = conn.cursor()

    # --- SETUP: Criando as tabelas ---
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Restaurantes (
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            NomeRestaurante TEXT,
            Endereco TEXT,
            TipoCulinaria TEXT,
            Aberto BOOLEAN
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Pedidos (
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            NomeCliente TEXT,
            ValorTotal REAL,
            DataPedido TEXT,
            Confirmado BOOLEAN
        )
    ''')

    # 1. CREATE (Inserir dados)
    print("--- Inserindo dados ---")
    restaurantes = [
        ('Bistrô Gourmet', 'Rua das Flores, 123', 'Francesa', True),
        ('Sushi House', 'Av. do Sol, 456', 'Japonesa', True),
        ('Pizza World', 'Av. Central, 789', 'Italiana', False)
    ]
    cursor.executemany('INSERT INTO Restaurantes (NomeRestaurante, Endereco, TipoCulinaria, Aberto) VALUES (?, ?, ?, ?)', restaurantes)

    pedidos = [
        ('João Silva', 75.50, '2024-09-27', True),
        ('Maria Oliveira', 120.00, '2024-09-28', False)
    ]
    cursor.executemany('INSERT INTO Pedidos (NomeCliente, ValorTotal, DataPedido, Confirmado) VALUES (?, ?, ?, ?)', pedidos)
    conn.commit()

    # 2. READ (Consultar dados)
    print("\n--- Consultando dados iniciais ---")
    print("Restaurantes:", cursor.execute('SELECT * FROM Restaurantes').fetchall())
    print("Pedidos:", cursor.execute('SELECT * FROM Pedidos').fetchall())

    # 3. UPDATE (Atualizar dados)
    print("\n--- Atualizando dados ---")
    cursor.execute("UPDATE Restaurantes SET Aberto = ? WHERE NomeRestaurante = ?", (True, 'Pizza World'))
    cursor.execute("UPDATE Pedidos SET Confirmado = ? WHERE NomeCliente = ?", (True, 'Maria Oliveira'))
    conn.commit()

    # 4. DELETE (Excluir dados)
    print("\n--- Excluindo dados ---")
    cursor.execute("DELETE FROM Restaurantes WHERE NomeRestaurante = ?", ('Sushi House',))
    cursor.execute("DELETE FROM Pedidos WHERE NomeCliente = ?", ('João Silva',))
    conn.commit()

    # Consulta final para verificar resultados
    print("\n--- Resultado Final após CRUD ---")
    print("Restaurantes restantes:", cursor.execute('SELECT * FROM Restaurantes').fetchall())
    print("Pedidos restantes:", cursor.execute('SELECT * FROM Pedidos').fetchall())

    conn.close()

if __name__ == "__main__":
    executar_crud()
