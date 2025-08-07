	-- ############################################ [PART IV]: TEMPORAL, REGIONAL & RETURN INSIGHTS ############################################

-- [TEMPORAL TRENDS]
-- Q1] What are the monthly sales trends over the past year?
-- Ans:
		SELECT DATE_FORMAT(ORDERDATE, '%Y-%m') AS YEARMONTH, SUM(QUANTITY * PRICE) AS REVENUE
        FROM CUSTOMER_NO_RETURN
        WHERE ORDERDATE >= CURRENT_DATE() - INTERVAL 12 MONTH
        GROUP BY YEARMONTH ORDER BY YEARMONTH ASC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2] How does the average order value (AOV) change by month or week?
-- Ans:
		SELECT DATE_FORMAT(ORDERDATE, '%Y-%m') AS PERIOD,
				ROUND(SUM(QUANTITY * PRICE) / COUNT(DISTINCT ORDERID), 2) AS AVG_ORDER_VALUE
		FROM CUSTOMER_NO_RETURN
        GROUP BY PERIOD ORDER BY PERIOD;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- [Regional Insights]

-- Q1] Which regions have the highest order volume and which have the lowest?
-- Ans:
		SELECT REGIONNAME, COUNT(ORDERID) AS TOTAL_VOLUME
        FROM CUSTOMER_NO_RETURN
        GROUP BY REGIONNAME
        ORDER BY TOTAL_VOLUME DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2] What is the revenue per region and how does it compare across different regions?
-- Ans:
		SELECT REGIONNAME, SUM(QUANTITY * PRICE) AS REV_PER_REGION
        FROM CUSTOMER_NO_RETURN
        GROUP BY REGIONNAME
        ORDER BY REV_PER_REGION DESC;
        
        SELECT REGIONNAME, COUNT(ORDERID) AS ORDER_VOLUME, SUM(QUANTITY * PRICE) AS REV_PER_REGION
        FROM CUSTOMER_NO_RETURN
        GROUP BY REGIONNAME
        ORDER BY REV_PER_REGION DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Return & Refund Insights

-- Q1] What is the overall return rate by product category?
-- Ans:
		SELECT CATEGORY, 
			ROUND(SUM(CASE WHEN ISRETURNED = 1 THEN 1 ELSE 0 END) / COUNT(O.ORDERID), 2) AS RETURNRATE
		FROM ORDERS O
        JOIN ORDERDETAILS OD ON O.ORDERID = OD.ORDERID
        JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
        GROUP BY CATEGORY ORDER BY RETURNRATE DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2] What is the overall return rate by region?
-- Ans:
		SELECT REGIONNAME, 
			ROUND(SUM(CASE WHEN ISRETURNED = 1 THEN 1 ELSE 0 END) / COUNT(O.ORDERID), 2) AS RETURNRATE
		FROM ORDERS O
        JOIN CUSTOMERS C ON C.CUSTOMERID = O.CUSTOMERID
        JOIN REGIONS R ON R.REGIONID = C.REGIONID
        GROUP BY REGIONNAME ORDER BY RETURNRATE DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q3] Which customers are making frequent returns?
-- Ans:
		SELECT CUSTOMERID, CUSTOMERNAME, COUNT(ORDERID) AS RETURN_COUNT
		FROM CUSTOMER_RETURN
        GROUP BY CUSTOMERID, CUSTOMERNAME
        ORDER BY RETURN_COUNT DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------