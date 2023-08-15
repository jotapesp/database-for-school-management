-- Script com as Queries.

-- boletim de Joao Pedro
USE school;
-- DESC transcript_course_cg;
-- DESC score;
-- DESC course;
-- DESC transcript;
-- SELECT * FROM course;
SELECT course.unique_id AS CODIGO,
	   course.cname AS CURSO,
	   CASE
		WHEN ROUND((SELECT (SUM(s.score * s.weight)/SUM(s.weight))
			FROM score AS s JOIN transcript_course_cg AS tccg ON s.transcript_course_cg_idTranscript_Course_cg = tccg.idTranscript_Course_cg
			WHERE s.Term = 1 AND tccg.idTranscript_Course_cg = outer_tccg.idTranscript_Course_cg), 1) is NOT NULL
        THEN ROUND((SELECT (SUM(s.score * s.weight)/SUM(s.weight))
			 FROM score AS s JOIN transcript_course_cg AS tccg ON s.transcript_course_cg_idTranscript_Course_cg = tccg.idTranscript_Course_cg
			 WHERE s.Term = 1 AND tccg.idTranscript_Course_cg = outer_tccg.idTranscript_Course_cg), 1)
        ELSE "-"
	  END AS BIMESTRE_1,
      CASE
		WHEN ROUND((SELECT (SUM(s.score * s.weight)/SUM(s.weight))
			FROM score AS s JOIN transcript_course_cg AS tccg ON s.transcript_course_cg_idTranscript_Course_cg = tccg.idTranscript_Course_cg
			WHERE s.Term = 2 AND tccg.idTranscript_Course_cg = outer_tccg.idTranscript_Course_cg), 1) is NOT NULL
        THEN ROUND((SELECT (SUM(s.score * s.weight)/SUM(s.weight))
			 FROM score AS s JOIN transcript_course_cg AS tccg ON s.transcript_course_cg_idTranscript_Course_cg = tccg.idTranscript_Course_cg
			 WHERE s.Term = 2 AND tccg.idTranscript_Course_cg = outer_tccg.idTranscript_Course_cg), 1)
        ELSE "-"
	  END AS BIMESTRE_2,
      CASE
		WHEN ROUND((SELECT (SUM(s.score * s.weight)/SUM(s.weight))
			FROM score AS s JOIN transcript_course_cg AS tccg ON s.transcript_course_cg_idTranscript_Course_cg = tccg.idTranscript_Course_cg
			WHERE s.Term = 3 AND tccg.idTranscript_Course_cg = outer_tccg.idTranscript_Course_cg), 1) is NOT NULL
        THEN ROUND((SELECT (SUM(s.score * s.weight)/SUM(s.weight))
			 FROM score AS s JOIN transcript_course_cg AS tccg ON s.transcript_course_cg_idTranscript_Course_cg = tccg.idTranscript_Course_cg
			 WHERE s.Term = 3 AND tccg.idTranscript_Course_cg = outer_tccg.idTranscript_Course_cg), 1)
        ELSE "-"
	  END AS BIMESTRE_3,
      CASE
		WHEN ROUND((SELECT (SUM(s.score * s.weight)/SUM(s.weight))
			FROM score AS s JOIN transcript_course_cg AS tccg ON s.transcript_course_cg_idTranscript_Course_cg = tccg.idTranscript_Course_cg
			WHERE s.Term = 4 AND tccg.idTranscript_Course_cg = outer_tccg.idTranscript_Course_cg), 1) is NOT NULL
        THEN ROUND((SELECT (SUM(s.score * s.weight)/SUM(s.weight))
			 FROM score AS s JOIN transcript_course_cg AS tccg ON s.transcript_course_cg_idTranscript_Course_cg = tccg.idTranscript_Course_cg
			 WHERE s.Term = 4 AND tccg.idTranscript_Course_cg = outer_tccg.idTranscript_Course_cg), 1)
        ELSE "-"
	  END AS BIMESTRE_4
FROM transcript_course_cg AS outer_tccg JOIN transcript ON outer_tccg.transcript_idTranscript = transcript.idTranscript
	 JOIN course_classgroup ON outer_tccg.course_classgroup_idCourse_Classgroup = course_classgroup.idCourse_Classgroup
     JOIN course ON course_classgroup.course_idCourse = course.idCourse
	 JOIN student ON transcript.student_idStudent = student.idStudent
	 JOIN person ON person.idPerson = student.person_idPerson
WHERE person.pname = 'João Pedro' AND person.psurname = 'Pinheiro';

-- 2. Busca os cursos quais o aluno João Pedro Pinheiro está matriculado 
SELECT course.cname AS MATERIA,
	   course.unique_id AS CODIGO_MATERIA
FROM course JOIN course_classgroup ON course.idCourse = course_classgroup.course_idCourse
WHERE course_classgroup.idCourse_Classgroup IN (SELECT transcript_course_cg.course_classgroup_idCourse_Classgroup
												FROM transcript_course_cg 
                                                JOIN transcript ON transcript_course_cg.transcript_idTranscript = transcript.idTranscript 
                                                JOIN student ON transcript.student_idStudent = student.idStudent 
                                                JOIN person ON student.person_idPerson = person.idPerson
												WHERE person.pname = 'João Pedro' AND person.psurname = 'Pinheiro');

-- 3. Conta e exibe em quantos cursos cada aluno está matriculado no ano atual (2023)
-- DESC transcript_course_cg;
-- DESC course_classgroup;
-- DESC student;
SELECT CONCAT(pname, ' ', psurname) AS NOME_COMPLETO,
	   cname AS CURSO
FROM transcript_course_cg JOIN transcript ON transcript_idTranscript = idTranscript
						  JOIN student ON student_idStudent = idStudent
                          JOIN person ON person_idPerson = idPerson
						  JOIN course_classgroup ON course_classgroup_idCourse_Classgroup = idCourse_Classgroup
                          JOIN course ON course_idCourse = idCourse
                          JOIN years ON years_idYears = idYears
WHERE value = 2023;

SELECT CONCAT(pname, ' ', psurname) AS NOME_COMPLETO,
	   COUNT(pname) AS QUANTIDADE_CURSOS
FROM transcript_course_cg JOIN transcript ON transcript_idTranscript = idTranscript
						  JOIN student ON student_idStudent = idStudent
                          JOIN person ON person_idPerson = idPerson
						  JOIN course_classgroup ON course_classgroup_idCourse_Classgroup = idCourse_Classgroup
                          JOIN course ON course_idCourse = idCourse
                          JOIN years ON years_idYears = idYears
WHERE value = 2023
GROUP BY NOME_COMPLETO
HAVING COUNT(*) > 1;

-- 4. Busca e exibe da tela o horário de aluno João Pedro Pinheiro do ano de 2023
SELECT CONCAT(class_schedule.start_time, "-", class_schedule.end_time) AS HORA,
	   weekday_name.day_name AS DIA,
	   course.cname AS CURSO
       FROM class_schedule
			JOIN course_classgroup_schedule ON class_schedule.idClass_schedule = course_classgroup_schedule.class_schedule_idClass_schedule
            JOIN course_classgroup ON course_classgroup.idCourse_Classgroup = course_classgroup_schedule.course_classgroup_idCourse_Classgroup
            JOIN weekday_name ON course_classgroup_schedule.weekday_idWeekday = weekday_name.idWeekday
            JOIN course ON course_classgroup.course_idCourse = course.idCourse
            JOIN transcript_course_cg ON course_classgroup.idCourse_Classgroup = transcript_course_cg.course_classgroup_idCourse_Classgroup
            JOIN transcript ON transcript_course_cg.transcript_idTranscript = transcript.idTranscript
            JOIN student ON transcript.student_idStudent = student.idStudent
            JOIN person ON student.person_idPerson = person.idPerson
            JOIN years ON course_classgroup.years_idYears = years.idYears
            WHERE person.pname = "João Pedro" AND person.psurname = "Pinheiro" AND years.value = 2023
            ORDER BY (class_schedule.start_time AND weekday_name.idWeekday);

-- o mesmo exemplo para Amanda Carvalho
SELECT CONCAT(class_schedule.start_time, "-", class_schedule.end_time) AS HORA,
	   weekday_name.day_name AS DIA,
	   course.cname AS CURSO
       FROM class_schedule
			JOIN course_classgroup_schedule ON class_schedule.idClass_schedule = course_classgroup_schedule.class_schedule_idClass_schedule
            JOIN course_classgroup ON course_classgroup.idCourse_Classgroup = course_classgroup_schedule.course_classgroup_idCourse_Classgroup
            JOIN weekday_name ON course_classgroup_schedule.weekday_idWeekday = weekday_name.idWeekday
            JOIN course ON course_classgroup.course_idCourse = course.idCourse
            JOIN transcript_course_cg ON course_classgroup.idCourse_Classgroup = transcript_course_cg.course_classgroup_idCourse_Classgroup
            JOIN transcript ON transcript_course_cg.transcript_idTranscript = transcript.idTranscript
            JOIN student ON transcript.student_idStudent = student.idStudent
            JOIN person ON student.person_idPerson = person.idPerson
            JOIN years ON course_classgroup.years_idYears = years.idYears
            WHERE person.pname = "Amanda" AND person.psurname = "Carvalho" AND years.value = 2023
            ORDER BY (weekday_name.idWeekday AND class_schedule.start_time);

-- 5. Retorna uma tabela com as informações de contato dos responsáveis de todos os alunos
SELECT CONCAT(p.pname, ' ', p.psurname) AS ALUNO,
	   (SELECT CONCAT(pp.pname, ' ', pp.psurname) FROM person AS pp JOIN representative AS rr ON rr.person_idPerson = pp.idPerson JOIN student_representative AS srsr ON rr.idRepresentative = srsr.representative_idRepresentative WHERE srsr.student_idStudent = s.idStudent) AS RESPONSAVEL,
       (SELECT pp.tel FROM person AS pp JOIN representative AS rr ON rr.person_idPerson = pp.idPerson JOIN student_representative AS srsr ON rr.idRepresentative = srsr.representative_idRepresentative WHERE srsr.student_idStudent = s.idStudent) AS CONTATO
FROM person AS p JOIN student AS s ON p.idPerson = s.person_idPerson;

-- 6. salários
-- DESC employee;
-- DESC shift;
-- DESC class_schedule;
-- DESC course_classgroup_schedule;
-- DESC course_classgroup;
-- SELECT * FROM course_classgroup;
-- DESC weekday_name;

-- SELECT hourly_rate FROM employee WHERE idEmployee = 1;

-- SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60))
-- FROM class_schedule JOIN course_classgroup_schedule ON idClass_schedule = class_schedule_idClass_schedule
-- 					JOIN weekday_name ON weekday_idWeekday = idWeekday
-- 					JOIN course_classgroup ON course_classgroup_idCourse_Classgroup = idCourse_Classgroup
--                  JOIN employee ON employee_idEmployee = idEmployee
-- WHERE idEmployee = 1;


-- 6. salário dos professores 
SELECT CONCAT(p.pname, ' ', p.psurname) AS PROFESSOR,
	   ROUND((SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60))
		FROM class_schedule JOIN course_classgroup_schedule ON idClass_schedule = class_schedule_idClass_schedule
					JOIN weekday_name ON weekday_idWeekday = idWeekday
					JOIN course_classgroup ON course_classgroup_idCourse_Classgroup = idCourse_Classgroup
                    JOIN employee ON employee_idEmployee = idEmployee
                    JOIN years ON years_idYears = idYears
		WHERE idEmployee = outer_emp.idEmployee AND value = 2023), 2) AS SALARIO_SEMANA,
        4 * ROUND((SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60))
		FROM class_schedule JOIN course_classgroup_schedule ON idClass_schedule = class_schedule_idClass_schedule
					JOIN weekday_name ON weekday_idWeekday = idWeekday
					JOIN course_classgroup ON course_classgroup_idCourse_Classgroup = idCourse_Classgroup
                    JOIN employee ON employee_idEmployee = idEmployee
                    JOIN years ON years_idYears = idYears
		WHERE idEmployee = outer_emp.idEmployee AND value = 2023), 2) AS ESTIMATIVA_MENSAL
FROM employee AS outer_emp JOIN person AS p ON outer_emp.person_idPerson = p.idPerson
WHERE teacher = 1
ORDER BY ESTIMATIVA_MENSAL DESC;

-- 7. salário dos colaboradores
SELECT CONCAT(p.pname, ' ', p.psurname) AS PROFESSOR,
	   ROUND((SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60)) AS TOTAL_HORAS
			  FROM shift JOIN employee_shift ON idShift = shift_idShift
                         JOIN employee on employee_idEmployee = idEmployee
						 JOIN years ON years_idYears = idYears
			  WHERE idEmployee = outer_emp.idEmployee AND value = 2023), 2) AS SALARIO_SEMANA,
        4 * ROUND((SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60)) AS TOTAL_HORAS
				   FROM shift JOIN employee_shift ON idShift = shift_idShift
							  JOIN employee on employee_idEmployee = idEmployee
							  JOIN years ON years_idYears = idYears
				   WHERE idEmployee = outer_emp.idEmployee AND value = 2023), 2) AS ESTIMATIVA_MENSAL
FROM employee AS outer_emp JOIN person AS p ON outer_emp.person_idPerson = p.idPerson
WHERE teacher = 0
ORDER BY ESTIMATIVA_MENSAL DESC;

-- 8. folha de pagamento todos funcionários ordenada por estimativa mensal
SELECT CONCAT(p.pname, ' ', p.psurname) AS NOME_COMPLETO,
CASE
	WHEN teacher = 0 THEN 
    ROUND((SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60)) AS TOTAL_HORAS
		   FROM shift JOIN employee_shift ON idShift = shift_idShift
					  JOIN employee on employee_idEmployee = idEmployee
					  JOIN years ON years_idYears = idYears
		   WHERE idEmployee = outer_emp.idEmployee AND value = 2023), 2) 
    ELSE 
    ROUND((SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60))
		   FROM class_schedule JOIN course_classgroup_schedule ON idClass_schedule = class_schedule_idClass_schedule
							   JOIN weekday_name ON weekday_idWeekday = idWeekday
							   JOIN course_classgroup ON course_classgroup_idCourse_Classgroup = idCourse_Classgroup
							   JOIN employee ON employee_idEmployee = idEmployee
							   JOIN years ON years_idYears = idYears
		   WHERE idEmployee = outer_emp.idEmployee AND value = 2023), 2)
END AS SALARIO_SEMANA,
CASE
	WHEN teacher = 0 THEN
	4 * ROUND((SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60)) AS TOTAL_HORAS
			   FROM shift JOIN employee_shift ON idShift = shift_idShift
			              JOIN employee on employee_idEmployee = idEmployee
						  JOIN years ON years_idYears = idYears
				WHERE idEmployee = outer_emp.idEmployee AND value = 2023), 2)
	ELSE
    4 * ROUND((SELECT SUM(hourly_rate * (HOUR(end_time) - HOUR(start_time) + (MINUTE(end_time) - MINUTE(start_time))/60))
			   FROM class_schedule JOIN course_classgroup_schedule ON idClass_schedule = class_schedule_idClass_schedule
								   JOIN weekday_name ON weekday_idWeekday = idWeekday
								   JOIN course_classgroup ON course_classgroup_idCourse_Classgroup = idCourse_Classgroup
								   JOIN employee ON employee_idEmployee = idEmployee
								   JOIN years ON years_idYears = idYears
				WHERE idEmployee = outer_emp.idEmployee AND value = 2023), 2)
END AS ESTIMATIVA_MENSAL
FROM employee AS outer_emp JOIN person AS p ON outer_emp.person_idPerson = p.idPerson
ORDER BY ESTIMATIVA_MENSAL DESC;