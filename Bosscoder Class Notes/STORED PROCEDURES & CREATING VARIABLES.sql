				-- ############################## [STORED PROCEDURES & CREATING VARIABLES] ##############################

-- ################## [VARIABLES]: Variables are containers that holds values. ##################

SET @X = 500; -- [DECLARING VARIABLE].
SELECT @X; -- OUTPUT: 500.
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
USE ONLINE_STORE;

-- [PRACTICE - 1]: Getting Sales where sales amount > 150?
-- Ans: [METHOD - 1]
		SELECT * FROM SALES
		WHERE SALE_AMOUNT > 150; -- [W/O declaring Variables]
-- #################################################################################################################3
-- Ans: [METHOD - 2: DECLARING VARIABLES]
		SET @THRESHOLD = 150;
        
		SELECT * FROM SALES
        WHERE SALE_AMOUNT > @THRESHOLD;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- SETTING MULTIPLE VARIABLES USING SELECT OPERATOR: -

SELECT @TOTAL := SUM(SALE_AMOUNT), @MIN := MIN(SALE_AMOUNT), @MAX := MAX(SALE_AMOUNT)
FROM SALES;

SELECT @TOTAL;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
				-- ################## [STORED PROCEDURES]: Creating Customized functions in SQL ##################

/* DELIMITER = IN SQL, a Delimeter is a character, usually a semicolon (;), that seperates individual statements. It tells the databse engines where one
	command ends & the next one begins.
    
-- ######### [Need for Stored Procedures in SQL]: Stored procedures are precompiled collections of SQL statements & logic stored on the database server. ######

$$ Main Reasons for using Stored procedures are: -

A] Code Reusability & Modularity = Procedures encapsulate business logic & be reused across applications.
B] Performance = Once compiled & stored in database, it reduces parsing & execution planning time for future invocations.
C] Security = Procedures help restrict direct access to tables by granting execution permissions on procedures instead of underlying data.
D] Maintainability = Centralized logic makes it easier to update code & minimize redundancy.
E] Reduced Network Traffic = Multiple operations/queries are bundled together, minimizing round-trips between application & database.

$$ Need to Use a Diff Delimiter in SQL : -

-- In MySQL & similar systems, the default statement delimiter is semicolon (;). However --> Stored procedures may contain multiple SQL statements, 
	each ending in a semicolon.
		If you use the default delimiter while defining a procedure, the server treats the first semicolon it encounters as the end of the entire statement, 
	which unintentionally terminates your procedure definition.
By temporarily changing the delimiter (e.g., to $$ or //), you allow semicolons inside the procedure body without confusing the SQL interpreter.
*/

-- PRINTING 'HELLO WORLD': -
SELECT "HELLO WORLD" AS WELCOME; 
SELECT 'GOOD BYE' AS FAREWELL; -- Proceding w/o an DELIMETER in the Previous statement will throw an Error Code.

-- ############### [SYNTAX] ###############

-- #################### [STEP - 1]: [CHANGING DELIMETER] ####################: -
DELIMITER /
SELECT * FROM SALES / -- NO ERROR.
SELECT 'HELLO WORLD' / -- NO ERROR.

DELIMITER $$ -- CHANGED DELIMITER TO ($$)
-- SELECT 'HELLO WORLD' / -- ERROR 
SELECT 'HELLO WORLD' $$

-- #################### [STEP - 2]: [CREATING PROCEDURE] ####################: - 
DELIMITER $$
CREATE PROCEDURE Welcome()
BEGIN
SELECT 'HELLO WORLD';

END $$
DELIMITER ;

-- #################### [STEP - 3]: [CALLING STORED PROCEDURE] ####################: -
CALL WELCOME(); 

-- #################### [STEP - 4]: [DROPING STORED PROCEDURE] ####################: -
DROP PROCEDURE WELCOME;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [PASSING ARGUEMENTS inside the Procedure --> 1 ARGUEMENT/PARAMETER]: -

DELIMITER $$
CREATE PROCEDURE EXPENSIVE(IN THRESHOLD INT)
BEGIN
	SELECT * FROM SALES WHERE SALE_AMOUNT > THRESHOLD;
END $$
DELIMITER ;

CALL EXPENSIVE(120);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [PASSING MULTIPLE ARGUEMENTS inside the Procedure]: -
DELIMITER ##
CREATE PROCEDURE ARGUEMENTS(IN MIN INT, IN MAX INT)
BEGIN
	SELECT * FROM SALES WHERE SALE_AMOUNT BETWEEN MIN AND MAX;
END ##
DELIMITER ;

CALL ARGUEMENTS(50, 150);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Find out details of sales whose amount is between avg sales and max sales?
-- Ans:
		-- select max(sale_amount) from sales; -- AVG: 176.7500 -- MAX: 330

-- [USING SUBQUERY]
	SELECT * FROM SALES
    WHERE SALE_AMOUNT BETWEEN (select avg(sale_amount) from sales) AND (select max(sale_amount) from sales);

-- [USING STORED PROCEDURE]: -
DELIMITER $$
CREATE PROCEDURE BetterThanAvgSales(IN MIN INT, IN MAX INT)
BEGIN
	SELECT * FROM SALES WHERE SALE_AMOUNT BETWEEN MIN AND MAX;
END $$
DELIMITER ;

-- CALLING PROCEDURE & ALSO SETTING THE VARIABLE VALUES: -
SELECT @X := AVG(SALE_AMOUNT), @Y := MAX(SALE_AMOUNT) FROM SALES; -- > STEP - 1

CALL BetterThanAvgSales(@X , @Y); -- > STEP - 2
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------