CREATE TABLE sales(sales_id char(10), order_date date, customer_id char(10), product_id char(10), purchase_amount int);

CREATE TABLE product(pr_id char(10), pr_name char(10), brand_id char(10), brand_name char(10));

INSERT INTO sales VALUES ('xx', '2019-02-01', 'a', 'first_pr', 10);
INSERT INTO sales VALUES ('xy', '2019-02-02', 'a', 'sec_pr', 15);
INSERT INTO sales VALUES ('xy11', '2019-02-03', 'a', 'sec1_pr', 22);
INSERT INTO sales VALUES ('xx1', '2020-02-01', 'a', 'sec1_pr', 50);
INSERT INTO sales VALUES ('xy1', '2020-02-02', 'a', '5_pr', 70);
INSERT INTO sales VALUES ('ver1', '2020-03-02', 'tt', 'pr_1', 70);
INSERT INTO sales VALUES ('ver2', '2020-03-02', 'll', 'pr_1', 70);
INSERT INTO sales VALUES ('ver3', '2020-03-04', 'ret', 'pr_4', 100);
INSERT INTO sales VALUES ('ver4', '2020-03-05', 'ret1', 'pr_5', 10);
INSERT INTO sales VALUES ('ver5', '2020-03-05', 'ret2', 'pr_9', 4);
INSERT INTO sales VALUES ('ver6', '2020-03-06', 'ret3', 'pr_6', 13);
INSERT INTO sales VALUES ('ver7', '2020-03-07', 'ret3', 'pr_7', 11);
INSERT INTO sales VALUES ('ver8', '2020-03-08', 'ret4', 'pr_77', 5);
INSERT INTO sales VALUES ('xx2', '2021-02-01', 'a', '5_pr', 30);
INSERT INTO sales VALUES ('xy2', '2021-02-02', 'a', '6_pr', 10);
INSERT INTO sales VALUES ('zz', '2019-02-01', 'b', '1_pr', 10);
INSERT INTO sales VALUES ('zy', '2019-02-02', 'b', '2_pr', 15);
INSERT INTO sales VALUES ('zy', '2019-02-02', 'b', '33_pr', 25);
INSERT INTO sales VALUES ('zz1', '2020-02-01', 'b', 'sec1_pr', 10);
INSERT INTO sales VALUES ('zy1', '2020-02-02', 'b', '22_pr', 50);
INSERT INTO sales VALUES ('zz2', '2021-02-01', 'b', '5_pr', 3);
INSERT INTO sales VALUES ('zy3', '2021-02-02', 'b', '23_pr', 4);
INSERT INTO sales VALUES ('aa', '2019-02-01', 'c', '1_ar', 10);
INSERT INTO sales VALUES ('bb', '2019-02-02', 'c', '2_ar', 15);
INSERT INTO sales VALUES ('bb1', '2019-02-02', 'c', 'sec1_pr', 25);
INSERT INTO sales VALUES ('bb29', '2019-02-02', 'c', 'sec0_pr', 3);
INSERT INTO sales VALUES ('cc1', '2020-02-01', 'c', '11_ar', 10);
INSERT INTO sales VALUES ('dd', '2020-02-02', 'c', '22_ar', 50);
INSERT INTO sales VALUES ('ee', '2021-02-01', 'c', '5_pr', 200);
INSERT INTO sales VALUES ('rr', '2021-02-02', 'c', '23_ar', 100);
INSERT INTO sales VALUES ('ry', '2021-02-10', 'c', '22_ar', 5);







INSERT INTO product VALUES ('first_pr', 'love','br1','brand1');
INSERT INTO product VALUES ('sec_pr', 'love2','br1','brand1');
INSERT INTO product VALUES ('sec1_pr', 'lust','br2','brand2');

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