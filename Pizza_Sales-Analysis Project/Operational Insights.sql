-- CHAPTER-4: OPERATIONAL INSIGHTS
use pizza_store;

-- TASK-1: CALCULATE THE PERCENTAGE CONTRIBUTIONS OF EACH PIZZA TYPE TO TOTAL REVENUE
select 
	pt.name Pizza_name,
	round(sum(od.quantity * p.price), 2) as Revenue,
	round(
		sum(od.quantity * p.price) * 100 / sum(sum(od.quantity * p.price))	over()
, 2) as Percentage
from order_details od
join pizzas p on p.pizza_id = od.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by p.pizza_id, pt.name
order by revenue desc;

-- TASK-2: ANALYZE THE CUMULATIVE REVENUE GENERATED OVER TIME
with Monthly_Revenue as (
	select 
		date_format(o.date, '%Y-%m') as YearMonth,
		round(sum(od.quantity * p.price), 2) as Rev_per_order
    from order_details od
    join pizzas p on od.pizza_id = p.pizza_id
    join orders o on o.order_id = od.order_id
    group by YearMonth
)
select YearMonth, Rev_per_order,
	round(
		sum(rev_per_order) over (order by yearmonth rows between unbounded preceding and current row)
	, 2) as Cumulative_Rev
from Monthly_Revenue
order by YearMonth;

-- TASK-3: DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON REVENUE FOR EACH PIZZA CATEGORY
with Revenue as (
	select 
		p.pizza_type_id
		, round(sum(od.quantity * p.price), 2) as Revenue_per_Pizza
    from order_details od
    join pizzas p on p.pizza_id = od.pizza_id
    group by p.pizza_type_id
)
, CategoryRevenue as (
	select 
		pt.pizza_type_id,
        pt.category,
		r.Revenue_per_Pizza 
    from revenue r
    join pizza_types pt on pt.pizza_type_id = r.pizza_type_id
)
, RankedCategory as (
	select *,
		rank() over (
			PARTITION BY category 
			ORDER BY revenue_per_pizza desc
		) as Ranked
    from CategoryRevenue
)
select * from RankedCategory 
where Ranked <= 3
order by category, ranked;