-- ANIMAL
INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (1,'Simba', 'Leão', TO_DATE('2003-03-28', 'YYYY-MM-DD'), 'M', 'Tanzania', 'Grande felino de pelagem dourada e uma juba espessa.');

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (2,'Gloria', 'Hipopotamo', TO_DATE('2007-05-15', 'YYYY-MM-DD'), 'F', 'Madagascar', 'Grande mamífero de corpo robusto, pele cinza e patas curtas. Vive em rios e lagos. E conhecido por sua força e comportamento territorial.');

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (3,'Rico', 'Pinguim', TO_DATE('2001-04-12', 'YYYY-MM-DD'), 'M', 'Antartida', 'Ele gosta de comer coisas estranhas, como lança foguetes.');

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (4,'Manny', 'Mamute', TO_DATE('2014-04-30', 'YYYY-MM-DD'), 'M', 'Siberia', 'Mamute clonado em laboratório a partir do ambar de uma arvore antiga Siberiana');

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (5,'Sid', 'Bicho-preguica', TO_DATE('1718-07-01', 'YYYY-MM-DD'), 'M', 'Brasil', 'Possui unhas grandes e uma inclinação a sono profundo tão intensa que parece desafiar o envelhecimento, sugerindo uma possível longevidade de mil anos');

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (6,'Kurama', 'Raposa de nove caudas', TO_DATE('1986-07-01', 'YYYY-MM-DD'), 'M', 'Konohagakure', 'Odiava o Naruto quando criança, agora vive na barriga de Claudino.');

-- FUNCIONARIOS

-- INSERT INTO tb_funcionario (cpf, nome, sexo, idade, cargo, data_contratacao, email, fone, salario)
-- VALUES ('98765432100', 'Qinqyi', 'F', 375, 'Policial gerente', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 1000.000);
-- /

-- INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fone, salario)
-- VALUES ('12345678901', 'Jane Doe', 'F', 29, (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '98765432100'), 'Policial infiltrado', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', '5551999887766', 5500.000);
-- /

-- INSERT INTO tb_funcionarios (cpf, nome, sexo, idade, cargo, data_contratacao, email, fone, salario)
-- VALUES ('01111111111', 'Carlos Henrique', 'M', 20,'Gerente Geral', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'chvmv@cin.ufpe.br', '5581992005097', 15000.000);
-- /

-- INSERT INTO tb_funcionarios (cpf, nome, sexo, idade, cpf_gerente, cargo, data_contratacao, email, fone, salario)
-- VALUES ('02222222222', 'Flávio Roberto', 'M', 21, (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '01111111111') 
-- 'Cuidador', TO_DATE('2021-05-04', 'YYYY-MM-DD'), 'frtb@cin.ufpe.br', '55819222222228', 7500.000);
-- /

-- INSERT INTO visitante (cpf, nome, sexo, idade, cpf_gerente, cargo, data_contratacao, email, fone, salario)
-- VALUES ('03333333333', 'Vini Seabra', 'M', 20, (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '01111111111'), 
-- 'Cuidador', TO_DATE('2021-05-04', 'YYYY-MM-DD'), 'vsll@cin.ufpe.br', '5581933333333', 5000.000);
-- /