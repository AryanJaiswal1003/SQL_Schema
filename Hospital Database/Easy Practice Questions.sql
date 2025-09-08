# Show first name, last name, and gender of patients whose gender is 'M'?
-- Ans:
SELECT first_name, last_name, gender FROM patients
where gender = 'M';

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show first name and last name of patients who does not have allergies. (null)?
-- Ans:
SELECT first_name, last_name FROM patients
where allergies is null;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show first name of patients that start with the letter 'C'?
-- Ans:
SELECT first_name FROM patients
where first_name like "C%";

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)?
-- Ans:
SELECT first_name, last_name FROM patients
where weight between 100 and 120;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'?
-- Ans:
update patients set allergies = 'NKA'
where allergies is null;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show first name and last name concatinated into one column to show their full name?
-- Ans:
select concat(first_name," ", last_name) as full_name
from patients;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show first name, last name, and the full province name of each patient?
-- Ans:
select first_name, last_name, province_name from patients p
join province_names pn on p.province_id = pn.province_id;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show how many patients have a birth_date with 2010 as the birth year?
-- Ans:
select count(patient_id) as total_patients from patients
where year(birth_date) = 2010;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show the first_name, last_name, and height of the patient with the greatest height?
-- Ans:
select first_name, last_name, max(height) from patients;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000?
-- Ans:
select * from patients
where patient_id in (1, 45, 534, 879, 1000);

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show the total number of admissions?
-- Ans:
select count(patient_id) as total_admission from admissions;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show all the columns from admissions where the patient was admitted and discharged on the same day?
-- Ans:
select * from admissions
where date(discharge_date) = date(admission_date);

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Show the patient id and the total number of admissions for patient_id 579?
-- Ans:
select patient_id,
	   count(patient_id) as total_admissions
from admissions
where patient_id = 579;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
-- Ans:
select distinct city as unique_cities from patients
where province_id like "NS";

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70?
-- Ans:
select first_name, last_name, birth_date
from patients where height > 160 and weight > 70;

-- ---------------------------------------------------------------------------------------------------------------------------------------
# Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'?
-- Ans:
select first_name, last_name, allergies
from patients where allergies is not null and city like 'Hamilton';
-- ---------------------------------------------------------------------------------------------------------------------------------------