DROP TABLE atribuido;
DROP TABLE visita;
DROP TABLE review;
DROP TABLE data_visitas;
DROP TABLE visitante_habitat; 
DROP TABLE visitante;
DROP TABLE funcionario;
DROP TABLE pessoa;
DROP TABLE animal;
DROP TABLE exibicao;
DROP TABLE habitat;

CREATE TABLE pessoa (
    cpf VARCHAR2(11),
    nome  VARCHAR2(50),
    sexo VARCHAR2(1),
    idade int,
    CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
    CONSTRAINT pessoa_sexo_ck CHECK (sexo IN ('M', 'F'))
);

CREATE TABLE animal (
    id int,
    nome  VARCHAR2(20),
    especie VARCHAR2(30),
    nascimento date,
    sexo VARCHAR2(1),
    origem VARCHAR2(30),
    descricao VARCHAR2(280),
    CONSTRAINT animal_pk PRIMARY KEY (id),
    CONSTRAINT animal_sexo_ck CHECK (sexo IN ('M', 'F'))
);

CREATE TABLE habitat (
    id int,
    tipo  VARCHAR2(20),
    localizacao VARCHAR2(30),
    nome VARCHAR2(50),
    descricao VARCHAR2(280),
    CONSTRAINT habitat_pk PRIMARY KEY (id)
);

CREATE TABLE exibicao(
    id_habitat int,
    data_inicio date,
    data_fim date,
    nome VARCHAR2(50),
    descricao VARCHAR2(280),
    CONSTRAINT exibicao_pk PRIMARY KEY (id_habitat, data_inicio),
    CONSTRAINT exibicao_habitat_fk FOREIGN KEY (id_habitat) REFERENCES habitat(id)  
);

CREATE TABLE visitante(
    cpf_visitante VARCHAR2(11),
    email VARCHAR2(50),
    fone VARCHAR(13),
    CONSTRAINT visitante_pk PRIMARY KEY (cpf_visitante),
    CONSTRAINT cpf_visitante_fk FOREIGN KEY (cpf_visitante) REFERENCES pessoa (cpf)
);

CREATE TABLE funcionario(
    cpf_funcionario VARCHAR2(11),
    cpf_gerente VARCHAR2(11),
    cargo VARCHAR2(50),
    data_contratacao date,
    email VARCHAR2(50),
    fone VARCHAR(13),
    salario DECIMAL(8, 3),
    CONSTRAINT funcionario_pk PRIMARY KEY (cpf_funcionario),
    CONSTRAINT cpf_funcionario_fk FOREIGN KEY (cpf_funcionario) REFERENCES pessoa (cpf),
    CONSTRAINT cpf_gerente_funcionario_fk FOREIGN KEY (cpf_gerente) REFERENCES funcionario(cpf_funcionario)
);

CREATE TABLE visitante_habitat (
    cpf_visitante_vh VARCHAR2(11),
    id_habitat_vh int,
    data_visita date,
    CONSTRAINT visitante_habitat_pk PRIMARY KEY (cpf_visitante_vh, id_habitat_vh, data_visita),
    CONSTRAINT cpf_visitante_vh_fk FOREIGN KEY (cpf_visitante_vh) REFERENCES visitante(cpf_visitante),
    CONSTRAINT id_habitat_vh_fk FOREIGN KEY (id_habitat_vh) REFERENCES habitat(id)
);

CREATE TABLE data_visitas (
    data_visita date,
    cpf_visitante_dv VARCHAR2(11),
    CONSTRAINT data_visitas_pk PRIMARY KEY (data_visita, cpf_visitante_dv),
    CONSTRAINT cpf_visitante_dv_fk FOREIGN KEY (cpf_visitante_dv) REFERENCES visitante(cpf_visitante)
);

CREATE TABLE review (
    id int,
    nota int,
    cpf_visitante_r VARCHAR2(11),
    id_habitat_r int,
    data_visita_r date,
    CONSTRAINT review_pk PRIMARY KEY (id),
    CONSTRAINT review_cpf_visitante_fk FOREIGN KEY (cpf_visitante_r, id_habitat_r, data_visita_r) REFERENCES visitante_habitat(cpf_visitante_vh, id_habitat_vh, data_visita)
);

CREATE TABLE visita (
    cpf_visitante_v VARCHAR2(11),
    id_habitat_v int,
    data_de_visita date,
    CONSTRAINT visita_pk PRIMARY KEY (cpf_visitante_v, id_habitat_v, data_de_visita),
    CONSTRAINT visita_cpf_fk FOREIGN KEY (cpf_visitante_v) REFERENCES visitante(cpf_visitante),
    CONSTRAINT visita_habitat_fk FOREIGN KEY (id_habitat_v) REFERENCES habitat(id)
);

CREATE TABLE atribuido (
    id_animal int,
    id_habitat int, 
    cpf_funcionario_att VARCHAR2(11),
    CONSTRAINT atribuido_pk PRIMARY KEY (id_animal),
    CONSTRAINT atribuido_animal_fk FOREIGN KEY (id_animal) REFERENCES animal(id),
    CONSTRAINT atribuido_habitat_fk FOREIGN KEY (id_habitat) REFERENCES habitat(id),
    CONSTRAINT atribuido_funcionario_fk FOREIGN KEY (cpf_funcionario_att) REFERENCES funcionario(cpf_funcionario)

);

