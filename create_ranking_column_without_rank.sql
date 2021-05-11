
create table emp
	( emp_id int,
		name char(10),
		salary int,
		dep char(1)
		);

insert into emp (emp_id,name,salary,dep)values (1,'John', 1000,'A');
insert into emp (emp_id,name,salary,dep)values (2,'Jim', 500,'A');
insert into emp (emp_id,name,salary,dep)values (3,'Lena', 20000,'A');
insert into emp (emp_id,name,salary,dep)values (4,'Jenny', 5000,'C');
insert into emp (emp_id,name,salary,dep)values (5,'Nir', 5000,'C');
insert into emp (emp_id,name,salary,dep)values (6,'Ronny', 3000,'D');



----Question: create a ranking column on salaraies without using rank function
--by department
------------------------------------------------------------------------------

select
dep,
salary,
(select count(*) + 1
 from emp e2 
 where e2.dep = e.dep
 and e.salary < e2.salary) as ranking
from emp e
order by dep,ranking, salary








-------------------------*******---------------------
---------same question but w/o partitioning by department

select
emp_id,
name,
salary,
(Select 1 + count(*)
	from emp A 
	where A.salary>B.salary) as ranking
from emp B
order by ranking