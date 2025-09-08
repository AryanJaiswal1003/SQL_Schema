/*Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group.
	Order the list by the weight group decending.

For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.*/
-- Ans:
select
	count(patient_id) as patients_in_group,
    floor(weight / 10) * 10 as weight_group
from patients
group by weight_group
order by weight_group desc;

-- ---------------------------------------------------------------------------------------------------------------------------------------
/*Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m)2) >= 30.
	weight is in units kg. height is in units cm.*/
-- Ans:
select 
	patient_id, weight, height,
	(case when (weight / power(height / 100.0, 2)) >= 30 then 1 else 0 end) as isObese
from patients;

-- ---------------------------------------------------------------------------------------------------------------------------------------
/*Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's 
	first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.*/
-- Ans:
select 
	p.patient_id, p.first_name, 
    p.last_name, d.specialty
from patients p
join admissions a on a.patient_id = p.patient_id
join doctors d on d.doctor_id = a.attending_doctor_id
where a.diagnosis like 'Epilepsy' and d.first_name like 'lisa';

-- ---------------------------------------------------------------------------------------------------------------------------------------
/*All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password 
	after their first admission. Show the patient_id and temp_password.
-- The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date*/
-- Ans:
select distinct p.patient_id,
	concat(p.patient_id, length(last_name), year(birth_date)) as temp_password
from patients p
join admissions a on p.patient_id = a.patient_id;

-- ---------------------------------------------------------------------------------------------------------------------------------------
/*Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
	Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.*/
-- Ans:
select 
	(case when patient_id % 2 = 0 then "Yes" else "No" end) as has_insurance,
    sum(case when patient_id % 2 = 0 then 10 else 50 end) as cost_after_insurance
from admissions
group by has_insurance;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name?
-- Ans:
with cat_male as (
	select province_id, 
  		count(case when gender = 'M' then 1 end) as gender_male
  	from patients
  	group by province_id
),
cat_female as (
	select province_id, 
  		count(case when gender = 'F' then 1 end) as gender_female
  	from patients
  	group by province_id
)
select province_name from province_names p
join cat_male cm on cm.province_id = p.province_id
join cat_female cf on cf.province_id = p.province_id
where cm.gender_male > cf.gender_female;

-- ---------------------------------------------------------------------------------------------------------------------------------------
/*We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'*/
-- Ans:
select * from patients
where 
	first_name like '__r%' 
    and gender = 'F' 
    and month(birth_date) in (02, 05, 12) 
    and weight between 60 and 80 
    and patient_id % 2 = 1 
    and city = 'Kingston';
    
-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form?
-- Ans:
select concat(round(
	Avg(gender = 'M') * 100, 2), '%'
) as percent_of_male_patients
from patients;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# For each day display the total amount of admissions on that day. Display the amount changed from the previous date?
-- Ans:
with daily_totals as (
	select 
		admission_date, 
		count(patient_id) as total_admissions
  	from admissions
  	group by admission_date
)
select
	admission_date, total_admissions,
	total_admissions - lag(total_admissions) over (order by admission_date) as admission_count
from daily_totals;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Sort the province names in ascending order in such a way that the province 'Ontario' is always on top?
-- Ans
select province_name from province_names
Order by
	(case when province_name = 'Ontario' then 0 else 1 end),
    province_name asc;

-- ---------------------------------------------------------------------------------------------------------------------------------------
/*We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, 
	specialty, year, total_admissions for that year.*/
-- Ans:
select
	d.doctor_id,
    concat(first_name, ' ', last_name) as doctor_name,
    specialty,
    year(admission_date) as selected_year,
    count(patient_id) as total_admissions
from admissions a
left join doctors d on a.attending_doctor_id = d.doctor_id
group by d.doctor_id, doctor_name, specialty, selected_year;
-- ---------------------------------------------------------------------------------------------------------------------------------------