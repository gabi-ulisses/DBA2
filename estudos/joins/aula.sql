-- Análise uso de JOIN

-- Na conexão system
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER aula identified by aula;
GRANT ALL PRIVILEGES TO aula;

---------------------------------------------------------------------

CREATE TABLE Curso(
    id_curso INT PRIMARY KEY,
    nome VARCHAR(10)
);

CREATE TABLE Aluno(
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(10),
    id_curso INT,
    FOREIGN KEY(id_curso) REFERENCES Curso(id_curso)
);

---------------------------------------------------------------------

INSERT INTO Curso(id_curso, nome) 
    VALUES  (100, 'MySQL');
    
INSERT INTO Curso(id_curso, nome) 
    VALUES  (200, 'Oracle');

INSERT INTO Aluno(id_aluno, nome, id_curso) 
    VALUES  (1, 'Ana', 100);
    
INSERT INTO Aluno(id_aluno, nome, id_curso) 
    VALUES  (2, 'Bia', 100);
    
INSERT INTO Aluno(id_aluno, nome, id_curso) 
    VALUES  (3, 'Carla', NULL);
    
    
-----------------------------------------------------------------------------


SELECT * FROM Aluno;

SELECT a.nome, c.nome
FROM Aluno a,Curso c
WHERE a.id_curso = c.id_curso;

SELECT a.nome, c.nome
FROM Aluno a
INNER JOIN Curso c ON a.id_curso = c.id_curso;

SELECT a.nome, c.nome
FROM Aluno a
LEFT OUTER JOIN Curso c ON a.id_curso = c.id_curso;