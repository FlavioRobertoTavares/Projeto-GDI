-- BLOCO ANONIMO, %ROWTYPE, SELECT INTO, EXCEPTION WHEN: Pega o nome de um animal como input e retorna o nome da pessoa que cuida dele e onde ele vive, retorna erro caso o animal não esteja no zoologico
DECLARE
   v_nome VARCHAR2(20) := 'Rico';
   v_animal animal%ROWTYPE;
   v_funcionario_nome pessoa.nome%TYPE;
   v_habitat_nome habitat.nome%TYPE;
BEGIN
   SELECT * 
   INTO v_animal
   FROM animal
   WHERE nome = v_nome;
   
   SELECT p.nome, h.nome
   INTO v_funcionario_nome, v_habitat_nome
   FROM atribuido att
   JOIN funcionario f ON att.cpf_funcionario_att = f.cpf_funcionario
   JOIN pessoa p ON f.cpf_funcionario = p.cpf
   JOIN habitat h ON att.id_habitat = h.id
   WHERE att.id_animal = v_animal.id;

   DBMS_OUTPUT.PUT_LINE(v_animal.nome || ' está no Zoologico! Ele mora no habitat ' || v_habitat_nome || ' e está sendo cuidado pelo seu cuidador ' || v_funcionario_nome);
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('O animal não está mais no Zoológico, ou não existe!');
END;

-- IF ELSEIF, %TYPE
DECLARE
    v_idade pessoa.idade%TYPE;
    v_nome pessoa.nome%TYPE;
BEGIN
    SELECT idade, nome
    INTO v_idade, v_nome
    FROM pessoa
    WHERE cpf = '01111111111'; 

    IF v_idade < 18 THEN
        DBMS_OUTPUT.PUT_LINE(v_nome || ' é um menor de idade.');
    ELSIF v_idade BETWEEN 18 AND 65 THEN
        DBMS_OUTPUT.PUT_LINE(v_nome || ' é um adulto.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_nome || ' é um idoso.');
    END IF;
END;

-- RECORD
DECLARE
    TYPE animal_record IS RECORD (
        id         animal.id%TYPE,
        nome       animal.nome%TYPE,
        especie    animal.especie%TYPE,
        nascimento animal.nascimento%TYPE,
        sexo       animal.sexo%TYPE,
        origem     animal.origem%TYPE,
        descricao  animal.descricao%TYPE
    );

    v_animal animal_record;
BEGIN
    SELECT id, nome, especie, nascimento, sexo, origem, descricao
    INTO v_animal
    FROM animal
    WHERE id = 1;  -- Altere o ID conforme necessário

    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_animal.nome);
    DBMS_OUTPUT.PUT_LINE('Espécie: ' || v_animal.especie);
    DBMS_OUTPUT.PUT_LINE('Origem: ' || v_animal.origem);
END;

-- CREATE OR REPLACE TRIGGER (LINHA)
CREATE OR REPLACE TRIGGER trigger_idade BEFORE INSERT OR UPDATE ON pessoa
FOR EACH ROW
WHEN (NEW.idade < 0)
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'IDADE MENOR QUE ZERO NÃO PERMITIDA.');
END;

-- CREATE OR REPLACE TRIGGER (COMANDO)
CREATE OR REPLACE TRIGGER update_habitat
AFTER UPDATE ON atribuido BEGIN
    DBMS_OUTPUT.PUT_LINE('As definições de habitat foram atualizadas');
END;