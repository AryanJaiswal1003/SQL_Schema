			############################################ [PART II]: Customer Insights ############################################

-- ########################## [CREATING VIEWS FOR CUSTOMER_NO_RETURN] ##########################
CREATE VIEW CUSTOMER_NO_RETURN AS
	SELECT
		C.CUSTOMERID, CUSTOMERNAME, O.ORDERID, ORDERDATE, REGIONNAME, CATEGORY, P.PRODUCTID, PRODUCTNAME,
		QUANTITY, PRICE
	FROM CUSTOMERS C
	JOIN ORDERS O ON O.CUSTOMERID = C.CUSTOMERID
	JOIN ORDERDETAILS OD ON OD.ORDERID = O.ORDERID
	JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
	JOIN REGIONS R ON R.REGIONID = C.REGIONID
	WHERE ISRETURNED = 0;
-- -------------------------------------------------------------------------------------------------------------------------------------------------    
-- ########################## [CREATING VIEWS FOR CUSTOMER_RETURN] ##########################
CREATE VIEW CUSTOMER_RETURN AS
	SELECT
		C.CUSTOMERID, CUSTOMERNAME, O.ORDERID, ORDERDATE, REGIONNAME, CATEGORY, P.PRODUCTID, PRODUCTNAME,
		QUANTITY, PRICE
	FROM CUSTOMERS C
	JOIN ORDERS O ON O.CUSTOMERID = C.CUSTOMERID
	JOIN ORDERDETAILS OD ON OD.ORDERID = O.ORDERID
	JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
	JOIN REGIONS R ON R.REGIONID = C.REGIONID
	WHERE ISRETURNED = 1;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1] Who are the top 10 customers by total revenue spent?
-- Ans:
		SELECT CUSTOMERID, CUSTOMERNAME, SUM(QUANTITY * PRICE) AS REVENUE_SPENT
        FROM CUSTOMER_NO_RETURN
        GROUP BY CUSTOMERNAME, CUSTOMERID
        ORDER BY REVENUE_SPENT DESC LIMIT 10;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2] What is the repeat customer rate?
-- Ans:
		WITH CUSTOMER_REPRATE AS (
					SELECT CUSTOMERID, COUNT(DISTINCT ORDERID) AS TOTAL
					FROM CUSTOMER_NO_RETURN
					GROUP BY CUSTOMERID
        )
        SELECT ROUND(
			COUNT(DISTINCT CASE WHEN TOTAL > 1 THEN CUSTOMERID END) * 100 / COUNT(DISTINCT CUSTOMERID)
		, 2) AS REP_CUSTOMERRATE 
        FROM CUSTOMER_REPRATE;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q3] What is the average time between two consecutive orders for the same customer Region-wise?
-- Ans:
		WITH ORDER_REPEAT AS (
				SELECT 
					CUSTOMERID, CUSTOMERNAME, REGIONNAME, ORDERDATE,
					LAG(ORDERDATE) OVER (PARTITION BY CUSTOMERID ORDER BY ORDERDATE) AS PREV_ORDERDATE
				FROM CUSTOMER_NO_RETURN
        )
        SELECT
			REGIONNAME,
            ROUND(AVG(DATEDIFF(ORDERDATE, PREV_ORDERDATE)), 2) AS TIMEDIFF
        FROM ORDER_REPEAT
        WHERE PREV_ORDERDATE IS NOT NULL
        GROUP BY REGIONNAME
        ORDER BY REGIONNAME;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q4] Customer Segment (based on total spend) -- > Platinum: Total Spend > 1500; Gold: 1000–1500, Silver: 500–999 Bronze: < 500?
-- Ans:
		WITH CUSTOMER_SEGMENT AS (
					SELECT CUSTOMERNAME, SUM(PRICE * QUANTITY) TOTAL 
                    FROM CUSTOMER_NO_RETURN
					GROUP BY CUSTOMERID
        )
        SELECT  CUSTOMERNAME, 
				CASE 
					WHEN TOTAL < 500 THEN 'BRONZE'
					WHEN TOTAL BETWEEN 500 AND 999 THEN 'SILVER'
					WHEN TOTAL BETWEEN 1000 AND 1500 THEN 'GOLD'
					ELSE 'PLATINUM'
				END AS SEGMENT
        FROM CUSTOMER_SEGMENT
        ORDER BY SEGMENT;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q5] What is the customer lifetime value (CLV)? [CLV: TOTAL REVENUE PER CUSTOMER]
-- Ans:
		SELECT CUSTOMERID, CUSTOMERNAME, SUM(PRICE * QUANTITY) TOTAL 
		FROM CUSTOMER_NO_RETURN
		GROUP BY CUSTOMERID, CUSTOMERNAME
        ORDER BY TOTAL DESC;
        
        SELECT C.CUSTOMERID, C.CUSTOMERNAME, SUM(QUANTITY * PRICE) AS CLV
        FROM CUSTOMERS C
        JOIN ORDERS O ON O.CUSTOMERID = C.CUSTOMERID
        JOIN ORDERDETAILS OD ON OD.ORDERID = O.ORDERID
        JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
        GROUP BY C.CUSTOMERID, C.CUSTOMERNAME
        ORDER BY CLV DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------