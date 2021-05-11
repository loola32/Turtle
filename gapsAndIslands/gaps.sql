
CREATE TABLE NumSeq 
( seqval INT );

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
    SELECT   seqval + 1 AS start_range          
   (SELECT MIN(B.seqval)							
    FROM NumSeq AS B
    WHERE B.seqval > A.seqval) - 1 AS end_range     

    FROM NumSeq AS A

    WHERE NOT EXISTS 
    	(SELECT *  FROM NumSeq AS B  WHERE B.seqval = A.seqval + 1)
       	AND seqval < (SELECT MAX(seqval) FROM NumSeq);



--version 2
    WITH C AS
     ( SELECT seqval,
      ROW_NUMBER() OVER(ORDER BY seqval) AS rownum
       FROM dbo.NumSeq )

    SELECT Cur.seqval + 1 AS start_range,
    Nxt.seqval - 1 AS end_range
    FROM C AS Cur  JOIN C AS Nxt
    ON Nxt.rownum = Cur.rownum + 1                  
    WHERE Nxt.seqval - Cur.seqval > 1;