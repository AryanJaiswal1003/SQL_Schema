									-- ################### ASSIGNMENT 5 #####################

/*-- Create database and switch to it
CREATE DATABASE company;
USE company;

-- Departments table
CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(50) NOT NULL);

-- Employees table
CREATE TABLE employees (
  employee_id INT PRIMARY KEY, 
  employee_name VARCHAR(100),
  salary DECIMAL(10, 2),
  department_id INT,
  manager_id INT,
  FOREIGN KEY (department_id) REFERENCES departments(department_id),
  FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Sample data
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'), (2, 'Engineering'), (3, 'HR');

INSERT INTO employees (employee_id, employee_name, salary, department_id, manager_id) VALUES
(101, 'Alice', 5000, 1, NULL), (102, 'Bob', 4500, 1, 101),
(103, 'Charlie', 7000, 2, NULL), (104, 'David', 6000, 2, 103),
(105, 'Eve', 4000, 3, NULL);*/
-- -------------------------------------------------------------------------------------------------------------------------------------------------    
-- TASK - 1: Transaction to Transfer Salary?
-- Ans:
		START TRANSACTION;
		UPDATE employees
		SET salary = salary - 1000
		WHERE employee_id = 101;
		
        UPDATE employees
		SET salary = salary + 1000
		WHERE employee_id = 102;
		COMMIT;
        
        SELECT * FROM EMPLOYEES;
-- -------------------------------------------------------------------------------------------------------------------------------------------------    
-- TASK - 2: Departments with Employees USING EXISTS?
-- Ans:
		SELECT DEPARTMENT_ID, DEPARTMENT_NAME
        FROM DEPARTMENTS D
        WHERE EXISTS (
			SELECT 1 FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
        );
-- -------------------------------------------------------------------------------------------------------------------------------------------------    
-- TASK - 3: Recursive CTE for Employee-Manager Hierarchy?
-- Ans:
		WITH RECURSIVE EMPLOYEE_HIERARCHY AS (
			SELECT EMPLOYEE_ID, EMPLOYEE_NAME, MANAGER_ID, 1 AS LEVEL
			FROM EMPLOYEES
			WHERE MANAGER_ID IS NULL
			UNION ALL
            SELECT E.EMPLOYEE_ID, E.EMPLOYEE_NAME, E.MANAGER_ID, EH.LEVEL + 1
            FROM EMPLOYEES E
            JOIN EMPLOYEE_HIERARCHY EH ON EH.EMPLOYEE_ID = E.MANAGER_ID
			
       ) 
        SELECT EMPLOYEE_ID, EMPLOYEE_NAME, MANAGER_ID, LEVEL
        FROM EMPLOYEE_HIERARCHY
        ORDER BY LEVEL, EMPLOYEE_ID, MANAGER_ID;
-- -------------------------------------------------------------------------------------------------------------------------------------------------    
-- TASK - 4: LEAD and LAG for Salaries?
-- Ans:
		SELECT EMPLOYEE_ID, EMPLOYEE_NAME, SALARY,
			LAG(SALARY) OVER (ORDER BY SALARY) AS LAG_SALARY,
			LEAD(SALARY) OVER (ORDER BY SALARY) AS LEAD_SALARY
		FROM EMPLOYEES
        ORDER BY SALARY;
-- -------------------------------------------------------------------------------------------------------------------------------------------------


-- TASK - 5: Salary Totals with ROLLUP? --> Use GROUP BY with ROLLUP to show salary totals per department and overall.
-- Ans:
		SELECT D.DEPARTMENT_NAME, SUM(SALARY) AS TOTAL_SALARY
        FROM EMPLOYEES E
        JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        GROUP BY D.DEPARTMENT_NAME WITH ROLLUP;
        
        
        
        
        
        
        