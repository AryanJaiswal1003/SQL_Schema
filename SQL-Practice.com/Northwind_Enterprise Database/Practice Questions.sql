-- ------------------------------------------ Easy Difficulty Questions ------------------------------------------
## Show the category_name and description from the categories table sorted by category_name?
-- Ans:
		select category_name, description
		from categories;

-- ------------------------------------------------------------------------------------------------------------------------------
## Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'?
-- Ans:
		select 
			contact_name, address, city
		from customers
		where country not in ('Germany', 'Mexico', 'Spain');

-- ------------------------------------------------------------------------------------------------------------------------------
## Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26?
-- Ans:
		select 
			order_date, shipped_date, 
            customer_id, freight
		from orders
		where order_date like '2018-02-26';

-- ------------------------------------------------------------------------------------------------------------------------------
## Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date?
-- Ans:
		select 
			employee_id, order_id, 
			customer_id, required_date, shipped_date
		from orders
		where shipped_date > required_date;

-- ------------------------------------------------------------------------------------------------------------------------------
## Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name?
-- Ans:
		select city, company_name, contact_name
		from customers
		where city like '%L%'
		order by contact_name;

-- ------------------------------------------------------------------------------------------------------------------------------
## Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)?
-- Ans:
		select company_name, contact_name, fax
		from customers
		where fax is not null;

-- ------------------------------------------------------------------------------------------------------------------------------
## Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table?
-- Ans:
		select
			round(avg(unit_price), 2) as average_price,
			sum(units_in_stock) as total_stock,
			sum(case when discontinued = 1 then 1 else 0 end) as total_discontinued
		from products;

-- ------------------------------------------ Medium Difficulty Questions ------------------------------------------
## Show the category_name and the average product unit price for each category rounded to 2 decimal places?
-- Ans:
		select
			category_name,
			round(avg(unit_price), 2) as average_unit_price
		from categories c
		join products p on p.category_id = c.category_id
		group by category_name;

-- ------------------------------------------------------------------------------------------------------------------------------
/*Show the city, company_name, contact_name from the customers and suppliers table merged together. Create a column which contains 'customers' 
	or 'suppliers' depending on the table it came from?*/
-- Ans:
		select 
			city, company_name, 
            contact_name, 'customers' as relationship
		from customers
        UNION
        select 
			city, company_name, 
            contact_name, 'suppliers'
		from suppliers;

-- ------------------------------------------------------------------------------------------------------------------------------
## Show the total amount of orders for each year/month?
-- Ans:
		select
			year(order_date) as order_year,
			month(order_date) as order_month,
			count(order_id) as no_of_orders
		from orders
		group by order_year, order_month;


-- ------------------------------------------ Hard Difficulty Questions ------------------------------------------
/*Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays 
	"On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late, "Not Shipped" if shipped_date is null.
		Order by employee last_name, then by first_name, and then descending by number of orders?*/
-- Ans:
		select
			e.first_name, e.last_name,
			count(order_id) as num_orders,
			CASE
				when shipped_date <= required_date then 'On Time'
				when shipped_date > required_date then 'Late'
				when shipped_date is NULL then 'Not Shipped' 
			END as shipped
		from employees e
		join orders o on o.employee_id = e.employee_id
		group by e.first_name, e.last_name, shipped
		order by e.last_name, first_name, num_orders desc;

-- ------------------------------------------------------------------------------------------------------------------------------
## Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places?
-- Ans:
		select
			year(o.order_date) as order_year,
			round(sum(od.quantity * p.unit_price * od.discount), 2) as discount_amount
		from order_details od
		join orders o on o.order_id = od.order_id
		join products p on p.product_id = od.product_id
		group by order_year
		order by order_year desc;
-- ------------------------------------------------------------------------------------------------------------------------------