INSERT INTO product VALUES ('first_pr', 'love','br1','brand1');
INSERT INTO product VALUES ('sec_pr', 'love2','br1','brand1');
INSERT INTO product VALUES ('sec1_pr', 'lust','br2','brand2');
INSERT INTO product VALUES ('sec0_pr', 'lusting','br2','brand2');

INSERT INTO product VALUES ('5_pr', 'joy','br3','brand3');

INSERT INTO product VALUES ('pr_1', 'love22','br4','brand4');
INSERT INTO product VALUES ('pr_4', 'love23','br4','brand4');
INSERT INTO product VALUES ('pr_5', 'love24','br4','brand4');

INSERT INTO product VALUES ('pr_9', 'happy','br5','brand5');

INSERT INTO product VALUES ('pr_6', 'lov1','br6','brand6');
INSERT INTO product VALUES ('pr_7', 'lov2','br6','brand6');
INSERT INTO product VALUES ('pr_77', 'lov3','br6','brand6');


INSERT INTO product VALUES ('6_pr', 'light','br7','brand7');

INSERT INTO product VALUES ('1_pr', 'la1','br8','brand8');
INSERT INTO product VALUES ('2_pr', 'la2','br8','brand8');


INSERT INTO product VALUES ('33_pr', 'warmth1','br9','brand9');
INSERT INTO product VALUES ('22_pr', 'warmth2','br9','brand9');
INSERT INTO product VALUES ('23_pr', 'warmth3','br9','brand9');
INSERT INTO product VALUES ('1_ar', 'warmth4','br9','brand9');

INSERT INTO product VALUES ('2_ar', 'comp1','br10','brand10');
INSERT INTO product VALUES ('11_ar', 'comp11','br10','brand10');
INSERT INTO product VALUES ('22_ar', 'comp12','br10','brand10');
INSERT INTO product VALUES ('23_ar', 'comp13','br10','brand10');



-- 10 Top prodcuts in year XXXX

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
with A as (
select 
customer_id,
sum (coalesce(case when year(order_date)='2019' then purchase_amount end,0))as '2019_total_purchase',
sum (coalesce(case when year(order_date)='2020' then purchase_amount end,0))as '2020_total_purchase',
sum (coalesce(case when year(order_date)='2021' then purchase_amount end,0))as '2021_total_purchase'
from sales
group by customer_id)

select customer_id
from A
where 2020_total_purchase>2019_total_purchase  
and 2021_total_purchase<2020_total_purchase


---------------------------------------------------------------
------------------*******--------------------------------------
------List of customers who bought both brands "X" & "Y" and at-least 2 products in each brand----


select 
P.brand_name,
S.customer_id,
count(S.product_id) as num_of_products
from sales S left join product P
on S.product_id = P.pr_id
where P.brand_name = 'brand10' or P.brand_name = 'brand2'
group by P.brand_name, S.customer_id
having num_of_products >1














