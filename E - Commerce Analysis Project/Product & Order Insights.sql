		############################################ [PART III]: Product & Order Insights ############################################

-- Q1] What are the top 10 most sold products (by quantity)?
-- Ans:
		SELECT PRODUCTNAME, CATEGORY, SUM(QUANTITY) AS TOTAL_SALES
        FROM CUSTOMER_NO_RETURN
        GROUP BY PRODUCTNAME, CATEGORY
        ORDER BY TOTAL_SALES DESC LIMIT 10;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2] What are the top 10 most sold products (by revenue)?
-- Ans:
		SELECT PRODUCTNAME, CATEGORY, SUM(QUANTITY * PRICE) AS TOTAL_REVENUE 
        FROM CUSTOMER_NO_RETURN
        GROUP BY PRODUCTNAME, CATEGORY
        ORDER BY TOTAL_REVENUE DESC LIMIT 10;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q3] Which products have the highest return rate?
-- Ans:
		WITH RETURNED AS (
				SELECT PRODUCTID, SUM(QUANTITY) AS TOTAL_RETURNED 
				FROM CUSTOMER_RETURN
                GROUP BY PRODUCTID
        ),
        SOLD AS (
				SELECT PRODUCTID, SUM(QUANTITY) AS TOTAL_SOLD
                FROM ORDERDETAILS
                GROUP BY PRODUCTID
        )
        SELECT P.PRODUCTNAME, ROUND(
				COALESCE(R.TOTAL_RETURNED, 0) / S.TOTAL_SOLD
			, 2) AS RETURNED_RATE
        FROM PRODUCTS P
        JOIN SOLD S ON S.PRODUCTID = P.PRODUCTID
        LEFT JOIN RETURNED R ON R.PRODUCTID = P.PRODUCTID
        ORDER BY RETURNED_RATE DESC LIMIT 10;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q4] Return Rate by Category?
-- Ans:
		WITH TOTAL_RETURNED AS (
				SELECT SUM(QUANTITY) AS RETURNED
				FROM CUSTOMER_RETURN
        )
        SELECT 
			CATEGORY, SUM(QUANTITY) AS RETURNED,
			CONCAT(ROUND(SUM(QUANTITY) * 100 / (SELECT RETURNED FROM TOTAL_RETURNED), 2), '%') AS RETURNED_RATE
		FROM CUSTOMER_RETURN
        GROUP BY CATEGORY ORDER BY RETURNED DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q5] What is the average price of products per region? [AVG PRICE = TOTAL REVENUE / TOTALQTY]
-- Ans:
		SELECT
			REGIONNAME, 
            ROUND(SUM(QUANTITY * PRICE) / SUM(QUANTITY), 2) AS AVG_PRICE
        FROM CUSTOMER_NO_RETURN
        GROUP BY REGIONNAME;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q6] What is the sales trend for each product category?
-- Ans:
		SELECT
			CATEGORY, 
			SUM(CASE WHEN YEAR(ORDERDATE) = 2023 THEN QUANTITY ELSE 0 END) AS Sales_2022,
			SUM(CASE WHEN YEAR(ORDERDATE) = 2023 THEN QUANTITY * PRICE ELSE 0 END) AS Revenue_2022,
			SUM(CASE WHEN YEAR(ORDERDATE) = 2024 THEN QUANTITY ELSE 0 END) AS Sales_2023,
			SUM(CASE WHEN YEAR(ORDERDATE) = 2024 THEN QUANTITY * PRICE ELSE 0 END) AS Revenue_2023,
			SUM(CASE WHEN YEAR(ORDERDATE) = 2025 THEN QUANTITY ELSE 0 END) AS Sales_2024,
			SUM(CASE WHEN YEAR(ORDERDATE) = 2025 THEN QUANTITY * PRICE ELSE 0 END) AS Revenue_2024
		FROM CUSTOMER_NO_RETURN
		GROUP BY CATEGORY
		ORDER BY CATEGORY;
-- -------------------------------------------------------------------------------------------------------------------------------------------------