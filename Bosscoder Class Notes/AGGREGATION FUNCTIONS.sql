									-- AGGREGATION FUNCTIONS [COUNT, SUM, AVG, MIN, MAX]
											-- > Aggregate Functions.
											-- > Group By.
											-- > Coalesce.
											-- > Having Clause.

USE ECOMMERCE;

-- [Scenario]: Count the number of customer records present in the database?
-- Ans: 
		SELECT COUNT(*) FROM CUSTOMERS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Find the average price of our products?
-- Ans: 
		SELECT AVG(PRICE) FROM PRODUCTS; -- [METHOD - 1]
        SELECT SUM(PRICE) / count(stock) AS AVERAGE FROM PRODUCTS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Find the average price of our products only upto 2 decimal places?
-- Ans: 
		SELECT ROUND(AVG(PRICE), 2) FROM PRODUCTS;
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------       
/* [SCENARIO]: John’s e-commerce company has started to invest more in product promotions for growing more. They are trying various promotional 
	activities like promoting highest selling product, identifying regions with higher customers, etc. The team came to you and asked if you can 
		identify the regions where the number of customers is very high?*/
-- Ans:
		SELECT CITY, COUNT(CUSTOMER_ID) AS TOTAL FROM CUSTOMERS
        GROUP BY CITY
        ORDER BY TOTAL DESC;
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------       
-- [SCENARIO]: The management has asked the numbers of orders which are already delivered and which are still in the process?
-- Ans: [COALESCE OPERATOR --> Clause in SQL used for handling the Null values.] 
			-- > COALESCE(col_name, value to replace Null)
		
        SELECT COALESCE(STATUS, 'NOT DETERMINED') AS STATUS, COUNT(ORDER_ID) FROM ORDERS
        GROUP BY STATUS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Write a SQL query to find the number of payments received for each payment method on each date in order so as to analyze the trend 
		-- over span of days?
-- Ans: 
		SELECT PAYMENT_METHOD, COUNT(PAYMENT_ID) AS COUNT, SUM(PAYMENT_AMOUNT) AS TOTAL_AMOUNT FROM PAYMENT
        GROUP BY PAYMENT_METHOD
        ORDER BY COUNT DESC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Identify the customers who spend more than 5000 on a single order and if single customer has multiple 
	-- orders greater than 5000 show the order with the maximum amount?
-- Ans:
		SELECT CUSTOMER_ID, MAX(TOTAL_AMOUNT) FROM ORDERS
        GROUP BY CUSTOMER_ID
        HAVING MAX(TOTAL_AMOUNT) > 5000;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1. Group orders by order date and calculate the total order amount for each date?
-- Ans:
		SELECT ORDER_DATE, SUM(TOTAL_AMOUNT) AS TOTAL_AMT FROM ORDERS
        GROUP BY ORDER_DATE
        ORDER BY TOTAL_AMT DESC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2. Find customers who have placed more than one order?
-- Ans:
		SELECT CUSTOMER_ID, COUNT(ORDER_ID) AS TOTAL_ORDER_PLACED FROM ORDERS
        GROUP BY CUSTOMER_ID HAVING TOTAL_ORDER_PLACED > 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q3. Identify products that have been ordered multiple times in the exact same quantity across different orders and determine the frequency 
		-- of these occurrences?
-- Ans:
		select ORDER_ID, PRODUCT_ID, COUNT(*) from order_items
        GROUP BY ORDER_ID, PRODUCT_ID;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------