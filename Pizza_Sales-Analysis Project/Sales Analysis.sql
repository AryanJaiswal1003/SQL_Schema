-- Chapter-3: Sales Analysis - Crunching the Numbers
use pizza_store;

-- TASK-1: LIST TOP 5 MOST ORDERED PIZZA TYPES ALONG WITH THEIR QUANTITIES
select 
	p.pizza_type_id as Pizza_Type, 
	pt.name as Pizza_Name,
	sum(o.quantity) as Quantities
from order_details o
join pizzas p on o.pizza_id = p.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by p.pizza_type_id, pt.name
order by quantities desc limit 5;

-- TASK-2: DETERMINE THE DISTRIBUTION OF ORDERS BY HOUR OF THE DAY
select 
	hour(time) as Hours,
	count(order_id) as Number_of_Order, 
	round( 
		count(order_id) * 100 / SUM(count(order_id)) over()
	, 2) as Percentage
from orders group by Hour(time)
order by Number_of_Order desc;

-- TASK-3: DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON REVENUE
select 
	pt.pizza_type_id, 
	pt.name, 
	sum(o.quantity * p.price) as Revenue
from order_details o
join pizzas p on o.pizza_id = p.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by pt.pizza_type_id, pt.name
order by Revenue desc limit 3;