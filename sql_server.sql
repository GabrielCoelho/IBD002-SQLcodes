-- Exercicio 1: 
CREATE DATABASE faculdade;

USE faculdade;

CREATE TABLE ALUNOS (
  RA INT IDENTITY PRIMARY KEY,
  NOME VARCHAR(100),
  CIDADE VARCHAR(40)
);

CREATE TABLE DISCIPLINAS (
  codigodisciplina INT IDENTITY NOT NULL PRIMARY KEY,
  nome VARCHAR(100),
  carga_horaria INT
);

CREATE TABLE PROFESSORES (
  codigoprofessor INT IDENTITY PRIMARY KEY,
  nome VARCHAR(100),
  cidade VARCHAR(40)
);

CREATE TABLE HISTORICO (
  codigohistorico INT IDENTITY PRIMARY KEY,
  ra INT,
  codigodisciplina INT,
  codigoprofessor INT,
  semestre INT,
  faltas INT,
  nota FLOAT,
  FOREIGN KEY (ra) REFERENCES ALUNOS (RA),
  FOREIGN KEY (codigodisciplina) REFERENCES DISCIPLINAS (codigodisciplina),
  FOREIGN KEY (codigoprofessor) REFERENCES PROFESSORES (codigoprofessor)
);

-- Exercicio 2: 
INSERT INTO
  ALUNOS (NOME, CIDADE)
VALUES
  ('João Silva', 'São Paulo'),
  ('Maria Oliveira', 'Campinas'),
  ('Pedro Santos', 'Rio de Janeiro'),
  ('Ana Costa', 'Curitiba'),
  ('Lucas Almeida', 'São Paulo'),
  ('José da Silva', 'Campinas'),
  ('Carlos Lima', 'Fortaleza'),
  ('Bianca Pereira', 'Belo Horizonte'),
  ('Pedro Paulo Cunha', 'Salvador'),
  ('Alex', 'Porto Alegre');

SELECT
  *
FROM
  ALUNOS;

INSERT INTO
  PROFESSORES (nome, cidade)
VALUES
  ('Sandro Armelin', 'Mogi Mirim'),
  ('Marcos Nava', 'Mogi Mirim'),
  ('Ricardo Akira', 'Mogi Mirim');

SELECT
  *
FROM
  PROFESSORES;

INSERT INTO
  DISCIPLINAS (nome, carga_horaria)
VALUES
  ('Banco de Dados', 80),
  ('Sistemas Operacionais', 40),
  ('Redes de Computadores', 80),
  ('Estrutura de Dados', 40);

SELECT
  *
FROM
  DISCIPLINAS;

INSERT INTO
  HISTORICO (
    ra,
    codigodisciplina,
    codigoprofessor,
    semestre,
    faltas,
    nota
  )
VALUES
  (1, 1, 1, 1, 2, 7.5),
  (2, 2, 1, 2, 0, 8.0),
  (3, 3, 3, 1, 3, 6.0),
  (4, 4, 2, 2, 1, 5.5),
  (5, 1, 1, 1, 0, 9.0),
  (6, 2, 1, 1, 4, 4.0),
  (7, 3, 3, 2, 2, 7.0),
  (8, 4, 2, 1, 1, 6.5),
  (8, 1, 2, 1, 3, 2.5),
  (9, 1, 1, 2, 3, 1.5),
  (10, 2, 1, 1, 0, 5.0),
  (1, 3, 3, 2, 1, 7.0),
  (2, 4, 2, 1, 2, 6.0),
  (3, 1, 1, 2, 0, 9.5),
  (4, 2, 1, 1, 3, 4.5),
  (5, 3, 3, 2, 1, 5.5);

SELECT
  *
FROM
  HISTORICO;

-- Exercicio 3:
SELECT
  a.NOME,
  a.RA
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  d.nome = 'Banco de Dados'
  AND h.semestre = 2
  AND h.nota < 5;

-- Exercicio 4:
ALTER TABLE HISTORICO ADD ano INT;

-- Exercicio 5:
UPDATE HISTORICO
SET
  ano = 2019
WHERE
  codigohistorico <= 7;

UPDATE HISTORICO
SET
  ano = 2020
WHERE
  codigohistorico > 7;

select
  *
from
  historico;

-- Exercicio 6:
SELECT DISTINCT
  p.nome
FROM
  PROFESSORES p
  JOIN HISTORICO h ON p.codigoprofessor = h.codigoprofessor
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  d.nome = 'Banco de Dados'
  AND h.ano = 2020;

-- Exercicio 7:
SELECT
  p.nome AS nome_professor,
  COUNT(DISTINCT d.nome) AS quantidade_disciplinas
FROM
  PROFESSORES p
  JOIN HISTORICO h ON p.codigoprofessor = h.codigoprofessor
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  h.ano = 2020
GROUP BY
  p.nome;

-- Exercicio 8:
SELECT
  a.NOME AS nome_aluno,
  a.CIDADE AS cidade_aluno,
  d.codigodisciplina,
  d.nome AS nome_disciplina
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  h.nota < 5
  AND h.semestre = 1
  AND h.ano = 2020;

-- Exercicio 9:
SELECT
  a.NOME,
  a.RA
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
  JOIN PROFESSORES p ON h.codigoprofessor = p.codigoprofessor
WHERE
  d.nome = 'Estrutura de Dados'
  AND p.nome = 'Marcos Nava'
  AND h.ano = 2019;

-- Exercicio 10:
SELECT
  a.RA,
  a.NOME AS nome_aluno,
  d.nome AS nome_disciplina,
  h.faltas,
  h.nota,
  h.ano,
  h.semestre
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  a.NOME = 'Alex';

-- Exercicio 11:
SELECT
  nome
FROM
  PROFESSORES
WHERE
  cidade = 'Mogi Mirim';

-- Exercicio 12:
SELECT
  a.nome AS nome_aluno,
  d.nome AS nome_disciplina,
  p.nome AS nome_professor
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
  JOIN PROFESSORES p ON h.codigoprofessor = p.codigoprofessor
WHERE
  d.carga_horaria < 60;

-- Exercicio 13:
SELECT DISTINCT
  p.nome AS nome_professor
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
  JOIN PROFESSORES p ON h.codigoprofessor = p.codigoprofessor
WHERE
  a.NOME = 'Pedro Paulo Cunha'
  AND h.nota < 5;

-- Exercicio 14: 
SELECT
  a.NOME,
  a.RA
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN PROFESSORES p ON h.codigoprofessor = p.codigoprofessor
WHERE
  p.nome = 'Sandro Armelin';

-- Exercicio 15:
SELECT
  A.nome as 'Nome do Aluno',
  A.ra as 'R.A.',
  AVG(H.nota) as 'Media'
FROM
  alunos A
  INNER JOIN historico H ON A.ra = H.ra
  INNER JOIN disciplinas D ON H.codigodisciplina = D.codigodisciplina
  INNER JOIN professores P ON H.codigoprofessor = P.codigoprofessor
WHERE
  P.cidade = 'Mogi Mirim'
GROUP BY
  A.ra,
  A.nome;

-- Exercicio 16:
SELECT
  COUNT(DISTINCT h.ra) AS numero_de_alunos
FROM
  HISTORICO h
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  (
    d.nome = 'Banco de Dados'
    OR d.nome = 'Estrutura de Dados'
  )
  AND h.semestre = 1
  AND h.ano = 2020
GROUP BY
  h.ra
HAVING
  COUNT(DISTINCT d.codigodisciplina) = 2;

-- Exercicio 17:
SELECT
  d.nome AS nome_disciplina,
  AVG(h.nota) AS media_notas
FROM
  HISTORICO h
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
GROUP BY
  d.nome
ORDER BY
  media_notas DESC;

-- Exercicio 18:
SELECT
  a.NOME AS nome_aluno,
  a.CIDADE AS cidade_aluno,
  d.codigodisciplina,
  d.nome AS nome_disciplina
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  h.nota > 5
  AND h.semestre = 1
  AND h.ano = 2020
ORDER BY
  d.nome;

-- Exercicio 19:
SELECT
  a.RA,
  a.NOME AS nome_aluno,
  d.codigodisciplina,
  d.nome AS nome_disciplina,
  h.faltas,
  h.nota,
  h.ano,
  h.semestre
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.ra
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  a.NOME = 'Alex';

-- Exercicio 20: 
SELECT
  COUNT(*) AS 'vezes cursadas'
FROM
  HISTORICO h
  JOIN ALUNOS a ON h.ra = a.RA
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  a.NOME = 'José da Silva'
  AND d.nome = 'Banco de Dados';

-- Exercicio 21: 
SELECT
  h.ano,
  COUNT(DISTINCT h.ra) AS quantidade_alunos
FROM
  HISTORICO h
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina
WHERE
  d.nome = 'Banco de Dados'
  AND h.ano IN (2019, 2020)
GROUP BY
  h.ano
ORDER BY
  h.ano;

-- Exercicio 22:
INSERT INTO
  disciplinas (nome, carga_horaria)
VALUES
  ('Tópicos em Banco de Dados', 40);

INSERT INTO
  Historico (
    RA,
    codigodisciplina,
    codigoprofessor,
    semestre,
    faltas,
    nota,
    ano
  )
SELECT
  h.RA,
  5 AS CodDisciplina,
  h.codigoprofessor,
  1,
  NULL,
  NULL,
  2018
FROM
  Historico h
  JOIN Disciplinas d ON h.codigodisciplina = d.codigodisciplina
  JOIN Professores p ON h.codigoprofessor = p.codigoprofessor
WHERE
  d.Nome = 'Banco de Dados'
  AND h.Ano = 2019
  AND h.Nota > 5
  AND p.Nome = 'Sandro Armelin';

select
  *
from
  historico;

-- Exercicio 23:
UPDATE HISTORICO
SET
  nota = CASE
    WHEN nota BETWEEN 4.0 AND 5.0  THEN 4.0
    WHEN nota BETWEEN 5.0 AND 9.5  THEN nota + 0.5
    WHEN nota > 9.5 THEN 10.0
    ELSE nota
  END
WHERE
  codigoprofessor = (
    SELECT
      codigoprofessor
    FROM
      PROFESSORES
    WHERE
      nome = 'Sandro Armelin'
  )
  AND Ano = 2019
  AND codigodisciplina = (
    SELECT
      codigodisciplina
    FROM
      DISCIPLINAS
    WHERE
      nome = 'Banco de Dados'
  );

SELECT
  *
FROM
  HISTORICO
WHERE
  codigodisciplina = 1;

-- Exercicio 24: 
SELECT
  a.NOME,
  d.nome,
  h.faltas,
  h.nota,
  CASE
    WHEN h.nota >= 7 THEN 'Aprovado'
    ELSE 'Reprovado'
  END AS Situacao
FROM
  ALUNOS a
  JOIN HISTORICO h ON a.RA = h.RA
  JOIN DISCIPLINAS d ON h.codigodisciplina = d.codigodisciplina;

-- Exercicio 25
SELECT
  d.nome,
  AVG(h.nota) AS media_notas
FROM
  DISCIPLINAS d
  JOIN HISTORICO h ON d.codigodisciplina = h.codigodisciplina
WHERE
  h.nota < 5
GROUP BY
  d.nome;

-- Exercicio 26:
UPDATE HISTORICO
SET
  nota = nota + 0.5
WHERE
  codigodisciplina = (
    SELECT
      codigodisciplina
    FROM
      DISCIPLINAS
    WHERE
      nome = 'Banco de Dados'
  );

SELECT
  *
FROM
  HISTORICO
WHERE
  codigodisciplina = 1;

-- Exercicio 27:
CREATE TABLE Cidade (
  CidadeID INT IDENTITY PRIMARY KEY,
  CidadeNome VARCHAR(40) UNIQUE NOT NULL
);

INSERT INTO
  Cidade (CidadeNome)
SELECT DISTINCT
  Cidade
FROM
  Alunos
WHERE
  Cidade NOT IN (
    SELECT
      CidadeNome
    FROM
      Cidade
  );

ALTER TABLE Alunos ADD CidadeID INT;

UPDATE Alunos
SET
  CidadeID = (
    SELECT
      CidadeID
    FROM
      Cidade
    WHERE
      CidadeNome = Alunos.Cidade
  );

ALTER TABLE Alunos
DROP COLUMN Cidade;

select
  *
from
  alunos;
