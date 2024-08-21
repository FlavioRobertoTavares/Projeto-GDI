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
/

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
/

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
/

-- CREATE OR REPLACE TRIGGER (LINHA)
CREATE OR REPLACE TRIGGER trigger_idade BEFORE INSERT OR UPDATE ON pessoa
FOR EACH ROW
WHEN (NEW.idade < 0)
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'IDADE MENOR QUE ZERO NÃO PERMITIDA.');
END;
/

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('15555555555', 'rODRIGAO', 'M', -20);

-- CREATE OR REPLACE TRIGGER (COMANDO)
CREATE OR REPLACE TRIGGER update_habitat
AFTER UPDATE ON atribuido BEGIN
    DBMS_OUTPUT.PUT_LINE('As definições de habitat foram atualizadas');
END;
/

UPDATE atribuido SET id_habitat = 2 WHERE id_animal = 1;

-- CREATE PROCEDURE, LOOP EXIT WHEN, CURSOR (OPEN FETCH CLOSE)
CREATE OR REPLACE PROCEDURE mostrar_exibicoes AS
    v_habitat exibicao.id_habitat%TYPE;
    v_nome exibicao.nome%TYPE;

    CURSOR c_exibicao IS 
    SELECT id_habitat, nome 
    FROM exibicao;

BEGIN
    OPEN c_exibicao;
    LOOP

    FETCH c_exibicao INTO v_habitat, v_nome;

    EXIT WHEN c_exibicao%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID DO HABITAT: ' || v_habitat || ', NOME DA EXIBIÇÃO: ' || v_nome);
    END LOOP;

    CLOSE c_exibicao;
    DBMS_OUTPUT.PUT_LINE('operacao concluída');
END;
/
    
EXEC mostrar_exibicoes;

-- ESTRUTURA DE DADOS DO TIPO TABLE
DECLARE
    TYPE FuncionarioInfo IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    funcionarios FuncionarioInfo;

BEGIN
    funcionarios(1) := 'Nome: João, Idade: 30';
    funcionarios(2) := 'Nome: Maria, Idade: 25';
    funcionarios(3) := 'Nome: Pedro, Idade: 40';

    FOR i IN funcionarios.FIRST .. funcionarios.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Funcionário ' || i || ': ' || funcionarios(i));
    END LOOP;
END;
/

-- FOR IN LOOP
DECLARE
    CURSOR c_animais IS
        SELECT a.nome AS animal_nome, h.nome AS habitat_nome
        FROM animal a
        JOIN atribuido att ON a.id = att.id_animal
        JOIN habitat h ON att.id_habitat = h.id;
BEGIN
    FOR r_animal IN c_animais LOOP
        DBMS_OUTPUT.PUT_LINE('Animal: ' || r_animal.animal_nome || ' - Habitat: ' || r_animal.habitat_nome);
    END LOOP;
END;
/

-- CREATE OR REPLACE PACKAGE, CREATE OR REPLACE PACKAGE BODY, WHILE LOOP
CREATE OR REPLACE PACKAGE pkg_idade IS 
    TYPE tbl_idade IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR(11); 
    PROCEDURE verifica_idade (tabela OUT tbl_idade); 
    PROCEDURE print_verificacao (tabela IN tbl_idade); 
    PROCEDURE executa; 
END pkg_idade; 
/

CREATE OR REPLACE PACKAGE BODY pkg_idade IS 
    PROCEDURE verifica_idade(tabela OUT tbl_idade) IS 
        CURSOR cur_idade IS SELECT cpf, idade FROM pessoa; 
    BEGIN 
        FOR linha IN cur_idade LOOP 
            IF linha.idade < 32 THEN 
                tabela(linha.cpf) := 'Caramba! Você é mais velho que o Kakashi!.'; 
            ELSIF linha.idade > 32 THEN 
                tabela(linha.cpf) := 'Você é mais novo que o Sensei Kakashi Hatake.'; 
            ELSE 
                tabela(linha.cpf) := 'Suspeito que você seja o Kakashi Sensei.'; 
            END IF; 
        END LOOP; 
    END verifica_idade; 
 
    PROCEDURE print_verificacao(tabela IN tbl_idade)  
        IS idx VARCHAR2(11); 
    BEGIN 
        idx := tabela.FIRST; 
            WHILE idx IS NOT NULL LOOP 
            DBMS_OUTPUT.PUT_LINE ('CPF: ' || idx || ' Verificacao: ' || tabela(idx)); 
            idx := tabela.NEXT(idx); 
                END LOOP; 
    END print_verificacao; 
 
    PROCEDURE executa IS tabela tbl_idade; 
        BEGIN 
            verifica_idade(tabela); 
            print_verificacao(tabela); 
        END executa; 
END pkg_idade;
/

BEGIN
    DBMS_OUTPUT.DISABLE;
    DBMS_OUTPUT.ENABLE(10000);
END;
/
BEGIN
    pkg_idade.executa;
END;
/

-- CREATE FUNCTION
CREATE OR REPLACE FUNCTION Funcionario_Salario_Maximo
RETURN VARCHAR2 IS
    v_cpf_funcionario VARCHAR2(11);
BEGIN
    SELECT cpf_funcionario
    INTO v_cpf_funcionario
    FROM funcionario
    WHERE salario = (SELECT MAX(salario) FROM funcionario);

    RETURN v_cpf_funcionario;
END Funcionario_Salario_Maximo;
/

DECLARE
    v_funcionario_rico funcionario.cpf_funcionario%TYPE := Funcionario_Salario_Maximo;
BEGIN
    DBMS_OUTPUT.PUT_LINE('O cpf do funcionario mais burgues eh o '|| v_funcionario_rico);
END;
/

-- CASE WHEN:
DECLARE
    CURSOR c_funcionarios IS
        SELECT p.nome, f.salario
        FROM funcionario f
        JOIN pessoa p ON f.cpf_funcionario = p.cpf;
    v_tipo_salario VARCHAR2(10);
BEGIN
    FOR rec IN c_funcionarios LOOP
        v_tipo_salario := CASE 
                            WHEN rec.salario < 3000 THEN 'Baixo'
                            WHEN rec.salario BETWEEN 3000 AND 7000 THEN 'Médio'
                            ELSE 'Alto'
                          END;

        DBMS_OUTPUT.PUT_LINE('Nome: ' || rec.nome || ' - Salário: ' || rec.salario || ' - Tipo de Salário: ' || v_tipo_salario);
    END LOOP;
END;
/