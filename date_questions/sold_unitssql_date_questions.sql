CREATE TABLE orders(order_date date,
					order_id char(10),
					units int);

CREATE TABLE items(order_id char(10),
					item_id char(10));

INSERT INTO orders VALUES ('2021-04-01','xx', 10);
INSERT INTO orders VALUES ('2021-04-02','xy',15);
INSERT INTO orders VALUES ('2021-04-03','xz',17);
INSERT INTO orders VALUES ('2021-04-05','xa', 2);
INSERT INTO orders VALUES ('2021-04-06','xb',4);
INSERT INTO orders VALUES ('2021-04-08','xc', 22);
INSERT INTO orders VALUES ('2021-04-09','xd',50);
INSERT INTO orders VALUES ('2021-04-09','xry',50);
INSERT INTO orders VALUES ('2021-05-03','xk', 10);
INSERT INTO orders VALUES ('2021-05-03','xm', 10);
INSERT INTO orders VALUES ('2021-05-04','xt', 11);



INSERT INTO items VALUES ('xx', 'love');
INSERT INTO items VALUES ('xx', 'respect');
INSERT INTO items VALUES ('xy', 'dfg');
INSERT INTO items VALUES ('xa', 'jmm');
INSERT INTO items VALUES ('xk', 'aaa');
INSERT INTO items VALUES ('xk', 'bbb');
INSERT INTO items VALUES ('xm', 'ret');
INSERT INTO items VALUES ('xm', 'gli');
INSERT INTO items VALUES ('xt', 'sdf');
INSERT INTO items VALUES ('xt', 'gli');




-----********************-----------
---------******Q1------------------
----Q1 How many units were sold yesterday? Output: order_day | units---
select
sum(units) as sum_units,
order_date
from orders
where date_add(cast(now() as date), interval -1 DAY)=order_date
group by order_date

select
sum(units) as sum_units,
order_date
from orders
where date_add(curdate(), interval -1 DAY)=order_date
group by order_date


---------*************-----------------
-------------Q2-----------------------
-------Q2 What items were ordered yesterday but not ordered today?
--------------------------------Output: item_id

select A.item_id from
(
select
O.order_date,
I.item_id,
O.units
from orders O left join items I
on O.order_id = I.order_id
where date_add(cast(now() as date), interval - 1 DAY)=order_date) A
left join 
(
select
O.order_date,
I.item_id,
O.units
from orders O left join items I
on O.order_id = I.order_id
where cast(now() as date)=order_date) B
  on A.item_id = B.item_id
  where B.item_id is null


  --version 2 - using subquery with not in

  select
it.item_id
from orders ord join items it
on ord.order_id = it.order_id
where order_date = date_add(curdate(), interval -1 day)
and item_id not in
(select
it.item_id
from orders ord join items it
on ord.order_id = it.order_id
where order_date = curdate())


 --version 3 - using subquery not exists

  select
it.item_id
from orders ord join items it
on ord.order_id = it.order_id
where order_date = date_add(curdate(), interval -1 day)
and not exists
(select
ita.item_id
from orders ord join items ita
on ord.order_id = ita.order_id
where order_date = curdate()
and it.item_id = ita.item_id)


---------------******************-----------------
------------------Q3------------------------------
--Q3 How many units were sold in each category that cost less
-- than $20, between $20 and $50, and more than $50? Output:
-- category | units_0_20 | units_20_50 | units_50_plus




