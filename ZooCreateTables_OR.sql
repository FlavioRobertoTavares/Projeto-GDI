-- #TYPES
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    cpf VARCHAR2(11),
    nome VARCHAR2(50),
    sexo VARCHAR2(1),
    idade INT,
    FINAL MEMBER PROCEDURE setName (new_nome VARCHAR2)
) NOT FINAL NOT INSTANTIABLE; 
/

CREATE OR REPLACE TYPE BODY tp_pessoa IS
  FINAL MEMBER PROCEDURE setName (new_nome VARCHAR2) IS
  BEGIN
    SELF.nome := new_nome;  
  END;
END;
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
  data_fim DATE,
  MEMBER FUNCTION getDuration return NUMBER
);
/
    
CREATE OR REPLACE TYPE BODY tp_data_exibicao IS
    MEMBER FUNCTION getDuration RETURN NUMBER IS
    BEGIN
        RETURN data_inicio - data_fim;
    END;
END;
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
    gerente SCOPE IS tb_funcionario
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

-- #Testes de funções
-- Teste setName
DECLARE
  funcionario tp_funcionario := tp_funcionario(
    cpf => '12345678901', 
    nome => 'João Silva', 
    sexo => 'M', 
    idade => 30,
    gerente => NULL,  
    cargo => 'Analista',
    data_contratacao => SYSDATE,
    email => 'joao.silva@example.com',
    fone => '1234567890',
    salario => 3000.00,
    atribuicoes => tp_nt_atribuicoes() 
  );

BEGIN
  DBMS_OUTPUT.PUT_LINE('Nome atual: ' || funcionario.nome);
  funcionario.setName('Carlos Pereira');
  DBMS_OUTPUT.PUT_LINE('Nome atualizado: ' || funcionario.nome);
END;
/

-- Teste getDuration
SELECT 
    e.id, 
    e.nome, 
    e.data_exib.getDuration() AS duracao_dias 
FROM 
    tb_exibicao e;

--CHECKLIST: https://www.canva.com/design/DAGQfZ2PP0M/jqMwQeHYPOw7CGDfxiWHmg/edit?ui=eyJEIjp7IkoiOnsiQiI6eyJBPyI6IkIifX19LCJBIjp7IkEiOiJkb3dubG9hZF9wbmciLCJGIjp0cnVlfSwiRyI6eyJEIjp7IkQiOnsiQT8iOiJBIiwiQSI6IkIifX19fQ