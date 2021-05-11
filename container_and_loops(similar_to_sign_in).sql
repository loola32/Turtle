container_edits:
container|units|status |move_time
XYZ 	| 5 |	Start  |2018-01-01 00:00:15
XYZ 	| 2 |	Add    |2018-01-01 00:01:10
XYZ 	| 3 |	Add    |2018-01-01 00:02:00
XYZ 	| 	|	Complete	|2018-01-01 00:03:00

XYZ 	| 5 |	Start  |2018-01-01 00:04:15    
XYZ 	| 3 |	Add | 	|2018-01-01 00:05:10
XYZ 	| 4 |	Add |	|2018-01-01 00:06:00
XYZ 	| 5 |	Add |	|2018-01-01 00:07:10
XYZ 	| 6 |	Add |	|2018-01-01 00:08:00
XYZ 	| 	|Complete 	|2018-01-01 00:09:00

XYZ 	| 2 |	Start  |2018-01-01 00:09:20 
XYZ 	| 2 |	Add | 	|2018-01-01 00:10:10
XYZ 	| 7 |	Add |	|2018-01-01 00:11:00
XYZ 	| 5 |	Add |	|2018-01-01 00:12:10
XYZ 	| 	|Complete 	|2018-01-01 00:12:30




CREATE TABLE container_edits
(
    container char(10),
    units int,
    status char(15),
    move_time timestamp
);

INSERT into container_edits VALUES ('XYZ', 5, 'Start', '2018-01-01 00:00:15');
INSERT into container_edits VALUES ('XYZ', 2, 'Add', '2018-01-01 00:01:10'); 
INSERT into container_edits VALUES ('XYZ', 3, 'Add', '2018-01-01 00:02:00'); 
INSERT into container_edits VALUES ('XYZ',null , 'Complete', '2018-01-01 00:03:00'); 

INSERT into container_edits VALUES ('XYZ', 5, 'Start', '2018-01-01 00:04:15'); 
INSERT into container_edits VALUES ('XYZ', 3, 'Add', '2018-01-01 00:05:10'); 
INSERT into container_edits VALUES ('XYZ', 4, 'Add', '2018-01-01 00:06:00'); 
INSERT into container_edits VALUES ('XYZ', 5, 'Add', '2018-01-01 00:07:10'); 
INSERT into container_edits VALUES ('XYZ', 6, 'Add', '2018-01-01 00:08:00'); 
INSERT into container_edits VALUES ('XYZ', null, 'Complete', '2018-01-01 00:09:00'); 


INSERT into container_edits VALUES ('XYZ', 2, 'Start', '2018-01-01 00:09:20'); 
INSERT into container_edits VALUES ('XYZ', 2, 'Add', '2018-01-01 00:10:10'); 
INSERT into container_edits VALUES ('XYZ', 7, 'Add', '2018-01-01 00:11:00'); 
INSERT into container_edits VALUES ('XYZ', 5, 'Add', '2018-01-01 00:12:10'); 
INSERT into container_edits VALUES ('XYZ',null , 'Complete', '2018-01-01 00:12:30');
   


For the above dataset the record should look like

loop:
container|loop_num|units|start_time 		|end_time
XYZ 		|1 		|10 |2018-01-01 00:00:15|2018-01-01 00:03:00
XYZ 		|2 		|23 |2018-01-01 00:04:15|2018-01-01 00:09:00



--solution
with ax as(
select
a.container,
a.move_time as begin_time,
min(b.move_time) as final_time
from container_edits a join container_edits b
on a.container = b.container
and a.move_time < b.move_time
where a.status = 'Start' and b.status = 'Complete'
group by a.container, begin_time
order by begin_time
),

b as(
select
a.status,
a.container,
dense_rank() over (partition by a.container order by final_time) as loop_num,
sum(units) over (partition by a.container, final_time) as units,
begin_time as start_time,
final_time as end_time,
a.move_time
from container_edits a join ax on
a.container = ax.container and
a.move_time between begin_time and final_time
)

select
*
from b
where status = 'Complete'


