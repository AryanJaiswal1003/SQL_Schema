/*Case Study:- This case study scenario involves user complaints and ride information associated with ABC Cab-booking App. You have been 
	given a dataset containing multiple tables associated with the case study.

As a new data analyst at ABC Cab-booking App, your task is to analyze the data and provide insights.
Can you retrieve a comprehensive report that combines the user_information table with the user_rides table?*/
-- Ans:
SELECT * FROM user_rides ur
LEFT JOIN user_information ui ON ui.user_id = ur.user_id

UNION

SELECT * FROM user_rides ur
RIGHT JOIN user_information ui ON ui.user_id = ur.user_id;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve a comprehensive report that combines the drivers table with the driver_feedback table?
-- Ans:
select * from drivers d
left join driver_feedback df on df. driver_id = d.id
union
select * from drivers d
right join driver_feedback df on df. driver_id = d.id;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
/*As a data analyst at ABC Cab-Booking App, you are tasked with exploring potential partnerships and collaborations to enhance 
	the services offered to customers. You have access to the cities table, which lists all the cities where the cab service operates, and the 
		partner_companies table, containing information about potential partner companies from various industries.

Your objective is to generate all possible combinations of cities and partner companies.
Your findings will play a crucial role in guiding decision-making processes related to partnerships and driving growth for the ABC Cab Booking App?*/
-- Ans:
	select * from cities
	cross join partner_companies;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- The ABC Cab-booking App encountered a peculiar case. A user with ID 10115 had a series of complaints. Retrieve complaint details?
-- Ans:
	select
		uc.complaint_id, ui.user_id,
		ui.full_name, cc.category_name
	from user_information ui
	join user_complaints uc on ui.user_id = uc.user_id
	join complaint_category cc on uc.category_id = cc.category_id
	where ui.user_id = 10115;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- As a data analyst for ABC Cab-booking App, you are tasked with analyzing all the complaints with status as 'resolved' or 'legal action taken'?
-- Ans:
	select
		uc.complaint_id, cs.status, uc.subcategory_id
	from complaint_status cs
	join user_complaints uc on uc.complaint_id = cs.complaint_id
	where status = 'resolved' or status = 'legal action taken';

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- You are a customer support representative for the ABC Cab-booking App, which has been facing some user complaints related to rides.
	-- Generate a report that lists all complaints, including those with missing user information?
-- Ans:
	select
		uc.complaint_id, ui.full_name, ui.email,
		cc.category_name, cd.reason
	from user_complaints uc
	left join user_information ui on ui.user_id = uc.user_id
	join complaint_category cc on cc.category_id = uc.category_id
	join category_description cd on uc.subcategory_id = cd.subcategory_id
	order by complaint_id;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- In the world of the ABC Cab-booking App, there exist a rare breed of users who have never complained about anything. Retrieve cases where the complaint ID is null?
-- Ans:
	select ui.user_id, full_name 
	from user_information ui
	left join user_complaints uc on ui.user_id = uc.user_id
	where complaint_id is null;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
/*As a data analyst at ABC Cab-booking App, you are tasked with analyzing user complaints and their resolution status. retrieve a distinct list 
	of complaint IDs, along with the corresponding user details and most recent status, including those without any complaints.*/
-- Ans:
	SELECT complaint_id, user_id, status, updated
	FROM (
		SELECT cs.complaint_id, uc.user_id, cs.status, cs.updated,
			   ROW_NUMBER() OVER (PARTITION BY cs.complaint_id ORDER BY cs.updated DESC) AS rn
		FROM complaint_status cs
		JOIN user_complaints uc ON uc.complaint_id = cs.complaint_id
	) data_table
	WHERE rn = 1;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve a comprehensive list of all cities and their associated driver information, even if there are no matching records in the 
	-- drivers table for certain cities?
-- Ans:
	select ct.city_id, ct.city_name, dr.id, dr.name
	from drivers dr
	Right join cities ct on dr.city_id = ct.city_id;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------