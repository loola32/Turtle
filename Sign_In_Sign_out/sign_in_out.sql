--my DDL
CREATE TABLE Activity
(
    empid integer,
    sign_time timestamp,
    In_Out VARCHAR(3)
);

INSERT into Activity VALUES (1, '2019-01-01 09:00:00', 'In');    
INSERT into  Activity VALUES (1, '2019-01-01 10:02:00', 'Out');
INSERT into Activity VALUES (1, '2019-01-01 10:15:00', 'In');    
INSERT into Activity VALUES (1, '2019-01-01 12:00:00', 'Out');
INSERT into Activity VALUES (1, '2019-01-01 13:00:00', 'In');    
INSERT into Activity VALUES (1, '2019-01-01 19:00:00', 'Out');
INSERT into Activity VALUES (1, '2019-01-01 22:00:00', 'In');    
INSERT into Activity VALUES (1, '2019-01-01 22:15:00', 'Out');


--count_break time
with A as (
select
Outa.empid, 
Outa.sign_time as sign_out_time,
min(Inna.sign_time) as sign_in_time
from Activity Outa join Activity Inna
on Outa.empid = Inna.empid
and Outa.sign_time < Inna.sign_time
where Outa.In_Out = 'Out' and Inna.In_Out='In'
group by 1,2
)

select
empid,
sum(round(time_to_sec(timediff(sign_in_time, sign_out_time))/3600,2)) as break_time
from A
group by 1




--version 1 - working hours, no breaks
with A as (
select
Inn.empid,
Inn.sign_time as sign_in,
min(Outa.sign_time) as sign_out
from Activity Inn join Activity Outa
on Inn.empid = Outa.empid
and Inn.sign_time < Outa.sign_time
where Inn.In_Out = 'In' and Outa.In_Out = 'Out'
group by Inn.empid, sign_in

)

select
empid,
sum(round(time_to_sec(timediff(sign_out, sign_in))/3600,2)) as total_sign_time
from A
group by empid


--version 2


with Inn as (
select
empid,
sign_time as sign_in_time,
In_Out as inn
from Activity
where In_Out='In'),

Outa as (
select
empid,
sign_time as sign_out_time,
In_Out as outa
from Activity
where In_Out='Out'),


wh as (
select
Inn.empid,
sign_in_time,
min(sign_out_time) as correct_sign_out_time,
min(round(time_to_sec(timediff(sign_out_time, sign_in_time))/3600,2)) as working_hours
from Inn join Outa
on Inn.empid = Outa.empid
and Inn.sign_in_time < Outa.sign_out_time
group by empid,sign_in_time)


select
empid,
sum(working_hours)
from wh
group by empid





-----------vesrion 1 of the solution--------
----using MySQL syntax and CTEs-----------

with Inn as (
select empid, sign_time as sign_in
from Activity Inn
where In_Out = 'In'
),

Outa as (
select
empid, sign_time as sign_out
from Activity
where In_Out = 'Out'

),

worker_clock as (
select Inn.empid,
Inn.sign_in,
Min(Outa.sign_out) as sign_out
#time_to_sec(timediff(sign_out, sign_in))/3600 as hours
from Inn left join Outa
on Inn.empid = Outa.empid
and Inn.sign_in < Outa.sign_out
group by empid, sign_in
order by sign_in, sign_out)


select empid,
round(sum(time_to_sec(timediff(sign_out, sign_in))/3600),3) as hours
from worker_clock
group by empid



------***********This solution will not work in MySQL - nu full outer join----
--My_solution
'''
WITH t
AS
(
SELECT i.empid,
         i.new_date,
         i.sign_time AS inn,
         o.sign_time AS out,
       RANK() OVER (PARTITION BY i.sign_time ORDER BY o.sign_time) AS r
      FROM
 (SELECT empid, CAST(sign_time AS DATE) AS new_date, sign_time 
             FROM Activity 
            WHERE In_Out = 'In') AS i
 FULL outer JOIN (SELECT empid, CAST(sign_time AS DATE) AS new_date, sign_time 
             FROM Activity
            WHERE In_Out = 'Out') AS o
ON i.empid = o.empid
       AND i.new_date = o.new_date
       AND i.sign_time < o.sign_time
)

SELECT empid, 
new_date,
--inn,
--out,
SUM(DATE_PART('hour', out) - DATE_PART('hour', inn)) AS HOURS
--SUM(DATEDIFF(HOUR, in, out)) AS Hours
  FROM t
 WHERE r = 1
GROUP BY empid, new_date
ORDER BY empid, new_date


--internet solution:
select 
I.empid,
I.sign_in_time,
I.sign_out_time
from Activity I full join
Activity O
on I.empid=O.empid
and I.sign_time=O.sign_time and I.sign_time<O.sign_time



WITH t
AS
(
    SELECT COALESCE(i.empid, o.empid) AS empid
         , COALESCE(i.new_date, o.new_date) AS new_date
         , COALESCE(i.sign_time, CAST(o.sign_time AS DATE)) AS in
         , COALESCE(o.sign_time, DATEADD(DAY, 1, CAST(i.sign_time AS DATE))) AS out
         , RANK() OVER (PARTITION BY i.sign_time ORDER BY o.sign_time) AS r
      FROM (SELECT empid, CAST(sign_time AS DATE) AS new_date, sign_time 
             FROM Activity 
            WHERE In_Out = 'In') AS i
 FULL JOIN (SELECT empid, CAST(sign_time AS DATE) AS new_date, sign_time 
             FROM Activity
            WHERE In_Out = 'Out') AS o
        ON i.empid = o.empid
       AND i.new_date = o.new_date
       AND i.sign_time < o.sign_time
)
SELECT empid, new_date, SUM(DATEDIFF(HOUR, in, out)) AS Hours
  FROM t
 WHERE r = 1
GROUP BY empid, new_date
ORDER BY empid, new_date

'''





