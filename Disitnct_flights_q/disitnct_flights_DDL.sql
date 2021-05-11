CREATE TABLE flights(dep CHAR(3), arr CHAR(3), distance INT);

INSERT INTO flights VALUES ('SEA', 'CHG', 100); ---X    not to include
INSERT INTO flights VALUES ('CHG', 'SEA', 100);   ----
INSERT INTO flights VALUES ('SEA', 'SFO', 200); ------
INSERT INTO flights VALUES ('SEA', 'LSA', 50);  -------
INSERT INTO flights VALUES ('SEA', 'SJO', 80);  -----
INSERT INTO flights VALUES ('SFO', 'CHG', 30); -----
INSERT INTO flights VALUES ('SFO', 'SEA', 200); ---X
INSERT INTO flights VALUES ('BOS', 'SEA', 150);  ----
INSERT INTO flights VALUES ('NYC', 'CHG', 300); ----
INSERT INTO flights VALUES ('NYC', 'SEA', 10); ----
INSERT INTO flights VALUES ('SEA', 'NYC', 10);  ---X




select 
dep,
arr,
distance
from flights
where dep < arr

union all

select 
dep,
arr,
distance
from flights f
where dep > arr and not exists (select
                                 from flights f2
                                 where f2.dep = f.arr and f2.arr = f.dep )





COL1 COL2 
---- ----
SFO  SEA
SFO  CHG
SEA  SJO
SEA  NYC
SEA  LSA
SEA  CHG
NYC  CHG
BOS  SEA

-----------***********************-------------------
----------------QUESTION 4---------------------------
--Given a table with a combination of flight paths,
-- how would you identify unique flights whichever city is the destination or arrival location

--option solution 1
Select distinct case when dep < arr then dep else arr end as col1,
                case when dep < arr then arr else dep end as col2
From flights

                 
--option solution 2

select dep,
    arr
from flights
where dep < arr

union all

select dep,
    arr
from flights f
where dep > arr
    and not exists (
        select 1 from flights f2 
        where f.dep = f2.arr and f.arr = f2.dep
        );