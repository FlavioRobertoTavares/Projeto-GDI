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
CREATE TABLE tb_funcionarios OF tp_funcionario(
    PRIMARY KEY (cpf),
    CONSTRAINT fk_gerente FOREIGN KEY (cpf_gerente) REFERENCES tb_funcionarios(cpf)
);

-- #TESTES 
INSERT INTO tb_funcionarios (cpf, nome, sexo, idade, cargo, data_contratacao, email, fone, salario)
VALUES ('98765432100', 'Qinqyi', 'F', 375, 'Policial gerente', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 1000.000);

INSERT INTO tb_funcionarios (cpf, nome, sexo, idade, cpf_gerente, cargo, data_contratacao, email, fone, salario)
VALUES ('12345678901', 'Jane Doe', 'F', 29, '98765432100', 'Policial infiltrado', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 5500.000);

SELECT * FROM tb_funcionarios;

--CHECKLIST: https://www.canva.com/design/DAGQfZ2PP0M/jqMwQeHYPOw7CGDfxiWHmg/edit?ui=eyJEIjp7IkoiOnsiQiI6eyJBPyI6IkIifX19LCJBIjp7IkEiOiJkb3dubG9hZF9wbmciLCJGIjp0cnVlfSwiRyI6eyJEIjp7IkQiOnsiQT8iOiJBIiwiQSI6IkIifX19fQ