# a.
select S.ID, S.name as a
from takes as T
left join student as S
	on S.ID = T.ID
left join course as C
	on C.course_id = T.course_id
where C.dept_name = 'Comp. Sci.' and T.semester = 'Fall' and T.year = 2010;


# b.
insert into course values ('CS-001', 'Weekly Seminar', 'Comp. Sci.', 1);

##takes: (ID, course_id, sec_id, semester, year, grade)
# c.
insert into section values ('CS-001', 1, 'Fall', 2007, null, null, null);
insert into takes
	select ID, 'CS-001', 1, 'Fall', 2007, null
    from student
    where dept_name = 'Comp. Sci.';

# d.
select min(max_salary) as d
from (select dept_name, max(salary) as max_salary
	  from instructor
	  group by dept_name) as result;
      
# e.
select distinct name as e
from instructor inner join teaches using (ID)
where year = 2008 and semester = 'Fall';

# f.
select distinct name as f
from student inner join takes using (ID)
where year = 2007 and dept_name = 'Physics';

# g.
select distinct S.name as student_name
from advisor as A
left join student as S
	on S.ID = s_ID
left join instructor as I
	on i_ID = I.ID
where I.name = 'Bondi';


# h.
select distinct ID, name as h
from student
where ID not in (
	select ID
    from takes
    where year < 2010);