-- #TYPES
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    cpf VARCHAR2(11),
    nome VARCHAR2(50),
    sexo VARCHAR2(1),
    idade INT
) NOT FINAL NOT INSTANTIABLE; 
/

CREATE OR REPLACE TYPE tp_animal AS OBJECT (
    id NUMBER,
    nome VARCHAR2(20),
    especie VARCHAR2(30),
    nascimento DATE,
    sexo VARCHAR2(1),
    origem VARCHAR2(30),
    descrico VARCHAR2(280)
);
/

CREATE OR REPLACE TYPE tp_habitat AS OBJECT(
    id NUMBER,
    tipo  VARCHAR2(20),
    localizacao VARCHAR2(30),
    nome VARCHAR2(50),
    descricao VARCHAR2(280)
);
/

CREATE OR REPLACE TYPE tp_atribuicoes AS OBJECT(
    animal REF tp_animal,
    habitat REF tp_habitat
);
/

CREATE OR REPLACE TYPE tp_nt_atribuicoes AS TABLE OF tp_atribuicoes;
/

CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa (
    gerente REF tp_funcionario,
    cargo VARCHAR2(50),
    data_contratacao DATE,
    email VARCHAR2(50),
    fone VARCHAR2(13),
    salario NUMBER(8, 3),
    atribuicoes tp_nt_atribuicoes
);
/


CREATE OR REPLACE TYPE tp_data_visitas AS OBJECT (
    data_visita DATE
);
/

CREATE OR REPLACE TYPE tp_nt_data_visitas AS TABLE OF tp_data_visitas;
/

CREATE OR REPLACE TYPE tp_visitante UNDER tp_pessoa(
    data_vsitas tp_nt_data_visitas,
	email VARCHAR2(50),
    fone VARCHAR(13)
);
/

CREATE OR REPLACE TYPE tp_visita AS OBJECT(
    visitante REF tp_visitante,
    habitat REF tp_habitat,
    data_visita DATE
);
/

CREATE OR REPLACE TYPE tp_review AS OBJECT (
    id NUMBER,
    nota NUMBER,
    visita REF tp_visita
);/

CREATE OR REPLACE TYPE tp_data_exibicao as OBJECT(
  data_inicio DATE,
  data_fim DATE
);
/

CREATE OR REPLACE TYPE tp_exibicao AS OBJECT (
    id NUMBER,
    nome VARCHAR2(50),
    descricao VARCHAR2(280),
    data_exib tp_data_exibicao,
    habitat REF tp_habitat
);
/

-- #TABLES
CREATE TABLE tb_funcionario OF tp_funcionario(
    cpf PRIMARY KEY,
    gerente WITH ROWID REFERENCES tb_funcionario
) NESTED TABLE atribuicoes STORE AS tb_atribuicoes;
/

CREATE TABLE tb_visitante OF tp_visitante(
    PRIMARY KEY (cpf)
) NESTED TABLE data_vsitas STORE AS tb_data_visita;
/

CREATE TABLE tb_animal OF tp_animal(
    PRIMARY KEY (id)
);
/

CREATE TABLE tb_habitat OF tp_habitat(
    PRIMARY KEY (id)
);
/

CREATE TABLE tb_exibicao OF tp_exibicao(
    PRIMARY KEY (habitat, data_exib),
    habitat WITH ROWID REFERENCES tb_habitat
);
/

CREATE TABLE tb_visita OF tp_visita(
    PRIMARY KEY (visitante, habitat, data_visita)
    habitat WITH ROWID REFERENCES tb_habitat
    visitante WITH ROWID REFERENCES tb_visitante
);
/

CREATE TABLE tb_review OF tp_review(
    PRIMARY KEY (id)
    visita WITH ROWID REFERENCES tb_visita
);
/


-- #TESTES 
INSERT INTO tb_funcionario (cpf, nome, sexo, idade, cargo, data_contratacao, email, fone, salario)
VALUES ('98765432100', 'Qinqyi', 'F', 375, 'Policial gerente', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 1000.000);
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fone, salario)
VALUES ('12345678901', 'Jane Doe', 'F', 29, (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '98765432100'), 'Policial infiltrado', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 5500.000);
/
INSERT INTO tb_visitante (cpf, nome, sexo, idade, data_vsitas, email, fone)
VALUES (
    '11122233344',  
    'John Doe',     
    'M',            
    30,             
    tp_nt_data_visitas(
        tp_data_visitas(TO_DATE('2024-09-01', 'YYYY-MM-DD')),
        tp_data_visitas(TO_DATE('2024-09-15', 'YYYY-MM-DD'))
    ),  -- Tá pegando, mas tem que visualizar do jeito certo na proxima entrega
    'john.doe@example.com',  
    '5551234567'            
);
/

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (1, 'Ben Bigger', 'Urso Pardo', TO_DATE('12/09/2024', 'dd/mm/yyyy'), 'M', 'Belobog', 'Urso irado que quebra pedra.');
/

INSERT INTO tb_habitat (id, tipo, localizacao, nome, descricao )
VALUES (1, 'Metalúrgica', 'Belobog', 'Usinas Pesadas de Belobog', 'Usina Metalúrgica de grande influência.')
    
SELECT 
    cpf,
    nome,
    sexo,
    idade,
    DEREF(gerente).cpf AS gerente_cpf,
    cargo,
    data_contratacao,
    email,
    fone,
    salario
FROM 
    tb_funcionario;

/

SELECT * FROM tb_visitante;

SELECT * from tb_animal;

SELECT * FROM tb_habitat;

--CHECKLIST: https://www.canva.com/design/DAGQfZ2PP0M/jqMwQeHYPOw7CGDfxiWHmg/edit?ui=eyJEIjp7IkoiOnsiQiI6eyJBPyI6IkIifX19LCJBIjp7IkEiOiJkb3dubG9hZF9wbmciLCJGIjp0cnVlfSwiRyI6eyJEIjp7IkQiOnsiQT8iOiJBIiwiQSI6IkIifX19fQ