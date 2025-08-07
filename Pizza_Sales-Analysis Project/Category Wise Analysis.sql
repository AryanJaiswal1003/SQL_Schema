-- CHAPTER-5: CATEGORY WISE ANALYSIS
use pizza_store;

-- TASK-1: JOIN THE NECESSARY TABLES TO FIND THE TOTAL QUANTITY OF EACH PIZZA CATEGORY ORDERED
select pt.category 
	, sum(od.quantity) as total_quantity 
from order_details od
join pizzas p on p.pizza_id = od.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by pt.category 
order by total_quantity desc;

-- Task-2: JOIN RELEVANT TABLES TO FIND THE CATEGORY WISE DISTRIBUION OF PIZZAS
with PizzaMenu as (
	select 
		pt.name as Pizza_Name
		, pt.category as Pizza_Category
		, sum(od.quantity) as Quantity_Ordered
		, count(od.order_id) as Orders_Made
	from  order_details od
	join pizzas p on p.pizza_id = od.pizza_id
	join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
	group by pt.name, pt.category
)
select * from PizzaMenu
order by Orders_Made desc;

-- TASK-3: GROUP THE ORDERS BY THE DATE & CALCULATE THE AVERAGE NUMBER OF PIZZAS ORDERED PER DAY
select
    avg(daily.Total_ordered) as Average_Per_Day 
from (
	select 
		o.date
		, sum(quantity) as Total_Ordered
	from order_details od
	join orders o on od.order_id = o.order_id
	group by o.date
) daily;