/*---------- SQL Social-Network Query Exercises (core set) ----------*/
-- Q1 Find the names of all students who are friends with someone named Gabriel.
select name
from Highschooler
where ID in (select ID2 from Friend F
	where F.ID1 in (select ID from Highschooler where name = 'Gabriel') );
 
-- Q2 For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. 
select H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1 join Highschooler H2 join Likes 
on H1.ID = ID1 and H2.ID = ID2 and H1.grade -2 >= H2.grade;
 
-- Q3 For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
select H1.name, H1.grade, H2.name, H2.grade
from Likes L1 join Likes L2 join Highschooler H1 join Highschooler H2
on L1.ID2 = L2.ID1 and L2.ID2 = L1.ID1 and L1.ID1 = H1.ID and L1.ID2 = H2.ID
where H1.name < H2.name;
 
-- Q4 Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
select name, grade
from Highschooler
where ID not in
(select ID1 from Likes union select ID2 from Likes)
order by grade, name;
 
-- Q5 For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.
select H1.name, H1.grade, H2.name, H2.grade
from Likes join Highschooler H1 join Highschooler H2
on ID1 = H1.ID and ID2 = H2.ID
where ID2 not in (select ID1 from Likes);
 
-- Q6 Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade. 
select H1.name, H1.grade from Friend F1 join Highschooler H1 join Highschooler H2
on F1.ID1 = H1.ID and F1.ID2 = H2.ID
group by F1.ID1
having max(H1.grade <> H2.grade) = 0
order by H1.grade, H1.name;
 
-- Q7 For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.
select H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Likes L join Friend F1 join Friend F2 join Highschooler H1 join Highschooler H2 join Highschooler H3
on L.ID1 = H1.ID and L.ID2 = H2.ID and F1.ID2 = H3.ID
where not exists (select * from Friend F where L.ID1 = F.ID1 and L.ID2 = F.ID2) 
	and F1.ID1 = L.ID1 and F1.ID2 = F2.ID1 and F2.ID2 = L.ID2;
	
-- Q8 Find the difference between the number of students in the school and the number of different first names. 
select (select count(*) from Highschooler) - (select count(distinct name) from Highschooler);
 
-- Q9 Find the name and grade of all students who are liked by more than one other student. 
select H2.name, H2.grade
from Likes join Highschooler H1 join Highschooler H2
on ID1 = H1.ID and ID2 = H2.ID
group by ID2
having count(*) > 1;
