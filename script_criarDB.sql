CREATE DATABASE school;
USE school;
-- DROP DATABASE nova_escola;
-- SHOW TABLES;


--  criei essas tabelas aqui


-- estado
CREATE TABLE state(
	idState INT,
    short CHAR(2),
    state_name VARCHAR(20),
    PRIMARY KEY (idState)
);

-- cidade
CREATE TABLE city(
	idCity INT,
    city_name VARCHAR(50),
    state_idState INT,
    PRIMARY KEY (idCity),
    CONSTRAINT fk_city_state FOREIGN KEY (state_idState) REFERENCES state(idState)
);

-- tabela referente a cada pessoa relacionada a entidade escola, de modo geral, sem especialização de papéis
CREATE TABLE person(
	idPerson INT PRIMARY KEY AUTO_INCREMENT,
	pname VARCHAR(15) NOT NULL,
    psurname VARCHAR(40),
	birthd DATE,
	gender_id ENUM("H", "M", "N"),
	cpf CHAR(11),
	email VARCHAR(50),
    tel VARCHAR(11),
    street_name VARCHAR(40),
    address_number INT,
    neighborhood VARCHAR(40),
    city_idCity INT,
    state_idState INT,
    ext VARCHAR(10),
    CONSTRAINT fk_person_city FOREIGN KEY (city_idCity) REFERENCES city (idCity),
    CONSTRAINT fk_person_state FOREIGN KEY (state_idState) REFERENCES state (idState)
);
-- ALTER TABLE person ADD COLUMN ext VARCHAR(10);

-- tabela com o nome das funções e um salário inicial base que deverá ser usado para definir o salário do contratado, podendo
-- ser exatamente o mesmo que o base, ou próximo.
CREATE TABLE jobtitle(
	idJobtitle INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(45),
    base_hourly_rate FLOAT
);

-- tabela com informações dos colaboradores. No caso do colaborador ser um professor (atributo teacher = 1), as informações 
-- sobre seus turnos de trabalho estarão obrigatoriamente associados a tabela de horário de aula (class_schedule) e o cálculo 
-- do seu salário deverá ser feito a partir dela, enquanto se o colaborador não for um professor (atributo teacher = 0),
-- essas informações deverão estar associadas a tabela de turnos (shift).
CREATE TABLE employee(
	idEmployee INT NOT NULL AUTO_INCREMENT,
    person_idPerson INT NOT NULL,
    jobtitle_idJobtitle INT NOT NULL,
    hourly_rate FLOAT,
    teacher BOOLEAN DEFAULT False,
	unique_id CHAR(7) UNIQUE NOT NULL,
    PRIMARY KEY (idEmployee, person_idPerson),
    CONSTRAINT fk_employee_person FOREIGN KEY (person_idPerson) REFERENCES person (idPerson) ON DELETE CASCADE,
    CONSTRAINT fk_employee_jobtitle FOREIGN KEY (jobtitle_idJobtitle) REFERENCES jobtitle (idJobtitle)
);

-- tabela de alunos
CREATE TABLE student(
	idStudent INT AUTO_INCREMENT,
    person_idPerson INT,
    unique_id CHAR(7) UNIQUE NOT NULL,
    PRIMARY KEY (idStudent, person_idPerson),
    CONSTRAINT fk_student_person FOREIGN KEY (person_idPerson) REFERENCES person(idPerson) ON DELETE CASCADE
);

-- tabela de responsáveis.
CREATE TABLE representative(
	idRepresentative INT AUTO_INCREMENT,
    person_idPerson INT,
    PRIMARY KEY (idRepresentative, person_idPerson),
    CONSTRAINT fk_representative_person FOREIGN KEY (person_idPerson) REFERENCES person(idPerson) ON DELETE CASCADE
);

-- tabela dos turnos padronizados. Escola abre as 6, por exemplo, mas as aulas começam as 7, porém, alguns colaboradores
-- já devem estar trabalhando desde as 6 e por padrão o turno da manhã vai até as 12, por exemplo. Se o colaborador for
-- um professor, seu turno não é associado a essa tabela, e sim a tabela de horario de aulas (class_schedule)
CREATE TABLE shift(
	idShift INT PRIMARY KEY AUTO_INCREMENT,
    start_time TIME,
    end_time TIME,
    descript VARCHAR(45)
);

-- tabela que contém os horários das aulas pré-estabelecidos e padronizados, por exemplo, o primeiro tempo vai das 7 as 7:50
-- criada tabela separada do turno (shift) para não misturar e ficar mais fácil na hora de buscar apenas os horarios de aula,
-- dado que os tempos das aulas tem duração de 50 min e os turnos podem ser bem mais longos, como por exemplo, das 7 as 12.
CREATE TABLE class_schedule(
	idClass_schedule INT PRIMARY KEY AUTO_INCREMENT,
    start_time TIME,
    end_time TIME,
    descript VARCHAR(45)
);

-- tabela com os nomes dos dias da semana para que eles sejam padronizados nos horários, facilitando a busca e verificação
-- se horários de aulas e/ou turnos estão colidindo (clashing).
CREATE TABLE weekday_name(
	idWeekday INT AUTO_INCREMENT PRIMARY KEY,
    day_name VARCHAR(15) NOT NULL
);

-- tabela com os anos de funcionamento da escola, assim fica padronizado para busca e criação de novas turmas/matrículas de
-- alunos
CREATE TABLE years(
	idYears INT PRIMARY KEY AUTO_INCREMENT,
    value YEAR
);

-- tabela com as matérias ofertadas pela escola, por exemplo Matemática I é uma matéria que pode estar associada a 1 ou 
-- mais cursos, cada curso possuindo apenas uma matéria associada, uma turma
CREATE TABLE subject(
	idSubject INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(45) NOT NULL,
    descript VARCHAR(255)
);
-- tabela das séries ofertadas, por exemplo, essa é uma escola de ensino médio, entào as séries serão 1 ANO, 2 ANO, 3 ANO
CREATE TABLE grade(
	idGrade INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(8) NOT NULL UNIQUE
);
-- tabela de turmas, por exemplo 1 ANO A, ou 1 ANO B
CREATE TABLE classgroup(
	idClass INT AUTO_INCREMENT,
    years_idYears INT NOT NULL,
    grade_idGrade INT NOT NULL,
    name VARCHAR(10),
    PRIMARY KEY (idClass, years_idYears, grade_idGrade),
    CONSTRAINT fk_class_years FOREIGN KEY (years_idYears) REFERENCES years(idYears),
    CONSTRAINT fk_class_grade FOREIGN KEY (grade_idGrade) REFERENCES grade(idGrade)
);
-- tabela dos cursos oferecidos (cada curso é sobre uma matéria (subject) específica, lecionada por apenas professor,
-- ligado a apenas 1 série e também contém a informação de quantas horas-aula semanais serão ofertadas para aquele
-- curso, em forma de int, por exemplo,  2 horas aulas semanais equivalem a 2 tempos de aula de duração 50 min cada.
CREATE TABLE course(
	idCourse INT AUTO_INCREMENT,
    grade_idGrade INT NOT NULL,
    subject_idSubject INT NOT NULL,
    Lvl ENUM("1", "2", "3"),
    cname VARCHAR(20) NOT NULL,
    unique_id CHAR(9) UNIQUE NOT NULL,
    weekly_hour_class INT NOT NULL,
    PRIMARY KEY (idCourse, grade_idGrade, subject_idSubject),
    CONSTRAINT fk_course_grade FOREIGN KEY (grade_idGrade) REFERENCES grade(idGrade),
    CONSTRAINT fk_course_subject FOREIGN KEY (subject_idSubject) REFERENCES subject(idSubject)
);

-- tabela de histórico. Cada aluno terá apenas 1 histórico, e esse histórico estará associado a cada curso que o aluno está
-- matriculado (curso_turma - course_classgroup), ou seja, uma nova tabela que terá as chaves referenciando as notas, 
-- por exemplo
CREATE TABLE transcript(
	idTranscript INT AUTO_INCREMENT,
    student_idStudent INT,
    PRIMARY KEY (idTranscript, student_idStudent),
    CONSTRAINT fk_transcript_student FOREIGN KEY (student_idStudent) REFERENCES student(idStudent)
);


-- tabela de ligação entre alunos e seus responsáveis, já que cada aluno pode ter mais de um responsável cadastrado, no
-- caso de emergência, por exemplo, tentar contato com um e não conseguir, tentar o seguinte, mas não é obrigatório.
CREATE TABLE student_representative(
	student_idStudent INT,
	representative_idRepresentative INT,
    relationship ENUM("Pai", "Mãe", "Avô/avó", "Irmão/irmã", "Outro") DEFAULT "Mãe",
    PRIMARY KEY (student_idStudent, representative_idRepresentative),
    CONSTRAINT fk_sr_student FOREIGN KEY (student_idStudent) REFERENCES student(idStudent) ON DELETE CASCADE,
    CONSTRAINT fk_sr_representative FOREIGN KEY (representative_idRepresentative) REFERENCES 
									representative(idRepresentative) ON DELETE CASCADE
);

-- tabela de ligação do curso com a turma o qual ele está relacionado. Essa tabela relaciona cada curso a uma turma,
-- também a tabela ano, e também o professor que leciona aquele curso.
CREATE TABLE course_classgroup(
	idCourse_Classgroup INT AUTO_INCREMENT,
	course_idCourse INT,
	classgroup_idClass INT,
    years_idYears INT,
    employee_idEmployee INT NOT NULL, -- excluir esse
    PRIMARY KEY (idCourse_Classgroup, course_idCourse, classgroup_idClass, years_idYears, employee_idEmployee),
    CONSTRAINT fk_ccg_course FOREIGN KEY (course_idCourse) REFERENCES course(idCourse) ON DELETE CASCADE,
	CONSTRAINT fk_ccg_classgroup FOREIGN KEY (classgroup_idClass) REFERENCES classgroup(idClass),
    CONSTRAINT fk_ccg_years FOREIGN KEY (years_idYears) REFERENCES years(idYears),
    CONSTRAINT fk_ccg_employee FOREIGN KEY (employee_idEmployee) REFERENCES employee(idEmployee)
);


-- tabela de ligação colaborador ao turno de trabalho dele, incluindo informação de dia da semana, e, caso colaborador
-- (employee) seja professor, essa tabela também faz a ligação com qual curso_turma (course_classgroup) ele dá aula naquele
-- horário (horário_aula - class_schedule), e caso não seja professor, então a ligação será com a tabela turno (shift) ao
-- invés de class_schedule. A constraint check dará conta de permitir linhas em que ou class_schedule é nulo, ou shift 
-- é nulo, não podendo os 2 serem nulos e, caso um seja nulo, o outro não poderá ser nulo obrigatoriamente.
CREATE TABLE employee_shift(
	employee_idEmployee INT,
	shift_idShift INT,
    weekday_idWeekday INT,
    years_idYears INT,
    PRIMARY KEY (employee_idEmployee, shift_idShift, weekday_idWeekday, years_idYears),
    CONSTRAINT fk_es_employee FOREIGN KEY (employee_idEmployee) REFERENCES employee(idEmployee),
    CONSTRAINT fk_es_shift FOREIGN KEY (shift_idShift) REFERENCES shift(idShift),
    CONSTRAINT fk_es_weekday FOREIGN KEY (weekday_idWeekday) REFERENCES weekday_name(idWeekday)
);

-- curso/horario aulas
CREATE TABLE course_classgroup_schedule(
	course_classgroup_idCourse_Classgroup INT,
    weekday_idWeekday INT,
    class_schedule_idClass_schedule INT,
    PRIMARY KEY (course_classgroup_idCourse_Classgroup, weekday_idWeekday, class_schedule_idClass_schedule),
    CONSTRAINT fk_ccg_course_classgroup FOREIGN KEY (course_classgroup_idCourse_Classgroup) REFERENCES course_classgroup(idCourse_Classgroup)
																						   ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ccg_weekday FOREIGN KEY (weekday_idWeekday) REFERENCES weekday_name(idWeekday),
    CONSTRAINT fk_ccg_class_schedule FOREIGN KEY (class_schedule_idClass_schedule) REFERENCES class_schedule(idClass_schedule)
);

-- tabela ligação historico_curso_turma (transcript_course_classgroup - transcript_course_cg)
CREATE TABLE transcript_course_cg (
	idTranscript_Course_cg INT AUTO_INCREMENT,
    transcript_idTranscript INT,
    course_classgroup_idCourse_Classgroup INT,
    PRIMARY KEY (idTranscript_Course_cg, transcript_idTranscript, course_classgroup_idCourse_Classgroup),
    CONSTRAINT fk_tccg_transcript FOREIGN KEY (transcript_idTranscript) REFERENCES transcript (idTranscript) 
								  ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tccg_course_classgroup FOREIGN KEY (course_classgroup_idCourse_Classgroup) REFERENCES course_classgroup(idCourse_Classgroup)
);

-- tabela de notas. Cada nota terá um termo, que no caso de uma escola no Brasil, normalmente é por bimestre, e então
-- isso facilitará depois a buscar todas as notas de cada termo, afim de gerar um boletim, calcula média, ou historico.
-- cada nota também terá um valor FLOAT e um peso, que por DEFAULT será 1. (trabalhos, provas, atividades em sala, dessa
-- forma, podem ter pesos diferentes)
CREATE TABLE score(
	idScore INT AUTO_INCREMENT,
	transcript_course_cg_idTranscript_Course_cg INT,
    score FLOAT NOT NULL,
    weight INT NOT NULL DEFAULT 1,
    Term ENUM("1", "2", "3", "4"), -- são 4 terms nesse caso, 4 bimestres
    PRIMARY KEY (idScore, transcript_course_cg_idTranscript_Course_cg),
    CONSTRAINT fk_score_transcript_course_cg FOREIGN KEY (transcript_course_cg_idTranscript_Course_cg) 
											 REFERENCES transcript_course_cg(idTranscript_Course_cg)
);