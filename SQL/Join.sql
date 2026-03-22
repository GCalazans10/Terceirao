SELECT Livros.titulo, Autores.nome AS nome_autor, Livros.preco
FROM Livros
INNER JOIN Autores ON Livros.id_autor = Autores.id_autor;
