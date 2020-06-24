/*---------- SQL Social-Network Modification Exercises ----------*/
-- Q1 It's time for the seniors to graduate. Remove all 12th graders from Highschooler.
delete from Highschooler
where grade = 12;
 
-- Q2 If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.
delete from Likes
where (not exists (select * from Likes L where L.ID1 = Likes.ID2 and L.ID2 = Likes.ID1) ) and exists (select * from Friend F where F.ID1 = Likes.ID1 and F.ID2 = Likes.ID2);
--wired: must use Likes.*
 
-- Q3 For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself. (This one is a bit challenging; congratulations if you get it right.)
insert into Friend
select distinct F1.ID1, F2.ID2
from Friend F1 join Friend F2
on F1.ID2 = F2.ID1 and F1.ID1 <> F2.ID2
where not exists (select * from Friend F where F.ID1 = F1.ID1 and F.ID2 = F2.ID2);
