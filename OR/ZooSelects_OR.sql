-- "Quem é o gerente da funcionária Jane Doe?"
SELECT DEREF(F.gerente).nome AS gerente
FROM tb_funcionario F
WHERE F.nome = 'Jane Doe';
/

-- "Qual o nome do funcionário cujo gerente se chama Qinqyi?"
SELECT F.nome
FROM tb_funcionario F
WHERE F.gerente = (SELECT REF(F1) FROM tb_funcionario F1 WHERE F1.nome = 'Qinqyi');
/

-- Procedimento que printa todos os telefones da pessoa com o nome especificado:
CREATE OR REPLACE PROCEDURE print_fones(v_nome VARCHAR2)
IS
    t tp_fones;
BEGIN
    SELECT fones INTO t FROM tb_funcionario WHERE nome = v_nome;
    DBMS_OUTPUT.PUT_LINE('Numeros de telefones de '||v_nome||':');
    FOR i IN 1..t.count LOOP
        DBMS_OUTPUT.PUT_LINE(i||' - '||t(i));
    END LOOP;
END print_fones;
/

BEGIN
    print_fones('Carlos Henrique');
END;
/

-- Quais são os animais e habitats atribuídos ao funcionario com o cpf 03333333333?
SELECT F.nome AS funcionario, DEREF(A.animal).nome AS animal, DEREF(A.habitat).nome AS habitat
FROM tb_funcionario F, TABLE(F.atribuicoes) A
WHERE F.cpf = '03333333333';
/