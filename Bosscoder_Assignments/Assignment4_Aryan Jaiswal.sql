					-- ####################### [Assignment4_Aryan Jaiswal] ####################### 



/*CREATE DATABASE DEMO;
USE DEMO;

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

-- Create Employees table with CHECK constraint
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert sample data into Departments with explicit IDs
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Sales'), (2, 'Marketing'), (3, 'IT'),
(4, 'Obsolete'), (5, 'HR');

-- Insert sample data into Employees using explicit DepartmentID values
INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary) VALUES
('Alice', 'Johnson', 1, 75000.00), ('Bob', 'Smith', 1, 68000.00),
('Charlie', 'Brown', 3, 90000.00), ('Diane', 'Clark', 4, 55000.00),
('Evan', 'Davis', 2, 62000.00), ('Fiona', 'Evans', 5, 81000.00);*/
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 1]: Update Salary of Sales[DEPARTMENTID = 1] employees by 10%?
-- Ans:
		UPDATE Employees
		SET Salary = Salary * 1.10
		WHERE DepartmentID = 1;
        
       SELECT * FROM EMPLOYEES;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 2]: Delete Employees in 'Obsolete' department [DEPARTMENTID = 4]?
-- Ans:
		DELETE FROM Employees
		WHERE DepartmentID = 4;

		SELECT * FROM EMPLOYEES;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 3]: Create a view showing employees with Salary > 80,000?
-- Ans:
		CREATE VIEW HighEarningEmployees AS
		SELECT 
			e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName, e.Salary
		FROM Employees e
		JOIN Departments d ON e.DepartmentID = d.DepartmentID
		WHERE e.Salary > 80000;
		
        SELECT * FROM HighEarningEmployees;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK 4]: Add a CHECK Constraint to Ensure Salary > 0?
-- Ans:
		CREATE TABLE Employees (
				EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
				FirstName VARCHAR(50) NOT NULL,
				LastName VARCHAR(50) NOT NULL,
				DepartmentID INT,
				Salary DECIMAL(10,2) CHECK (Salary > 0),
				FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
	);
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 5]: Create index on Employees.LastName for faster searching?
CREATE INDEX idx_employee_lastname ON Employees(LastName);
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [TASK - 6] : Create stored procedure to get employees by department name
DELIMITER $$

CREATE PROCEDURE GetEmployeesByDepartment(IN deptName VARCHAR(50))
BEGIN
    SELECT e.EmployeeID, e.FirstName, e.LastName, e.Salary
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE d.DepartmentName = deptName;
END $$
-- --------------------------------------------------------------------------------------------------------------------------------------------------------