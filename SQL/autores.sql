-- Tabela de Autores
CREATE TABLE Autores (
    id_autor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de Livros (com Chave Estrangeira)
CREATE TABLE Livros (
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(150),
    preco DECIMAL(10,2),
    id_autor INT,
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);
