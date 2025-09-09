
-- Banco de Dados Megasena
-- Avaliação diagnõstica | Gabrielle Ulisses

ALTER SESSION SET "_ORACLE_SCRIPT"=true;

CREATE TABLE Sorteio (
   id INT PRIMARY KEY, 
   data DATE NOT NULL   
 );
 
CREATE TABLE Numero (
  id_sorteio INT NOT NULL,
  numero INT NOT NULL, 
  CONSTRAINT pk_numero PRIMARY KEY (id_sorteio, numero), 
  CONSTRAINT fk_sorteio FOREIGN KEY (id_sorteio) REFERENCES Sorteio(id)
);

--------------------------------------------------------------------------------------

INSERT INTO Sorteio (id, data) VALUES (2900, TO_DATE('12/08/2025', 'DD/MM/YYYY'));
INSERT INTO Sorteio (id, data) VALUES (2901, TO_DATE('12/02/2025', 'DD/MM/YYYY'));

-- Ou, importar arquivos .csv: sorteio.csv


INSERT INTO Numero (id_sorteio, numero) VALUES (2900, 60);
INSERT INTO Numero (id_sorteio, numero) VALUES (2900, 59);
INSERT INTO Numero (id_sorteio, numero) VALUES (2900, 25);
INSERT INTO Numero (id_sorteio, numero) VALUES (2900, 54);
INSERT INTO Numero (id_sorteio, numero) VALUES (2900, 50);
INSERT INTO Numero (id_sorteio, numero) VALUES (2900, 33);
INSERT INTO Numero (id_sorteio, numero) VALUES (2901, 25);
INSERT INTO Numero (id_sorteio, numero) VALUES (2901, 60);
INSERT INTO Numero (id_sorteio, numero) VALUES (2901, 50);
INSERT INTO Numero (id_sorteio, numero) VALUES (2901, 30);
INSERT INTO Numero (id_sorteio, numero) VALUES (2901, 10);
INSERT INTO Numero (id_sorteio, numero) VALUES (2901, 33);

-- Ou, importar arquivos .csv: num1.csv, num2.csv, num3.csv, num4.csv, num5.csv, num6.csv

--------------------------------------------------------------------------------------

SELECT
  n2.numero,
  COUNT(*) frequencia
FROM
  Numero n1,
  Numero n2
WHERE
  n1.id_sorteio = n2.id_sorteio
  AND n1.numero = :x
  AND n2.numero != :x
GROUP BY
  n2.numero
ORDER BY
  frequencia DESC;

--------------------------------------------------------------------------------------

SELECT
  N.numero,
  COUNT(*) frequencia
FROM
  Sorteio S,
  Numero N
WHERE
  S.id = N.id_sorteio
  AND S.data LIKE '%/08/%'
GROUP BY
  N.numero
ORDER BY
  frequencia DESC;

--------------------------------------------------------------------------------------
  
SELECT
  COUNT(*) "Frequencia do 25"
FROM
  Sorteio S,
  Numero N
WHERE
  S.id = N.id_sorteio
  AND S.data >= DATE '2025-02-01' -- Data fixa representando 6 meses atrás
  AND N.numero = 25;

--------------------------------------------------------------------------------------
  
SELECT
  numero,
  frequencia
FROM
  (
	-- 1. Primeiro, a consulta interna ordena TODOS os números por frequência
	SELECT
  	 numero,
  	 COUNT(*) as frequencia
	FROM
  	 Numero
	GROUP BY
  	 numero
	ORDER BY
  	 frequencia ASC
  ) T
WHERE
  ROWNUM <= 6; -- 2. Depois, a consulta externa pega apenas as 6 primeiras linhas já ordenadas

--------------------------------------------------------------------------------------

SELECT
  T.id_sorteio
FROM
  (SELECT
	id_sorteio,
	COUNT(numero) as contagem
  FROM
	Numero
  WHERE
	numero IN (4, 8, 15, 16, 23, 42)
  GROUP BY
	id_sorteio
  ) T
WHERE
  T.contagem = 6;

  
  
