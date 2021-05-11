

CREATE TABLE sales(sales_id char(10),
				   order_date date,
				   customer_id char(10),
				   product_id char(20),
				   purchase_amount int);

CREATE TABLE product(pr_id char(20),
					 pr_name char(10),
					 brand_id char(10),
					 brand_name char(10));

-- 10 Top prodcuts in year XXXX
--version 1

with cte as (
select
p.pr_name,
year(order_date) as year_purchased,
sum(s.purchase_amount) as total_purch_amount
from sales s join product p
on s.product_id = p.pr_id
where year(order_date) = '2020'
group by pr_name, year_purchased
order by total_purch_amount desc
),

b as (
select
row_number() over(order by total_purch_amount desc) as ranking,
pr_name
from cte)

select pr_name from b
where ranking between 1 and 10


--version 2

select 
A.product_id,
P.pr_name,
sum(purchase_amount) as sum_purch
from sales A left join product P
on A.product_id=P.pr_id
where year(order_date)='2020'
group by A.product_id,P.pr_name
order by sum_purch desc
limit 10


--Top 10 products in each year


with CTE as (
select purch_year, 
row_number() over (partition by purch_year order by sum_purch desc) as ranking,
product_id,
pr_name
from
(
select 
year(order_date) as purch_year,
A.product_id,
P.pr_name,
sum(purchase_amount) as sum_purch
from sales A left join product P
on A.product_id=P.pr_id
group by purch_year,A.product_id,P.pr_name
)A)

select purch_year,product_id, pr_name
from CTE
where ranking between 1 and 10



----------------------------------
---------************----------------
---List of customers whose total purchase increased from XXXX-XXXX but decreased from XXXX-XXXX.
-----customers with total purchase in 2020 >2019 and purchases in 2021<2020


select
customer_id,
coalesce(sum(case when year(order_date) = '2019' then purchase_amount end),0) as purchase_2019,
coalesce(sum(case when year(order_date) = '2020' then purchase_amount end),0) as purchase_2020,
coalesce(sum(case when year(order_date) = '2021' then purchase_amount end),0) as purchase_2021
from sales
group by customer_id
having purchase_2020 > purchase_2019 and purchase_2021 < purchase_2020




---------------------------------------------------------------
------------------*******--------------------------------------
------List of customers who bought both brands "brand2" & "brand10" and at-least 2 products in each brand----
with cte as (
select
s.customer_id,
p.brand_name,
count(distinct p.pr_id) as dist_num_of_products,
case when brand_name = 'brand2' then 1
	 when brand_name = 'brand10' then 1
    else 0
    end brand_ind
from sales s join product p
on s.product_id = p.pr_id
group by s.customer_id, p.brand_name
having dist_num_of_products > 1
)

select
sum(brand_ind) as ind,
customer_id
from cte
group by customer_id
having ind = 2


--version 2 with : customers that bought either of the "brand2" & "brand10"


select
distinct s.customer_id
from sales s join product p
on s.product_id = p.pr_id
where p.brand_name = 'brand2' or p.brand_name = 'brand10'
group by s.customer_id, p.brand_name
having count(distinct p.pr_id) > 1


















select
s.customer_id,
p.brand_name,
count(distinct s.product_id) as distinct_product_per_brand
from sales s left join product p
on s.product_id = p.pr_id
where p.brand_name = 'brand10' or p.brand_name = 'brand2'
group by 1,2
having distinct_product_per_brand>1














