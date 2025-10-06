-- Output the list of unique subscribers?
select distinct subscriber_id from subscribers
order by subscriber_id;

-- Calculate the total number of courses sold and display the count?
select count(course_id) as total_courses_sold
from subscribers;

-- Calculate the number of courses enrolled by each subscriber?
select subscriber_id, count(course_id) as courses_enrolled
from subscribers
group by subscriber_id;

-- Output all courses where the price is greater than the average price?
select course_id, course_name, price
from courses
where price > (select avg(price) from courses);

-- Determine the number of courses created by each instructor?
select 
    i.instructor_id, first_name, last_name,
    count(course_id) as courses_created
from instructors i 
join courses c on i.instructor_id = c.instructor_id
group by i.instructor_id;

-- Find the difference of each course price from the average course price?
WITH AvgPrice AS (
    SELECT AVG(price) AS avg_price
    FROM courses
  )
SELECT 
  c.course_id, c.course_name, c.price,
  c.price - avg_price AS price_diff
FROM courses AS c
CROSS JOIN AvgPrice;

-- Group all courses based on the number of sales and order them by sales count?
select c.course_id, course_name, count(s.course_id) as sales_count
from courses c 
left join subscribers s on c.course_id = s.course_id
group by course_name, c.course_id
order by sales_count desc;

-- Output all courses with exactly one sale?
select c.course_id, course_name
from courses c 
left join subscribers s on c.course_id = s.course_id
group by c.course_id
having count(subscriber_id) = 1;

/*Retrieve a list of instructors who either have a course with zero subscribers or have a course with a price 
	higher than the average price of all courses:*/
with avg_course_price as (
    select instructor_id from courses
    where price > (select avg(price) from courses)
)
select instructor_id, first_name, last_name
from instructors
where instructor_id in (select * from avg_course_price) 
or 
(select count(subscriber_id) from subscribers) = 0;

-- Calculate the lifetime earnings of each instructor ordered by decreasing earnings(Output 0 if no earnings)?
with earnings as (
    select c.instructor_id, sum(price) as total_earnings
    from courses c
    join subscribers s on s.course_id = c.course_id
    group by c.instructor_id
)
select 
    i.instructor_id, first_name, last_name,
    case 
        when e.total_earnings is null then 0 
        else e.total_earnings 
    end as lifetime_earnings
from instructors i
left join earnings e on i.instructor_id = e.instructor_id
order by lifetime_earnings desc;

-- Retrieve the courses where the number of sales is greater than the average?
with sales as (
    select course_id, count(subscriber_id) as sales_count
    from subscribers
    group by course_id
),
avgsales as (
    select avg(sales_count) as avg_sales 
    from sales
)
select c.course_id, course_name, instructor_id, price
from courses c
join sales s on c.course_id = s.course_id
where sales_count > (select avg_sales from avgsales);