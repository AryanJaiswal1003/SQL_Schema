							-- ############################## DATE FUNCTIONS ##############################
/*CREATE DATABASE demo;
USE demo;

CREATE TABLE Employee(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    BirthDate DATE,
    HireDate DATE,
    Salary DECIMAL(10, 2),
    Department VARCHAR(255)
);
INSERT INTO Employee (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary, Department)
VALUES
(1, 'John', 'Doe', '1990-05-15', '2015-03-10', 55000.00, 'Sales'),
(2, 'Jane', 'Smith', '1985-08-21', '2016-01-22', 60000.00, 'Marketing'),
(3, 'Michael', 'Johnson', '1992-12-02', '2017-07-05', 52000.00, 'IT'),
(4, 'Emily', 'Davis', '1988-04-17', '2018-09-12', 65000.00, 'HR'),
(5, 'David', 'Wilson', '1995-07-09', '2019-02-28', 58000.00, 'Finance'),
(6, 'Sarah', 'Anderson', '1983-02-14', '2020-06-15', 70000.00, 'Sales'),
(7, 'Jennifer', 'Lee', '1991-11-30', '2021-04-20', 54000.00, 'Marketing'),
(8, 'Matthew', 'Brown', '1989-09-05', '2015-12-03', 61000.00, 'IT'),
(9, 'Olivia', 'Taylor', '1994-06-23', '2017-08-18', 59000.00, 'HR'),
(10, 'Daniel', 'Martinez', '1987-03-07', '2018-11-14', 66000.00, 'Finance'),
(11, 'Ava', 'Garcia', '1993-01-12', '2019-10-07', 57000.00, 'Sales'),
(12, 'William', 'Rodriguez', '1984-10-28', '2020-03-25', 63000.00, 'Marketing'),
(13, 'Sophia', 'Hernandez', '1996-04-03', '2021-07-09', 62000.00, 'IT'),
(14, 'James', 'Lopez', '1986-08-10', '2016-09-02', 67000.00, 'HR'),
(15, 'Emma', 'Clark', '1990-12-19', '2017-11-30', 60000.00, 'Finance');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------	
									############################# [SYNTAX] #############################
1] CURRENT_DATE() or CURDATE() = RETURNS THE CURRENT DATE.
2] CURRENT_TIME() or CURTIME() = RETURNS THE CURRENT TIME.
3] CURRENT_TIMESTAMP() = RETURNS THE CURRENT DATE & TIME.
4] DATE_ADD() = ADDS SPECIFIC INTERVAL TO DATE or TIMESTAMP --> SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 4 DAY) or SELECT CURRENT_DATE() + INTERVAL 4 DAY/MONTH/QUARTER/YEAR.
5] DATE() = FUNCTION EXTRACTS THE DATE PART (YYYY-MM-DD).
6] EXTRACT() = EXTRACTS SPECIFIC COMPONENTS FROM DATE or TIMESTAMP VALUE --> EXTRACT(field FROM source).
				-- FIELD: SPECIFIES THE COMPONENT YOU WANT TO EXTRACT[e.g., YEAR/MONTH/DAY/WEEK/QUARTER HOUR/MINUTES/SECOND].
				-- SOURCE: DATE or TIMESTAMP VALUE FROM WHICH COMPONENT IS TO BE EXTRACTED.

7] DATEDIFF() = CALCULATES THE DIFFRENCE IN DAYS B/W DATES --> DATEDIFF(date1, date2).
8] TIMESTAMPDIFF() = CALCULATES THE DIFF PROVIDED FIELDS BETWEEN DATES --> TIMESTAMPDIFF(unit, date1, date2).
				-- UNITS: MINUTES/HOUR/SECOND/DAY/MONTH/YEAR.
9] DATE_FORMAT() = FORMATS DATE or TIMESTAMP VALUE as a STRING ACC TO a SPECIFIED FORMAT --> SELECT DATE_FORMAT(date, '%Y-%m-%d').

					-----------------------------------------------------------------------------------------------------------------------------
					|	FORMAT SPECIFIER	|			            DESCRIPTION						|	 OUTPUT FOR ('2024-02-19 15:30:45') 	|
					-----------------------------------------------------------------------------------------------------------------------------
					| 		    %Y 			|				YEAR (4 DIGITS)							|	2024									|
					|			%y			|				YEAR (2 DIGITS)							| 	24										|
					|			%M			|				FULL MONTH NAME							|	FEBRUARY								|
					|			%m			|				MONTH (2 DIGITS)						|	02										|
					|			%b			|			 ABBREVIATED MONTH NAME						|	FEB										|
					|			%D			|		 DAY OF THE MONTH IN th FORMAT (2 DIGITS)		|	19th									|
					|			%d			|			DAY OF THE MONTH (2 DIGITS)					|	19										|
					|			%W 			|				FULL WEEKDAY NAME						|	MONDAY									|
					|			%a			|			ABBREVIATED WEEKDAY NAME					|	MON										|
					-----------------------------------------------------------------------------------------------------------------------------*/
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------	
-- ############################# [QUERY - 1] #############################
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 4 DAY);
SELECT CURRENT_DATE() + INTERVAL 4 DAY; 

-- [QUERY - 1.2]: -
SELECT DATE(CURRENT_TIMESTAMP());

-- [QUERY - 1.3]: -
SELECT DATE('2025-09-05 05:50:55.2100');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ############################# [QUERY - 2] #############################
SELECT DATE_ADD('2025-9-05', INTERVAL 1 DAY);
SELECT DATE('2025-09-05') + INTERVAL 1 DAY;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ############################# [QUERY - 3] #############################
SELECT DATE_ADD('2025-09-15', INTERVAL -1 WEEK);
SELECT DATE('2025-09-05') + INTERVAL -1 WEEK;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ############################# [QUERY - 4] #############################
SELECT DATE_ADD('2025-09-05', INTERVAL 1 MONTH);
SELECT DATE('2025-09-05') + INTERVAL 1 MONTH;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ############################# [QUERY - 5] #############################
SELECT DATE_ADD('2025-09-05', INTERVAL -1 YEAR);
SELECT DATE('2025-09-05') + INTERVAL -1 YEAR;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ############################# [QUERY - 6] #############################
SELECT EXTRACT(YEAR FROM '2025-09-05 05:50:55.2100');
SELECT YEAR('2025-09-05 05:50:55.2100');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ############################# [QUERY - 7] #############################
SELECT DATEDIFF('2024-05-24', '2024-04-24'); -- > DATE1 - DATE2
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ############################# [QUERY - 8] #############################
SELECT TIMESTAMPDIFF(MINUTE, '2025-09-05 10:00:00', '2028-09-06 10:30:00'); -- > TIME2 - TIME1
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ############################# [QUERY - 9] #############################
SELECT DATE_FORMAT('2024-02-19', '%D-%M-%Y') AS FORMATTED_DATE;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
/* [SCENARIO]: The HR Team seeks to retrive servicing duration for all employees to recognize & reward long-serving individuals & track service
				milestones. How do you plan to help them?*/
-- Ans: 
        SELECT 
        CONCAT(FIRSTNAME, ' ', LASTNAME) AS FULL_NAME,
        CONCAT(TIMESTAMPDIFF(DAY, HIREDATE, CURRENT_DATE), '  ', "Day's") AS SERVICE_PERIOD
        FROM EMPLOYEE;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------- 
