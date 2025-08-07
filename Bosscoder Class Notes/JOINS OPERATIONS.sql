					-- ####################### JOINS OPERATIONS[INNER, SELF, LEFT, RIGHT, FULL, CROSS] ####################### 

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
/*-- 1. (Optional) Create the database
CREATE DATABASE library_db;

-- 2. Use the new database
USE library_db;

-- 3. Create the authors table
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

-- 4. Create the books table, with foreign key to authors
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- 5. Create the book_loans table, with foreign key to books
CREATE TABLE book_loans (
    borrow_id INT PRIMARY KEY,
    book_id INT,
    borrower_name VARCHAR(255) NOT NULL,
    loan_date DATE NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- 6. Insert sample data into authors

INSERT INTO authors (author_id, author_name) VALUES
(1, 'J.K. Rowling'),
(2, 'George Orwell'),
(3, 'Jane Austen');

-- 7. Insert sample data into books

INSERT INTO books (book_id, title, author_id) VALUES
(101, 'Harry Potter and the Sorcerer''s Stone', 1),
(102, 'Harry Potter and the Chamber of Secrets', 1),
(201, '1984', 2),
(202, 'Animal Farm', 2),
(301, 'Pride and Prejudice', 3),
(302, 'Sense and Sensibility', 3);

-- 8. Insert sample data into book_loans

INSERT INTO book_loans (borrow_id, book_id, borrower_name, loan_date) VALUES
(5001, 101, 'Alice Johnson', '2025-06-15'),
(5002, 201, 'Bob Smith', '2025-07-01'),
(5003, 301, 'Carol Davis', '2025-07-10'),
(5004, 202, 'David Wilson', '2025-07-20');*/
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM BOOK_LOANS;
SELECT * FROM BOOKS;
SELECT * FROM AUTHORS;

-- [SCENARO]: You visited a library, and the librarian, sought your assistance in retrieving a list of borrowed books along with their authors. 
		-- How can you help her?
-- Ans:
		SELECT A.AUTHOR_ID, B.TITLE, BL.BORROW_ID, BL.BORROWER_NAME, BL.LOAN_DATE
        FROM AUTHORS A
        JOIN BOOKS B ON A.AUTHOR_ID = B.AUTHOR_ID
		JOIN BOOK_LOANS BL ON BL.BOOK_ID = B.BOOK_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
						-- ################################ UNIVERSITY DATABASE ################################

/*CREATE DATABASE University;
USE University;
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Faculty (
    DepartmentID INT PRIMARY KEY,
    FacultyName VARCHAR(50)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Percentage DECIMAL(5, 2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Insert data into Department table
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES
    (1, 'Mathematics'),
    (2, 'Physics'),
    (3, 'English');

-- Insert data into Faculty table
INSERT INTO Faculty (DepartmentID, FacultyName)
VALUES
    (1, 'Piyush'),
    (2, 'Namita'),
    (3, 'Ashneer'),
    (4, 'Ghazal'),
    (5, 'Anupam');

-- Insert data into Student table
INSERT INTO Student (StudentID, Name, Email, Percentage, DepartmentID)
VALUES
    (1001, 'Ajay', 'ajay@xyz.com', 85, 1),
    (1002, 'Babloo', 'babloo@xyz.com', 67, 2),
    (1003, 'Chhavi', 'chhavi@xyz.com', 89, 3),
    (1004, 'Dheeraj', 'dheeraj@xyz.com', 75, NULL), -- Note: No DepartmentID for Dheeraj
    (1005, 'Evina', 'evina@xyz.com', 91, 1),
    (1006, 'Krishna', 'krishna@xyz.com', 99, 3);*/
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: JOINING STUDENT TABLE WITH ITS REPECTIVE FACULTY AND DEPARTMENT?
-- Ans:
		SELECT S.STUDENTID, S.NAME, D.DEPARTMENTNAME, F.FACULTYNAME
        FROM STUDENT S
        INNER JOIN FACULTY F ON S.DEPARTMENTID = F.DEPARTMENTID
        INNER JOIN DEPARTMENT D ON S.DEPARTMENTID = D.DEPARTMENTID
        ORDER BY S.STUDENTID ASC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: The HoD wants to identify high-achieving students along with their department & faculty information for recognition & awards. 
	-- They want to filter students with a percentage greater than or equal to 85 & present this information in descending order of performance?
-- Ans:
		SELECT S.NAME, S.PERCENTAGE, S.EMAIL, D.DEPARTMENTNAME, F.FACULTYNAME 
        FROM STUDENT S
        INNER JOIN FACULTY F ON S.DEPARTMENTID = F.DEPARTMENTID
        INNER JOIN DEPARTMENT D ON S.DEPARTMENTID = D.DEPARTMENTID
        WHERE S.PERCENTAGE >= 85 
        ORDER BY S.PERCENTAGE DESC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
								-- ########################### EMPLOYEE TABLE ###########################
/*CREATE TABLE EMPLOYEES (
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT
);
INSERT INTO EMPLOYEES (employee_id, employee_name, manager_id) 
VALUES
	(1 , 'ZAID', 3),
    (2, 'RAHUL', 3),
	(3 , 'RAMAN', 4),
    (4, 'KAMRAN', NULL),
    (5, 'FARHAN', 4);*/
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------    
-- [Scenario]: HR department needs to maintain an up-to-date record of who reports to whom. Hence, we have to return employee list along with their manager 
	-- names. Employees table has both employee name along with its manager details?
-- Ans:
		SELECT E.EMPLOYEE_NAME AS EMPLOYEE, M.EMPLOYEE_NAME AS MANAGER
        FROM EMPLOYEES E
        JOIN EMPLOYEES M ON E.EMPLOYEE_ID = M.MANAGER_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------        
-- [SCENARIO]: Is it possible to display all the employee names irrespective of whether they have or don’t have the managers?
-- Ans:
		SELECT E.EMPLOYEE_NAME AS EMPLOYEE, M.EMPLOYEE_NAME AS MANAGER
        FROM EMPLOYEES E
        LEFT JOIN EMPLOYEES M ON E.EMPLOYEE_ID = M.MANAGER_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
 -- [SCENARIO]: Identify the list of customers who haven’t placed any order yet. (From ecommerce database)?
 -- Ans:
		SELECT C.FIRST_NAME, O.ORDER_ID, O.ORDER_DATE, O.TOTAL_AMOUNT 
        FROM CUSTOMERS C
        LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
        WHERE O.ORDER_ID IS NULL;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------        
-- [SCENARIO]: Generate a comprehensive report with data of all orders & customers, where each order is mapped with their customer [FULL JOIN]?
-- Ans:
		SELECT C.FIRST_NAME, C.LAST_NAME, O.ORDER_ID, O.ORDER_DATE, O.TOTAL_AMOUNT 
        FROM CUSTOMERS C
        LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
        
        UNION
        
        SELECT C.FIRST_NAME, C.LAST_NAME, O.ORDER_ID, O.ORDER_DATE, O.TOTAL_AMOUNT 
        FROM CUSTOMERS C
        RIGHT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Analyze all potential customer-product pairings to improve their recommendation engine. By examining every possible combination, 
	-- identify which customer-product pairs are successful & which are not? 
-- Ans: 
		SELECT
        CONCAT(FIRST_NAME, ' ', LAST_NAME) AS CUSTOMER_NAME,
        P.PRODUCT_NAME , P.CATEGORY
        FROM CUSTOMERS C
        CROSS JOIN PRODUCTS P;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
					-- ######################################### PRACTICE QUESTIONS #########################################
-- [SCENARIO]: Write an SQL query to list all products along with any orders they have been a part of. If a product has not been included 
		-- in any orders, it should still appear in your list with the order details as NULL?
-- Ans: 
		SELECT P.PRODUCT_NAME, P.CATEGORY, O.ORDER_ID, O.ORDER_DATE 
        FROM ORDERS O
        RIGHT JOIN ORDER_ITEMS OI ON OI.ORDER_ID = O.ORDER_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Write an SQL query to find all pairs of customers who have placed orders on the same date. Exclude pairs of the 
	-- same customer . The output should include first & last names of both customers in each pair & date on which they placed their orders?
-- Ans:
		SELECT 
        CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS CUSTOMER1,
        CONCAT(C1.FIRST_NAME, ' ', C1. LAST_NAME) AS CUSTOMER2,
        O1.ORDER_DATE
        FROM ORDERS O1
        JOIN ORDERS O2 ON O1.ORDER_DATE = O2.ORDER_DATE AND O1.CUSTOMER_ID < O2.CUSTOMER_ID
        JOIN CUSTOMERS C ON C.CUSTOMER_ID = O1.CUSTOMER_ID
        JOIN CUSTOMERS C1 ON C1.CUSTOMER_ID = O2.CUSTOMER_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: How many rows will we get in the output if we left join the Orders and Payments using order_id?
-- Ans:
		SELECT *
        FROM ORDERS O
        LEFT JOIN PAYMENT P ON O.ORDER_ID = P.ORDER_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------