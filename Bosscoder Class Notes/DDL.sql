							-- ####################### DATA DEFINITION LANGUAGE [DDL] #######################

CREATE DATABASE MY_ECOMMERCE_DB;

-- TASK-1: CREATING TABLES: -
USE MY_ECOMMERCE_DB;

CREATE TABLE CUSTOMER (
	CUSTOMER_ID INT PRIMARY KEY AUTO_INCREMENT,
    FNAME VARCHAR(100),
    LNAME VARCHAR(100),
    EMAIL VARCHAR(100),
    PHONE_NUM VARCHAR(100) NOT NULL,
    ADDRESS VARCHAR(100) DEFAULT 'NO ADDRESS PROVIDED',
    CITY VARCHAR(100) DEFAULT 'NO ADDRESS PROVIDED',
    COUNTRY VARCHAR(100),
    ZIP_CODE INT
);
DESCRIBE CUSTOMER;

-- TASK-2: ALTERING THE DATABASE: -

-- 1. ADDING TABLES [ADDING DOB TABLE AS INT & NULL]:
ALTER TABLE CUSTOMER
ADD DOB INT NULL;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. MODIFY TABLES [MODIFYING DOB AS DATE FORMAT]:
ALTER TABLE CUSTOMER
MODIFY DOB DATE;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. RENAMING DOB TO DATE OF BIRTH:
ALTER TABLE CUSTOMER
RENAME COLUMN DOB TO DateOfBirth;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. DROPPING THE DATEOFBIRTH COLUMN:
ALTER TABLE CUSTOMER
DROP COLUMN DATEOFBIRTH;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- TASK-3: TRUNCATE [DELETES DATA FROM THE TABLE BUT THE STRUCTURE REMAINS]:
TRUNCATE TABLE CUSTOMER;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- TASK-4: DROP FUNCTION [DELETES BOTH DATA & THE TABLE]:
DROP TABLE CUSTOMER;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------