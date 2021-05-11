
---employees that joined before their manager


create table empdata (
emp_id int,
mng_id int,
join_date date,
dep char(5),
salary int
);


insert into empdata(emp_id, mng_id, join_date, dep, salary) values (1, 7, '2021-01-01','A', 25000);
insert into empdata(emp_id, mng_id, join_date, dep, salary) values (1, 7, '2021-01-01','A', 25000);
insert into empdata(emp_id, mng_id, join_date, dep, salary) values (3, 7, '2021-01-15','A',60000);
insert into empdata(emp_id, mng_id, join_date, dep, salary) values (7, 5, '2021-02-02','B',55000);
insert into empdata(emp_id, mng_id, join_date, dep, salary) values (8, 5, '2021-03-01','B',7000);
insert into empdata(emp_id, mng_id, join_date, dep, salary) values (12,11,  '2020-11-10','C',11000);
insert into empdata(emp_id, mng_id, join_date, dep, salary) values (11,5 , '2021-03-15','C',4000);
insert into empdata(emp_id, mng_id, join_date, dep, salary) values (11,5 , '2021-03-15','C',4000);
insert into empdata(emp_id, mng_id, join_date, dep, salary) values (5, NULL, '2021-02-10','D',32000);


--option_1
select
e.emp_id as employee,
e.join_date as emp_joined_date,
m.join_date as mng_joined_date
from empdata e left join empdata m
on e.mng_id = m.emp_id
where e.join_date < m.join_date





--option 2 

select
e.emp_id as emp_id,
coalesce(m.emp_id,'Big_Boss') as mng_id,
e.join_date as emp_join_date,
coalesce(m.join_date, e.join_date) as mng_join_date

from empdata e left join empdata m
on e.mng_id = m.emp_id
where e.join_date < m.join_date
order by emp_join_date, mng_join_date







-----employees that joined before their manager
select
#case when B.join_date is null then 'The first joinee' else A.emp_id end as employee,
A.emp_id as emp_id,
A.join_date as emp_join_date,
B.emp_id as mng_id,
B.join_date as mng_join_date
  from empdata A left join empdata B
  on A.mng_id = B.emp_id
 where A.join_date<B.join_date or A.mng_id is NULL

 --employees that were hired n months ago
 select
emp_id,
join_date,
timestampdiff(week,join_date, curdate()) as hire_months_ago
from empdata
where timestampdiff(MONTH,join_date, curdate()) = 2


----List all employees with salary greater than the everage department salary and also greather than $50K
--version1  derived table
select
e.emp_id,
b.dep,
e.salary from empdata e
join

(select
dep,
AVG(salary) as dep_avg_salary
from empdata
group by dep) b
 on e.dep = b.dep
 and e.salary > b.dep_avg_salary
 and e.salary > 50000


--version 2 analytical function and derived table


List all employees with salary greater than the everage department salary and also greather than $50K
select emp_id
from(
select
emp_id,
salary,
AVG(salary) over(partition by dep) as avg_salary_dep
from empdata)A
where salary>avg_salary_dep and salary>50000

--find only the duplicate rows
select
emp_id,
dep,
salary
from
(
select
emp_id,
dep,
salary,
rou_number() over (partition by emp_id order by emp_id) as ranking
from empdata
) A
where A.ranking>1






select *
from(
select
*,
row_number() over (partition by emp_id order by emp_id) as ranking
from empdata)A
where ranking = 2
