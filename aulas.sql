CREATE DATABASE aula5;
USE aula5;

CREATE TABLE Curso ( 
	cod_curso INTEGER PRIMARY KEY AUTO_INCREMENT,
    tot_cred INTEGER,
    nome_curso VARCHAR (60) NOT NULL,
    cod_coord INTEGER NOT NULL
)AUTO_INCREMENT = 0;

DESC Curso;

CREATE TABLE Aluno ( 
	mat_aluno INTEGER PRIMARY KEY AUTO_INCREMENT,
    cod_curso INTEGER,
    dat_nasc DATE NOT NULL, 
    tot_cred INTEGER NOT NULL,
    mgp DOUBLE NOT NULL,
    nom_alun VARCHAR (60) NOT NULL, 
    email VARCHAR (30),
    
    CONSTRAINT fk_cod_curso FOREIGN KEY (cod_curso) REFERENCES Curso (cod_curso)
);
DESC Aluno;

INSERT INTO Curso (tot_cred, nome_curso, cod_coord) 
VALUES
(200, "Egenharia da Computacao", 1),
(320, "Egenharia Eletrica", 1),
(300, "Ciencia da Computacao", 1),
(150, "Sistema de Informacao", 2),
(140, "Egenharia Civil", 3);

INSERT INTO Aluno (cod_curso, dat_nasc, tot_cred, mgp, nom_alun, email) 
VALUES
(2, '2000-10-5', 60, 8.75, 'Diogo Rodrigues', 'diogo@gmail.com'),
(3, '2001-10-5', 60, 8.75, 'Andrea', 'andrea@gmail.com'),
(Null, '2001-10-5', 60, 8.75, 'Pedro', 'Pedro@gmail.com'),
(Null, '2001-10-5', 60, 8.75, 'Alexandre', 'alexandre@gmail.com')
;
Select * from Aluno;
/*1  Construa um SELECT que mostre todos os alunos e o respectivo nome do curso no  qual ele está matriculado.
*/
SELECT nom_alun, nome_curso FROM Aluno LEFT JOIN Curso
 ON (Aluno.cod_curso = Curso.cod_curso);
 
/*CRIANDO UM PROCEDURE*/
CREATE PROCEDURE consultarNome (codNome SMALLINT)
SELECT CONCAT('O nome do aluno é ', nom_alun) AS Nome
FROM aluno 
WHERE mat_aluno = codNome;
/*EXCLUINDO UM PROCEDURE*/
drop procedure consultarNome;
/*RODANDO O PROCEDURE*/
CALL consultarNome(2);

/*CRIANDO UMA FUNÇÃO*/
CREATE FUNCTION fn_teste(a DECIMAL(10,2), b INT) RETURNS INT
RETURN a*b;
/*RODANDO A FUNÇÃO*/
SELECT fn_teste(3,4) AS Result;

/*PROCEDURE BEGIN END*/
DELIMITER $$
CREATE PROCEDURE verEmail(codAluno SMALLINT)
BEGIN 
	SELECT CONCAT('O e-mail do aluno é ', email) AS Email
    FROM aluno 
    WHERE mat_aluno = codAluno;
    SELECT 'PROCEDURE executado com sucesso!';
END$$
DELIMITER ;
/*RODANDO O BLOCO BEGIN E END*/
CALL verEmail(1);

/*CRIANDO UM PROCEDURE*/
DELIMITER //
CREATE PROCEDURE alunoCurso(IN codAluno SMALLINT)
BEGIN
	SELECT A.nom_alun, C.nome_curso
    FROM aluno AS A
    INNER JOIN curso AS C
    ON A.cod_curso = C.cod_curso
    WHERE A.mat_aluno = codAluno;
END//
DELIMITER ;
/*RODANDO O PROCEDURE*/
CALL alunoCurso(1);


/*CRIANDO PROCEDURE TESTE_OUT*/
DELIMITER %% 
CREATE PROCEDURE teste_out(IN id INT, OUT cursoRef VARCHAR(30))
BEGIN
	SELECT nome_curso
    INTO cursoRef
    FROM curso
    WHERE cod_curso = id;
END%%
DELIMITER ;
/*CHAMANDO A PROCEDURE*/
CALL teste_out(3, @cursoR);
/*CHAMANDO A VARIÁVEL*/
SELECT @cursoR;