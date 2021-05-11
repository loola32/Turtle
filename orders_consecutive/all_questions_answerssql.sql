 -----------**************----------------
 -----QUESTION 1 date with the greatest number of orders-------------------------
select count(*) as num_orders, 
order_date
from orders
group by order_date
order by count(*) desc
--limit 1


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

 -----------**************----------------
 -----QUESTION 2-------------------------
 --by day, the cumulative sum of quantity
with tempa as (
select order_id,sum(quantity) sum_of_items_per_order
from order_items
group by order_id)

select 
ord.order_date,
tempa.sum_of_items_per_order,
sum(sum_of_items_per_order) over(order by order_date rows between unbounded preceding and current row) as cumulative_total
from orders ord join tempa
on ord.order_id = tempa.order_id

--above question without CTE
select 
ord.order_date,
i.sum_of_items_per_order,
sum(sum_of_items_per_order) over(order by order_date rows between unbounded preceding and current row) as cumulative_total
from orders ord 
join
(
select order_id, sum(quantity) sum_of_items_per_order
from order_items
group by order_id) i
on ord.order_id = i.order_id


------***************-----------------
-----------QUESTION 3-----------------
----customers who placed orders on 2 consecutive
-- days both days having greater than 2 order QUANTITY
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









