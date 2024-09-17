-- ANIMAL
INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (1,'Simba', 'Leão', TO_DATE('2003-03-28', 'YYYY-MM-DD'), 'M', 'Tanzania', 'Grande felino de pelagem dourada e uma juba espessa.');
/

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (2,'Gloria', 'Hipopotamo', TO_DATE('2007-05-15', 'YYYY-MM-DD'), 'F', 'Madagascar', 'Grande mamífero de corpo robusto, pele cinza e patas curtas. Vive em rios e lagos. E conhecido por sua força e comportamento territorial.');
/

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (3,'Rico', 'Pinguim', TO_DATE('2001-04-12', 'YYYY-MM-DD'), 'M', 'Antartida', 'Ele gosta de comer coisas estranhas, como lança foguetes.');
/

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (4,'Manny', 'Mamute', TO_DATE('2014-04-30', 'YYYY-MM-DD'), 'M', 'Siberia', 'Mamute clonado em laboratório a partir do ambar de uma arvore antiga Siberiana');
/

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (5,'Sid', 'Bicho-preguica', TO_DATE('1718-07-01', 'YYYY-MM-DD'), 'M', 'Brasil', 'Possui unhas grandes e uma inclinação a sono profundo tão intensa que parece desafiar o envelhecimento, sugerindo uma possível longevidade de mil anos');
/

INSERT INTO tb_animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (6,'Kurama', 'Raposa de nove caudas', TO_DATE('1986-07-01', 'YYYY-MM-DD'), 'M', 'Konohagakure', 'Odiava o Naruto quando criança, agora vive na barriga de Claudino.');
/

-- HABITATS

INSERT INTO tb_habitat(id, tipo, localizacao, nome, descricao)
VALUES (1, 'Semi-desertico', 'Sul', 'Savana', 'Habitat legal');
/

INSERT INTO tb_habitat (id, tipo, localizacao, nome, descricao)
VALUES (2, 'Semiaquatico', 'Sul','Savana','Habitat com caracteristicas semelhantes a uma Savana com caracteristicas semiaquaticas');
/

INSERT INTO tb_habitat (id, tipo, localizacao, nome, descricao)
VALUES (3, 'Glacial', 'Norte','Glace','Habitat com caracteristicas semelhantes a Antartica');
/

INSERT INTO tb_habitat (id, tipo, localizacao, nome, descricao)
VALUES (4, 'Taiga', 'Norte','Glace terrestre','Habitat com caracteristicas semelhantes a uma tundra da era do gelo');
/

INSERT INTO tb_habitat (id, tipo, localizacao, nome, descricao)
VALUES (5, 'Terrestre', 'Oeste','Floresta','Habitat com caracteristicas semelhantes a Amazonia');
/

INSERT INTO tb_habitat (id, tipo, localizacao, nome, descricao)
VALUES (6, 'Vila', 'Leste','Ninja','Habitat com caracteristicas semelhantes a vila da folha');
/

-- FUNCIONARIOS

INSERT INTO tb_funcionario
VALUES (tp_funcionario(
    cpf => '12345678991', 
    nome => 'João Silva', 
    gerente => NULL,  
    data_contratacao => TO_DATE('1945-01-15', 'YYYY-MM-DD'),
    email => 'joao.silva@sofredor.com'
  ));

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, cargo, data_contratacao, email, fones, salario)
VALUES ('98765432100', 'Qinqyi', 'F', 375, 'Gerente Geral', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com', tp_fones('5551999887766'), 1000.000);
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, cargo, data_contratacao, email, fones, salario)
VALUES ('01111111111', 'Carlos Henrique', 'M', 20, 'Gerente Geral', TO_DATE('2020-09-28', 'YYYY-MM-DD'), 'chvmv@cin.ufpe.br', tp_fones('5581992005097', '5581992005098'), 15000.000);
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fones, salario, atribuicoes)
VALUES (
    '12345678901', 'Jane Doe', 'F', 29,
    (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '98765432100'),
    'Cuidador', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'ZZZ@zenless.com',
    tp_fones('5551999887766', '5551999887767', '5551999887768'), 5500.000,
    tp_nt_atribuicoes(
        tp_atribuicoes(
            (SELECT REF(A) FROM tb_animal A WHERE A.id = '1'),
            (SELECT REF(H) FROM tb_habitat H WHERE H.id = '1')
        )
    )
);
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fones, salario, atribuicoes)
VALUES (
    '02222222222', 'Flávio Roberto', 'M', 21,
    (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '01111111111'),
    'Cuidador', TO_DATE('2021-05-04', 'YYYY-MM-DD'), 'frtb@cin.ufpe.br',
    tp_fones('5581922222222'), 7500.000,
    tp_nt_atribuicoes(
        tp_atribuicoes(
            (SELECT REF(A) FROM tb_animal A WHERE A.id = '2'),
            (SELECT REF(H) FROM tb_habitat H WHERE H.id = '2')
        )
    )
);
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fones, salario, atribuicoes)
VALUES (
    '03333333333', 'Vini Seabra', 'M', 20,
    (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '01111111111'),
    'Cuidador', TO_DATE('2021-05-04', 'YYYY-MM-DD'), 'vsll@cin.ufpe.br',
    tp_fones('5581933333333', '5581933333334'), 5000.000,
    tp_nt_atribuicoes(
        tp_atribuicoes(
            (SELECT REF(A) FROM tb_animal A WHERE A.id = '3'),
            (SELECT REF(H) FROM tb_habitat H WHERE H.id = '3')
        )
    )
);
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fones, salario, atribuicoes)
VALUES (
    '04444444444', 'Valeria Dias', 'F', 28,
    (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '01111111111'),
    'Cuidador', TO_DATE('2005-07-01', 'YYYY-MM-DD'), 'vd@cin.ufpe.br',
    tp_fones('5581944528947', '5581944528948'), 20000.000,
    tp_nt_atribuicoes(
        tp_atribuicoes(
            (SELECT REF(A) FROM tb_animal A WHERE A.id = '4'),
            (SELECT REF(H) FROM tb_habitat H WHERE H.id = '4')
        )
    )
);
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fones, salario, atribuicoes)
VALUES (
    '05555555555', 'Carla Guedes', 'F', 55,
    (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '01111111111'),
    'Cuidador', TO_DATE('2017-09-03', 'YYYY-MM-DD'), 'caguedes@cin.ufpe.br',
    tp_fones('5581925545639'), 5000.000,
    tp_nt_atribuicoes(
        tp_atribuicoes(
            (SELECT REF(A) FROM tb_animal A WHERE A.id = '5'),
            (SELECT REF(H) FROM tb_habitat H WHERE H.id = '5')
        )
    )
);
/

INSERT INTO tb_funcionario (cpf, nome, sexo, idade, gerente, cargo, data_contratacao, email, fones, salario, atribuicoes)
VALUES (
    '13333333333', 'Rock Lee', 'M', 21,
    (SELECT REF(F) FROM tb_funcionario F WHERE F.cpf = '01111111111'),
    'Cuidador', TO_DATE('2019-01-04', 'YYYY-MM-DD'), 'rl@cin.ufpe.br',
    tp_fones('5581936656749', '5581936656750', '5581936656751'), 5000.000,
    tp_nt_atribuicoes(
        tp_atribuicoes(
            (SELECT REF(A) FROM tb_animal A WHERE A.id = '6'),
            (SELECT REF(H) FROM tb_habitat H WHERE H.id = '6')
        )
    )
);
/

-- VISITANTES

INSERT INTO tb_visitante (cpf, nome, sexo, idade, data_vsitas, email, fone)
VALUES ('12345678901', 'Jane Doe', 'F', 29, tp_nt_data_visitas(tp_data_visitas(TO_DATE('2003-03-28', 'YYYY-MM-DD'))), 'jd@cin.ufpe.br', '5551999887766');
/

INSERT INTO tb_visitante (cpf, nome, sexo, idade, data_vsitas, email, fone)
VALUES ('00111111111', 'Sabugo Oliveira', 'M', 27, tp_nt_data_visitas(tp_data_visitas(TO_DATE('2002-01-27', 'YYYY-MM-DD'))), 'so@cin.ufpe.br', '5581912657893');
/

INSERT INTO tb_visitante (cpf, nome, sexo, idade, data_vsitas, email, fone)
VALUES ('00222222222', 'Robertin Flavin', 'M', 48, tp_nt_data_visitas(tp_data_visitas(TO_DATE('2003-04-25', 'YYYY-MM-DD'))), 'rf@cin.ufpe.br', '5551999999992');
/

INSERT INTO tb_visitante (cpf, nome, sexo, idade, data_vsitas, email, fone)
VALUES ('00333333333', 'Ari Aragonis', 'M', 35, tp_nt_data_visitas(tp_data_visitas(TO_DATE('2002-05-26', 'YYYY-MM-DD'))), 'ari.aragonis@cin.ufpe.br', '5551999999993');
/

INSERT INTO tb_visitante (cpf, nome, sexo, idade, data_vsitas, email, fone)
VALUES ('00444444444', 'Gaara da Areia', 'M', 20, tp_nt_data_visitas(tp_data_visitas(TO_DATE('2005-03-28', 'YYYY-MM-DD'))), 'gaara.areia@cin.ufpe.br', '5551999999994');
/

-- EXIBICAO

INSERT INTO tb_exibicao (id, nome, descricao, data_exib, habitat)
VALUES ('1', 'O Rei Leão', 'Experiencie a imponência do Rei da Selva', tp_data_exibicao(TO_DATE('2001-03-28', 'YYYY-MM-DD'), TO_DATE('2001-06-28', 'YYYY-MM-DD')), 1);
/

INSERT INTO tb_exibicao (id, nome, descricao, data_exib, habitat)
VALUES ('2', 'Poderosa Gloria', 'Exibicao mostrando a alimentacao e dia a dia dos hipopotamos', tp_data_exibicao(TO_DATE('2012-02-28', 'YYYY-MM-DD'), TO_DATE('2001-05-28', 'YYYY-MM-DD')), 2);
/

INSERT INTO tb_exibicao (id, nome, descricao, data_exib, habitat)
VALUES ('3', 'Pinguim fofinho', 'Aprecie um pinguim com habitos explosivos', tp_data_exibicao(TO_DATE('2024-06-15', 'YYYY-MM-DD'), TO_DATE('2028-06-20', 'YYYY-MM-DD')), 3);
/

INSERT INTO tb_exibicao (id, nome, descricao, data_exib, habitat)
VALUES ('4', 'O Mamute das Eras', 'Veja o primeiro clone de um animal da Era do Gelo trazida de volta em toda sua impônencia', tp_data_exibicao(TO_DATE('2014-04-30', 'YYYY-MM-DD'), TO_DATE('2048-09-20', 'YYYY-MM-DD')), 4);
/

INSERT INTO tb_exibicao (id, nome, descricao, data_exib, habitat)
VALUES ('5', 'O Dorminhoco Sid', 'Mostre o Sid pra sentir a paz da natureza', tp_data_exibicao(TO_DATE('2024-08-19', 'YYYY-MM-DD'), TO_DATE('2030-09-20', 'YYYY-MM-DD')), 5);
/

-- VISITA

INSERT INTO tb_visita (visitante, habitat, data_visita)
VALUES ('12345678901', '1', TO_DATE('2003-03-28', 'YYYY-MM-DD'));
/

INSERT INTO tb_visita (visitante, habitat, data_visita)
VALUES ('00111111111', '2', TO_DATE('2002-01-27', 'YYYY-MM-DD'));
/

INSERT INTO tb_visita (visitante, habitat, data_visita)
VALUES ('00222222222', '3', TO_DATE('2003-04-25', 'YYYY-MM-DD'));
/

INSERT INTO tb_visita (visitante, habitat, data_visita)
VALUES ('00333333333', '4', TO_DATE('2002-05-26', 'YYYY-MM-DD'));
/

INSERT INTO tb_visita (visitante, habitat, data_visita)
VALUES ('00444444444', '5', TO_DATE('2005-03-28', 'YYYY-MM-DD'));
/

-- REVIEW

INSERT INTO tb_review (id, nota, visita)
VALUES (1, 9, (SELECT REF(V) FROM tb_visita V WHERE V.visitante = '12345678901' AND V.habitat = '1' AND V.data_visita = TO_DATE('2003-03-28', 'YYYY-MM-DD')));
/

INSERT INTO tb_review (id, nota, visita)
VALUES (2, 8, (SELECT REF(V) FROM tb_visita V WHERE V.visitante = '00111111111'AND V.habitat = '2' AND V.data_visita = TO_DATE('2002-01-27', 'YYYY-MM-DD')));
/

INSERT INTO tb_review (id, nota, visita)
VALUES (3, 4, (SELECT REF(V) FROM tb_visita V WHERE V.visitante = '00222222222'AND V.habitat = '3' AND V.data_visita = TO_DATE('2003-04-25', 'YYYY-MM-DD')));
/

INSERT INTO tb_review (id, nota, visita)
VALUES (4, 7, (SELECT REF(V) FROM tb_visita V WHERE V.visitante = '00333333333'AND V.habitat = '4' AND V.data_visita = TO_DATE('2002-05-26', 'YYYY-MM-DD')));
/

INSERT INTO tb_review (id, nota, visita)
VALUES (5, 9, (SELECT REF(V) FROM tb_visita V WHERE V.visitante = '00444444444'AND V.habitat = '5' AND V.data_visita = TO_DATE('2005-03-28', 'YYYY-MM-DD')));
/