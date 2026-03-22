CREATE VIEW v_relatorio_livros AS
SELECT L.titulo, A.nome, L.preco
FROM Livros L
JOIN Autores A ON L.id_autor = A.id_autor;

-- Agora, para consultar, basta fazer:
SELECT * FROM v_relatorio_livros WHERE preco > 40;
