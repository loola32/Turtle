CREATE TABLE emp(emp_id int, task_id int, start_time date, end_time date);


INSERT INTO emp VALUES (1, 1, '2021-03-15', '2021-03-17' );
INSERT INTO emp VALUES (1, 2, '2021-03-15', '2021-03-16' );
INSERT INTO emp VALUES (1, 3, '2021-03-19', '2021-03-19' );

INSERT INTO emp VALUES (2, 1, '2021-03-15', '2021-03-19' );
INSERT INTO emp VALUES (2, 2, '2021-03-15', '2021-03-17' );


with RECURSIVE cte as
(
select min(start_time) as anchor_date
from emp

union ALL

select
date_add(anchor_date, INTERVAL 1 day) 
from cte
where anchor_date < (select max(end_time) from emp)
)

select 
emp_id,
count(distinct anchor_date) as working_days,
from cte left join emp
on cte.anchor_date between start_time and end_time
group by emp_id


























