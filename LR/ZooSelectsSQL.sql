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

-- LEFT JOIN QUE MOSTRA QUE NEM TODAS AS PESSOAS TEM CARGO NO ZOOLÓGICO, PORTANTO, SEM DATA DE CONTRATAÇÃO TAMBÉM
SELECT p.nome, func.cargo, func.data_contratacao
	FROM pessoa p
	LEFT JOIN funcionario func ON p.cpf = func.cpf_funcionario;

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

-- Sub consulta com IN exibindo somente o nome de animais que tem visitantes, excluindo então a preguiça

SELECT nome
	FROM animal
WHERE id IN (
    SELECT id_habitat_v
    	FROM visita
);

-- Subconsulta com ALL que busca achar os visitantes que tem idade maior que TODAS as idades dos funcionários
SELECT p.nome, p.idade
FROM pessoa p
WHERE p.idade > ALL (
    SELECT p.idade
    FROM pessoa p
    INNER JOIN funcionario f ON p.cpf = f.cpf_funcionario
);

-- Subconsulta com any que procura saber se existe ALGUM funcionário mais velho que ALGUM visitante, e lista quais
SELECT p.nome, p.idade
FROM pessoa p, funcionario f
WHERE p.idade > ANY (
    SELECT p.idade
    FROM pessoa p
    JOIN visitante v ON p.cpf = v.cpf_visitante
) AND f.cpf_funcionario = p.cpf;

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

-- HAVING: Consulta que nos retorna o nome dos habitats e o número de visitas que eles tiveram, caso tenham sido visitados pelo menos 4 vezes
SELECT h.nome AS habitat_nome, COUNT(vh.cpf_visitante_vh) AS total_visitantes
FROM habitat h
JOIN visitante_habitat vh ON h.id = vh.id_habitat_vh
GROUP BY h.nome
HAVING COUNT(vh.cpf_visitante_vh) > 3
ORDER BY total_visitantes DESC;

-- UNION: Consulta quantos visitantes cada habitat teve, então consulta quantos funcionarios estão atribuidos a cada habitat, então une as duas consultas em uma.
SELECT 'Visitantes' AS categoria, h.nome AS habitat, COUNT(vh.cpf_visitante_vh) AS total
FROM habitat h
JOIN visitante_habitat vh ON h.id = vh.id_habitat_vh
GROUP BY h.nome
UNION
SELECT 'Funcionários' AS categoria, h.nome AS habitat, COUNT(a.cpf_funcionario_att) AS total
FROM habitat h
JOIN atribuido a ON h.id = a.id_habitat
GROUP BY h.nome;

-- CREATE VIEW: Cria uma tabela virtual dos candidatos a gerência no futuro, baseado na sua idade e salário, onde eles tem que ter pelo menos 19 anos e ganhar mais de 5 mil reais
CREATE VIEW Candidatos_a_gerência AS
SELECT f.cpf_funcionario AS CPF, f.email AS Email, f.fone AS Telefone, f.salario AS Salario, p.nome AS Nome,f.cargo AS Cargo_Atual
FROM funcionario f
JOIN pessoa p ON f.cpf_funcionario = p.cpf
WHERE p.idade >= 19
AND f.salario > 5000;
SELECT * FROM Candidatos_a_gerência;