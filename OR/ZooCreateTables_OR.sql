-- #TYPES
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    cpf VARCHAR2(11),
    nome VARCHAR2(50),
    sexo VARCHAR2(1),
    idade INT,
    MEMBER PROCEDURE setName (new_nome VARCHAR2),
    FINAL ORDER MEMBER FUNCTION compareCPF (other_pessoa tp_pessoa) RETURN INTEGER
) NOT FINAL NOT INSTANTIABLE; 
/

CREATE OR REPLACE TYPE BODY tp_pessoa IS
  MEMBER PROCEDURE setName (new_nome VARCHAR2) IS
  BEGIN
    SELF.nome := new_nome;  
  END;
  FINAL ORDER MEMBER FUNCTION compareCPF (other_pessoa tp_pessoa) RETURN INTEGER IS
  BEGIN
    IF SELF.cpf < other_pessoa.cpf THEN
      RETURN -1;
    ELSIF SELF.cpf > other_pessoa.cpf THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END compareCPF;
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
    atribuicoes tp_nt_atribuicoes,
    OVERRIDING MEMBER PROCEDURE SetName(new_nome VARCHAR2),
    CONSTRUCTOR FUNCTION tp_funcionario(
    	cpf VARCHAR2,
    	nome VARCHAR2,
    	gerente REF tp_funcionario,
    	data_contratacao DATE,
    	email VARCHAR2
    ) RETURN SELF AS RESULT
);
/
    
CREATE OR REPLACE TYPE tp_fones AS VARRAY(3) OF VARCHAR2(13);
/

ALTER TYPE tp_funcionario DROP ATTRIBUTE fone CASCADE;
/
ALTER TYPE tp_funcionario ADD ATTRIBUTE fones tp_fones CASCADE;
/

CREATE OR REPLACE TYPE BODY tp_funcionario IS
  OVERRIDING MEMBER PROCEDURE setName (new_nome VARCHAR2) IS 
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Nova Contratação'); 
    SELF.nome := new_nome; 
  END setName;

  CONSTRUCTOR FUNCTION tp_funcionario(
    	cpf VARCHAR2,
    	nome VARCHAR2,
    	gerente REF tp_funcionario,
    	data_contratacao DATE,
    	email VARCHAR2
  ) RETURN SELF AS RESULT IS
        BEGIN
        	SELF.cpf := cpf;
        	SELF.nome := 'Estagiario ' || nome;
            SELF.sexo := NULL;
        	SELF.idade := NULL;
            SELF.gerente := gerente;
            SELF.cargo := 'Faz tudo por pouco';
            SELF.data_contratacao := data_contratacao;
            SELF.email := email;
            SELF.fones := NULL;
            SELF.atribuicoes := NULL;
			SELF.salario := 600.000;
        	RETURN;
	END tp_funcionario;

END;
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
  MAP MEMBER FUNCTION getDuration return NUMBER
);
/
    
CREATE OR REPLACE TYPE BODY tp_data_exibicao IS
    MAP MEMBER FUNCTION getDuration RETURN NUMBER IS
    BEGIN
        RETURN data_fim - data_inicio;
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
-- Teste setName e Constructor
DECLARE
  funcionario tp_funcionario := tp_funcionario(
    cpf => '12345678901', 
    nome => 'João Silva', 
    gerente => NULL,  
    data_contratacao => SYSDATE,
    email => 'joao.silva@example.com'
  );

BEGIN
  DBMS_OUTPUT.PUT_LINE('Nome atual: ' || funcionario.nome);
  funcionario.setName('Carlos Pereira');
  DBMS_OUTPUT.PUT_LINE('Nome atualizado: ' || funcionario.nome);
END;
/

-- Teste getDuration (Como ela tem MAP, podemos chamar ela para ordenar as exibições por tempo de duração!)
INSERT INTO tb_habitat (id, tipo, localizacao, nome, descricao)
VALUES (6, 'Vila', 'Leste','Ninja','Habitat com caracteristicas semelhantes a vila da folha');
/

INSERT INTO tb_exibicao (id, nome, descricao, data_exib, habitat)
VALUES ('6', 'O Rei Leão', 'Experiencie a imponência do Rei da Selva', tp_data_exibicao(TO_DATE('2001-03-28', 'YYYY-MM-DD'), TO_DATE('2001-06-28', 'YYYY-MM-DD')), 6);
/

SELECT 
    e.id, 
    e.nome, 
    e.data_exib.getDuration() AS duracao_dias 
FROM 
    tb_exibicao e;
/

-- Teste alter type com varray
INSERT INTO tb_funcionario (cpf, nome, sexo, idade, cargo, data_contratacao, email, fones, salario)
VALUES ('98765432100', 'Qinqyi', 'F', 375, 'Gerente Geral', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', tp_fones('5551999887766', '5551963476572'), 1000.000);
/


--CHECKLIST: https://www.canva.com/design/DAGQfZ2PP0M/jqMwQeHYPOw7CGDfxiWHmg/edit?ui=eyJEIjp7IkoiOnsiQiI6eyJBPyI6IkIifX19LCJBIjp7IkEiOiJkb3dubG9hZF9wbmciLCJGIjp0cnVlfSwiRyI6eyJEIjp7IkQiOnsiQT8iOiJBIiwiQSI6IkIifX19fQ