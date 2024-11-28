-- Trabalho de IBD
-- Integrantes: 
-- Gabriel Coelho Soares
-- Marcos Moreira Martins 

-- Exercicio 1: Criar o banco com as tabelas propostas;

CREATE DATABASE faculdade;

USE faculdade;

CREATE TABLE alunos
(
  ra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  cidade VARCHAR(40)
);

CREATE TABLE professor
(
  codigoprofessor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  cidade VARCHAR(40)
);

CREATE TABLE disciplina
(
  codigodisciplina INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  disciplina VARCHAR(100),
  cargahoraria FLOAT
);

CREATE TABLE historico
(
  codigohistorico INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ra INT,
  CONSTRAINT fk_hist_aluno FOREIGN KEY (ra)
    REFERENCES alunos(ra),
  codigodisciplina INT,
  CONSTRAINT fk_hist_disc FOREIGN KEY (codigodisciplina)
    REFERENCES disciplina(codigodisciplina),
  codigoprofessor INT,
  CONSTRAINT fk_hist_prof FOREIGN KEY (codigoprofessor)
    REFERENCES professor(codigoprofessor),
  semestre INT,
  faltas INT,
  nota FLOAT
);

-- 02 Inserir informações em todas as tabelas (10 alunos, 4 disciplinas - Banco de dados, Sistemas Operacionais, Rede de Computadores e Estrutura de dados, 3professores e 15 históricos)

INSERT INTO alunos(nome,cidade) VALUES 
('Gabriel', 'Mogi Guaçu'),
('Marcos' , 'Mogi Guaçu'),
('Adryelle','Mogi Mirim'),
('Brenda' , 'Mogi Mirim'),
('Tabata' , 'Mogi Guaçu'),
('Renan' , 'Mogi Guaçu'),
('Thaito', 'Mogi Guaçu'),
('Fernando', 'Mogi Mirim'),
('Luis', 'Jaguariuna'),
('Ian', 'Estiva');

INSERT INTO disciplina(disciplina,cargahoraria) VALUES
('Banco de Dados',80),
('Sistemas Operacionais',80),
('Redes de Computadores', 40),
('Estrutura de Dados' , 80);

INSERT INTO professor(nome, cidade) VALUES
('Maromo', 'Mogi Mirim'),
('Sandro', 'Mogi Mirim'),
('Ana Célia', 'Mogi Mirim');

INSERT INTO historico(ra, codigodisciplina, codigoprofessor, semestre, faltas, nota) VALUES 
(1, 1, 2, 3, 4, 10),
(1, 2, 2, 3, 8, 10),
(1, 3, 1, 3, 12, 8.5),
(1, 4, 3, 3, 20, 7.8),
(2, 1, 2, 3, 4, 8.5),
(2, 2, 2, 3, 4, 9),
(2, 3, 2, 3, 4, 9.5),
(2, 2, 2, 1, 5, 2.5), 
(4, 2, 1, 3, 4, 6.5), 
(5, 3, 2, 3, 3, 10.0),
(6, 3, 3, 3, 3, 9.0), 
(7, 4, 1, 3, 5, 8.5),
(8, 4, 2, 3, 2, 7.0),
(4, 3, 1, 3, 4, 6.5),
(9, 1, 3, 3, 4, 6.5);


--03 Encontre o nome e RA dos alunos com nota na disciplina de Banco de Dados no 2º semestre menor que 5.

SELECT A.ra as RA, A.nome as 'Nome Aluno' 
FROM alunos A, historico H, disciplina D
WHERE A.ra = H.ra 
AND H.codigodisciplina = D.codigodisciplina
AND D.disciplina = 'Banco de Dados'
AND H.semestre = 2
AND H.nota < 5;


-- 04 Alterar a tabela histórico e incluir um campo inteiro chamado ano, com o objetivo de armazenar o ano e semestre do registro de histórico dos alunos.
ALTER TABLE historico 
ADD ano INT;

UPDATE historico 
SET ano = CASE
WHEN semestre = 2 THEN 2024
WHEN semestre = 3 THEN 2023
WHEN semestre = 1 THEN 2024
END
WHERE semestre IN (2, 3, 1);


-- 05 Alterar a tabela de histórico definindo o ano para cada um dos registros de histórico da tabela.

UPDATE historico 
SET ano = CASE
WHEN codigohistorico = 1 THEN 2009
WHEN codigohistorico = 2 THEN 2010
WHEN codigohistorico = 3 THEN 2011
WHEN codigohistorico = 4 THEN 2009
WHEN codigohistorico = 5 THEN 2012
WHEN codigohistorico = 6 THEN 2013
WHEN codigohistorico = 7 THEN 2004
WHEN codigohistorico = 8 THEN 2015
WHEN codigohistorico = 9 THEN 2016
WHEN codigohistorico = 10 THEN 2017
WHEN codigohistorico = 11 THEN 2018
WHEN codigohistorico = 12 THEN 2019
WHEN codigohistorico = 13 THEN 2020
WHEN codigohistorico = 14 THEN 2021
WHEN codigohistorico = 15 THEN 2022
END
WHERE codigohistorico IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);


-- 06 Apresente o nome dos professores de banco de dados que ministraram aulas em 2020 

SELECT DISTINCT P.nome 
FROM professor P
JOIN historico H ON P.codigoprofessor = H.codigoprofessor
JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
WHERE D.disciplina = 'Banco de Dados' AND H.ano = 2020;

-- 07 Apresente a quantidae e nomes das disciplinas que cada professor ministrou em 2020

SELECT P.nome AS 'Nome do Professor',
COUNT(DISTINCT (D.disciplina)) AS 'Quantidade Ministrada'
FROM professor P
JOIN historico H on P.codigoprofessor = H.codigoprofessor
JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
WHERE H.ano = 2020
GROUP BY P.nome;


-- 08 Encontre o nome, cidade dos alunos, código das disciplinas e nome da disciplina onde os alunos tiveram nota menor que 5 no 1º semestre de 2020.
SELECT 
A.nome as 'Nome do Aluno', 
A.cidade as 'Cidade',
D.codigodisciplina as 'Codigo da Disciplina',
D.disciplina as 'Disciplina'
FROM alunos A
INNER JOIN historico H on A.ra = H.ra
INNER JOIN disciplina D on H.codigodisciplina = D.codigodisciplina
WHERE H.nota < 5;


-- 09 Apresente o nome e RA dos alunos que frequentaram a disciplina de Estrutura de Dados com o professor Marcos em 2019.

SELECT
A.nome as 'Nome do Aluno',
A.ra as 'R.A.'
FROM alunos A
INNER JOIN historico H ON A.ra = H.ra
INNER JOIN disciplina D on H.codigodisciplina = D.codigodisciplina
INNER JOIN professor P on H.codigoprofessor = P.codigoprofessor
WHERE D.disciplina = 'Estrutura de Dados' AND P.nome = 'Marcos' AND H.ano = 2019;


-- 10 Apresentar o histórico escolar do aluno Alex com informações do seu RA, nome, disciplinas, faltas, nota, ano e semestre.

SELECT
A.ra as 'R.A.',
A.nome as 'Nome do Aluno',
D.disciplina as 'Disciplina',
H.faltas as 'Faltas',
H.nota as 'Nota',
H.ano as 'Ano Letivo',
H.semestre as 'Semestre'
FROM alunos A
INNER JOIN historico H on A.ra = H.ra
INNER JOIN disciplina D on H.codigodisciplina = D.codigodisciplina
WHERE A.nome = 'Alex';


-- 11 Encontre o nome dos professores que reside em Mogi Mirim.
SELECT nome AS 'Nome do Professor'
FROM professor
WHERE cidade = 'Mogi Mirim';


-- 12 Forneça o nome dos alunos e nome das disciplinas com carga horária menor que 60 horas.

SELECT A.nome as 'Nome do Aluno',
D.disciplina as 'Disciplina',
P.nome as 'Nome Professor'
FROM alunos A
INNER JOIN historico H on A.ra = H.ra
INNER JOIN disciplina D on H.codigodisciplina = D.codigodisciplina
INNER JOIN professor P ON H.codigoprofessor = P.codigoprofessor
WHERE D.cargahoraria < 60;


-- 13 Localize o nome dos professores que lecionam matérias ao aluno "Pedro Paulo Cunha" que foi reprovado com nota inferior a 5

SELECT DISTINCT P.nome
FROM historico H
INNER JOIN alunos A ON H.ra = A.ra
INNER JOIN professor P ON H.codigoprofessor = P.codigoprofessor
WHERE H.nota < 5 AND A.nome = 'Pedro Paulo Cunha';

-- 14 Apresente o RA e nome dos alunos que frequentam disciplinas do professor Sandro

SELECT A.nome as 'Nome do Aluno', 
A.ra as 'R.A.'
FROM alunos A
INNER JOIN historico H ON A.ra = H.ra
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
INNER JOIN professor P ON H.codigoprofessor = P.codigoprofessor
WHERE P.nome = 'Sandro'
GROUP BY A.nome;

-- 15 Encontre o RA, Nome e Média das notas dos alunos que cursaram as materias de professores de Mogi Mirim

SELECT A.nome as 'Nome do Aluno',
A.ra as 'R.A.',
AVG(H.nota) as 'Media'
FROM alunos A
INNER JOIN historico H ON A.ra = H.ra
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
INNER JOIN professor P ON H.codigoprofessor = P.codigoprofessor
WHERE P.cidade = 'Mogi Mirim'
GROUP BY A.nome;

-- 16 Apresente o número de alunos que fizeram banco de dados e estrutura de dados em 2020 no primeiro semestre. 

SELECT COUNT(DISTINCT A.ra) as 'Quantidade de alunos que cursaram IBD e IED no primeiro Semestre de 2020' 
FROM alunos A
INNER JOIN historico H ON A.ra = H.ra
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
WHERE D.disciplina = 'Banco de Dados' 
AND D.disciplina = 'Banco de Dados' 
AND H.ano = 2020 AND H.semestre = 1;

-- 17 Apresente a média de notas por disciplina. Ordenar por média decrescente 

SELECT D.disciplina as 'Disciplina',
AVG(H.nota) as Média
FROM historico H
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
GROUP BY D.disciplina
ORDER BY H.nota DESC;

-- 18 Apresente nome do aluno, cidade, código da disciplina e nome da disciplina que os alunos tiveram nota superior a 5 no 1º semestre de 2020. ORdenar por nome da disciplina. 

SELECT 
A.nome as 'Nome do Aluno',
A.cidade as 'Cidade',
D.codigodisciplina as 'Código da Disciplina',
D.disciplina as 'Disciplina cuja nota foi maior que 5 no 1º semestre de 2020'
FROM historico H
INNER JOIN alunos A ON H.ra = A.ra 
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
WHERE H.semestre = 1 AND H.ano = 2020 AND H.nota > 5 
GROUP BY A.nome 
ORDER BY D.disciplina ASC;

-- 19 Apresentar o Historico escolar do aluno Alex, contendo seu RA, nome, lista de disciplinas que já cursou contendo codigo e nome da disciplina, faltas, nota, ano e semestre. 

SELECT 
A.nome as 'Nome do Aluno', A.ra as 'R.A.',
D.disciplina as 'Disciplina', D.codigodisciplina as 'Código da Disciplina',
H.semestre as 'Cursada no semestre:', H.ano as 'no Ano:', H.faltas as 'Faltando ... Dias', 
H.nota as 'Nota Final:' 
FROM historico H 
INNER JOIN alunos A ON H.ra = A.ra 
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
WHERE A.nome = 'Alex'
ORDER BY H.ano DESC;

-- 20 Apresente a quantidade que o aluno José da Silva cursou Banco de Dados 

SELECT 
A.nome as 'Nome do Aluno',
D.disciplina as 'Disciplina',
COUNT(H.codigodisciplina) as 'Vezes que cursou'
FROM historico H 
INNER JOIN alunos A ON H.ra = A.ra 
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
WHERE A.nome = 'José da Silva' AND D.disciplina = 'Banco de Dados';

-- 21 Apresentar a quantidade de alunos que cursou a disciplina de banco de dados em 2019 e 2020. 

SELECT 
COUNT(DISTINCT A.ra) as 'Quantidade de aluno que cursou Banco de Dados'
FROM historico H 
INNER JOIN alunos A ON H.ra = A.ra 
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
WHERE D.disciplina = 'Banco de Dados' AND (H.ano = 2019 OR H.ano = 2020);

-- 22 Insira todos os alunos da disciplina de BD em 2019 e que tiveram nota > 5, cursando uma disciplina de TBD (Tópicos em Banco de Dados) em 2018 com o mesmo professor mas frequencia e notas desconhecidas. 

INSERT INTO disciplina(disciplina, cargahoraria) VALUES 
(
  'Tópicos em Banco de Dados', 80
);

INSERT INTO historico(ra, codigodisciplina, codigoprofessor, semestre, ano) VALUES 
SELECT A.ra, D.codigodisciplina, P.codigoprofessor, 1, 2018 
FROM historico H
INNER JOIN alunos A ON H.ra = A.ra
INNER JOIN disciplina D ON H.codigodisciplina = D.codigodisciplina
INNER JOIN professor P ON H.codigoprofessor = P.codigoprofessor
WHERE D.disciplina = 'Banco de Dados' AND H.ano = 2019 AND H.nota > 5; 
