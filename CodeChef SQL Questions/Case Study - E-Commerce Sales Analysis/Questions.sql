-- Retrieve the top 3 customers who have made the highest total purchases?
-- Ans:
select 
    c.customer_id, name, 
    sum(total_amount) as Total_purchases
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, name
order by Total_purchases desc
limit 3;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve the customers who have never placed an order with a total amount exceeding $1000?
-- Ans:
SELECT c.customer_id, c.name
FROM Customers AS c
LEFT JOIN Orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(CASE WHEN o.total_amount > 1000 THEN 1 END) = 0;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve the customers who have placed orders from 2023/05/08 to 2023/05/13?
-- Ans:
select distinct c.customer_id, name 
from customers c
join orders o on o.customer_id = c.customer_id
where order_date between '2023-05-08' and '2023-05-13';

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve the products that have been ordered by more than two customers?
-- Ans:
with customer_count as (
    select p.product_id, p.name, count(distinct o.customer_id) as cus_count
    from products p
    join order_items oi on oi.product_id = p.product_id
    join orders o on o.order_id = oi.order_id
    group by p.product_id, p.name
    having cus_count > 2
)
select product_id, name from customer_count;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve the customers who have placed orders for products from more than two categories?
-- Ans:
select c.customer_id, c.name
from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
group by c.customer_id, c.name
having count(distinct category) > 2;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve the customers who have never placed orders?
-- Ans:
select customer_id, name
from customers
where customer_id not in (
    select customer_id from orders
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve the top 5 customers who have made the highest average order amount?
-- Ans:
select 
    c.customer_id, name,
    avg(total_amount) as average_order_amount
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.name
order by average_order_amount desc
limit 5;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Retrieve the top 4 best-selling products based on the total quantity ordered. Include the product name, category, and the total quantity ordered 
		for each product. Sort the results in descending order of the total quantity?*/
-- Ans:
SELECT p.name, p.category, SUM(oi.quantity) AS total_quantity_ordered
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name, p.category
ORDER BY total_quantity_ordered DESC
LIMIT 4;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Retrieve the top 5 ranks who have made the highest total purchases in each category. The result should include the customer name, category, and the total 
		amount spent by each customer in each category. Additionally, calculate the average purchase amount for each category and include it in the result as well. 
				Sort the results by the total amount spent in descending order?*/
-- Ans:
with category_avg as (
	select category, avg(item_price) as avg_amount
    from order_items oi
    join products p on oi.product_id = p.product_id
    group by category
), 
ranked_products as (
	select c.name, category,
		sum(item_price) as total_amount,
        rank() over (partition by category order by sum(item_price) desc) as ranked
	from customers c
    join orders o on o.customer_id = c.customer_id
    join order_items oi on oi.order_id = o.order_id
    join products p on p.product_id = oi.product_id
    group by c.name, category
)
select name, rp.category, total_amount, avg_amount
from ranked_products rp
join category_avg ca on ca.category = rp.category
where ranked <= 5
order by total_amount desc;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Retrieve customer names and categorize their total spending into "High Spenders" (>2500), "Moderate Spenders" ($1500−$2500), or "Low Spenders" 
		(<$1500).*/
-- Ans:
SELECT c.name AS customer_name,
    CASE
        WHEN SUM(o.total_amount) > 2500 THEN 'High Spenders'
        WHEN SUM(o.total_amount) BETWEEN 1500 AND 2500 THEN 'Moderate Spenders'
        ELSE 'Low Spenders'
    END AS spender_category
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.name;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Retrieve the customers who have placed orders for products from “Electronics” category, but have not placed any orders for products from 
		“Clothing” and “Footwear” category. The result should include the customer name for which the conditions are met.*/
-- Ans:
with customer_category as (
    select customer_id, category
    from orders o
    join order_items oi on o.order_id = oi.order_id
    join products p on p.product_id = oi.product_id
    where category in ('Clothing', 'Footwear')
)
select c.customer_id, c.name, email, address, phone_number
from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
where category = 'Electronics' 
and c.customer_id not in (
        select customer_id from customer_category
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Retrieve the top 3 customers by highest average purchase amount for each product category. Only include customers who bought at least 3 distinct products 
		in that category. Return category, customer name and avgerage product amount*/
-- Ans:
with ranked_category as (
    select c.name, category,
        avg(item_price) as average_purchase_amount,
        rank() over (partition by category order by avg(item_price) desc) as ranked
    from customers c 
    join orders o on o.customer_id = c.customer_id
    join order_items oi on oi.order_id = o.order_id
    join products p on p.product_id = oi.product_id
    group by c.name, category
    having count(distinct oi.product_id) >= 3
)
select name, category, average_purchase_amount
from ranked_category
where ranked <= 3
order by average_purchase_amount desc;