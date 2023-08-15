USE school;
-- populando as tabelas com dados para teste

-- para as tabelas cidade e estado, foram baixados dois arquivos, estados.csv e municipios.csv que continham todas as info
-- desejadas e a partir desses arquivos eu populei as tabelas utilizando os comandos abaixo direto na linha de comando/terminal
-- pois pelo workbench tava dando erro de permissão:

-- funcionou assim no terminal:

-- LOAD DATA LOCAL INFILE 'estados.csv'
--  	INTO TABLE state
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- IGNORE 1 LINES
-- (@codigo_uf, @uf, @nome, @latitude, @longitude, @regiao)
-- set idState = @codigo_uf, short = @uf, state_name = @nome;

-- LOAD DATA LOCAL INFILE 'municipios.csv'
	-- INTO TABLE city
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- IGNORE 1 LINES
-- (@codigo_ibge, @nome, @latitude, @longitude, @capital, @codigo_uf, @siafi_id, @ddd, @fuso_horario)
-- set idCity = @codigo_ibge, city_name = @nome, state_idState = @codigo_uf;
-- codigo_ibge	nome	latitude	longitude	capital	codigo_uf	siafi_id	ddd	fuso_horario

-- Porém, para facilitar, vou utilizar os métodos comuns, de INSERT INTO, mas daí como são muitos dados, só colocarei
-- 3 dados de cidade, só o necessário para testar a DB com os dados que criei.

-- inserir os dados dos estados através de INSERT INTO
INSERT INTO state (idState, short, state_name)
VALUES (11,"RO","Rondônia"),
		(12,"AC","Acre"),
		(13,"AM","Amazonas"),
		(14,"RR","Roraima"),
		(15,"PA","Pará"),
		(16,"AP","Amapá"),
		(17,"TO","Tocantins"),
		(21,"MA","Maranhão"),
		(22,"PI","Piauí"),
		(23,"CE","Ceará"),
		(24,"RN","Rio Grande do Norte"),
		(25,"PB","Paraíba"),
		(26,"PE","Pernambuco"),
		(27,"AL","Alagoas"),
		(28,"SE","Sergipe"),
		(29,"BA","Bahia"),
		(31,"MG","Minas Gerais"),
		(32,"ES","Espírito Santo"),
		(33,"RJ","Rio de Janeiro"),
		(35,"SP","São Paulo"),
		(41,"PR","Paraná"),
		(42,"SC","Santa Catarina"),
		(43,"RS","Rio Grande do Sul"),
		(50,"MS","Mato Grosso do Sul"),
		(51,"MT","Mato Grosso"),
		(52,"GO","Goiás"),
		(53,"DF","Distrito Federal");
        
-- inserir os dados de algumas cidades através do INSERT INTO
INSERT INTO city (idCity, city_name, state_idState)
VALUES (5002704,"Campo Grande",50),
	   (3550308,"São Paulo",35),
       (3304557,"Rio de Janeiro",33);

-- funções/jobtitles
INSERT INTO jobtitle (title, base_hourly_rate)
VALUES ("Diretor(a)", 80.00),
	   ("Secretário(a)", 25.00),
       ("Zelador(a)", 15.60),
       ("Cozinheiro(a)", 12.50),
       ("Professor(a)", 80.00),
	   ("Coordenador(a)", 80.00);   
SELECT * FROM jobtitle;

-- configurar os dias da semana
INSERT INTO weekday_name (day_name)
VALUES ("Domingo"), -- id 1
	   ("Segunda-feira"), -- id 2
	   ("Terça-feira"), -- id 3
       ("Quarta-feira"), -- id 4
       ("Quinta-feira"), -- id 5
       ("Sexta-feira"), -- id 6
       ("Sábado"); -- id 7
SELECT * FROM weekday_name;

-- configurar os anos considerando que a escola abriu as portas em 2020
INSERT INTO years (value)
VALUES (2020), -- id 1
	   (2021), -- id 2
       (2022), -- id 3
       (2023); -- id 4
SELECT * FROM years;

-- tabela referente as matérias ofertadas (subject)
INSERT INTO subject (title, descript)
VALUES ("Matemática I", "Álgebra"),
	   ("Matemática II", "Geometria"),
       ("Língua portuguesa", "Gramática da língua portuguesa formal"),
       ("Redação", "Escrita em diferentes estruturas de texto"),
       ("Biologia I", null),
       ("Biologia II", null),
       ("Química I", "Química inorgânica"),
       ("Química II", "Química orgânica"),
       ("Física I", null),
       ("Física II", null),
       ("Língua estrangeira: Inglês", "Gramática e conversação da língua inglesa"),
       ("Educação física", "Teoria e prática de esportes e atividades físicas"),
       ("História", "História do Brasil e do mundo"),
       ("Geografia", "Geografia física, econômica e geral do Brasil e do mundo"),
       ("Atualidades", "Estudo de temas atuais"),
       ("Livre", "Sem matéria definida, para horários extras, como hora dos estudos.");
SELECT * FROM subject;

-- tabela das séries que os alunos podem ser matriculados (grade)
INSERT INTO grade (title)
VALUES ("1 ANO"),
	   ("2 ANO"),
       ("3 ANO");
-- DELETE FROM grade WHERE idGrade in (5, 6, 7);
-- ALTER TABLE grade AUTO_INCREMENT = 1;
       
-- configuração inicial dos turnos de trabalho disponívels (shift)
INSERT INTO shift (start_time, end_time, descript)
VALUES ('6:30:00', '11:30:00', 'Turno 1 - turno comercial período matutino'), -- id 1
       ('13:30:00', '16:30:00', 'Turno 2 - turno comercial período vespertino'), -- id 2
       ('11:30:00', '14:30:00', 'Turno 3 - turno alternativo pré-almoço'), -- id 3
       ('16:30:00', '21:30:00', 'Turno 4 - turno alternativo pós-almoço'), -- id 4
       ('7:00:00', '12:00:00', 'Turno 1 - turno comercial período matutino 2'), -- id 5
	   ('14:00:00', '17:00:00', 'Turno 2 - turno comercial período vesperti 2'), -- id 6
       ('7:30:00', '13:30:00', 'Turno 7 - turno cozinha');
SELECT * FROM shift;
-- configuração inicial dos horários das aulas. Cada tempo de aula tem 50 min, que é o valor de 1 hora aula. 
-- (tabela class_schedule)
INSERT INTO class_schedule (start_time, end_time, descript)
VALUES ('7:00:00', '7:50:00', '1 tempo matutino'), -- id 1
       ('7:50:01', '8:40:00', '2 tempo matutino'), -- id 2
       ('8:40:01', '9:30:00', '3 tempo matutino'), -- id 3
       ('9:30:01', '9:40:00', 'Intervalo'), -- id 4
       ('9:40:01', '10:30:00', '4 tempo matutino'), -- id 5
       ('10:30:01', '11:20:00', '5 tempo matutino'), -- id 6
       ('11:20:01', '12:10:00', '6 tempo matutino'), -- id 7
       ('14:00:00', '14:50:00', '1 tempo vespertino'), -- id 8
       ('14:50:01', '15:40:00', '2 tempo vespertino'), -- id 9
       ('15:40:01', '16:30:00', '3 tempo vespertino'); -- id 10
SELECT * FROM class_schedule;

-- criação das turmas de alunos da escola (ex 1 ANO A, 1 ANO B, 2 ANO A, 2 ANO B...)
-- (tabela classgroup)
INSERT INTO classgroup (years_idYears, grade_idGrade, name)
VALUES (4, 1, "1 ANO A"),
	   (4, 2, "2 ANO A"),
       (4, 3, "3 ANO A"),
	   (1, 1, "1 ANO A"),
	   (1, 2, "2 ANO A"),
       (1, 3, "3 ANO A"),
       (2, 1, "1 ANO A"),
	   (2, 2, "2 ANO A"),
       (2, 3, "3 ANO A"),
       (3, 1, "1 ANO A"),
	   (3, 2, "2 ANO A"),
       (3, 3, "3 ANO A");
-- SELECT idClass as ID, 
	   -- CONCAT(name, '-', value) AS TURMA 
-- FROM classgroup JOIN years ON years_idYears = idYears;
-- SELECT idClass as ID, 
	--   name AS TURMA, 
    --   value AS ANO
-- FROM classgroup JOIN years ON years_idYears = idYears;
-- SELECT * FROM years;
-- SELECT * FROM grade;

-- criando os cursos para as matérias ofertadas (tabela course)
INSERT INTO course (grade_idGrade, subject_idSubject, Lvl, cname, unique_id, weekly_hour_class)
VALUES (1, 1, '1', 'Matemática 1', 'MAT001001', 4),
	   (1, 2, '1', 'Matemática 2', 'MAT001002', 4),
       (1, 3, '1', 'Português', 'POR001003', 3),
       (1, 4, '1', 'Redação', 'RED001004', 4),
       (1, 5, '1', 'Biologia 1', 'BIO001005', 3),
       (1, 6, '1', 'Biologia 2', 'BIO001006', 3),
       (1, 7, '1', 'Química 1', 'QUI001007', 3),
       (1, 8, '1', 'Química 2', 'QUI001008', 3),
       (1, 9, '1', 'Física 1', 'FIS001009', 3),
       (1, 10, '1', 'Física 2', 'FIS001010', 3),
       (1, 11, '1', 'Inglês', 'ING001011', 2),
       (1, 12, '1', 'Educação Física', 'EDF001012', 3),
       (1, 13, '1', 'História', 'HIS001013', 3),
       (1, 14, '1', 'Geografia', 'GEO001014', 3),
       (1, 15, '1', 'Atualidades', 'ATU001015', 1),
       (2, 1, '2', 'Matemática 1', 'MAT002001', 4),
	   (2, 2, '2', 'Matemática 2', 'MAT002002', 4),
       (2, 3, '2', 'Português', 'POR002003', 3),
       (2, 4, '2', 'Redação', 'RED002004', 4),
       (2, 5, '2', 'Biologia 1', 'BIO002005', 3),
       (2, 6, '2', 'Biologia 2', 'BIO002006', 3),
       (2, 7, '2', 'Química 1', 'QUI002007', 3),
       (2, 8, '2', 'Química 2', 'QUI002008', 3),
       (2, 9, '2', 'Física 1', 'FIS002009', 3),
       (2, 10, '2', 'Física 2', 'FIS002010', 3),
       (2, 11, '2', 'Inglês', 'ING002011', 2),
       (2, 12, '2', 'Educação Física', 'EDF002012', 3),
       (2, 13, '2', 'História', 'HIS002013', 3),
       (2, 14, '2', 'Geografia', 'GEO002014', 3),
       (2, 15, '2', 'Atualidades', 'ATU002015', 1),
       (3, 1, '3', 'Matemática 1', 'MAT003001', 3),
	   (3, 2, '3', 'Matemática 2', 'MAT003002', 3),
       (3, 3, '3', 'Português', 'POR003003', 3),
       (3, 4, '3', 'Redação', 'RED003004', 4),
       (3, 5, '3', 'Biologia 1', 'BIO003005', 2),
       (3, 6, '3', 'Biologia 2', 'BIO003006', 2),
       (3, 7, '3', 'Química 1', 'QUI003007', 2),
       (3, 8, '3', 'Química 2', 'QUI003008', 2),
       (3, 9, '3', 'Física 1', 'FIS003009', 2),
       (3, 10, '3', 'Física 2', 'FIS003010', 2),
       (3, 11, '3', 'Inglês', 'ING003011', 2),
       (3, 16, '3', 'Estudos', 'EST003012', 15),
       (3, 13, '3', 'História', 'HIS003013', 2),
       (3, 14, '3', 'Geografia', 'GEO003014', 2),
       (3, 15, '3', 'Atualidades', 'ATU003015', 1);
-- SELECT * FROM course;

-- SELECT * FROM class_schedule;
-- SELECT * FROM grade;
-- SELECT * FROM subject;

-- tabela pessoa (person)
-- DESC person;
INSERT INTO person (pname, psurname, birthd, gender_id, cpf, email, tel, street_name, address_number, neighborhood, city_idCity, state_idState, ext)
VALUES ("Marcelo", "Hokawa", "1987-10-01", "H", "12345678901", "marcelohokawa@gmail.com", "67987898345", "Rua dos Ipês", 54, "Vila das Flores", 5002704, 50, null),
	   ("Ana Marcela", "Gouveia Lins", "1989-11-10", "M", "45678901234", "profanagouveia@gmail.com", "67997543469", "Av Independência", 1077, "Centro", 5002704, 50, "apt 560"),
       ("Ricardo", "Hokama", "1985-08-05", "H", "78901234567", "richokama@gmail.com", "67995657676", "Rua dos Ipês", 104, "Vila das Flores", 5002704, 50, null),
       ("Jacinto", "Kekleo", "1977-03-17", "H", "00012345678", "jk345@outlook.com", "67994535443", "Avenida Cesar Asas", 8765, "Jardim dos Estados", 5002704, 50, "apt 15"),
       ("Edneia", "Macedo Ulisses", "1979-05-02", "M", "22234567890", "edneiaul2@gmail.com", "67988779898", "Rua da Barra", 22, "Vila Sobrinho", 5002704, 50, null),
       ("Paulo Otávio", "Magnolia", "1989-10-19", "H", "76543256788", "pmagnolia@gmail.com", "67887775676", "Rua Cerquilho", 700, "Vila Interior", 5002704, 50, "apt 560"),
       ("Guilherme", "Molho", "1991-06-03", "H", "87678855643", "guimol23@gmail.com", "67988889090", "Rua Maringá", 44, "Jardim Paraná", 5002704, 50, null),
       ("Carla Julia", "Morato Goulart", "1991-04-30", "M", "76765798745", "carlinhamoratog@gmail.com", "67978774545", "Rua do Interior", 145, "Vila Interior", 5002704, 50, null),
       ("Carolina", "Azevedo Alameda", "1982-07-20", "M", "98789678564", "carolazev@hotmail.com", "67998672222", "Av da Celebração", 788, "Lar do Trabalhador", 5002704, 50, "apt 210"),
       ("Ilton Augusto", "Souza Pereira", "1984-08-10", "H", "87654321567", "iltaugsp@gmail.com", "67997658899", "Rua Lorraine Pereira", 77, "Lar do Trabalhador", 5002704, 50, null),
       ("Hugo", "Morato Mellier", "1990-12-15", "H", "78865237905", "hmm_@gmail.com", "67997553868", "Avenida do Estado", 122, "Centro", 5002704, 50, "apt 222"),
       ("João Paulo", "Amigo", "1991-07-20", "H", "08898567463", "jpa12@gmail.com", "67998996787", "Rua dos Ipês", 444, "Vila das Flores", 5002704, 50, null),
       ("Corina", "Dandaleu Pirineu", "1989-03-10", "M", "98798067587", "corinadp@gmail.com", "67994563254", "Alameda das Flores", 5678, "Vila das Flores", 5002704, 50, "apt 5610"),
       ("Matheus", "Margarida", "1979-01-01", "H", "00078976754", "mamag@outlook.com", "67977675544", "Rua da Floresta", 564, "Vila das Flores", 5002704, 50, null),
       ("Gabriela", "Gonçalves Alíquota", "1980-08-24", "M", "08976754677", "gabalq@gmail.com", "67998798787", "Rua das Almas", 354, "São Francisco", 5002704, 50, null),
       ("Rosana", "Kiscuidar", "1978-04-09", "M", "09876758872", "rokiscuida@gmail.com", "67998656232", "Rua do Sertão", 244, "Jardim Panamá", 5002704, 50, null),
       ("João Pedro", "Pinheiro", "2008-11-04", "H", "45678567855", "joaopedropinheiro@gmail.com", "67991288988", "Rua Copacabana", 240, "Vila Sobrinho", 5002704, 50, null),
	   ("Amanda", "Carvalho", "2007-06-11", "M", "86756486752", "acarvalho09@gmail.com", "67992346588", "Rua General Rondon", 540, "Centro", 5002704, 50, "apt 16"),
	   ("Leonardo", "Knoth", "2006-12-01", "H", "06758456723", "leoknoth@gmail.com", "67987785656", "Travessa Curta", 10, "Vila da Mata", 5002704, 50, null),
       ("Maria", "das Dores", "1970-07-24", "M", "00067857463", "mariadasd0@gmail.com", "67989890770", "Rua Parati", 23, "Nova Lima", 5002704, 50, null), -- cozinheira
	   ("José Armando", "Souza dos Santos", "1972-05-12", "H", "00567655467", "zezinhoss@hotmail.com", "67887854342", "Rua Osório Martins", 401, "Jardim Los Angeles", 5002704, 50, null), -- zelador
	   ("Edson", "Arantes de Souza", "1975-04-30", "H", "00156756489", "edarantessouza@gmail.com", "67992345676", "Avenida do Sóter", 678, "Vila das Flores", 5002704, 50, "apt 501"), -- diretor
       ("Marlene Regina", "Albuquerque", "1979-02-26", "M", "77688745632", "marleneregalb@gmail.com", "67999853439", "Rua Silva Matos", 2345, "Jardim Floriano", 5002704, 50, null), -- secretaria
       ("Tania", "Pinheiro", "1979-10-01", "M", "05407012876", "tanialsp@gmail.com", "67992814156", "Rua Copacabana", 240, "Vila Sobrinho", 5002704, 50, null), -- mãe Joao Pedro
	   ("Iolanda Maria", "Carvalho", "1979-11-06", "M", "06576534596", "iomcarvalho@gmail.com", "67992675643", "Rua General Rondon", 540, "Centro", 5002704, 50, "apt 16"), -- mãe Amanda
	   ("Augusto", "Knoth", "1974-04-13", "H", "00678576854", "augustoknoth@gmail.com", "67998687763", "Travessa Curta", 10, "Vila da Mata", 5002704, 50, null), -- pai Leonardo
       ("Juliana", "Boaventura", "1989-06-22", "M", "66756238129", "jujuboa@gmail.com", "67998769090", "Rua Parapuã", 230, "Vila Interior", 5002704, 50, null), -- secretária 2
	   ("Jamila", "Trento Souza", "1977-04-12", "M", "00653766587", "jamillatrent@gmail.com", "67977786343", "Rua das Graças", 567, "Nova Lima", 5002704, 50, null); -- cozinheira 2
-- SELECT * FROM person;
-- SELECT * FROM city JOIN state ON state_idState = idState WHERE city_name = "Campo Grande" AND short = "MS";

-- tabela de colaboradores (employee)
-- DESC employee;
-- DESC jobtitle;
-- SELECT idJobtitle, base_hourly_rate FROM jobtitle WHERE title = "Professor(a)";
-- ALTER TABLE employee MODIFY COLUMN unique_id CHAR(7) UNIQUE NOT NULL;
INSERT INTO employee (person_idPerson, jobtitle_idJobtitle, hourly_rate, teacher, unique_id)
VALUES (1, 5, 95, 1, 'AMAH001'),
	   (2, 5, 95, 1, 'AAMG002'),
       (3, 5, 90, 1, 'ARIH003'),
       (4, 5, 92, 1, 'AJAK004'),
       (5, 5, 90, 1, 'AEMU005'),
       (6, 5, 95, 1, 'APOM006'),
       (7, 5, 92, 1, 'AGUM007'),
       (8, 5, 70, 1, 'ACJM008'),
       (9, 5, 90, 1, 'ACAA009'),
       (10, 5, 93, 1, 'AIAS010'),
       (11, 5, 95, 1, 'AHMM011'),
       (12, 5, 75, 1, 'AJPA012'),
       (13, 5, 80, 1, 'ACDP013'),
       (14, 5, 88, 1, 'AMAM014'),
       (15, 5, 88, 1, 'AGGA015'),
       (16, 6, 85, 0, 'BROK016'),
       (20, 4, 12.5, 0, 'BMDD017'),
	   (21, 3, 15.6, 0, 'BJAS018'),
       (22, 1, 100, 0, 'BEAS019'),
       (23, 2, 25, 0, 'BMRA020'),
       (27, 2, 12.5, 0, 'BJUB021'),
	   (28, 4, 12.5, 0, 'BJTS022');
-- SELECT * FROM employee;
-- tabela course_classgroup
-- SELECT * FROM course;
-- DESC course;
-- DESC course_classgroup;
-- ALTER TABLE course_classgroup MODIFY COLUMN idCourse_Classgroup INT AUTO_INCREMENT;
INSERT INTO course_classgroup (course_idCourse, classgroup_idClass, years_idYears, employee_idEmployee)
VALUES (1, 1, 4, 2),
	   (2, 1, 4, 6),
       (3, 1, 4, 5),
       (4, 1, 4, 9),
       (5, 1, 4, 11),
       (6, 1, 4, 10),
       (7, 1, 4, 4),
       (8, 1, 4, 3),
       (9, 1, 4, 1),
       (10, 1, 4, 7),
       (11, 1, 4, 13),
       (12, 1, 4, 12),
       (13, 1, 4, 15),
       (14, 1, 4, 14),
       (15, 1, 4, 8),
       (16, 2, 4, 2),
       (17, 2, 4, 6),
       (18, 2, 4, 5),
       (19, 2, 4, 9),
       (20, 2, 4, 11),
       (21, 2, 4, 10),
       (22, 2, 4, 4),
       (23, 2, 4, 3),
       (24, 2, 4, 1),
       (25, 2, 4, 7),
       (26, 2, 4, 13),
       (27, 2, 4, 12),
       (28, 2, 4, 15),
       (29, 2, 4, 14),
       (30, 2, 4, 8),
       (31, 3, 4, 2),
       (32, 3, 4, 6),
       (33, 3, 4, 5),
       (34, 3, 4, 9),
       (35, 3, 4, 11),
       (36, 3, 4, 10),
       (37, 3, 4, 4),
       (38, 3, 4, 3),
       (39, 3, 4, 1),
       (40, 3, 4, 7),
       (41, 3, 4, 13),
       (42, 3, 4, 16),
       (43, 3, 4, 15),
       (44, 3, 4, 14),
       (45, 3, 4, 8),
       (1, 4, 1, 2),
	   (2, 4, 1, 6),
       (3, 4, 1, 5),
       (4, 4, 1, 9),
       (5, 4, 1, 11),
       (6, 4, 1, 10),
       (7, 4, 1, 4),
       (8, 4, 1, 3),
       (9, 4, 1, 1),
       (10, 4,1, 7),
       (11, 4, 1, 13),
       (12, 4, 1, 12),
       (13, 4, 1, 15),
       (14, 4, 1, 14),
       (15, 4, 1, 8),
       (16, 5, 1, 2),
       (17, 5, 1, 6),
       (18, 5, 1, 5),
       (19, 5, 1, 9),
       (20, 5, 1, 11),
       (21, 5, 1, 10),
       (22, 5, 1, 4),
       (23, 5, 1, 3),
       (24, 5, 1, 1),
       (25, 5, 1, 7),
       (26, 5, 1, 13),
       (27, 5, 1, 12),
       (28, 5, 1, 15),
       (29, 5, 1, 14),
       (30, 5, 1, 8),
       (31, 6, 1, 2),
       (32, 6, 1, 6),
       (33, 6, 1, 5),
       (34, 6, 1, 9),
       (35, 6, 1, 11),
       (36, 6, 1, 10),
       (37, 6, 1, 4),
       (38, 6, 1, 3),
       (39, 6, 1, 1),
       (40, 6, 1, 7),
       (41, 6, 1, 13),
       (42, 6, 1, 16),
       (43, 6, 1, 15),
       (44, 6, 1, 14),
       (45, 6, 1, 8),
       (1, 7, 2, 2),
	   (2, 7, 2, 6),
       (3, 7, 2, 5),
       (4, 7, 2, 9),
       (5, 7, 2, 11),
       (6, 7, 2, 10),
       (7, 7, 2, 4),
       (8, 7, 2, 3),
       (9, 7, 2, 1),
       (10, 7, 2, 7),
       (11, 7, 2, 13),
       (12, 7, 2, 12),
       (13, 7, 2, 15),
       (14, 7, 2, 14),
       (15, 7, 2, 8),
       (16, 8, 2, 2),
       (17, 8, 2, 6),
       (18, 8, 2, 5),
       (19, 8, 2, 9),
       (20, 8, 2, 11),
       (21, 8, 2, 10),
       (22, 8, 2, 4),
       (23, 8, 2, 3),
       (24, 8, 2, 1),
       (25, 8, 2, 7),
       (26, 8, 2, 13),
       (27, 8, 2, 12),
       (28, 8, 2, 15),
       (29, 8, 2, 14),
       (30, 8, 2, 8),
       (31, 9, 2, 2),
       (32, 9, 2, 6),
       (33, 9, 2, 5),
       (34, 9, 2, 9),
       (35, 9, 2, 11),
       (36, 9, 2, 10),
       (37, 9, 2, 4),
       (38, 9, 2, 3),
       (39, 9, 2, 1),
       (40, 9, 2, 7),
       (41, 9, 2, 13),
       (42, 9, 2, 16),
       (43, 9, 2, 15),
       (44, 9, 2, 14),
       (45, 9, 2, 8),
       (1, 10, 3, 2),
	   (2, 10, 3, 6),
       (3, 10, 3, 5),
       (4, 10, 3, 9),
       (5, 10, 3, 11),
       (6, 10, 3, 10),
       (7, 10, 3, 4),
       (8, 10, 3, 3),
       (9, 10, 3, 1),
       (10, 10, 3, 7),
       (11, 10, 3, 13),
       (12, 10, 3, 12),
       (13, 10, 3, 15),
       (14, 10, 3, 14),
       (15, 10, 3, 8),
       (16, 11, 3, 2),
       (17, 11, 3, 6),
       (18, 11, 3, 5),
       (19, 11, 3, 9),
       (20, 11, 3, 11),
       (21, 11, 3, 10),
       (22, 11, 3, 4),
       (23, 11, 3, 3),
       (24, 11, 3, 1),
       (25, 11, 3, 7),
       (26, 11, 3, 13),
       (27, 11, 3, 12),
       (28, 11, 3, 15),
       (29, 11, 3, 14),
       (30, 11, 3, 8),
       (31, 12, 3, 2),
       (32, 12, 3, 6),
       (33, 12, 3, 5),
       (34, 12, 3, 9),
       (35, 12, 3, 11),
       (36, 12, 3, 10),
       (37, 12, 3, 4),
       (38, 12, 3, 3),
       (39, 12, 3, 1),
       (40, 12, 3, 7),
       (41, 12, 3, 13),
       (42, 12, 3, 16),
       (43, 12, 3, 15),
       (44, 12, 3, 14),
       (45, 12, 3, 8);
-- SELECT * FROM course_classgroup;

-- fim da configuração inicial básica, agora inserção de dados
-- alimentando o DB com os dados que faltam (alunos, outros colaboradores, etc)
-- alunos em person
-- SELECT * FROM person;
INSERT INTO person (pname, psurname, birthd, gender_id, cpf, email, tel, street_name, address_number, neighborhood, city_idCity, state_idState, ext)
VALUES ("João Pedro", "Pinheiro", "2008-11-04", "H", "45678567855", "joaopedropinheiro@gmail.com", "67991288988", "Rua Copacabana", 240, "Vila Sobrinho", 5002704, 50, null),
	   ("Amanda", "Carvalho", "2007-06-11", "M", "86756486752", "acarvalho09@gmail.com", "67992346588", "Rua General Rondon", 540, "Centro", 5002704, 50, "apt 16"),
	   ("Leonardo", "Knoth", "2006-12-01", "H", "06758456723", "leoknoth@gmail.com", "67987785656", "Travessa Curta", 10, "Vila da Mata", 5002704, 50, null);

-- responsáveis pelos alunos
INSERT INTO person (pname, psurname, birthd, gender_id, cpf, email, tel, street_name, address_number, neighborhood, city_idCity, state_idState, ext)
VALUES ("Tania", "Pinheiro", "1979-10-01", "M", "05407012876", "tanialsp@gmail.com", "67992814156", "Rua Copacabana", 240, "Vila Sobrinho", 5002704, 50, null), -- mãe Joao Pedro
	   ("Iolanda Maria", "Carvalho", "1979-11-06", "M", "06576534596", "iomcarvalho@gmail.com", "67992675643", "Rua General Rondon", 540, "Centro", 5002704, 50, "apt 16"), -- mãe Amanda
	   ("Augusto", "Knoth", "1974-04-13", "H", "00678576854", "augustoknoth@gmail.com", "67998687763", "Travessa Curta", 10, "Vila da Mata", 5002704, 50, null); -- pai Leonardo
       
-- outros funcionarios em person
INSERT INTO person (pname, psurname, birthd, gender_id, cpf, email, tel, street_name, address_number, neighborhood, city_idCity, state_idState, ext)
VALUES ("Maria", "das Dores", "1970-07-24", "M", "00067857463", "mariadasd0@gmail.com", "67989890770", "Rua Parati", 23, "Nova Lima", 5002704, 50, null), -- cozinheira
	   ("José Armando", "Souza dos Santos", "1972-05-12", "H", "00567655467", "zezinhoss@hotmail.com", "67887854342", "Rua Osório Martins", 401, "Jardim Los Angeles", 5002704, 50, null), -- zelador
	   ("Edson", "Arantes de Souza", "1975-04-30", "H", "00156756489", "edarantessouza@gmail.com", "67992345676", "Avenida do Sóter", 678, "Vila das Flores", 5002704, 50, "apt 501"), -- diretor
       ("Marlene Regina", "Albuquerque", "1979-02-26", "M", "77688745632", "marleneregalb@gmail.com", "67999853439", "Rua Silva Matos", 2345, "Jardim Floriano", 5002704, 50, null), -- secretaria
	   ("Juliana", "Boaventura", "1989-06-22", "M", "66756238129", "jujuboa@gmail.com", "67998769090", "Rua Parapuã", 230, "Vila Interior", 5002704, 50, null), -- secretária 2
	   ("Jamila", "Trento Souza", "1977-04-12", "M", "00653766587", "jamillatrent@gmail.com", "67977786343", "Rua das Graças", 567, "Nova Lima", 5002704, 50, null); -- cozinheira 2

-- adicionando os novos funcionarios a tabela de colaboradores (employee)
-- SELECT * FROM person;
-- SELECT * FROM jobtitle;
-- SELECT * FROM employee;

-- alimentando a tabela de alunos (student)
-- SELECT * FROM person; -- ids 17 joao 1 ano, 18 amanda 2 ano, 19 leo 3 ano
-- DESC student;
INSERT INTO student (person_idPerson, unique_id)
VALUES (17, 'SJPP001'),
       (18, 'SAMC002'),
       (19, 'SLEK003');

-- criando os historicos para cada aluno (transcript)
-- DESC transcript;
INSERT INTO transcript (student_idStudent)
VALUES (1), -- transcript joao
	   (2), -- transcript amanda
       (3); -- transcript leonardo

-- inserindo os dados para criar a ligação entre o histórico, a matéria, e futuramente, as notas (transcriot_course_cg)
-- DESC transcript_course_cg;
-- SELECT * FROM transcript;
-- SELECT * FROM course_classgroup; -- 1 ANO A ids (); 2 ANO A ids (); 3 ANO A ids ()
-- SELECT idCourse_Classgroup FROM course_classgroup WHERE classgroup_idClass = 3;
-- SELECT * FROM classgroup; -- 1 ANO A 2023 - id 1; 2 ANO A 2023 - id 2; 3 ANO A 2023 - id 3
INSERT INTO transcript_course_cg (transcript_idTranscript, course_classgroup_idCourse_Classgroup)
VALUES (1, 1),
	   (1, 2),
       (1, 3),
       (1, 4),
       (1, 5),
       (1, 6),
       (1, 7),
       (1, 8),
       (1, 9),
       (1, 10),
       (1, 11),
       (1, 12),
       (1, 13),
       (1, 14),
       (1, 15),
	   (2, 16),
       (2, 17),
       (2, 18),
       (2, 19),
       (2, 20),
       (2, 21),
       (2, 22),
       (2, 23),
       (2, 24),
       (2, 25),
       (2, 26),
       (2, 27),
       (2, 28),
       (2, 29),
       (2, 30),
       (3, 31),
       (3, 32),
       (3, 33),
       (3, 34),
       (3, 35),
       (3, 36),
       (3, 37),
       (3, 38),
       (3, 39),
       (3, 40),
       (3, 41),
       (3, 42),
       (3, 43),
       (3, 44),
       (3, 45);
       
-- alimentando a tabela de responsáveis com os dados dos respnsávels em person
-- SELECT * FROM person; -- ids 24 tania, 25 iolanda, 26 augusto
-- DESC representative;
INSERT INTO representative (person_idPerson)
VALUES (24), -- id 1 mae joao id student 1
       (25), -- mae amanda id student 2
       (26); -- pai leonardo id student 3
-- tabela de ligação entre aluno e responsável
-- DESC student_representative;
-- SELECT * FROM student;
INSERT INTO student_representative (student_idStudent, representative_idRepresentative, relationship)
VALUES (1, 1, "Mãe"),
	   (2, 2, "Mãe"),
       (3, 3, "Pai");
-- DESC person;
-- SELECT * FROM student_representative;

-- agora designar turnos aos colaboradores
-- DESC employee_shift;
-- SELECT * FROM employee;
-- SELECT * FROM weekday_name;
-- SELECT * FROM shift;
INSERT INTO employee_shift (employee_idEmployee, weekday_idWeekday, 
							shift_idShift, years_idYears)
VALUES (16, 2, 5, 4), -- coordenadora
	   (16, 2, 6, 4),
       (16, 3, 5, 4),
	   (16, 3, 6, 4),
       (16, 4, 5, 4),
	   (16, 4, 6, 4),
       (16, 5, 5, 4),
	   (16, 5, 6, 4),
       (16, 6, 5, 4),
	   (16, 6, 6, 4),
	   (17, 2, 7, 4), -- cozinheira
       (17, 3, 7, 4),
       (17, 4, 7, 4),
       (17, 5, 7, 4), 
       (17, 6, 7, 4), 
       (18, 2, 1, 4), -- zelador
       (18, 2, 2, 4),
       (18, 3, 1, 4),
       (18, 3, 2, 4),
       (18, 4, 1, 4),
       (18, 4, 2, 4),
       (18, 5, 1, 4),
       (18, 5, 2, 4),
       (18, 6, 1, 4),
       (18, 6, 2, 4),
       (19, 2, 5, 4), -- diretor
       (19, 2, 6, 4),
       (19, 3, 5, 4),
       (19, 3, 6, 4),
       (19, 4, 5, 4),
       (19, 4, 6, 4),
       (19, 5, 5, 4),
       (19, 5, 6, 4),
       (19, 6, 5, 4),
       (19, 6, 6, 4),
       (20, 2, 5, 4), -- secretária 1
       (20, 2, 6, 4),
       (20, 3, 5, 4),
       (20, 3, 6, 4),
       (20, 4, 5, 4),
       (20, 4, 6, 4),
       (20, 5, 5, 4),
       (20, 5, 6, 4),
       (20, 6, 5, 4),
       (20, 6, 6, 4),
	   (21, 2, 3, 4), -- secretária 2
       (21, 2, 4, 4),
       (21, 3, 3, 4),
       (21, 3, 4, 4),
       (21, 4, 3, 4),
       (21, 4, 4, 4),
       (21, 5, 3, 4),
       (21, 5, 4, 4),
       (21, 6, 3, 4),
       (21, 6, 4, 4),
	   (22, 2, 7, 4), -- cozinheira 2
       (22, 3, 7, 4),
       (22, 4, 7, 4),
       (22, 5, 7, 4), 
       (22, 6, 7, 4);

-- horários dos cursos (e horario de trabalho dos professores)
-- SELECT * FROM class_schedule;
-- SELECT * FROM course_classgroup;
-- DESC course_classgroup_schedule;
INSERT INTO course_classgroup_schedule (course_classgroup_idCourse_Classgroup, weekday_idWeekday, 
						                class_schedule_idClass_schedule)
VALUES (1, 2, 1), -- MAT 1 7:00 segunda-feira (1 ANO A 2023)
	   (1, 2, 2), -- MAT 1 7:50 segunda-feira( 1 ANO A 2023)
       (1, 2, 10), -- MAT 1 15:40 segunda-feira (1 ANO A 2023)
       (1, 3, 3), -- MAT 1 8:40 terça-feira (1 ANO A 2023)
       (2, 4, 1), -- MAT 2 7:00 quarta-feira (1 ANO A 2023)
       (2, 5, 10), -- MAT 2 15:40 quinta-feira (1 ANO A 2023)
       (2, 6, 2), -- MAT 2 7:50 sexta-feira (1 ANO A 2023)
       (2, 6, 3), -- MAT 2 8:40 sexta-feira (1 ANO A 2023)
       (3, 2, 5),
       (3, 2, 6),
       (3, 4, 5),
       (4, 2, 8),
       (4, 4, 6),
       (4, 4, 7),
       (5, 3, 1),
       (5, 3, 2),
       (5, 3, 8),
       (6, 3, 9),
       (6, 5, 6),
       (6, 5, 7),
       (7, 3, 5),
       (7, 3, 6),
       (7, 3, 10),
       (8, 4, 2),
       (8, 4, 3),
       (8, 4, 10),
       (9, 4, 8),
       (9, 5, 1),
       (9, 5, 2),
       (10, 4, 9),
       (10, 6, 6),
       (10, 6, 7),
       (11, 2, 3),
       (11, 6, 1),
       (12, 6, 8),
       (12, 6, 9),
       (12, 6, 10),
       (13, 5, 3),
       (13, 5, 5),
       (13, 5, 8),
       (14, 2, 7),
       (14, 3, 7),
       (14, 5, 9),
       (15, 6, 5),
	   (16, 2, 5), -- MAT 1 9:40 segunda-feira (2 ANO A 2023)
	   (16, 2, 6),
       (16, 3, 7),
	   (16, 3, 10),
       (17, 4, 5),
       (17, 6, 6),
       (17, 6, 7),
       (17, 6, 10),
       (18, 2, 1),
       (18, 2, 2),
       (18, 4, 1),
       (19, 3, 8),
       (19, 3, 9),
       (19, 4, 2),
       (19, 4, 3),
       (20, 3, 5),
	   (20, 3, 6),
	   (20, 4, 8),
       (21, 4, 9),
       (21, 5, 3),
       (21, 5, 5),
       (22, 3, 1),
       (22, 3, 2),
       (22, 4, 10),
       (23, 2, 10),
       (23, 4, 6),
       (23, 4, 7),
       (24, 2, 8),
       (24, 5, 6),
       (24, 5, 7),
       (25, 2, 9),
       (25, 6, 2),
       (25, 6, 3),
       (26, 2, 7),
       (26, 6, 5),
       (27, 5, 8),
       (27, 5, 9),
       (27, 5, 10),
       (28, 5, 1),
       (28, 5, 2),
       (28, 6, 8),
       (29, 2, 3),
       (29, 3, 3),
       (29, 6, 9),
       (30, 6, 1),
       (31, 2, 7), -- MAT 1 Segunda-feira 11:20 (3 ANO A)
       (31, 3, 5),
       (31, 3, 6),
       (32, 3, 7),
       (32, 4, 6),
       (32, 4, 7),
       (33, 3, 1),
       (33, 3, 2),
       (33, 4, 2),
       (34, 6, 1),
       (34, 6, 2),
       (35, 2, 3),
       (35, 2, 5),
       (36, 5, 1),
       (36, 5, 2),
       (37, 2, 1),
       (37, 2, 2),
       (38, 6, 5),
       (38, 6, 6),
       (39, 5, 3),
       (39, 5, 5),
       (40, 4, 3),
       (40, 4, 5),
       (41, 3, 3),
       (41, 6, 7),
       (42, 2, 8),
       (42, 2, 9),
       (42, 2, 10),
       (42, 3, 8),
       (42, 3, 9),
       (42, 3, 10),
       (42, 4, 8),
       (42, 4, 9),
       (42, 4, 10),
       (42, 5, 8),
       (42, 5, 9),
       (42, 5, 10),
       (42, 6, 8),
       (42, 6, 9),
       (42, 6, 10),
       (43, 5, 6),
       (43, 5, 7),
       (44, 2, 6),
       (44, 4, 1),
       (45, 6, 3);
-- SELECT * FROM course_classgroup;


-- inserir as notas do aluno João Pedro Pinheiro

-- DESC score;
-- DESC transcript_course_cg;
-- DESC transcript;
-- DESC course_classgroup;
-- DESC course;

INSERT INTO score (transcript_course_cg_idTranscript_Course_cg, score, weight, Term)
VALUES (1, 10.0, 1, 1),
	   (2, 9.8, 1, 1),
       (3, 8.7, 1, 1),
       (4, 7.5, 1, 1),
       (5, 8.0, 1, 1),
       (6, 8.5, 1, 1),
       (7, 9.0, 1, 1),
       (8, 8.9, 1, 1),
       (9, 9.7, 1, 1),
       (10, 10.0, 1, 1),
       (11, 10.0, 1, 1),
       (12, 10.0, 1, 1),
       (13, 9.0, 1, 1),
       (14, 10.0, 1, 1),
       (15, 9.0, 1, 1),
       (1, 10.0, 2, 1),
	   (2, 10.0, 2, 1),
       (3, 8.5, 2, 1),
       (4, 8.0, 2, 1),
       (5, 8.0, 2, 1),
       (6, 8.6, 2, 1),
       (7, 10.0, 2, 1),
       (8, 9.8, 2, 1),
       (9, 10.0, 2, 1),
       (10, 10.0, 2, 1),
       (11, 10.0, 2, 1),
       (12, 10.0, 2, 1),
       (13, 8.9, 2, 1),
       (14, 9.4, 2, 1),
       (15, 10.0, 2, 1),
       (1, 9.8, 1, 2),
	   (2, 10.0, 1, 2),
       (3, 7.8, 1, 2),
       (4, 8.5, 1, 2),
       (5, 8.3, 1, 2),
       (6, 8.8, 1, 2),
       (7, 10.0, 1, 2),
       (8, 10.0, 1, 2),
       (9, 10.0, 1, 2),
       (10, 10.0, 1, 2),
       (11, 10.0, 1, 2),
       (12, 10.0, 1, 2),
       (13, 9.4, 1, 2),
       (14, 9.0, 1, 2),
       (15, 10.0, 1, 2),
       (1, 10.0, 2, 2),
	   (2, 10.0, 2, 2),
       (3, 8.0, 2, 2),
       (4, 8.0, 2, 2),
       (5, 8.0, 2, 2),
       (6, 8.5, 2, 2),
       (7, 9.9, 2, 2),
       (8, 9.8, 2, 2),
       (9, 10.0, 2, 2),
       (10, 9.5, 2, 2),
       (11, 10.0, 2, 2),
       (12, 10.0, 2, 2),
       (13, 8.9, 2, 2),
       (14, 10.0, 2, 2),
       (15, 10.0, 2, 2);

