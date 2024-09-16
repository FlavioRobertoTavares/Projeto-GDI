-- INSERINDO PESSOAS
INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('01111111111', 'Carlos Henrique', 'M', 20);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('02222222222', 'Flavio Roberto', 'M', 20);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('03333333333', 'Vini Seabra', 'M', 20);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('04444444444', 'Valeria Dias', 'F', 25);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('05555555555', 'Carla Guedes', 'F', 63);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('07777777777', 'Fabia Aveiro', 'F', 55);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('08888888888', 'Naruto Uzumaki', 'M', 18);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('09999999999', 'Sasuke Uchiha', 'M', 18);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('11111111111', 'Sakura Haruno', 'F', 18);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('12222222222', 'Kakashi Hatake', 'M', 32);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('13333333333', 'Rock Lee', 'M', 20);

INSERT INTO pessoa (cpf, nome, sexo, idade)
VALUES ('14444444444', 'Lucas Oliveira', 'M', 40);

--INSERINDO ANIMAIS

CREATE SEQUENCE animais_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (animais_seq.nextval,'Simba', 'Leão', TO_DATE('2003-03-28', 'YYYY-MM-DD'), 'M', 'Tanzania', 'Grande felino de pelagem dourada e uma juba espessa.');

INSERT INTO animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (animais_seq.nextval,'Gloria', 'Hipopotamo', TO_DATE('2007-05-15', 'YYYY-MM-DD'), 'F', 'Madagascar', 'Grande mamífero de corpo robusto, pele cinza e patas curtas. Vive em rios e lagos. E conhecido por sua força e comportamento territorial.');

INSERT INTO animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (animais_seq.nextval,'Rico', 'Pinguim', TO_DATE('2001-04-12', 'YYYY-MM-DD'), 'M', 'Antartida', 'Ele gosta de comer coisas estranhas, como lança foguetes.');

INSERT INTO animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (animais_seq.nextval,'Manny', 'Mamute', TO_DATE('2014-04-30', 'YYYY-MM-DD'), 'M', 'Siberia', 'Mamute clonado em laboratório a partir do ambar de uma arvore antiga Siberiana');

INSERT INTO animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (animais_seq.nextval,'Sid', 'Bicho-preguica', TO_DATE('1718-07-01', 'YYYY-MM-DD'), 'M', 'Brasil', 'Possui unhas grandes e uma inclinação a sono profundo tão intensa que parece desafiar o envelhecimento, sugerindo uma possível longevidade de mil anos');

INSERT INTO animal (id, nome, especie, nascimento, sexo, origem, descricao)
VALUES (animais_seq.nextval,'Kurama', 'Raposa de nove caudas', TO_DATE('1986-07-01', 'YYYY-MM-DD'), 'M', 'Konohagakure', 'Odiava o Naruto quando criança, agora vive na barriga de Claudino.');

--INSERINDO HABITAT

INSERT INTO habitat (id, tipo, localizacao, nome, descricao)
VALUES (1, 'Semi-desertico', 'Sul','Savana','Habitat com caracteristicas semelhantes a uma Savana');

INSERT INTO habitat (id, tipo, localizacao, nome, descricao)
VALUES (2, 'Semiaquatico', 'Sul','Savana','Habitat com caracteristicas semelhantes a uma Savana com caracteristicas semiaquaticas');

INSERT INTO habitat (id, tipo, localizacao, nome, descricao)
VALUES (3, 'Glacial', 'Norte','Glace','Habitat com caracteristicas semelhantes a Antartica');

INSERT INTO habitat (id, tipo, localizacao, nome, descricao)
VALUES (4, 'Taiga', 'Norte','Glace terrestre','Habitat com caracteristicas semelhantes a uma tundra da era do gelo');

INSERT INTO habitat (id, tipo, localizacao, nome, descricao)
VALUES (5, 'Terrestre', 'Oeste','Floresta','Habitat com caracteristicas semelhantes a Amazonia');

INSERT INTO habitat (id, tipo, localizacao, nome, descricao)
VALUES (6, 'Vila', 'Leste','Ninja','Habitat com caracteristicas semelhantes a vila da folha');


--INSERINDO EXIBICAO

INSERT INTO exibicao (id_habitat, data_inicio, data_fim, nome, descricao)
VALUES (1, TO_DATE('2003-06-28', 'YYYY-MM-DD'), TO_DATE('2015-06-20', 'YYYY-MM-DD'), 'O Rei Leão', 'Experiencie a imponência do Rei da Selva');

INSERT INTO exibicao (id_habitat, data_inicio, data_fim, nome, descricao)
VALUES (2, TO_DATE('2024-08-19', 'YYYY-MM-DD'), TO_DATE('2027-09-28', 'YYYY-MM-DD'), 'Poderosa Gloria', 'Exibicao mostrando a alimentacao e dia a dia dos hipopotamos.');

INSERT INTO exibicao (id_habitat, data_inicio, data_fim, nome, descricao)
VALUES (3, TO_DATE('2024-06-15', 'YYYY-MM-DD'), TO_DATE('2028-06-20', 'YYYY-MM-DD'), 'Pinguim fofinho', 'Aprecie um pinguim com habitos explosivos');

INSERT INTO exibicao (id_habitat, data_inicio, data_fim, nome, descricao)
VALUES (4, TO_DATE('2014-04-30', 'YYYY-MM-DD'), TO_DATE('2048-09-20', 'YYYY-MM-DD'), 'O Mamute das Eras', 'Veja o primeiro clone de um animal da Era do Gelo trazida de volta em toda sua imponência');

INSERT INTO exibicao (id_habitat, data_inicio, data_fim, nome, descricao)
VALUES (5, TO_DATE('2024-08-19', 'YYYY-MM-DD'), TO_DATE('2030-09-20', 'YYYY-MM-DD'), 'O Dorminhoco Sid', 'Mostre o Sid pra sentir a paz da natureza');

INSERT INTO exibicao (id_habitat, data_inicio, data_fim, nome, descricao)
VALUES (6, TO_DATE('2024-08-03', 'YYYY-MM-DD'), TO_DATE('2029-09-20', 'YYYY-MM-DD'), 'Raposa com poder inestimavel', 'Assista a furiosa raposa de 9 caudas e sinta seu poder');

--INSERINDO VISITANTE

INSERT INTO visitante (cpf_visitante, email, fone)
VALUES ('01111111111', 'chvmv@cin.ufpe.br', '5581992005097');

INSERT INTO visitante (cpf_visitante, email, fone)
VALUES ('02222222222', 'frtb@cin.ufpe.br', '5581922222222');

INSERT INTO visitante (cpf_visitante, email, fone)
VALUES ('03333333333', 'vsll@cin.ufpe.br', '5581933333333');

INSERT INTO visitante (cpf_visitante, email, fone)
VALUES ('04444444444', 'vd@cin.ufpe.br', '5581944528947');

INSERT INTO visitante (cpf_visitante, email, fone)
VALUES ('05555555555', 'caguedes@cin.ufpe.br', '5581925545639');

--INSERINDO FUNCIONARIO

INSERT INTO funcionario (cpf_funcionario, cargo, data_contratacao, email, fone, salario)
VALUES ('12222222222', 'Gerente Geral', TO_DATE('1999-08-19', 'YYYY-MM-DD'), 'kks@cin.ufpe.br', '5581912345678', 15000.000);

INSERT INTO funcionario (cpf_funcionario, cpf_gerente, cargo, data_contratacao, email, fone, salario)
VALUES ('07777777777', '12222222222', 'Cuidador do Leao', TO_DATE('2024-08-19', 'YYYY-MM-DD'), 'frtb@cin.ufpe.br', '558123568451', 5000.000);

INSERT INTO funcionario (cpf_funcionario, cpf_gerente, cargo, data_contratacao, email, fone, salario)
VALUES ('08888888888', '12222222222', 'Cuidador do Hipopotamo', TO_DATE('2022-08-19', 'YYYY-MM-DD'), 'nuz@cin.ufpe.br', '5581912653247', 8000.000);

INSERT INTO funcionario (cpf_funcionario, cpf_gerente, cargo, data_contratacao, email, fone, salario)
VALUES ('09999999999', '12222222222', 'Cuidador do Pinguim', TO_DATE('2021-09-18', 'YYYY-MM-DD'), 'ssu@cin.ufpe.br', '5581978652341', 2000.000);

INSERT INTO funcionario (cpf_funcionario, cpf_gerente, cargo, data_contratacao, email, fone, salario)
VALUES ('11111111111', '12222222222', 'Cuidador do Mamute', TO_DATE('2023-01-14', 'YYYY-MM-DD'), 'skh@cin.ufpe.br', '5581997453201', 50000.000);

INSERT INTO funcionario (cpf_funcionario, cpf_gerente, cargo, data_contratacao, email, fone, salario)
VALUES ('13333333333', '12222222222', 'Cuidador da Preguica', TO_DATE('2020-09-09', 'YYYY-MM-DD'), 'rkl@cin.ufpe.br', '5581973916428', 100.000);

INSERT INTO funcionario (cpf_funcionario, cpf_gerente, cargo, data_contratacao, email, fone, salario)
VALUES ('14444444444', '12222222222', 'Cuidador da Raposa', TO_DATE('2019-11-13', 'YYYY-MM-DD'), 'lo@cin.ufpe.br', '558194967585', 35000.000);

--INSERINDO VISITANTE_HABITAT

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('01111111111', 1, TO_DATE('2012-02-19', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('02222222222', 2, TO_DATE('2026-03-12', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('03333333333', 3, TO_DATE('2024-08-19', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('04444444444', 4, TO_DATE('2020-05-29', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('05555555555', 6, TO_DATE('2024-08-19', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('02222222222', 3, TO_DATE('2022-11-09', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('04444444444', 3, TO_DATE('2018-11-09', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('03333333333', 3, TO_DATE('2019-07-09', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('01111111111', 1, TO_DATE('2012-02-20', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('05555555555', 1, TO_DATE('2012-02-20', 'YYYY-MM-DD'));

INSERT INTO visitante_habitat (cpf_visitante_vh, id_habitat_vh, data_visita)
VALUES ('02222222222', 2, TO_DATE('2024-08-19', 'YYYY-MM-DD'));

--INSERINDO DATA_VISITAS

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES (TO_DATE('2012-02-19', 'YYYY-MM-DD'), '01111111111');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES (TO_DATE('2026-03-12', 'YYYY-MM-DD'), '02222222222');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES (TO_DATE('2024-08-19', 'YYYY-MM-DD'), '03333333333');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES (TO_DATE('2020-05-29', 'YYYY-MM-DD'), '04444444444');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES (TO_DATE('2024-08-19', 'YYYY-MM-DD'), '05555555555');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES (TO_DATE('2020-05-12', 'YYYY-MM-DD'), '01111111111');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES  (TO_DATE('2027-12-12', 'YYYY-MM-DD'), '01111111111');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES (TO_DATE('2015-01-01', 'YYYY-MM-DD'), '02222222222');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES  (TO_DATE('2028-09-28', 'YYYY-MM-DD'), '04444444444');

INSERT INTO data_visitas (data_visita, cpf_visitante_dv)
VALUES  (TO_DATE('2017-10-11', 'YYYY-MM-DD'), '05555555555');


--INSERINDO REVIEWS

INSERT INTO review (id, nota, cpf_visitante_r, id_habitat_r, data_visita_r)
VALUES (1, 10, '01111111111', 1, TO_DATE('2012-02-19', 'YYYY-MM-DD'));

INSERT INTO review (id, nota, cpf_visitante_r, id_habitat_r, data_visita_r)
VALUES (2, 8, '02222222222', 2, TO_DATE('2026-03-12', 'YYYY-MM-DD'));

INSERT INTO review (id, nota, cpf_visitante_r, id_habitat_r, data_visita_r)
VALUES (3, 9, '03333333333', 3, TO_DATE('2024-08-19', 'YYYY-MM-DD'));

INSERT INTO review (id, nota, cpf_visitante_r, id_habitat_r, data_visita_r)
VALUES (4, 10, '04444444444', 4, TO_DATE('2020-05-29', 'YYYY-MM-DD'));

INSERT INTO review (id, nota, cpf_visitante_r, id_habitat_r, data_visita_r)
VALUES (5, 7, '05555555555', 6, TO_DATE('2024-08-19', 'YYYY-MM-DD'));

--INSERINDO VISITA

INSERT INTO visita (cpf_visitante_v, id_habitat_v, data_de_visita)
VALUES ('01111111111', 1, TO_DATE('2012-02-19', 'YYYY-MM-DD'));

INSERT INTO visita (cpf_visitante_v, id_habitat_v, data_de_visita)
VALUES ('02222222222', 2, TO_DATE('2026-03-12', 'YYYY-MM-DD'));

INSERT INTO visita (cpf_visitante_v, id_habitat_v, data_de_visita)
VALUES ('03333333333', 3, TO_DATE('2024-08-19', 'YYYY-MM-DD'));

INSERT INTO visita (cpf_visitante_v, id_habitat_v, data_de_visita)
VALUES ('04444444444', 4, TO_DATE('2020-05-29', 'YYYY-MM-DD'));

INSERT INTO visita (cpf_visitante_v, id_habitat_v, data_de_visita)
VALUES ('05555555555', 6, TO_DATE('2024-08-19', 'YYYY-MM-DD'));

--INSERINDO ATRIBUIDO
INSERT INTO atribuido (id_animal, id_habitat, cpf_funcionario_att)
VALUES (1, 1, '07777777777');

INSERT INTO atribuido (id_animal, id_habitat, cpf_funcionario_att)
VALUES (2, 2, '08888888888');

INSERT INTO atribuido (id_animal, id_habitat, cpf_funcionario_att)
VALUES (3, 3, '09999999999');

INSERT INTO atribuido (id_animal, id_habitat, cpf_funcionario_att)
VALUES (4, 4, '11111111111');

INSERT INTO atribuido (id_animal, id_habitat, cpf_funcionario_att)
VALUES (5, 5, '13333333333');

INSERT INTO atribuido (id_animal, id_habitat, cpf_funcionario_att)
VALUES (6, 6, '14444444444');


