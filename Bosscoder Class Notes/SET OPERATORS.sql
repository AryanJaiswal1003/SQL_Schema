					-- ############################## SET OPERATORS [UNION, INTERSECT, MINUS] ##############################

USE demo;

/*CREATE TABLE university_professors (
    professor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    teaching_subject VARCHAR(100),
    office_location VARCHAR(100),
    office_hours VARCHAR(100),
    academic_rank VARCHAR(50)
);
CREATE TABLE online_platform_professors (
    professor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    platform_name VARCHAR(100),
    teaching_subject VARCHAR(100),
    course_schedule VARCHAR(100)
);
INSERT INTO university_professors (professor_id, first_name, last_name, department, teaching_subject, office_location, office_hours, academic_rank)
VALUES
    (1, 'John', 'Smith', 'Computer Science', 'Data Structures', 'Building A, Room 101', 'Monday 2-4 PM', 'Professor'),
    (2, 'Alice', 'Johnson', 'Mathematics', 'Calculus', 'Building B, Room 203', 'Wednesday 10 AM-12 PM', 'Associate Professor'),
    (3, 'Michael', 'Brown', 'Physics', 'Quantum Mechanics', 'Building C, Room 305', 'Tuesday 3-5 PM', 'Professor'),
    (4, 'Emily', 'Davis', 'History', 'World History', 'Building D, Room 107', 'Thursday 1-3 PM', 'Associate Professor'),
    (5, 'David', 'Wilson', 'English', 'Literature', 'Building E, Room 201', 'Friday 9-11 AM', 'Professor');
INSERT INTO online_platform_professors (professor_id, first_name, last_name, platform_name, teaching_subject, course_schedule)
VALUES
    (101, 'Maria', 'Martinez', 'OnlineEdX', 'Machine Learning', 'Monday and Wednesday 6-8 PM'),
    (102, 'Robert', 'Clark', 'Coursera', 'Artificial Intelligence', 'Tuesday and Thursday 9-11 AM'),
    (103, 'Jennifer', 'Lee', 'Udemy', 'Web Development', 'Friday 3-5 PM'),
    (104, 'Daniel', 'Hall', 'edX', 'Data Analytics', 'Tuesday and Friday 1-3 PM'),
    (105, 'Sarah', 'Garcia', 'Coursera', 'Digital Marketing', 'Monday and Thursday 2-4 PM'),
    (106, 'Emily', 'Davis', 'Udemy', 'World History', 'Thursday 1-3 PM'),
    (107, 'David', 'Wilson', 'edX', 'Literature', 'Friday 9-11 AM');*/
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM UNIVERSITY_PROFESSORS;
SELECT * FROM ONLINE_PLATFORM_PROFESSORS;

-- ####################### [UNION OPERATOR] #######################
SELECT COUNT(*)
FROM (
	SELECT FIRST_NAME, LAST_NAME FROM UNIVERSITY_PROFESSORS
	UNION
	SELECT FIRST_NAME, LAST_NAME FROM ONLINE_PLATFORM_PROFESSORS
) TEMP;

-- ####################### [UNION ALL OPERATOR] #######################
SELECT COUNT(*)
FROM (
	SELECT FIRST_NAME, LAST_NAME FROM UNIVERSITY_PROFESSORS
	UNION ALL
	SELECT FIRST_NAME, LAST_NAME FROM ONLINE_PLATFORM_PROFESSORS
) TEMP;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
					/* ####################### [INNER JOIN & EXIST (INTERSECT) OPERATOR] #######################
				 [IN MYSQL, THERE IS NO INTERSECT SET OPEARATOR, THUS WE USE EITHER INNER JOIN or EXIST OPERATOR].*/

-- [SCENARIO]: Find the list of university professors who already are teaching on both online & offline platforms?
-- Ans: [MEHTOD - 1] = INNER JOIN: -
		SELECT 
			CONCAT(UP.FIRST_NAME, ' ' , UP.LAST_NAME) AS COMMON_PROFESSOR,
			UP.TEACHING_SUBJECT
		FROM UNIVERSITY_PROFESSORS UP
		INNER JOIN ONLINE_PLATFORM_PROFESSORS OP 
        ON UP.FIRST_NAME = OP.FIRST_NAME AND UP.LAST_NAME = OP.LAST_NAME;
        
-- Ans: [METHOD - 2] = EXIST OPERATOR: -
		SELECT
			CONCAT(UP.FIRST_NAME, ' ' , UP.LAST_NAME) AS COMMON_PROFESSOR,
			UP.TEACHING_SUBJECT
		FROM UNIVERSITY_PROFESSORS UP
        WHERE EXISTS (
			SELECT 1 
             FROM ONLINE_PLATFORM_PROFESSORS OP
            WHERE UP.FIRST_NAME = OP.FIRST_NAME AND UP.LAST_NAME = OP.LAST_NAME
        );
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
					-- ####################### [LEFT JOIN & NOT EXIST (MINUS) OPERATOR] #######################
				 -- [IN MYSQL, THERE IS NO MINUS SET OPEARATOR, THUS WE USE EITHER LEFT JOIN or NOT EXIST OPERATOR].

-- [SCENARIO]: Find the list of university professors who are not taking any online classes?
-- Ans: [METHOD - 1] = LEFT JOIN: -
		SELECT 
			CONCAT(U.FIRST_NAME, ' ' , U.LAST_NAME) AS PROFESSOR,
			U.TEACHING_SUBJECT AS SUBJECTS
		FROM UNIVERSITY_PROFESSORS U
        LEFT JOIN ONLINE_PLATFORM_PROFESSORS O 
        ON U.FIRST_NAME = O.FIRST_NAME AND U.LAST_NAME = O.LAST_NAME
        WHERE O.FIRST_NAME IS NULL;
     
-- Ans: [METHOD - 2] = NOT EXISTS: -
		SELECT 
			CONCAT(U.FIRST_NAME, ' ' , U.LAST_NAME) AS PROFESSOR,
			U.TEACHING_SUBJECT AS SUBJECTS
		FROM UNIVERSITY_PROFESSORS U
        WHERE NOT EXISTS (
			SELECT 1
            FROM ONLINE_PLATFORM_PROFESSORS O 
			WHERE U.FIRST_NAME = O.FIRST_NAME AND U.LAST_NAME = O.LAST_NAME
        );
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------