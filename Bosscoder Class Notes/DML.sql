						-- ####################### DATA MANIPULATION LANGUAGE [DML] #######################:
											-- 1. INSERT 
											-- 2. UPDATE 
											-- 3. DELETE

-- TASK-1: UPDATING VALUES: -
 
-- CASE-1: DOING INDIVIDUALLLY
-- I] UPDATE 1ST RECORD: -
UPDATE Customers
SET first_name = 'Jonathan', last_name = 'Doe_Updated'
where customer_id = 1;
-- II] UPDATE 2ND RECORD: -
UPDATE Customer
SET first_name = 'Janet', last_name = 'Smith_Updated'
where customer_id = 2;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CASE-2: DOING COLLECTIVELY:
Update Customer
	set 
		fname = (case
						when customer_id = 1 then 'Jonathan'
						when customer_id = 2 then 'Janet'
					End),
		lname = (case
						when customer_id = 1 then 'Doe_Updated'
						when customer_id = 2 then 'Smith_Updated'
					End)
where customer_id in (1, 2);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- TASK-2: DELETING THE RECORDS: -
DELETE FROM CUSTOMER
WHERE customer_id = 4 or customer_id = 5;

-- NOTE: If we don't use WHERE condition in the Delete Operation?
-- Ans: It will delete all Data from the Table, keeping the table structure intact. In this case DELETE is SIMILAR to TRUNCATE.
-- BUT: TRUNCATE is faster than DELETE.

select * from customer; 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------