# Question a
# Computer Science 학부 과목을 듣고 있는 최신 년도가 2007년이므로 2007년을 현재년도로 잡고 출력
SELECT DISTINCT ID, name FROM student WHERE ID IN 
	(SELECT ID FROM takes WHERE course_id IN 
		(SELECT course_id FROM course WHERE dept_name='Comp. Sci.') and year=2007);

# Question b
# 과목을 새로 신설? - course에 새로운 row insert, dept_name은 Comp. Sci.로 가정
INSERT INTO course VALUES ('CS-001', 'Weekly Seminar', 'Comp. Sci.', 1);

# Question c - incomplete
create table students_takes
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references student (ID)
		on delete cascade
	);
DELETE FROM student_takes; 
INSERT INTO student_takes (ID, course_id, sec_id, semester, year) SELECT student.ID, '893', '1', 'Fall', 2007 from student WHERE dept_name='Comp. Sci.';
INSERT INTO student_takes (ID, course_id, sec_id, semester, year) SELECT student.ID, '489', '1', 'Fall', 2007 from student WHERE dept_name='Comp. Sci.';
INSERT INTO student_takes (ID, course_id, sec_id, semester, year) SELECT student.ID, '612', '1', 'Fall', 2007 from student WHERE dept_name='Comp. Sci.';
INSERT INTO student_takes (ID, course_id, sec_id, semester, year) SELECT student.ID, '258', '1', 'Fall', 2007 from student WHERE dept_name='Comp. Sci.';
INSERT INTO student_takes (ID, course_id, sec_id, semester, year) SELECT student.ID, '949', '1', 'Fall', 2007 from student WHERE dept_name='Comp. Sci.';
SELECT * FROM takes UNION SELECT * FROM student_takes;

# Question d
# 각 학부별로 가장 많은 연봉을 가진 instrutor 가져오고 그중에서 가장 연봉이 낮은 salary를 조회후 그 값과 instructor table을 매칭
SELECT name, dept_name
FROM instructor
WHERE salary IN
	(SELECT min(salary) FROM instructor WHERE (dept_name, salary) IN 
		(SELECT dept_name, max(salary) FROM instructor GROUP BY dept_name));
    
# Question e
# 2018년도 가을학기에 수업을 진행하는 instructor
SELECT * FROM instructor WHERE ID IN 
	(SELECT ID FROM teaches WHERE year='2008' AND semester='Fall');

# Question f 
# 2017년도 기준 물리학부에 재학중인 모든학생
SELECT * FROM student WHERE ID IN 
	(SELECT ID FROM takes WHERE course_id IN 
		(SELECT course_id FROM course WHERE dept_name='Physics') and year=2007);

# Question g
# LEE 컴퓨터공학 강사가 없으므로 다른 강사 이름을 사용하여 결과 출력함
SELECT * FROM instructor WHERE dept_name='Comp. Sci.';
# LEE 강사 결과 없음
SELECT * FROM student WHERE ID IN
	(SELECT DISTINCT ID FROM takes WHERE course_id IN
		(SELECT course_id FROM teaches WHERE ID IN 
			(SELECT ID FROM instructor WHERE name='LEE'))) AND dept_name!='Comp. Sci.';
# Bourrier 강사 결과 
SELECT * FROM student WHERE ID IN
	(SELECT DISTINCT ID FROM takes WHERE course_id IN
		(SELECT course_id FROM teaches WHERE ID IN 
			(SELECT ID FROM instructor WHERE name='Bourrier'))) AND dept_name!='Comp. Sci.';

# Question h
# student table에서 ID 값을 가져와서 takes table의 ID 값과 비교후 중복된 값들 제거 후 student table 에서 ID와 이름 출력 - 결과 없음
SELECT ID, name FROM student WHERE ID IN 
	(SELECT DISTINCT ID FROM takes WHERE ID NOT IN(SELECT ID FROM student));