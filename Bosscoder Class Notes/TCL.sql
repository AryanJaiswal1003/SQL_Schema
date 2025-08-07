/* ##################### TRANSACTION CONTROL LANGUAGE [TCL]: Rolling back the Table to previous stage, if data at later stage found faulty #####################
										1. SAVEPOINT		2. ROLLBACK			3. COMMIT */

use ecommerce;

/* SCENARIO: We have an employee data but we are only partially sure that it is correct. so, there is possibility to insert the data, & if at a later 
	point in time, if found to be faulty, can you Roll back to the previous stage? */
  
-- TASK-1: SAVEPOINT OPERATOR: -
SAVEPOINT NewInsertion;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

-- SAY THE EMPLOYEE BY MISTAKE DELEATED THE CUSTOMER WITH ID = 28;
DELETE FROM Customer WHERE customerid = 28; -- DELETE OPERATION
SELECT * FROM CUSTOMER;

-- TASK-2: ROLLBACK OPERATION: -
ROLLBACK TO NewInsertion;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
								##################### [CREATING USERS & PRIVILEGES] #####################
-- [CREATING USER]
CREATE USER 'JOHN'@'LOCALHOST' IDENTIFIED BY '1234';

-- [GRANTING PERMISSIONS]:
GRANT ALL PRIVILEGES ON *.* TO 'JOHN'@'LOCALHOST'; -- [GRANT ALL PRIVILEDGES]
GRANT SELECT ON ECOMMERCE.* TO 'JOHN'@'LOCALHOST'; -- [GRANT SELECT PRIVILEDGES]
GRANT SELECT ON ECOMMERCE.SALES TO 'JOHN'@'LOCALHOST'; -- [GRANT ACCESS TO ONLY SALES TABLE IN ECOMMERCE DATABASE]

-- [CHECKING PRIVILEDGES]: -
SELECT * FROM MYSQL.USER;

-- [DROP USER]: -
DROP USER 'JOHN'@'LOCALHOST';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

