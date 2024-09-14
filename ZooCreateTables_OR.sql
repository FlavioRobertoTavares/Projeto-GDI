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
    descricao VARCHAR2(280)
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
    visitante VARCHAR2(11),
    habitat NUMBER,
    data_visita DATE
);
/

CREATE OR REPLACE TYPE tp_review AS OBJECT (
    id NUMBER,
    nota NUMBER,
    visita REF tp_visita
);
/

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
    habitat NUMBER
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
    PRIMARY KEY (habitat, data_exib.data_inicio),
    CONSTRAINT fk_habitat FOREIGN KEY (habitat) REFERENCES tb_habitat(id)
);
/
   
CREATE TABLE tb_visita OF tp_visita(
    PRIMARY KEY (visitante, habitat, data_visita),
    CONSTRAINT fk_habitat_v FOREIGN KEY (habitat) REFERENCES tb_habitat(id),
    CONSTRAINT fk_visitante_v FOREIGN KEY (visitante) REFERENCES tb_visitante(cpf)
);
/

CREATE TABLE tb_review OF tp_review(
    PRIMARY KEY (id),
    visita WITH ROWID REFERENCES tb_visita
);
/

-- #EXEMPLOS:
INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descrico)
VALUES (1,'Simba', 'Leão', TO_DATE('2003-03-28', 'YYYY-MM-DD'), 'M', 'Tanzania', 'Grande felino de pelagem dourada e uma juba espessa.');
/

INSERT INTO tb_habitat(id, tipo, localizacao, nome, descricao)
VALUES (1, 'Semi-desertico', 'Sul', 'Savana', 'Habitat legal');
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, cargo, data_contratacao, email, fone, salario)
VALUES ('98765432100', 'Qinqyi', 'F', 375, 'Policial gerente', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 1000.000);
/
    
INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fone, salario, atribuicoes)
VALUES ('12345678901', 'Jane Doe', 'F', 29, (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '98765432100'), 'Policial infiltrado', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 5500.000, 
tp_nt_atribuicoes(tp_atribuicoes((SELECT REF(A) FROM tb_animal A WHERE A.id = '1'), (SELECT REF(H) from tb_habitat H WHERE H.id = '1'))));
/

INSERT INTO tb_visitante (cpf, nome, sexo, idade, data_vsitas, email, fone)
VALUES ('12345678901', 'Jane Doe', 'F', 29, tp_nt_data_visitas(tp_data_visitas(TO_DATE('2003-03-28', 'YYYY-MM-DD'))), 'ex@john.doe', '5551999887766');
/

INSERT INTO tb_exibicao (id, nome, descricao, data_exib, habitat)
VALUES ('1', 'NOME EXIB', 'DESCRICAO', tp_data_exibicao(TO_DATE('2001-03-28', 'YYYY-MM-DD'), TO_DATE('2001-03-28', 'YYYY-MM-DD')), '1');
/

INSERT INTO tb_visita (visitante, habitat, data_visita)
VALUES ('12345678901', '1', TO_DATE('2001-03-28', 'YYYY-MM-DD'));
/

INSERT INTO tb_review (id, nota, visita)
VALUES (1, 9, (SELECT REF(V) FROM tb_visita V WHERE V.visitante = '12345678901' AND V.habitat = '1' AND V.data_visita = TO_DATE('2003-03-28', 'YYYY-MM-DD')));
/

--CHECKLIST: https://www.canva.com/design/DAGQfZ2PP0M/jqMwQeHYPOw7CGDfxiWHmg/edit?ui=eyJEIjp7IkoiOnsiQiI6eyJBPyI6IkIifX19LCJBIjp7IkEiOiJkb3dubG9hZF9wbmciLCJGIjp0cnVlfSwiRyI6eyJEIjp7IkQiOnsiQT8iOiJBIiwiQSI6IkIifX19fQ