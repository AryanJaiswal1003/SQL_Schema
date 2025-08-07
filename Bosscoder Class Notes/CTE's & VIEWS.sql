			/* ############################## COMMON TABLE EXPRESSION & VIEWS [CTEs] ##############################*/

USE ECOMMERCE;

-- [SCENARIO]: Analyze the sales for each product category?
-- Ans: [USING SUBQUERY]
			SELECT CATEGORY, SALES
            FROM (
				SELECT CATEGORY, SUM(OI.QUANTITY * OI.PRICE) AS SALES
				FROM PRODUCTS P
				JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID
				GROUP BY CATEGORY
            ) T;
-- -----------------------------------------------------------------------------------------
-- Ans: [USING CTE's]
		WITH TOTAL_SALES AS (
			SELECT CATEGORY, SUM(OI.QUANTITY * OI.PRICE) AS SALES
				FROM PRODUCTS P
				JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID
                GROUP BY CATEGORY
        )
        SELECT * FROM TOTAL_SALES; 
 -- -------------------------------------------------------------------------------------------------------------------------------------------------------- 
 /* Calculate the total order amount spent by each customer. Also write the query to list the top 10 customers along with their names based on 
	their total amount spent?*/
-- Ans:
		WITH TOTAL AS (
				SELECT CUSTOMER_ID, SUM(TOTAL_AMOUNT) AS TOTAL_AMT
                FROM ORDERS
                GROUP BY CUSTOMER_ID
			)
		SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'NAME', TOTAL_AMT
        FROM CUSTOMERS C
        JOIN TOTAL T ON T.CUSTOMER_ID = C.CUSTOMER_ID
        ORDER BY TOTAL_AMT DESC LIMIT 10;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- [SCENARIO]: Create a CTE to calculate total sales amount for each month & then present the results?
-- Ans:
		WITH TOTAL AS (
				SELECT 
					DAY(ORDER_DATE) AS 'DAY', 
					SUM(TOTAL_AMOUNT) AS TOTAL_AMT
                FROM ORDERS 
                GROUP BY DAY
        )
        SELECT * FROM TOTAL;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------         
						-- ############################## [VIEWS OPERATOR] ##############################
/* 
## VIEW is a permanent virtual table in the database created with a CREATE VIEW statement, which can be reused in many queries, helps restrict access, 
	& centralizes complex logic.
    
## A CTE is a temporary result set defined within a specific query using WITH clause; it exists only for duration of that query and is often used for 
	making complex queries readable or for recursive operations.

Key differences:
		-------------------------------------------------------------------------------------------------------------------------------------------------
		|	  PARAMETERS		|						VIEWS						 			|						CTE's							 |
        -------------------------------------------------------------------------------------------------------------------------------------------------
		 1] Lifetime:           |	Permanent, persists in the database until dropped.		  	| Temp, exists only during execution of a single query.		
								|																|
         2] Reusability:        |   Can be used in any query, including by multiple users or 	| Only available in the query where it is defined.
								|	processes.													|
								|																|
		 3] Storage:			|	Database object (but stores only query, not results/data)	| Purely in-memory during query execution, not stored in 
								|																| database.
								|																|
		 4] Indexing & 			|	Can sometimes be indexed and permissioned for security.		| Cannot be indexed or secured independently.
			Permissions:		|																|
		-------------------------------------------------------------------------------------------------------------------------------------------------

In summary: Use views for reusable, permanent abstraction or security; use CTEs for temporary, inline simplification of complex or hierarchical queries 
		within a single statement
*/

-- [SCENARIO]: RETURN VIEW TABLE FOR ANALYZING THE DAILY TREND PER CUSTOMER?  
-- Ans: 
		CREATE VIEW DAILY_TREND AS
		SELECT  
			C.CUSTOMER_ID,
			CONCAT(FIRST_NAME, ' ', LAST_NAME) AS CUSTOMER, 
			QUANTITY, TOTAL_AMOUNT
		FROM ORDERS O
		JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
		JOIN ORDER_ITEMS OI ON OI.ORDER_ID = O.ORDER_ID;

SELECT * FROM DAILY_TREND;
-- ------------------------------------------------------- [USING THE VIEW] --------------------------------------------------------------------------------
-- [SCENARIO]: Analysis of Monthly Order Trend?
-- Ans: 
	SELECT
		  D.CUSTOMER_ID,
		  DAY(O.ORDER_DATE) AS "DATE",
		  SUM(D.TOTAL_AMOUNT) AS TOTAL,
		  SUM(D.QUANTITY) AS QUANTITY
FROM DAILY_TREND D
JOIN ORDERS O ON O.CUSTOMER_ID = D.CUSTOMER_ID
GROUP BY D.CUSTOMER_ID, DAY(O.ORDER_DATE)
ORDER BY CUSTOMER_ID;
-- ------------------------------------------------------- [USING THE VIEW] --------------------------------------------------------------------------------
/* [SCENARIO]: The database administrator needs to provide diff departments(sales & inventory) with specific access to data w/o granting them direct access
		to underlying tables with views. How would you solve this?*/

-- Ans: ############################ [STEP - 1]: CREATING VIEWS FOR SALES DEPARTMENT ############################
		CREATE VIEW SALES_DEPT AS
        SELECT 
			O.ORDER_ID, O.ORDER_DATE, P.PRODUCT_ID,
			CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'NAME',
			PRODUCT_NAME, QUANTITY, OI.PRICE
        FROM ORDERS O
        JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
        JOIN ORDER_ITEMS OI ON O.ORDER_ID = OI.ORDER_ID
        JOIN PRODUCTS P ON OI.PRODUCT_ID = P.PRODUCT_ID;
        
		############################ [STEP - 2]: CREATING VIEWS FOR INVENTORY DEPARTMENT ############################
        CREATE VIEW INVENTORY_DEPT AS
        SELECT PRODUCT_ID, PRODUCT_NAME, CATEGORY, PRICE, STOCK
        FROM PRODUCTS;
        
					############################ [STEP - 3]: WORKING WITH VIEWS ############################
        SELECT ORDER_ID, ORDER_DATE, CATEGORY,
        ID.PRODUCT_NAME, NAME, SUM(QUANTITY * SD.PRICE) AS TOTAL_AMT
        FROM SALES_DEPT SD
        JOIN INVENTORY_DEPT ID ON SD.PRODUCT_ID = ID.PRODUCT_ID
        GROUP BY ORDER_ID, ORDER_DATE, CATEGORY, ID.PRODUCT_NAME, NAME;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------