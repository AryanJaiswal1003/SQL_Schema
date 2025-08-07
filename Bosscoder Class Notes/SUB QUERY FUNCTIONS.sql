			/* ############################## SUB QUERY FUNCTIONS [CORRELATED & NON CORRELATED] ##############################
Q] What is a SUB - QUERY?
Ans: SUB-QUERY is a Query under Query. In a Sub-Query, we first executes the Inner query & then pass the Results to the Outer query, 
		& then the outer query executes.

############################## [TWO TYPES] ##############################
A] NON - CORRELATED = The subquery here executes independently of the outer query. The subquery executes first & then passes its results to outer query.
B] CORRELATED = The Inner Query here depends upon the simultaneous execution of the outer query.*/
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
USE ECOMMERCE;
-- [SCENARIO]: Find the Most expensive product in your inventory using a single query? [NON - CORRELATED]
-- Ans:
		SELECT PRODUCT_NAME, PRICE FROM PRODUCTS
        WHERE PRICE = (
				SELECT MAX(PRICE) FROM PRODUCTS
	);
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
/* [SCENARIO]: The marketing team is planning to flag/work upon less popular products. Hence, we need to identify products that have not been ordered 
by any customer?*/
-- Ans:[METHOD - 1]: -
		SELECT PRODUCT_ID, PRODUCT_NAME
        FROM PRODUCTS
        WHERE PRODUCT_ID NOT IN (
				SELECT DISTINCT PRODUCT_ID FROM ORDER_ITEMS
        );

-- Ans: [METHOD - 2]
        SELECT PRODUCT_NAME FROM PRODUCTS P
        LEFT JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID
        WHERE OI.PRODUCT_ID IS NULL;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
/* [SCENARIO]: The manager asks to identify high value customers based on their total purchase amt which must be higher than the avg purchase 
	price amt across all orders?*/
-- Ans:
		-- RETURN CUSTOMER NAME FROM CUSTOMERS TABLE | FIND CUSTOMER ID & ITS TOTAL AOUNT FROM ORDERS | FIND AVG OF TOTAL AMOUNT FROM ORDERS
        SELECT CUSTOMER_ID, 
			CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'NAME', 
            STATE, COUNTRY
        FROM CUSTOMERS
        WHERE CUSTOMER_ID IN (
			SELECT CUSTOMER_ID FROM ORDERS
			WHERE TOTAL_AMOUNT > (
						SELECT AVG(TOTAL_AMOUNT) FROM ORDERS
        ));
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
/* [SCENARIO]: In order to help manage inventory, retrive the product names & quantities of products that have a stock level below the average
		stock we maintain?*/
-- Ans: 
		SELECT PRODUCT_NAME, CATEGORY, STOCK FROM PRODUCTS
        WHERE STOCK < (
				SELECT AVG(STOCK) FROM PRODUCTS
        );
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Help marketing team showcase their product which generated the highest total sales revenue [REVENUE = PRICE * STOCK]?
-- Ans:
		SELECT PRODUCT_NAME, CATEGORY FROM PRODUCTS
        WHERE (PRICE * STOCK) = (
					SELECT MAX(PRICE * STOCK) 
					FROM PRODUCTS
		);
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Identify the products with the lowest price within each product category?
-- Ans: [CORRERELATED SUBQUERY]
		SELECT PRODUCT_NAME, CATEGORY, PRICE
        FROM PRODUCTS P
        WHERE PRICE = (
				SELECT MIN(PRICE) FROM PRODUCTS
                WHERE CATEGORY = P.CATEGORY 
        );
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
