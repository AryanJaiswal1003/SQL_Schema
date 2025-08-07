/* Companies table
CREATE TABLE Companies (company_id INTEGER PRIMARY KEY, company_name TEXT
);

-- Departments table
CREATE TABLE Departments (
    department_id INTEGER PRIMARY KEY, department_name TEXT, company_id INTEGER, 
    FOREIGN KEY (company_id) REFERENCES Companies(company_id)
);

-- Employees table
CREATE TABLE Employees (
    employee_id INTEGER PRIMARY KEY, name TEXT, salary INTEGER,
    manager_id INTEGER, department_id INTEGER, 
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Populate Companies
INSERT INTO Companies VALUES
(1, 'Tech Innovations Ltd'), (2, 'Green Valley Corp'), (3, 'Sunrise Solutions');

-- Populate Departments
INSERT INTO Departments VALUES
(1, 'Engineering', 1), (2, 'Human Resources', 1), (3, 'Marketing', 2),
(4, 'Sales', 2), (5, 'Customer Support', 3);

INSERT INTO Employees VALUES
(1, 'Alice Johnson', 95000, NULL, 1), (2, 'Bob Smith', 80000, 1, 1),           
(3, 'Helen Carter', 40000, NULL, 2), (4, 'Ian Black', 58000, NULL, 3),        
(5, 'John Brown', 45000, 4, 4), (6, 'Mona Patel', 47000, NULL, 5); 
*/
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM COMPANIES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

-- [TASK - 1]: Use LEFT JOIN to List Employees and Their Managers?
-- Ans:	
		SELECT E.employee_id, E.name AS employee_name, E.salary, M.name AS manager_name
		FROM EMPLOYEES E
		LEFT JOIN EMPLOYEES M ON E.manager_id = M.employee_id;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 2]: Subquery for Employees Earning Above Average Salary?
-- Ans:
		SELECT EMPLOYEE_ID, NAME, SALARY
        FROM EMPLOYEES
        WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 3]: Nested JOIN to Get Employee Name, Department, and Company?
-- Ans:
		SELECT NAME, DEPARTMENT_NAME, COMPANY_NAME
        FROM (
			EMPLOYEES E
			JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
		)
        JOIN COMPANIES C ON C.COMPANY_ID = D.COMPANY_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 4]: Use a CTE to Find the Second-Highest Salary?
-- Ans:
		WITH EMP_SALARY AS (
			SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES
            ORDER BY SALARY DESC
        )
        SELECT E.NAME, ES.SALARY
        FROM EMP_SALARY ES
        JOIN EMPLOYEES E ON E.EMPLOYEE_ID = ES.EMPLOYEE_ID
        LIMIT 1 OFFSET 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 5]: Rank Employees by Salary Within Departments?
-- Ans:
		SELECT 
			NAME, SALARY, D.DEPARTMENT_NAME,
			RANK() OVER (PARTITION BY E.DEPARTMENT_ID ORDER BY SALARY DESC) AS salary_rank
		FROM EMPLOYEES E
        JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 6]: Categorise Employees as 'Low', 'Medium', or 'High' Earners?
-- Ans:
		SELECT 
			NAME, SALARY, DEPARTMENT_NAME,
			CASE
				WHEN SALARY < 42000 THEN 'LOW'
				WHEN SALARY BETWEEN 42000 AND 60000 THEN 'MEDIUM'
				WHEN SALARY > 60000 THEN 'HIGH' END AS SALARY_CATEGORY
		FROM EMPLOYEES E
        JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
        ORDER BY SALARY DESC;
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------       