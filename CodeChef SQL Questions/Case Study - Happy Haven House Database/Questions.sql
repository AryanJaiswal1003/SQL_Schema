-- Retrieve all reviews by users who have booked properties in more than one location. Arrange the results in ascending order of user IDs?
-- Ans:
	with user_booking as (
		select bk.property_id, bk.user_id
		from bookings bk
		join properties prop on prop.property_id = bk.property_id
		group by bk.user_id
		having count(distinct prop.location) > 1
	)
	select rv.property_id, rv.user_id, rv.comment
	from reviews rv
	join user_booking ub on ub.user_id = rv.user_id
	order by rv.user_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Find all users who have made more than one payment and have at least one booking for the month of July 2023. Arrange the results in 
	-- ascending order of user IDs?
-- Ans:
	with condition_july as (
		select distinct user_id from bookings
		where start_date >= '2023-07-01' and end_date <= '2023-07-31'
	),
	payment_count as (
		select user_id from payments
		group by user_id
		having count(user_id) > 1
	)
	select usr.user_id, name, email, phone, address
	from users usr
	join condition_july cj on cj.user_id = usr.user_id
	join payment_count pc on usr.user_id = pc.user_id
	order by usr.user_id asc;
    
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- List all properties with their average rating greater than 4 and the number of reviews they have received.
	-- Present the results in ascending order of property IDs?
-- Ans:
	WITH property_stats AS (
		SELECT 
			property_id, round(AVG(rating), 2) AS avg_rating,
			COUNT(*) AS review_count
		FROM Reviews
		GROUP BY property_id
		HAVING AVG(rating) > 4
	)
	SELECT 
		p.property_id, p.title, p.location,
		ps.avg_rating as average_rating,
		ps.review_count
	FROM Properties p
	JOIN property_stats ps ON p.property_id = ps.property_id
	ORDER BY p.property_id ASC;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve properties that have a rating higher than the average rating of all properties in the dataset.
	-- Present the results in ascending order of property IDs?
-- Ans:
	select 
		property_id, title, 
		location, rating,
		(select avg(rating) from properties) as avg_all_ratings
	from properties
	where rating > (select avg(rating) from properties)
	order by property_id asc;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Get the user with the maximum number of favorite properties?
-- Ans:
	with property_count as (
		select user_id, count(property_id) as num_property
		from favorites
		group by user_id
	)
	select user_id, count(property_id) as favorite_count
	from favorites
	group by user_id
	having favorite_count = (select max(num_property) from property_count);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Find the properties that have all the following amenities available: 'Heating' and 'Kitchen'?
-- Ans:
	select distinct prop.property_id, title, location
	from properties prop
	join propertyamenities pa on pa.property_id = prop.property_id
	join amenities am on am.amenity_id = pa.amenity_id
	where am.name in ('Heating', 'Kitchen');

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve properties with the highest two bookings in Canada?
-- Ans:
	with booking as (
		select property_id, count(*) as booking_count
		from bookings
		group by property_id
	)
	select prop.property_id, title, location, booking_count
	from properties prop
	join booking b on b.property_id = prop.property_id
	where location like '%Canada%'
	order by booking_count desc
	limit 2;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- List the properties that have less than two amenities?
-- Ans:
	WITH AmenityCount AS (
		SELECT property_id, COUNT(amenity_id) AS total_amenities
		FROM PropertyAmenities
		GROUP BY property_id
		HAVING COUNT(amenity_id) < 2
	)
	SELECT 
		prop.property_id, title, prop.location, 
		am.amenity_id, am.name
	FROM Properties prop
	JOIN AmenityCount ac ON prop.property_id = ac.property_id
	JOIN PropertyAmenities pa ON prop.property_id = pa.property_id
	JOIN Amenities am ON am.amenity_id = pa.amenity_id
	ORDER BY prop.property_id ASC;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Retrieve users who have favorited properties with an average rating greater than 4, including property details.
Arrange the results in ascending order based on the property IDs?*/
-- Ans:
	with avg_ratings as (
		select property_id, avg(rating) as avg_rate
		from reviews
		group by property_id
		having avg_rate > 4
	)
	select
		usr.user_id, usr.name,
		prop.property_id, prop.title, prop.location
	from users usr
	join favorites fv on fv.user_id = usr.user_id
	join properties prop on prop.property_id = fv.property_id
	join avg_ratings ar on ar.property_id = prop.property_id
	order by prop.property_id asc;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Provide a list of properties that are mentioned as "farmhouse" in the property title and meet the following criteria:
	1. The properties must have at least a 4.5 rating.
	2. They should be booked for dates between September 1, 2023, and September 30, 2023?*/
-- Ans:
	with booking_date as (
		select distinct prop.property_id from bookings bk
		join properties prop on prop.property_id = bk.property_id
		where rating >= 4.5 
		and start_date >= '2023-09-01' and end_date <= '2023-09-30' 
		and title like '%Farmhouse%'
	)
	select prop.property_id, title, rating, location
	from properties prop
	join booking_date bd on bd.property_id = prop.property_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------