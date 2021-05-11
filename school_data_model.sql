create table courses (
id char(10),
name char(20),
semester int
);

create table student_course (
st_id char(10),
course_id char(10),
semester int,
c_grade int
);


insert into courses values ('a', 'Math',1);
insert into courses values ('a', 'Math',2);
insert into courses values ('b', 'Lang',1);
insert into courses values ('b', 'Lang',2);
insert into courses values ('c', 'History',2);
insert into courses values ('d', 'Sport',2);


insert into student_course values ('x','a',1,90);
insert into student_course values ('x','b',2,80);
insert into student_course values ('y','c',2,85);


--All courses that are not taken by anyone
select
c.name,
c.semester,
sc.course_id
from courses c left join student_course sc
on c.id = sc.course_id 
and c.semester = sc.semester
where sc.course_id is null