/*---------- SQL Movie-Rating Modification Exercises ----------*/
-- Q1 Add the reviewer Roger Ebert to your database, with an rID of 209.
insert into Reviewer
values(209, 'Roger Ebert');
 
-- Q2 Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL.
nsert into Rating
select (select rID from Reviewer where name = 'James Cameron') as rID, mID, 5, null
from Movie;
 
-- Q3 For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)
update Movie
set year = year + 25
where (select avg(stars) from Rating where Rating.mID = Movie.mID group by Rating.mID) >= 4;

-- Q4 Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars.
delete from Rating
where ( (select year from Movie where Movie.mID = Rating.mID) not between 1970 and 2000) and stars < 4;
