-- CHAPTER-2: DATA EXPLORATION

use pizza_store;

-- TASK-1: RETRIEVE TOTAL NUMBER OF ORDERS PLACED
select COUNT(distinct order_id) as Total_Ordered from order_details;

-- TASK-2: CALCULATE THE TOTAL REVENUE GENERATED FROM PIZZA SALES
select round(sum(o.quantity * p.price), 2) as Total_Revenue
from order_details o
inner join pizzas p on o.pizza_id = p.pizza_id;

-- TASK-3: IDENTIFY THE HIGHEST PRIZED PIZZA
select * from pizzas 
where price = (select max(price) from pizzas);

select p.*, pt.name from pizzas p
left join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
order by p.price desc limit 1;

-- TASK-4: IDENTIFY THE MOST COMMON PIZZA SIZE ORDERED
select 
	p.size, 
	count(*) as Max_ordered, 
	sum(o.quantity) as Quantities
from order_details o
left join pizzas p on o.pizza_id = p.pizza_id
group by p.size
order by max_ordered desc limit 1;