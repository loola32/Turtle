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

insert into orders(order_id, order_date, customer_id) values ('xx', '2021-01-01','persa');
insert into orders(order_id, order_date, customer_id) values ('xy', '2021-01-01','persb');
insert into orders(order_id, order_date, customer_id) values ('xz', '2021-01-02','persc');
insert into orders(order_id, order_date, customer_id) values ('xa', '2021-01-02','persa');
insert into orders(order_id, order_date, customer_id) values ('xb', '2021-02-10','persd');
insert into orders(order_id, order_date, customer_id) values ('xc', '2021-02-10','persm');
insert into orders(order_id, order_date, customer_id) values ('upd_order', '2021-02-11','persm'); #
insert into orders(order_id, order_date, customer_id) values ('xd', '2021-02-11','persa');
insert into orders(order_id, order_date, customer_id) values ('xe', '2021-03-22','persc');
insert into orders(order_id, order_date, customer_id) values ('xg', '2021-03-23','perskl');
insert into orders(order_id, order_date, customer_id) values ('xh', '2021-03-23','persb');
insert into orders(order_id, order_date, customer_id) values ('xt', '2021-04-05','persy');
insert into orders(order_id, order_date, customer_id) values ('xyp', '2021-04-06','persy');
insert into orders(order_id, order_date, customer_id) values ('new', '2021-04-06','persz');
insert into orders(order_id, order_date, customer_id) values ('new_a', '2021-04-07','persz');


insert into order_items(order_id, item_id, quantity) values ('xx', 'm',2);
insert into order_items(order_id, item_id, quantity) values ('xx', 'm34',3);
insert into order_items(order_id, item_id, quantity) values ('xy', 'ee',10);
insert into order_items(order_id, item_id, quantity) values ('xz', 'tr',11); #
insert into order_items(order_id, item_id, quantity) values ('xz', 'tjl',3); #
insert into order_items(order_id, item_id, quantity) values ('xz', 'why',7); #
insert into order_items(order_id, item_id, quantity) values ('xa', 'sf',3); #
insert into order_items(order_id, item_id, quantity) values ('xb', 'mj',1);
insert into order_items(order_id, item_id, quantity) values ('xb', 'the',3);
insert into order_items(order_id, item_id, quantity) values ('xc', 'dg',22);
insert into order_items(order_id, item_id, quantity) values ('xc', 'best',4);
insert into order_items(order_id, item_id, quantity) values ('xc', 'me',1);
insert into order_items(order_id, item_id, quantity) values ('xd', 'sdfg',5);
insert into order_items(order_id, item_id, quantity) values ('xe', 'ertj',7);
insert into order_items(order_id, item_id, quantity) values ('xg', 'lh',1);
insert into order_items(order_id, item_id, quantity) values ('xg', 'inspire',1);
insert into order_items(order_id, item_id, quantity) values ('xh', 'sgj5r',4);
insert into order_items(order_id, item_id, quantity) values ('xt', 'thnd',8);
insert into order_items(order_id, item_id, quantity) values ('xt', 'love',4);
insert into order_items(order_id, item_id, quantity) values ('xyp', 'love',3);
insert into order_items(order_id, item_id, quantity) values ('new', 'self_love',5);
insert into order_items(order_id, item_id, quantity) values ('new_a', 'health',9);
insert into order_items(order_id, item_id, quantity) values ('upd_order', 'happiness',1);
