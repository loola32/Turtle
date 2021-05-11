CREATE TABLE person(id char(10),
				   name char(20)
				   );

CREATE TABLE BankAccount(id char(10),
					 	balance float
					 	);

CREATE TABLE BankMApping(id char(20),
						person_id char(10),
					 	account_id char(10)
					 	);



INSERT INTO person VALUES ('xx', 'John');
INSERT INTO person VALUES ('xy', 'Jenn');
INSERT INTO person VALUES ('xz', 'Ross');
INSERT INTO person VALUES ('yy', 'Monica');
INSERT INTO person VALUES ('yt', 'Phoebe');
INSERT INTO person VALUES ('gr', 'Joey');



INSERT INTO BankAccount VALUES ('111', 20000);
INSERT INTO BankAccount VALUES ('112', 30000);
INSERT INTO BankAccount VALUES ('113', 30000);
INSERT INTO BankAccount VALUES ('114', 20000);
INSERT INTO BankAccount VALUES ('115', 200);
INSERT INTO BankAccount VALUES ('116', 100);
INSERT INTO BankAccount VALUES ('117', 50);
INSERT INTO BankAccount VALUES ('118', 100000);


INSERT INTO BankMApping VALUES ('a','xx',111);
INSERT INTO BankMApping VALUES ('b','xx',112);
INSERT INTO BankMApping VALUES ('c','xy',113);
INSERT INTO BankMApping VALUES ('d','xy',114);
INSERT INTO BankMApping VALUES ('e','xz',115);
INSERT INTO BankMApping VALUES ('f','yy',116);
INSERT INTO BankMApping VALUES ('g','yt',117);
INSERT INTO BankMApping VALUES ('h','gr',118);



--people that have less than half of the wealthiest person

with cte as (
select
max(total_balance) over() as richest,
person_id,
total_balance
from
(
select
person_id,
sum(balance) as total_balance
from BankMApping A join BankAccount B
on A.account_id = B.id
group by 1
)A

)

select
p.name
from cte join person p
on cte.person_id = p.id
and total_balance< richest/2


