							-- ####################### [CASE STATEMENTS] #######################
USE ECOMMERCE;

/* [SCENARIO 1]: Return to find if we have sufficient stocks of our products or not. In order to understand this, if stock of any product is 
	below 100, then output as ‘Low’ else output as ‘Sufficient stock’?*/
-- Ans:
        SELECT PRODUCT_NAME, 
        (CASE WHEN STOCK < 100 THEN 'LOW' ELSE 'SUFFICIENT' END) AS STOCK_DETAILS
        FROM PRODUCTS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO 2]: We are now required to categorize the products as ‘Cheap’, ‘Reasonable’, or ‘Expensive’ based on their price?
-- Ans:
		SELECT 
			PRODUCT_NAME, CATEGORY, PRICE,
			CASE 
				WHEN PRICE < 500 THEN 'CHEAP'
				WHEN PRICE BETWEEN 500 AND 1000 THEN 'REASONABLE'
			ELSE 'EXPENSIVE' END AS PRICE_CATEGORY
        FROM PRODUCTS
        ORDER BY PRICE ASC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
/* [Scenario]: Now that we have categorized the products into ‘Cheap’, ‘Reasonable’, & ‘Expensive’, we also need to calculate the counts of 
	products in each category?*/
-- Ans:
		SELECT PRICE_CATEGORY, COUNT(DISTINCT PRODUCT_NAME) AS PRODUCT_COUNT
        FROM (
			SELECT PRODUCT_NAME, CATEGORY,
				CASE 
					WHEN PRICE <= 500 THEN 'CHEAP'
					WHEN PRICE <= 1000 THEN 'REASONABLE'
				ELSE 'EXPENSIVE' END AS PRICE_CATEGORY
			FROM PRODUCTS
        ) TEMP
		GROUP BY PRICE_CATEGORY;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Scenario]: Let’s say, we need to find the same, but this time categories in different columns?
-- Ans: ####################### [METHOD 1] #######################
		SELECT 
			COUNT(CASE WHEN PRICE <= 500 THEN PRODUCT_NAME END) AS CHEAP,
            COUNT(CASE WHEN PRICE BETWEEN 501 AND 1000 THEN PRODUCT_NAME END) AS RESONABLE,
            COUNT(CASE WHEN PRICE > 1000 THEN PRODUCT_NAME END) AS EXPENSIVE
        FROM PRODUCTS;
        
-- Ans: ####################### [METHOD 2] #######################
		SELECT 
			SUM(CASE WHEN PRICE <= 500 THEN 1 ELSE 0 END) AS CHEAP,
            SUM(CASE WHEN PRICE BETWEEN 501 AND 1000 THEN 1 ELSE 0 END) AS RESONABLE,
            SUM(CASE WHEN PRICE > 1000 THEN 1 ELSE 0 END) AS EXPENSIVE
        FROM PRODUCTS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
/* Scenario: In order to analyze diversity of price segments in each product category our users are ordering, management asked to come up with 
	data having total quantity ordered within each price range. The decided Price ranges are 0-50, 50-100 and 200+?*/
-- Ans:
		SELECT P.CATEGORY,
			CASE 
				WHEN P.PRICE <= 50 THEN '0 - 50'
                WHEN P.PRICE BETWEEN 51 AND 100 THEN '51 - 100'
                WHEN P.PRICE BETWEEN 101 AND 200 THEN '101 - 200'
                ELSE '200+' END AS PRICE_RANGE,
			SUM(OI.QUANTITY) AS TOTAL_QUANTITY
		FROM PRODUCTS P
        JOIN ORDER_ITEMS OI ON P.PRODUCT_ID = OI.PRODUCT_ID
        GROUP BY P.CATEGORY, PRICE_RANGE;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------