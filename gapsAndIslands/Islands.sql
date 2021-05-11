


INSERT INTO NumSeq(seqval) VALUES(2);   --1
INSERT INTO NumSeq(seqval) VALUES(3);	--2
INSERT INTO NumSeq(seqval) VALUES(4);	--3
INSERT INTO NumSeq(seqval) VALUES(11);	--4
INSERT INTO NumSeq(seqval) VALUES(12);  --5
INSERT INTO NumSeq(seqval) VALUES(13);  --6
INSERT INTO NumSeq(seqval) VALUES(31);  --7
INSERT INTO NumSeq(seqval) VALUES(33);  --8
INSERT INTO NumSeq(seqval) VALUES(34);  --9
INSERT INTO NumSeq(seqval) VALUES(35);  --10
INSERT INTO NumSeq(seqval) VALUES(42);  --11


--version 1
WITH StartingPoints AS
 (SELECT seqval,
  ROW_NUMBER() OVER(ORDER BY seqval) AS rownum
   FROM NumSeq AS A
   WHERE NOT EXISTS
     (SELECT * 
      FROM NumSeq AS B
      WHERE B.seqval = A.seqval - 1)  --2==2
   ),

 EndingPoints AS 
 (SELECT seqval,
  ROW_NUMBER() OVER(ORDER BY seqval) AS rownum
  FROM NumSeq AS A
   WHERE NOT EXISTS
     (SELECT *
      FROM NumSeq AS B
       WHERE B.seqval = A.seqval + 1)
   )

   SELECT S.seqval AS start_range,
   		   E.seqval AS end_range
   FROM StartingPoints AS S   JOIN EndingPoints AS E
    ON E.rownum = S.rownum;




--version 2

SELECT 
MIN(seqval) AS start_range,
MAX(seqval) AS end_range 
FROM 
(SELECT seqval,
 seqval - ROW_NUMBER() OVER(ORDER BY seqval) AS grp
  FROM NumSeq) AS D
GROUP BY grp;






CREATE TABLE T1 
(  id  INT ,
   val VARCHAR(10));

INSERT INTO T1(id, val) VALUES(2, 'a');   --a
INSERT INTO T1(id, val) VALUES(3, 'a');   --a
INSERT INTO T1(id, val) VALUES(5, 'a');   --a
INSERT INTO T1(id, val) VALUES(7, 'b');
INSERT INTO T1(id, val) VALUES(11, 'b');
INSERT INTO T1(id, val) VALUES(13, 'a');   --a
INSERT INTO T1(id, val) VALUES(17, 'a');
INSERT INTO T1(id, val) VALUES(19, 'a');
INSERT INTO T1(id, val) VALUES(23, 'c');
INSERT INTO T1(id, val) VALUES(29, 'c');
INSERT INTO T1(id, val) VALUES(31, 'a');
INSERT INTO T1(id, val) VALUES(37, 'a');
INSERT INTO T1(id, val) VALUES(41, 'a');
INSERT INTO T1(id, val) VALUES(43, 'a');
INSERT INTO T1(id, val) VALUES(47, 'c');
INSERT INTO T1(id, val) VALUES(53, 'c');
INSERT INTO T1(id, val) VALUES(59, 'c');


WITH C AS 
(  SELECT id,
 		  val,
ROW_NUMBER() OVER(ORDER BY id) - ROW_NUMBER()
 OVER(partition by val ORDER BY id) AS grp
 FROM T1 )

 SELECT MIN(id) AS mn,
       MAX(id) AS mx,
       val FROM C
        GROUP BY val, grp
         ORDER BY val,mn,mx


