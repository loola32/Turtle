create table Emp
	( emp_id int,
		name char(10),
		salary int,
		dep char(1)
		);

insert into Emp (emp_id,name,salary,dep)values (1,'John', 1000,'A');
insert into Emp (emp_id,name,salary,dep)values (2,'Jim', 500,'A');
insert into Emp (emp_id,name,salary,dep)values (3,'Jonna', 500,'A');
insert into Emp (emp_id,name,salary,dep)values (4,'Rachel', 200,'A');
insert into Emp (emp_id,name,salary,dep)values (5,'Ross', 100,'A');

insert into Emp (emp_id,name,salary,dep)values (6,'AA', 25,'C');
insert into Emp (emp_id,name,salary,dep)values (7,'BB', 150,'C');
insert into Emp (emp_id,name,salary,dep)values (8,'VV', 500,'C');
insert into Emp (emp_id,name,salary,dep)values (9,'CC', 3,'C');
insert into Emp (emp_id,name,salary,dep)values (10,'fsgh', 5,'C');

--version_1
select distinct dep, salary
from(
select
dep,
salary,
dense_rank() over (partition by dep order by salary desc) as rank_sal
from Emp)A
where rank_sal between 1 and 2


--version 2


with cte as(
select dep,salary,
  dense_rank() over (partition by dep order by salary desc) as ranking
  from Emp
  )

select distinct Salary, dep
From cte
where ranking between 1 and 2


-----**************Prettier display---------------
--------------------******------------------------
select 
dep,
MAX(salary) as 'first_highest',
MIN(salary) as 'second_highest'
from cte
where ranking between 1 and 2
group by dep


