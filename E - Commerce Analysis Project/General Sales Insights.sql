		-- ############################################ [PART I]: General Sales Insights ############################################

-- SETTING VARIABLES:
SELECT @TOTAL_REVENUE := SUM(OD.QUANTITY * P.PRICE) FROM ORDERDETAILS OD
JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID;

SELECT @TOTAL_RETURNS := SUM(OD.QUANTITY * P.PRICE) FROM ORDERS O
JOIN ORDERDETAILS OD ON O.ORDERID = OD.ORDERID
JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
WHERE O.ISRETURNED IS TRUE;
-- -------------------------------------------------------------------------------------------------------------------------------------------------

-- Q1] What is the total revenue generated over the entire period?
-- Ans:
		SELECT @TOTAL_REVENUE AS TOTAL_REVENUE;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2] Revenue Excluding Returned Orders?
-- Ans:
		SELECT DISTINCT ROUND(@TOTAL_REVENUE - @TOTAL_RETURNS, 2) AS NET_REVENUE;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q3] Total Revenue per Year / Month?
-- Ans:
		WITH ORDER_DETAILS AS (
				SELECT 
					DISTINCT DATE_FORMAT(ORDERDATE, '%Y-%m') YEARMONTH,
					SUM(OD.QUANTITY * P.PRICE) AS TOTAL_REVENUE
				FROM ORDERS O
				JOIN ORDERDETAILS OD ON OD.ORDERID = O.ORDERID
				JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
				WHERE O.ISRETURNED IS FALSE
				GROUP BY YEARMONTH
        )
		SELECT * FROM ORDER_DETAILS 
        GROUP BY YEARMONTH
        ORDER BY MIN(YEARMONTH);
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q4] Revenue by Product / Category?
-- Ans:
		SELECT
			PRODUCTNAME, P.CATEGORY,
			SUM(OD.QUANTITY * P.PRICE) AS REVENUE_PerCategory
		FROM ORDERDETAILS OD
		JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
		GROUP BY PRODUCTNAME, P.CATEGORY
        ORDER BY PRODUCTNAME, REVENUE_PerCategory DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q5] What is the average order value (AOV) across all orders?
-- Ans:
        SELECT AVG(TOTAL_ORDERVALUE) AS AVG_ORDERVALUE
        FROM (
			SELECT O.ORDERID, SUM(QUANTITY * PRICE) AS TOTAL_ORDERVALUE
            FROM ORDERS O
            JOIN ORDERDETAILS OD ON OD.ORDERID = O.ORDERID
            JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
            GROUP BY O.ORDERID
        ) T;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q6] AOV per Year / Month?
-- Ans:
		WITH ORDER_TOTAL AS (
					SELECT
						O.ORDERID, ORDERDATE,
						SUM(OD.QUANTITY * P.PRICE) AS TOTAL
					FROM ORDERS O
					JOIN ORDERDETAILS OD ON O.ORDERID = OD.ORDERID
					JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
					WHERE ISRETURNED IS FALSE
					GROUP BY O.ORDERID, ORDERDATE
        )
		SELECT
			DATE_FORMAT(ORDERDATE, '%Y-%m') AS YEARMONTH,
            ROUND(AVG(TOTAL), 2) AS AVG_MONTH
        FROM ORDER_TOTAL
        GROUP BY YEARMONTH
        ORDER BY YEARMONTH;
-- -------------------------------------------------------------------------------------------------------------------------------------------------	
-- Q7] What is the average order size by region?
-- Ans:
		WITH ORDER_TOTAL AS (
					SELECT O.ORDERID, O.CUSTOMERID, SUM(OD.QUANTITY) AS TOTAL_ORDERSIZE
					FROM ORDERS O
					JOIN ORDERDETAILS OD ON O.ORDERID = OD.ORDERID
					JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
					WHERE ISRETURNED IS FALSE
					GROUP BY O.CUSTOMERID, O.ORDERID
        ),
        CUSTOMER_DETAILS AS (
					SELECT CUSTOMERID, REGIONNAME
                    FROM CUSTOMERS C
                    JOIN REGIONS R ON R.REGIONID = C.REGIONID
        )
        SELECT CD.REGIONNAME, ROUND(AVG(OT.TOTAL_ORDERSIZE), 2) AS AVG_ORDER_SIZE
        FROM ORDER_TOTAL OT
        JOIN CUSTOMER_DETAILS CD ON OT.CUSTOMERID = CD.CUSTOMERID
        GROUP BY CD.REGIONNAME ORDER BY AVG_ORDER_SIZE DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------------------