create table Empmng(
	emp_id int,
	emp_name varchar(40),
	mng_id int
);

insert into Empmng (emp_id, emp_name, mng_id) values (99, 'Avi', NULL);
insert into Empmng (emp_id, emp_name, mng_id) values (70, 'John', 99);
insert into Empmng (emp_id, emp_name, mng_id) values (40, 'Lena', 99);
insert into Empmng (emp_id, emp_name, mng_id) values (30, 'Katy', 99);
insert into Empmng (emp_id, emp_name, mng_id) values (10, 'Rina', 70);
insert into Empmng (emp_id, emp_name, mng_id) values (20, 'Monica', 40);
insert into Empmng (emp_id, emp_name, mng_id) values (78, 'Ronny', 40);
insert into Empmng (emp_id, emp_name, mng_id) values (5, 'Ron', 30);
insert into Empmng (emp_id, emp_name, mng_id) values (3, 'Keren', 20);



with recursive A as (
select
emp_id,
emp_name,
mng_id,
1 as hierarcy_level
from Empmng
where mng_id is NULL

union ALL

select
E.emp_id,
E.emp_name,
E.mng_id,
hierarcy_level + 1 
from Empmng E join A
on E.mng_id = A.emp_id
)

select
* from A



















with recursive cte as(
select
emp_id,
emp_name,
mng_id,
1 as levela
from Empmng 
where mng_id is NULL

UNION ALL

select
e.emp_id,
e.emp_name,
e.mng_id,
cte.levela+1
from Empmng e join cte
on e.mng_id = cte.emp_id
)

select 
e.emp_name,
e.levela,
coalesce(m.emp_name, 'Big Boss') as mng_name
from cte e left join cte m
on e.mng_id = m.emp_id

