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

-- Teste da "OVERRIDING MEMBER PROCEDURE SetName" e "CONSTRUCTOR FUNCTION tp_funcionario"
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

-- Teste da "FINAL ORDER MEMBER FUNCTION compareCPF"
DECLARE
Func1 tp_funcionario;
Func2 tp_funcionario;
Func3 tp_funcionario;
is_equal1 number;
is_equal2 number;

BEGIN
Func1 := tp_funcionario(
    cpf => '12345678901', 
    nome => 'João Silva', 
    gerente => NULL,  
    data_contratacao => SYSDATE,
    email => 'joao.silva@example.com'
  );


Func2 := tp_funcionario(
    cpf => '98765432198', 
    nome => 'Antonio', 
    gerente => NULL,  
    data_contratacao => SYSDATE,
    email => 'Aa@example.com'
  );

Func3 := tp_funcionario(
    cpf => '12345678901', 
    nome => 'João Silva', 
    gerente => NULL,  
    data_contratacao => SYSDATE,
    email => 'joao.silva@example.com'
  );

is_equal1 := Func1.compareCPF(Func2);
is_equal2 := Func1.compareCPF(Func3);

DBMS_OUTPUT.PUT_LINE('Comparação com o Funcionario 2: ' || is_equal1 || '. comparação com o Funcionario 3: ' || is_equal2); -- prints order:1 
 END;
/

-- Testando " MAP MEMBER FUNCTION getDuration" com e sem ORDER BY em uma consulta
SELECT e.nome
FROM tb_exibicao e
ORDER BY e.data_exib.getDuration() DESC;
/

SELECT 
    e.id, 
    e.nome, 
    e.data_exib.getDuration() AS duracao_dias 
FROM 
    tb_exibicao e;
/