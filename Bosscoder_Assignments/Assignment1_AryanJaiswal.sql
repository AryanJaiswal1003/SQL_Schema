-- 1. Create a New Database
CREATE DATABASE company_db;

-- Use the newly created database
USE company_db;

---------------------------------------------------
-- 2. Create Tables with Constraints
---------------------------------------------------

-- a) Create companies Table
CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL
);

-- b) Create departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL,
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- c) Create employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    department_id INT,
    salary DECIMAL(15, 2) NOT NULL,
    hire_date DATE NOT NULL,
    manager_id INT NULL,
    job_title VARCHAR(255) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

---------------------------------------------------
-- 3. Insert Sample Data
---------------------------------------------------

-- a) Insert Data into companies
INSERT INTO companies (company_id, company_name) VALUES
(1, 'Tech Innovators Inc'),
(2, 'Green Energy Solutions'),
(3, 'HealthCare Partners');

-- b) Insert Data into departments
INSERT INTO departments (department_id, department_name, company_id) VALUES
(101, 'Research and Development', 1),
(102, 'Sales and Marketing', 1),
(201, 'Project Management', 2),
(202, 'Customer Support', 2),
(301, 'Human Resources', 3),
(302, 'IT Support', 3);

-- c) Insert Data into employees
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, job_title) VALUES
(1001, 'Alice', 'Johnson', 101, 95000.00, '2020-03-15', NULL, 'R&D Manager'),
(1002, 'Bob', 'Smith', 101, 80000.00, '2021-07-10', 1001, 'Software Engineer'),
(1003, 'Carol', 'Davis', 102, 70000.00, '2019-01-25', NULL, 'Marketing Manager'),
(1004, 'David', 'Wilson', 102, 60000.00, '2022-05-30', 1003, 'Sales Representative'),
(2001, 'Eva', 'Taylor', 201, 85000.00, '2018-09-12', NULL, 'Project Manager'),
(2002, 'Frank', 'Brown', 202, 55000.00, '2021-11-03', 2001, 'Customer Support Rep'),
(3001, 'Grace', 'Moore', 301, 78000.00, '2017-06-23', NULL, 'HR Manager'),
(3002, 'Henry', 'Anderson', 302, 62000.00, '2023-01-15', 3001, 'IT Specialist');