 create table orders (
order_id char(10),
order_date date,
customer_id char(15)
);

create table order_items (
order_id char(10),
item_id char(10),
quantity int
);



 -----------**************----------------
 -----QUESTION 1 date with the greatest number of orders-------------------------

 --version 1 - with cte
with cte as (
select
order_date,
num_of_orders,
dense_rank() over(order by num_of_orders desc) as ranking
from (
select
order_date,
count(order_id) as num_of_orders
from orders
group by order_date
)A
)

select
order_date,
num_of_orders
from cte
where ranking = 1

--



 --version 2 - w/o cte
--same question where there are the same number of orders for different dates
select 
order_date,
num_of_orders
from(
select
order_date,
num_of_orders,
dense_rank() over (order by num_of_orders desc) as ranking
from(
 select
 order_date,
 count(*) as num_of_orders from orders
 group by order_date
 )A)B
  where B.ranking=1



--without considering different dates



select count(*) as num_orders, 
order_date
from orders
group by order_date
order by count(*) desc
--limit 1



 -----------**************----------------
 -----QUESTION 2-------------------------
 --by day, the cumulative sum of quantity


 --version 1 w/o cte
select
order_date,
sum(total_quant) over (order by order_date rows between unbounded preceding and current row)
as running_total
from(
select
ord.order_date,
sum(ita.quantity) total_quant
from orders ord join order_items ita
on ord.order_id = ita.order_it
group by order_date)A


 --version 2 with cte


with cte as (
select order_date,
sum(quantity_per_order) as quantity_per_day
from(
select
order_id,
sum(quantity) as quantity_per_order
from order_items
group by order_id) A
join orders B
on A.order_id = B.order_id
group by order_date
  )
  
  select
  order_date,
  sum(quantity_per_day) over(order by order_date rows between unbounded preceding and current row) as running_total
  from cte


------***************-----------------
-----------QUESTION 3-----------------
----customers who placed orders on 2 consecutive
-- days both days having greater than 2 order QUANTITY

with a as (
select 	
customer_id,
grouping_set,
count(order_id) as num_of_orders
from (
select
customer_id,
ord.order_id,
order_date,
date_add(order_date, interval -(row_number() over (partition by customer_id order by order_date)) day )
as grouping_set
from orders ord join order_items ita
on ord.order_id  = ita.order_id
where quantity > 2)B
group by 1,2
having num_of_orders = 2
)

select
customer_id
from a



--another way question 3


with tempa as(
SELECT  ord.customer_id,
        ord.order_date,
        ord.order_id,
  i.quantity,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) as ranking,
        DATE_ADD(order_date, INTERVAL - (row_number() OVER(PARTITION BY customer_id ORDER BY order_date)) DAY) as grouping_set
FROM    orders ord join order_items i
         on ord.order_id = i.order_id
where i.quantity>2  )


select
grouping_set,
 customer_id,
count(order_id) as count_orders
from tempa
group by grouping_set, customer_id
having count_orders>1  









