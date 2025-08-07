-- Department Table
CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Employee Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);
-- Departments
INSERT INTO department (department_id, department_name) VALUES
    (1, 'Sales'),
    (2, 'IT'),
    (3, 'HR');

-- Employees
INSERT INTO employees (employee_id, employee_name, job_title, salary, department_id) VALUES
    (101, 'Alice', 'Sales Executive', 60000, 1),
    (102, 'Bob', 'Sales Manager', 80000, 1),
    (103, 'Charlie', 'Developer', 75000, 2),
    (104, 'Diana', 'HR Manager', 70000, 3),
    (105, 'Eva', 'Support Engineer', 50000, 2),
    (106, 'Frank', 'Recruiter', 48000, 3);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [QUERIES - 1]: Retrieve all employees from the employees table?
-- Ans:
		SELECT * FROM EMPLOYEES;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [QUERIES - 2]: Select employees working in the 'Sales' department?
-- Ans: 
		SELECT E.EMPLOYEE_NAME, E.JOB_TITLE, D.DEPARTMENT_NAME 
        FROM EMPLOYEES E
        JOIN DEPARTMENT D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
        WHERE D.DEPARTMENT_NAME = 'SALES';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [QUERIES - 3]: List unique job titles available?
-- Ans:
		SELECT DISTINCT JOB_TITLE FROM EMPLOYEES;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [QUERIES - 4]: Sort employees by salary in descending order?
-- Ans:
		SELECT * FROM EMPLOYEES
        ORDER BY SALARY DESC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [QUERIES - 5]: Count the total number of employees?
-- Ans: 
		SELECT COUNT(EMPLOYEE_ID) AS NUM_OF_EMPLOYEES
        FROM EMPLOYEES;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [QUERIES - 6]: Show the average salary per department?
-- Ans: 
		SELECT 
        D.DEPARTMENT_NAME,
        ROUND(AVG(E.SALARY), 2) AS AVG_SALARY
        FROM EMPLOYEES E
        JOIN DEPARTMENT D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
        GROUP BY D.DEPARTMENT_NAME;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [QUERIES - 7]: Join employees and departments to show employee name and department?
-- Ans: 
		SELECT E.EMPLOYEE_NAME, D.DEPARTMENT_NAME 
        FROM EMPLOYEES E
        JOIN DEPARTMENT D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------