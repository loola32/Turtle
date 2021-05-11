create table movie_stars
	(  member_id char(10),
		member_name char (20)
		);


create table stars_in_movie
	(  movie_id int,
		member_id char (10)
		);

insert into movie_stars (member_id,member_name)values ('X','Brad Pitt');
insert into movie_stars (member_id,member_name)values ('Y','Jenn Aniston');
insert into movie_stars (member_id,member_name)values ('Z','Angelina Jollie');
insert into movie_stars (member_id,member_name)values ('Z1','Anna Kendrick');
insert into movie_stars (member_id,member_name)values ('Z2','Pamela Anderson');
insert into movie_stars (member_id,member_name)values ('Z3','Chris Hemsworth');
insert into movie_stars (member_id,member_name)values ('Z4','Margo Robbie' );


insert into stars_in_movie (movie_id,member_id)values (1,'X');
insert into stars_in_movie (movie_id,member_id)values (1,'Z');
insert into stars_in_movie (movie_id,member_id)values (1,'Z4');
insert into stars_in_movie (movie_id,member_id)values (2,'X');
insert into stars_in_movie (movie_id,member_id)values (2,'Z1');
insert into stars_in_movie (movie_id,member_id)values (3,'Y');
insert into stars_in_movie (movie_id,member_id)values (3,'Z3');
insert into stars_in_movie (movie_id,member_id)values (4,'Z2');



select
A.member_id as Main_star,
B.member_id as Supportive_star,
msp.member_name as acted_with_Brad
from stars_in_movie A join stars_in_movie B
on A.movie_id = B.movie_id
and A.member_id <> B.member_id
join movie_stars ms
on A.member_id = ms.member_id
join movie_stars msp
on B.member_id = msp.member_id
where ms.member_name = 'Brad Pitt'








select
msa.member_name as acted_with_Brad
from stars_in_movie A left join stars_in_movie B
on A.movie_id = B.movie_id
and A.member_id<>B.member_id
join movie_stars ms on A.member_id=ms.member_id
join movie_stars msa on B.member_id = msa.member_id
where ms.member_name = 'Brad Pitt'
