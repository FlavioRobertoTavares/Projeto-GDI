-- #TYPES
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    cpf VARCHAR2(11),
    nome  VARCHAR2(50),
    sexo VARCHAR2(1),
    idade int
) NOT FINAL NOT INSTANTIABLE; 


CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa(
    cpf_gerente VARCHAR2(11),
    cargo VARCHAR2(50),
    data_contratacao date,
    email VARCHAR2(50),
    fone VARCHAR(13),
    salario DECIMAL(8, 3)
);

-- #TABLES
CREATE TABLE tb_funcionarios OF tp_funcionario;

-- #TESTES 

INSERT INTO tb_funcionarios
VALUES ('12345678901', 'Jane Doe', 'F', 29, '98765432100', 'Policial infiltrado', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 5500.000);

SELECT * FROM tb_funcionarios;