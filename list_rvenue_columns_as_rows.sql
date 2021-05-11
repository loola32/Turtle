
---Write a query to pull the monthly revenue as columns instead of rows.

create table revenue (
company char(1),
month char(15),
revenue int
);

insert into revenue values ('A','Jan',20);
insert into revenue values ('B','Jan',30);
insert into revenue values ('C','Jan',50);
insert into revenue values ('A','Feb',200);
insert into revenue values ('B','Feb',10);
insert into revenue values ('C','Feb',5);


select
company,
max(case when month = 'Jan' then revenue end) as Jan,
max(case when month = 'Feb' then revenue end) as Feb
from revenue
group by company