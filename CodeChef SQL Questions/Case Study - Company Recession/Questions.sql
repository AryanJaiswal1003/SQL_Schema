/*Given this dataset, you need to analyze and find the company name.
	Additionally, you are required to categorize the companies as "High Risk" when their Growth_Percent is negative and as "Low Risk" 
		when their Growth_Percent is positive, assigning the respective category under the column named Risk_Category.*/
-- Ans:
select company_name,
    Case 
		when growth_percent < 0 then 'High Risk' else 'Low Risk' 
		end as Risk_category
from company_information;

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Identify "Sector" where at least one company showed positive growth.
		Please determine the number of companies in that category and record it under the column named "Recession_Free_Companies".*/
-- Ans:
select sector_id,
    count(case when growth_percent >= 0 then 1 end) as Recession_Free_Companies
from company_information
group by sector_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Identify the names of the companies and sectors whose Q4 result earnings are lower than the average of their earnings across 
	all quarters and also determine the average of each company.*/
-- Ans:
select 
    company_name, sector, 
    (Q1_Result + Q2_Result + Q3_Result + Q4_Result) / 4  as average
from company_information
where Q4_Result < average;

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Identify the sector and determine the highest estimated growth value within each sector.
		Afterwards, present the results sorted in descending order based on the sectors with the highest estimated growth.*/
-- Ans:
select sector_id,
    max(estimated_growth) as highest_estimated_growth
from company_information
group by sector_id
order by highest_estimated_growth desc;

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Identify the sector name and calculate the total growth for each sector, sorting the results in descending order based on 
		the total growth of each sector.*/
-- Ans:
select 
	sector_name, 
    sum(growth_percent) as Total_growth
from company_information ci 
join company_sector cs on ci.sector_id = cs.sector_id
group by sector_name
order by Total_growth desc;

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Retrieve the sector names and their corresponding performance grades where the effect of crude oil prices is deemed 
		to be "NO," indicating that these sectors are not impacted by the increase in crude oil prices.*/
-- Ans:
select sector_name, performance_grade
from company_sector cs
join company_performance cp on cs.performance_id = cp.performance_id
where effect_of_crudeprice = 'NO';

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Identify the company names and their corresponding sector where the inflation rate in the country is lower than the average 
		inflation rate across all countries, and at the same time, the growth percent of these companies is positive.
These companies have demonstrated outstanding results regardless of their country's economic situation.*/
-- Ans:
with avg_inflation_rate as (
    select avg(inflation) as avg_inflation
    from company_headquarter
)
select company_name, sector_id
from company_information ci 
join company_headquarter ch on ci.company_hq_id = ch.nation_id
cross join avg_inflation_rate
where inflation < avg_inflation and growth_percent >= 0;

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Identify the sector with the highest overall estimated growth, considering only companies headquartered in countries where 
	the inflation rate is less than 3.*/
-- Ans:
select 
	sector_name, 
	sum(estimated_growth) as Highest_Estimated_Growth
from company_sector cs 
join company_information ci on cs.sector_id = ci.sector_id
join company_headquarter ch on ci.company_hq_id = ch.nation_id
where inflation < 3
group by sector_name;

-- ------------------------------------------------------------------------------------------------------------------------------------------
--  Identify the names of the companies that have shown 'Poor' performance.
-- Ans:
select company_name 
from company_information ci 
join company_sector cs on cs.sector_id = ci.sector_id
join company_performance cp on cp.performance_id = cs.performance_id
where performance_grade = 'Poor';

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Identify those companies' names, growth_percent and sector name in the IT sector whose estimated growth is higher than 
	the average estimated growth of the companies in the sector.*/
-- Ans:
WITH avg_growth_rate AS (
    SELECT AVG(estimated_growth) AS avg_growth
    FROM company_information 
    WHERE sector_id = 1
)
SELECT company_name, growth_percent, sector_name
FROM company_information ci
JOIN company_sector cs ON ci.sector_id = cs.sector_id
cross join avg_growth_rate
WHERE sector_name = 'IT' AND estimated_growth > avg_growth;

-- ------------------------------------------------------------------------------------------------------------------------------------------
/* Task:
1. You need to determine which sectors have a higher concentration of companies headquartered in countries with inflation greater 
		than 3, compared to countries with inflation less than or equal to 3.
2. If a sector has more companies with inflation greater than 3 than companies with inflation less than or equal to 3, mark that 
		sector as 'Greater inflation.'
3. Otherwise, mark it as 'Lesser inflation'. Record it under the column named "Inflation_Comparison".
4. Additionally, you should sort the Sector_Name in increasing order to show how each sector is affected by inflation.*/
-- Ans:
WITH InflationCounts AS (
   SELECT cs.Sector_Name,
          SUM(CASE WHEN ch.Inflation > 3 THEN 1 ELSE 0 END) AS high_inflation_count,
          SUM(CASE WHEN ch.Inflation <= 3 THEN 1 ELSE 0 END) AS low_inflation_count
   FROM Company_Information ci
   JOIN Company_Sector cs ON ci.Sector_id = cs.Sector_id
   JOIN Company_HeadQuarter ch ON ci.Company_HQ_Id = ch.Nation_id
   GROUP BY cs.Sector_Name
)
SELECT Sector_Name,
       CASE 
           WHEN high_inflation_count > low_inflation_count THEN 'Greater inflation'
           ELSE 'Lesser inflation'
       END AS Inflation_Comparison
FROM InflationCounts
ORDER BY Sector_Name;

-- ------------------------------------------------------------------------------------------------------------------------------------------
/*Task:
1. You are interested in identifying the companies within the 'Defence' and 'IT' sectors that have achieved an Estimated Growth above 5.
2. Additionally, you would like to understand how this growth correlates with their performance grade and the impact of COVID-19 and 
		crude oil prices.
3. Furthermore, sorting the results in ascending order of sector name and then in descending order based on estimated growth*/
-- Ans:
select
    company_name, sector_name, growth_percent,
    performance_grade, effect_of_covid, effect_of_crudeprice
from company_information ci
join company_sector cs on ci.sector_id = cs.sector_id
join company_performance cp on cp.performance_id = cs.performance_id
where sector_name in ('Defence', 'IT') and estimated_growth > 5
order by sector_name asc, estimated_growth desc;
-- ------------------------------------------------------------------------------------------------------------------------------------------