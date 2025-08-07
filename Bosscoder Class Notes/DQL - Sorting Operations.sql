									/* ####################### DATA QUERY LANGUAGE [DQL] #######################:
												1. SORTING OPERATIONS 		2. DISTINCT & LIMIT CLAUSE
												3. ALIASING					4. FILTERING
												5. LOGICAL OPERATORS		6. STRING OPERATORS */

USE ECOMMERCE;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
													
                                                    -- [TASK-I]: SORTING OPERATIONS: -

-- [Scenario]: Suppose ABC company is organizing an event & wants to create personalized name badges for all its attendees. You, have been tasked with 
-- sorting customer list alphabetically by name to facilitate printing individual name badges, ensuring a smooth & organized event registration process.
-- Ans:
		SELECT * FROM Customers ORDER BY first_name ASC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Show me the products list but in the order where the maximum priced product appears first and the minimum priced last. 
-- Ans:
		SELECT * FROM PRODUCTS ORDER BY PRICE DESC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
												
                                                -- [TASK-II]: DISTINCT, LIMIT & OFFSET OPERATIONS: -
 
-- [Scenario]: Sort orders by their order dates. Present me just the details of the last 10 Orders.
-- Ans:
		SELECT * FROM Orders
		ORDER BY Order_date DESC
		LIMIT 10;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ans:
		SELECT * FROM Orders
		ORDER BY Order_date ASC
		LIMIT 10, 5; -- [Returns only 5 Rows from 10 Rows after Limit Operator]
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Show me all the product categories we have? Remove the duplicates.
-- Ans:
		SELECT DISTINCT category FROM Products;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- USING OFFSET OPERATOR: -
-- Ans:
		SELECT * FROM Orders
		ORDER BY Order_date ASC
		LIMIT 10 OFFSET 5;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
                                                    -- [TASK-III]: ALAISING OPERATIONS: -

-- [Scenario]: Is it possible to see the customer’s first name list appearing with column name as Customer and not first_name?
-- Ans:
		SELECT FIRST_NAME AS CUSTOMER
		FROM CUSTOMERS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
													-- [TASK-IV]: FILTERING OPERATIONS [WHERE, IS NULL, IS NOT NULL, BETWEEN]: -

-- [Scenario]: Show me all the products that are marked under the ‘Electronics’ category.
-- Ans:
		SELECT * FROM PRODUCTS WHERE CATEGORY = 'ELECTRONICS';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Show me all the product categories we have except ‘Clothing’.
-- Ans:
		SELECT * FROM PRODUCTS WHERE CATEGORY <> 'CLOTHING';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
/* [Scenario]: 
		 List full names of customers who are from California state(represented as ‘CA” in the database)
		 I want to contact a customer named Jane. Give me his phone number
		 Return product names along with their price whose price is more than Rs.1000. Let products be listed in ascending order of their price*/
         
-- Ans [1 & 2]:
		SELECT customer_id, concat(first_name, ' ', last_name) as Customers, email, phone, address, city, state, country
        FROM CUSTOMERS
        WHERE STATE = 'CA' and first_name = 'jane';
-- Ans [3]:
		SELECT * FROM PRODUCTS WHERE PRICE >= 1000 ORDER BY PRICE ASC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Present me the product names priced between Rs. 500 and Rs.1000
-- Ans:
		SELECT * FROM PRODUCTS WHERE PRICE BETWEEN 500 AND 1000;
		SELECT * FROM PRODUCTS WHERE PRICE >= 500 AND PRICE <= 1000;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
												-- [TASK-V]: LOGICAL OPERATORS [AND, OR, NOT]: -

-- [Scenario]: 
	-- Q1] Give me the list of accessories names along with their price whose price is more than Rs.1000?
    -- Ans:
			SELECT product_name, category FROM PRODUCTS WHERE PRICE > 1000 AND CATEGORY = 'ACCESSORIES';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------           
	-- Q2] Present me a list of product names along with their category which belong to either the Clothing or Footwear category?
    -- Ans:
			SELECT product_name, category FROM Products WHERE category in ('Clothing', 'Footwear');
            SELECT product_name, category FROM Products WHERE category = 'Clothing' OR category = 'Footwear';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------            
	-- Q3] Present me a list of all products along with their category not belonging to the “Electronics” category
    -- Ans: 
			SELECT * FROM PRODUCTS WHERE CATEGORY <> 'ELECTRONICS';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
										/* [TASK-VI]: STRING OPERATORS [LIKE & WILDCARDS(% , _)]: -
I] LIKE: Searches for a specific pattern in a column.
II] WILDCARD USED IN CONJUNCTION WITH LIKE OPERATOR: -
		-- 1. '%': Represents Zero, One or Multiple Characters.
        -- 2. '_': Represents One Character.*/

-- [Scenario]: Retrieve only the customer's email addresses that ends with 'gmail.com.’?
-- Ans:
		SELECT * FROM CUSTOMERS WHERE EMAIL LIKE '%GMAIL.COM';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------        
-- [Scenario]: Retrieve the list of products whose name begins with letter ‘L’ ?
-- Ans:
		SELECT * FROM PRODUCTS WHERE PRODUCT_NAME LIKE 'L%';
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------       
-- [Scenario]: Retrieve the list of customer’s names who’s first name contains exactly 3 letters?
-- Ans:
		SELECT * FROM CUSTOMERS WHERE FIRST_NAME LIKE '___';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- PRACTICE QUESTIONS:
-- Q1) Combine the first & last name of customers to create a full name and write it all in capital letters?
-- Ans:
		SELECT UPPER(concat(FIRST_NAME, ' ', LAST_NAME)) AS FULL_NAME FROM CUSTOMERS; -- UPPER: Converts into UpperCase. Opposite LOWER OPERATOR
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2) What is the length of the names of customers?
-- Ans:
		SELECT FIRST_NAME, length(CONCAT(FIRST_NAME, LAST_NAME)) AS WORD_LEN FROM CUSTOMERS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ** Q3) Extract all the cities which has 2 words?
-- Ans: 
        SELECT * FROM CUSTOMERS WHERE length(city) - length(REPLACE(CITY, " " , "")) + 1 = 2; -- REPLACE(string, substring_to_replace, new_substring)
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q4) Extract the customers who belong to a specific domain name (for e.g. @example.com)?
-- Ans: [METHOD-1]
		SELECT * FROM CUSTOMERS WHERE EMAIL LIKE '%@example.com';
	
    -- [METHOD-2]: SUBSTR(col_name, start_position, length_of_char) ||&|| LOCATE(str, col_name) --> gives start_position
        SELECT * FROM CUSTOMERS
        WHERE SUBSTR(email, locate('@', email)) = '@example.com';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q5) Extract "Class" from " Hello Class"?
-- Ans: 
		SELECT locate('CLASS', "HELLO CLASS"); -- [METHOD - 1: RIGHT Function]
        SELECT substr('HELLO CLASS', LOCATE('CLASS', 'HELLO CLASS'), 5); -- [METHOD - 2: SUBSTR & LOCATE OPERATOR]
        SELECT SUBSTRING_INDEX ('HELLO CLASS', ' ', -1); -- [METHOD - 3: SUBSTRING_INDEX(string, delimiter, count)]
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------