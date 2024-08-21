--ALTER TABLE
ALTER TABLE review
ADD CONSTRAINT chk_nota CHECK (nota BETWEEN 1 AND 10);

ALTER TABLE pessoa
ADD CONSTRAINT chk_idade_maxima CHECK (idade <= 80);

-- CREATE INDEX
CREATE INDEX idx_nome_pessoa ON pessoa(nome);

-- INSERT INTO
INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('15555555555', 'Ariston Aragao', 'M', 22);

-- UPDATE
UPDATE pessoa 
SET idade = 23
WHERE cpf = '15555555555';

-- DELETE
DELETE FROM pessoa 
WHERE cpf = '15555555555';

-- SELECT FROM WHERE & INNER JOIN & IN
SELECT pe.nome, pe.idade
FROM pessoa pe
INNER JOIN funcionario func ON func.cpf_funcionario = pe.cpf
WHERE pe.sexo = 'M' AND pe.idade IN (18,20,32); 

-- LIKE
SELECT id, tipo, nome 
FROM habitat 
WHERE tipo LIKE 'Semi%';

-- IS NULL
SELECT * 
FROM funcionario
WHERE cpf_gerente IS NULL;

-- MIN & MAX

SELECT cpf_funcionario, data_contratacao 
FROM funcionario 
WHERE data_contratacao = (SELECT MIN(data_contratacao) FROM funcionario) 
OR data_contratacao = (SELECT MAX(data_contratacao) FROM funcionario);

-- BETWEEN & ORDER BY
SELECT id, nota, cpf_visitante_r 
FROM review 
WHERE nota BETWEEN 7 AND 9
ORDER BY nota ASC;

-- AVG & SUBCONSULTA COM OPERADOR RELACIONAL
SELECT id, nota, cpf_visitante_r 
FROM review 
WHERE nota > (SELECT AVG(nota) FROM review);

-- COUNT
SELECT COUNT(*) 
FROM exibicao 
WHERE data_fim < TO_DATE('2024-08-20', 'YYYY-MM-DD');

-- GROUP BY
SELECT cpf_visitante_dv, COUNT(cpf_visitante_dv) AS Numero_de_Visitas, MIN(data_visita) AS Primeira_Visita 
FROM data_visitas
GROUP BY cpf_visitante_dv
ORDER BY cpf_visitante_dv ASC;

-- SELECT * FROM animal;

-- SELECT * FROM habitat;

-- SELECT * FROM exibicao;

-- SELECT * FROM visitante;

-- SELECT * FROM funcionario;

-- SELECT * FROM visitante_habitat;

-- SELECT * FROM data_visitas;

-- SELECT * FROM review;

-- SELECT * FROM visita;

-- SELECT * FROM atribuido;


