'''
I have given Two Tables, Dimensions, Warehouse
Dimensions: ProductID, L,B,H in inches
Warehouse:WarehouseID, ProductID, Units
Products
1) Write a query to find overall volume of the each product?
2) Write a query to Find out max number of units in each warehouse?
3) Write a query to find the products which doesn’t have any dimensions and not present in Dimensions table?
'''


CREATE TABLE dimensions
			 (product_id char(20),
			 len int,
			 height int,
			 width int);


CREATE TABLE warehouse
			 (warehouse_id char(20),
			 product_id char(20),
			 units int);



INSERT INTO warehouse VALUES('a','xx', 10);
INSERT INTO warehouse VALUES('a','xy', 30);
INSERT INTO warehouse VALUES('a','xz', 20);
INSERT INTO warehouse VALUES('a','xe', 24);
INSERT INTO warehouse VALUES('a','yd', 24);
INSERT INTO warehouse VALUES('b','xx', 56);
INSERT INTO warehouse VALUES('b','xk', 23);
INSERT INTO warehouse VALUES('b','xn', 13);
INSERT INTO warehouse VALUES('b','xc', 17);
INSERT INTO warehouse VALUES('b','xl', 17);
INSERT INTO warehouse VALUES('c','xz', 10);
INSERT INTO warehouse VALUES('c','xx', 80);
INSERT INTO warehouse VALUES('c','xb', 80);
INSERT INTO warehouse VALUES('c','yn', 40);


INSERT INTO dimensions VALUES('xx',10, 5, 6);
INSERT INTO dimensions VALUES('xy',5, 5, 6);
INSERT INTO dimensions VALUES('xz',3, 2, 3);
INSERT INTO dimensions VALUES('xe',4, 2, 3);
INSERT INTO dimensions VALUES('xr',5, 1, 3);
INSERT INTO dimensions VALUES('xt',2, 4, 7);
INSERT INTO dimensions VALUES('xk',3, 5, 3);
INSERT INTO dimensions VALUES('xn',3, 4, 2);
INSERT INTO dimensions VALUES('xc',3, 9, 1);
INSERT INTO dimensions VALUES('xb',null, null, null);
INSERT INTO dimensions VALUES('xl',null, null, null);
INSERT INTO dimensions VALUES('ya',null, null, null);



'''
1) Write a query to find overall volume of the each product?
'''
select
product_id,
max(len*height*width) as volumne
from dimensions
group by product_id

'''
2) Write a query to Find out max number of units in each warehouse?
'''


select A.warehouse_id,
A.max_units,
B.product_id
from(
select
warehouse_id,
max(units) as max_units
from warehouse
group by warehouse_id)A
join warehouse B on A.warehouse_id = B.warehouse_id
and A.max_units = B.units

'''
3) Write a query to find the products which doesn’t have any dimensions and not present in Dimensions table?
'''

select
w.product_id,
coalesce(d.product_id, 'not_in_dimensions_table') as roduct,
w.units,
d.len,
d.height,
d.width
from warehouse w left join dimensions d
on w.product_id = d.product_id
where len is null and height is null and width is null
or d.product_id is null