create table dep (
dep_id int,
dep_name char(15)
);


create table Employee (
emp_id int,
dep_id int
);

insert into dep values(1,'IT');
insert into dep values(2,'HR');
insert into dep values(3,'Payroll');
insert into dep values(4,'Admni');

insert into Employee values(1,1);
insert into Employee values(2,1);
insert into Employee values(3,1);
insert into Employee values(4,2);
insert into Employee values(5,3);
insert into Employee values(6,NULL)

---Alternative to full outer join in Mysql

select 
E.emp_id, E.dep_id,dep.dep_name
from Employee E left join dep
on E.dep_id = dep.dep_id 

union

select 
E.emp_id, E.dep_id,dep.dep_name
from dep left join Employee E
on dep.dep_id = E.dep_id 	
