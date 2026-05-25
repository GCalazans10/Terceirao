BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS aluno (
    id_aluno INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    id_serie INTEGER,
    FOREIGN KEY (id_serie) REFERENCES serie(id_serie) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS materia (
    id_materia INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_materia VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS nota (
    id_nota INTEGER PRIMARY KEY AUTOINCREMENT,
    id_aluno INTEGER NOT NULL,
    id_materia INTEGER NOT NULL,
    nota_b1 REAL CHECK(nota_b1 >= 0 AND nota_b1 <= 10),
    nota_b2 REAL CHECK(nota_b2 >= 0 AND nota_b2 <= 10),
    nota_b3 REAL CHECK(nota_b3 >= 0 AND nota_b3 <= 10),
    nota_b4 REAL CHECK(nota_b4 >= 0 AND nota_b4 <= 10),
    -- Média calculada dinamicamente baseada nos bimestres preenchidos
    media_final REAL GENERATED ALWAYS AS (
        (COALESCE(nota_b1, 0) + COALESCE(nota_b2, 0) + COALESCE(nota_b3, 0) + COALESCE(nota_b4, 0)) / 
        ((CASE WHEN nota_b1 IS NOT NULL THEN 1 ELSE 0 END) +
         (CASE WHEN nota_b2 IS NOT NULL THEN 1 ELSE 0 END) +
         (CASE WHEN nota_b3 IS NOT NULL THEN 1 ELSE 0 END) +
         (CASE WHEN nota_b4 IS NOT NULL THEN 1 ELSE 0 END))
    ) STORED,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE,
    FOREIGN KEY (id_materia) REFERENCES materia(id_materia) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS professor (
    id_professor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    id_materia INTEGER,
    FOREIGN KEY (id_materia) REFERENCES materia(id_materia) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS serie (
    id_serie INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_serie VARCHAR(50) NOT NULL,
    turno VARCHAR(20) NOT NULL
);
INSERT INTO "aluno" ("id_aluno","nome","data_nascimento","id_serie") VALUES (1,'Lucas Alencar','2015-03-12',1),
 (2,'Beatriz Nunes','2015-07-22',1),
 (3,'Gabriel Costa','2015-01-05',1),
 (4,'Mariana Reis','2015-11-30',1),
 (5,'Rafael Souza','2015-05-14',1),
 (6,'Larissa Melo','2015-09-18',1),
 (7,'Gustavo Lima','2015-02-25',1),
 (8,'Amanda Dias','2015-08-08',1),
 (9,'Pedro Rocha','2015-04-20',1),
 (10,'Sofia Martins','2015-10-02',1),
 (11,'Thiago Silva','2015-06-11',2),
 (12,'Camila Pires','2015-12-01',2),
 (13,'Bruno Alves','2015-03-19',2),
 (14,'Isabela Fontes','2015-05-27',2),
 (15,'Matheus Cruz','2015-08-14',2),
 (16,'Manuela Ramos','2015-02-10',2),
 (17,'Daniel Gomes','2015-07-04',2),
 (18,'Giovanna Lima','2015-09-22',2),
 (19,'Leonardo Mota','2015-01-15',2),
 (20,'Elena Castro','2015-10-31',2);
INSERT INTO "materia" ("id_materia","nome_materia") VALUES (1,'Matemática'),
 (2,'Português'),
 (3,'História'),
 (4,'Geografia'),
 (5,'Biologia'),
 (6,'Física'),
 (7,'Química'),
 (8,'Inglês'),
 (9,'Educação Física');
INSERT INTO "nota" ("id_nota","id_aluno","id_materia","nota_b1","nota_b2","nota_b3","nota_b4","media_final") VALUES (1,1,1,7.5,8.0,6.5,9.0,7.75),
 (2,1,2,8.0,7.0,8.5,8.0,7.875),
 (3,2,1,5.5,6.0,4.5,7.0,5.75),
 (4,2,2,9.0,9.5,10.0,9.0,9.375);
INSERT INTO "professor" ("id_professor","nome","email","id_materia") VALUES (1,'Carlos Silva','carlos.mat@escola.com',1),
 (2,'Ana Souza','ana.port@escola.com',2),
 (3,'Marcos Lima','marcos.hist@escola.com',3),
 (4,'Julia Costa','julia.bio@escola.com',5);
INSERT INTO "serie" ("id_serie","nome_serie","turno") VALUES (1,'6º Ano A','Manhã'),
 (2,'6º Ano B','Manhã'),
 (3,'6º Ano C','Tarde'),
 (4,'6º Ano D','Tarde'),
 (5,'7º Ano A','Manhã'),
 (6,'7º Ano B','Manhã'),
 (7,'7º Ano C','Tarde'),
 (8,'7º Ano D','Tarde'),
 (9,'8º Ano A','Manhã'),
 (10,'8º Ano B','Manhã'),
 (11,'8º Ano C','Tarde'),
 (12,'8º Ano D','Tarde'),
 (13,'9º Ano A','Manhã'),
 (14,'9º Ano B','Manhã'),
 (15,'9º Ano C','Tarde'),
 (16,'9º Ano D','Tarde'),
 (17,'1º Ano E.M. A','Manhã'),
 (18,'1º Ano E.M. B','Tarde'),
 (19,'2º Ano E.M. A','Manhã'),
 (20,'2º Ano E.M. B','Tarde'),
 (21,'3º Ano E.M. A','Manhã'),
 (22,'3º Ano E.M. B','Tarde');
COMMIT;
