		/* ############################## WINDOW FUNCTIONS [RANK, RUNNING_TOTAL, LEAD, LAG, DENSE _RANK] ##############################
				1] WINDOW FUNCTIONS		2] RANK FUNCTIONS		3] OVER()				4] PARTITION BY
                5] RUNNING TOTAL		6] LEAD() FUNCTION		7] LAG() FUNCTION		8] WINDOW FRAME	

## WINDOW FUNCTION: It operates on a set of rows related to the current row in a specified order, rather than the entire result set (diff from Aggregate
		functions). With Window Function, we can calculate value for each row keeping whole table in context (Ranking based on basis of order amt).

## 3 TYPES OF RANK FUNCTIONS: -
1] RANK() = Assigns rank, but if there is a tie it skips the next rank. E.g., If 2 People finish 1st, the next person is considered 3rd.
2] DENSE_RANK() = Assigns ranks, but it dosen't slip ranks in case of a tie. E.g., If 2 People finish 1st, the next person is considered 2nd.
3] ROW_NUMBER() = Dosen't care about how fast/slow participants are. It simply numbers them one after the other, starting from the beginning.        

## OVER() FUNCTION = The clause is used in window functions to apply the function over the defined windows in a certain manner. Here we consider that
	the whole table is a window & we are applying function on that window.
    
## PARTITION BY = It is used inside the OVER() to form GROUP of Rows [similar to GROUP function].

## LEAD() FUNCTION = It allows us to access data from the next row within the same window.

## LAG() FUNCTION = It allows us to access data from the previous row within the same window.

## WINDOW FRAMES = These are filters for window functions, letting us specify which rows to consider for calculations.

	-------------------------------------------------------------------------------------------------------------------------
	|				ABBREVIATION					|							COMPLETE SYNTAX								|
	-------------------------------------------------------------------------------------------------------------------------
	|	A] UNBOUNDED PRECEDING =					|	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.					|
	|												|																		|
	|	B] n PRECEDING =							|	ROWS BETWEEN n PRECEDING AND CURRENT ROW.							|
	|												|																		|
	|	C] CURRENT ROW =							|	ROWS BETWEEN CURRENT ROW AND CURRENT ROW.							|
	|												|																		|
	|	D] n FOLLOWING = 							|	ROWS BETWEEN CURRENT ROW AND n FOLLOWING.							|
	|												|																		|
	|	E] UNBOUNDED FOLLOWING = 					|	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING.					|
    |												|																		|
	--------------------------------------------------------------------------------------------------------------------------
*/
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

USE ECOMMERCE;

SELECT ORDER_ID, ORDER_DATE, TOTAL_AMOUNT,
		RANK() OVER (ORDER BY TOTAL_AMOUNT DESC) AS RNK,
        DENSE_RANK() OVER (ORDER BY TOTAL_AMOUNT DESC) AS DENSE_RNK,
        ROW_NUMBER() OVER (ORDER BY TOTAL_AMOUNT DESC) AS ROW_NUM
FROM ORDERS
ORDER BY TOTAL_AMOUNT DESC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
								-- $$$$$$$$$$$$$$$$$$$ [PARTITION BY PRACTICE] $$$$$$$$$$$$$$$$$$$

-- [SCENARION]: Write a query to Rank the orders for each customer separately on the basis of order amount?
-- Ans:
		SELECT CUSTOMER_ID, ORDER_ID, TOTAL_AMOUNT,
			RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY TOTAL_AMOUNT DESC) AS RNK
		FROM ORDERS;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Return rank of orders in each category separetely?
-- Ans: 
		SELECT 
			O.ORDER_ID, ORDER_DATE, TOTAL_AMOUNT, CATEGORY,
            RANK() OVER (PARTITION BY CATEGORY ORDER BY TOTAL_AMOUNT DESC) AS RANKED_CATEGORY       
        FROM ORDERS O
        JOIN ORDER_ITEMS OI ON O.ORDER_ID = OI.ORDER_ID
        JOIN PRODUCTS P ON P.PRODUCT_ID = OI.PRODUCT_ID
        ORDER BY CATEGORY, TOTAL_AMOUNT DESC;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
								-- $$$$$$$$$$$$$$$$$$$ [RUNNING TOTAL] $$$$$$$$$$$$$$$$$$$

-- [SCENARIO]: Identify the salespeople who are constanly making good sales by checking their day by day progress?
-- Ans:
/* ###################### [Create the Salespersons and Sales tables] ######################

USE ECOMMERCE;
CREATE TABLE Salespersons (
    SalespersonID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE sales (
    SaleID INT PRIMARY KEY,
    SalespersonID INT,
    SaleDate DATE,
    Amount DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO Salespersons (SalespersonID, Name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'David');

INSERT INTO sales (SaleID, SalespersonID, SaleDate, Amount)
VALUES
    (1, 1, '2023-01-01', 500.00),
    (2, 2, '2023-01-02', 750.00),
    (3, 3, '2023-01-03', 300.00),
    (4, 1, '2023-01-04', 200.00),
    (5, 4, '2023-01-05', 600.00),
    (6, 2, '2023-01-06', 450.00),
    (7, 4, '2023-01-06', 700.00),
    (8, 3, '2023-01-06', 200.00),
    (9, 2, '2023-01-07', 900.00),
    (10, 1, '2023-01-07', 200.00),
    (11, 1, '2023-08-01', 100.00),
    (12, 1, '2023-08-03', 150.00),
    (13, 1, '2023-08-05', 200.00),
    (14, 1, '2023-08-06', 175.00),
    (15, 2, '2023-08-02', 120.00),
    (16, 2, '2023-08-03', 180.00),
    (17, 2, '2023-08-04', 250.00),
    (18, 3, '2023-08-01', 80.00),
    (19, 3, '2023-08-02', 110.00),
    (21, 1, '2023-08-01', 100.00),
    (22, 1, '2023-08-03', 150.00),
    (23, 1, '2023-08-05', 200.00),
    (24, 1, '2023-08-06', 175.00),
    (25, 2, '2023-08-02', 120.00),
    (26, 2, '2023-08-03', 180.00),
    (27, 2, '2023-08-05', 250.00),
    (28, 3, '2023-08-01', 80.00),
    (29, 3, '2023-08-03', 110.00);*/

SELECT 
		SP.NAME, S.SALEDATE, S.AMOUNT,
		SUM(AMOUNT) OVER (PARTITION BY S.SALESPERSONID ORDER BY SALEDATE) AS RUNNING_TOTAL
FROM SALESPERSONS SP
JOIN SALES S ON S.SALESPERSONID = SP.SALESPERSONID
ORDER BY SALEDATE, SP.NAME, SALE;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Write a query to determine the top selling products based on their total revenue by ranking them?
-- Ans:
		with TOP_SELLING AS (
				SELECT PRODUCT_NAME, (OI.QUANTITY * OI.PRICE) AS REVENUE
				FROM PRODUCTS P
				JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID = P.PRODUCT_ID
				ORDER BY REVENUE DESC
		),
        RANKING AS (
				SELECT *, RANK() OVER (ORDER BY REVENUE DESC) AS RNK
				FROM TOP_SELLING
        )
        SELECT * FROM RANKING
		WHERE RNK < 5;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Write a query to create a ranking of unique purchase orders based on their order dates. Ensure that there are no gaps in the ranking sequence?
-- Ans:
		SELECT 
				ORDER_ID, ORDER_DATE, 
				CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'NAME',
                DENSE_RANK() OVER (ORDER BY ORDER_DATE) AS D_RNK
        FROM ORDERS O
        JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
/* [SCENARIO]: Write a query to display the order history for each customer. Assign unique row number to each order for every customer on the sequence of
		their order dates?*/
-- Ans:
		SELECT
			ORDER_ID,
			CONCAT(FIRST_NAME, ' ', LAST_NAME) 'NAME',
            ORDER_DATE,
			ROW_NUMBER() OVER (PARTITION BY C.CUSTOMER_ID ORDER BY ORDER_DATE) AS ROLL_NUM
        FROM ORDERS O
        JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
/* [SCENARIO]: Generate a report that ranks customers based on the number of orders they have placed, segmented by each year. The  report should include 
	customer's first_name, last_name, the year of the orders, total number of orders they placed that year & their rank in order of frequency for that year?*/
-- Ans:
		WITH ORDER_DETAILS AS (
					SELECT
						CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,
						YEAR(ORDER_DATE) AS YEAR,
						COUNT(ORDER_ID) AS NUM_OF_ORDERS
					FROM CUSTOMERS C
					JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID
					GROUP BY NAME, YEAR
		)
        SELECT *,
			DENSE_RANK() OVER (PARTITION BY YEAR ORDER BY NUM_OF_ORDERS DESC) AS FREQUENCY
		FROM ORDER_DETAILS;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
										-- $$$$$$$$$$$$$$$$$$$ [LEAD & LAG FUNCTIONS] $$$$$$$$$$$$$$$$$$$

-- PRACTICE SAMPLE: -
	SELECT ORDER_ID, CUSTOMER_ID, ORDER_DATE,
		LEAD(ORDER_DATE) OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS LEAD_FUNCTION,
        LAG(ORDER_DATE) OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS LAG_FUNCTION
	FROM ORDERS;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
										-- $$$$$$$$$$$$$$$$$$$ [WINDOW FUNCTION] $$$$$$$$$$$$$$$$$$$

-- [SCENARIO]: Calculate the rolling sum of sales_amount for the current row & the two rows preceding it based on the product_id ordering?
-- Ans:
		SELECT PRODUCT_ID, PRICE,
			SUM(PRICE) OVER (ORDER BY PRODUCT_ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ROLLING_PRICE
		FROM ORDER_ITEMS;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- [SCENARIO]: Calculate the avg_sales amount for the current row and the two rows following it based on the product_id ordering it?
-- Ans:
		SELECT PRODUCT_ID, PRICE,
			ROUND(AVG(PRICE) OVER (ORDER BY PRODUCT_ID ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING), 2) AS ROLLING_AVG
        FROM ORDER_ITEMS;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------