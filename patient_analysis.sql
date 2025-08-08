-- View all records from the table
SELECT * 
FROM patients_record;

-- View table structure
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'patients_record';

-- Change column types to DATE
ALTER TABLE patients_record
ALTER COLUMN Date_of_Admission DATE;

ALTER TABLE patients_record
ALTER COLUMN Discharge_Date DATE;


------------------------------------------------------
-- 1. Which medical condition has the highest average billing amount
------------------------------------------------------
select 
    Medical_Condition,
    round(avg(Billing_Amount), 2) as Avg_Billing_Amount
from patients_record
group by Medical_Condition
order by Avg_Billing_Amount desc;

------------------------------------------------------
-- 2. How many unique doctors treated more than one patient
------------------------------------------------------
select count(*) as Unique_Doctors
from (
    select Doctor
    from patients_record
    group by Doctor
    having count(*) > 1
) t;

------------------------------------------------------
-- 3. Number of patients treated by each insurance provider
------------------------------------------------------
select 
    Insurance_Provider,
    count(*) as Patient_Count
from patients_record
group by Insurance_Provider
order by Patient_Count desc;

------------------------------------------------------
-- 4. Average stay duration (in days) by admission type
------------------------------------------------------
select 
    Admission_Type,
    avg(datediff(day, Date_of_Admission, Discharge_Date)) as Avg_Stay_Duration
from patients_record
group by Admission_Type;

------------------------------------------------------
-- 5. Doctor who handled the most "Urgent" admissions
------------------------------------------------------
select top 1
    Doctor,
    count(*) as Urgent_Count
from patients_record
where Admission_Type = 'Urgent'
group by Doctor
order by Urgent_Count desc;

------------------------------------------------------
-- 6. Percentage of patients prescribed "Lipitor"
------------------------------------------------------
select 
    round(sum(case when Medication = 'Lipitor' then 1 else 0 end) * 100.0 / count(*), 2) as Lipitor_Percentage
from patients_record;

------------------------------------------------------
-- 7. Blood type with the highest average billing amount
------------------------------------------------------
select 
    Blood_Type,
    round(avg(Billing_Amount), 2) as Avg_Billing
from patients_record
group by Blood_Type
order by Avg_Billing desc;

------------------------------------------------------
-- 8. Number of female patients diagnosed with diabetes
------------------------------------------------------
select 
    count(*) as Female_Diabetes_Count
from patients_record 
where Gender = 'Female' and Medical_Condition = 'Diabetes';

------------------------------------------------------
-- 9. Insurance provider covering the most arthritis patients
------------------------------------------------------
select top 1
    Insurance_Provider,
    count(*) as Arthritis_Patient_Count
from patients_record 
where Medical_Condition = 'Arthritis'
group by Insurance_Provider
order by Arthritis_Patient_Count desc;

------------------------------------------------------
-- 10. Hospital names and patient admission counts
------------------------------------------------------
select 
    Hospital,
    count(*) as Patients_Admitted
from patients_record 
group by Hospital
order by Patients_Admitted desc;

------------------------------------------------------
-- 11. Hospital with the highest total billing in 2022
------------------------------------------------------
select top 1
    Hospital,
    floor(sum(Billing_Amount)) as Total_Amount
from patients_record
where year(Date_of_Admission) = 2022
group by Hospital
order by Total_Amount desc;

------------------------------------------------------
-- 12. Compare avg billing for Asthma vs Arthritis
------------------------------------------------------
select
    floor(avg(case when Medical_Condition = 'Asthma' then Billing_Amount end)) as Asthma_Avg,
    floor(avg(case when Medical_Condition = 'Arthritis' then Billing_Amount end)) as Arthritis_Avg
from patients_record;

------------------------------------------------------
-- 13. Doctor with the lowest average billing per patient
------------------------------------------------------
select top 1
    Doctor,
    floor(avg(Billing_Amount)) as Avg_Billing_Per_Patient
from patients_record
group by Doctor
order by Avg_Billing_Per_Patient asc;

------------------------------------------------------
-- 14. Medication with the highest proportion of abnormal results
------------------------------------------------------
select top 1
    Medication,
    count(*) as Abnormal_Count
from patients_record
where Test_Results = 'Abnormal'
group by Medication
order by Abnormal_Count desc;

------------------------------------------------------
-- 15. Month with the highest number of admissions
------------------------------------------------------
select top 1
    datename(month, Date_of_Admission) as Month_Name,
    count(*) as Admissions
from patients_record
group by datename(month, Date_of_Admission)
order by Admissions desc;

------------------------------------------------------
-- 16. Average length of stay by hospital
------------------------------------------------------
select 
    Hospital,
    avg(datediff(day, Date_of_Admission, Discharge_Date)) as Avg_Stay_Length
from patients_record
group by Hospital
order by Avg_Stay_Length desc;

------------------------------------------------------
-- 17. Room numbers with more than one medical condition
------------------------------------------------------
select Room_Number, count(*) as Different_Conditions
from (
    select distinct Room_Number, Medical_Condition
    from patients_record
) t
group by Room_Number
having count(*) > 1;

------------------------------------------------------
-- 18. Insurance provider covering the oldest patient
------------------------------------------------------
select top 1
    Insurance_Provider,
    Age
from patients_record
order by Age desc;

------------------------------------------------------
-- 19. Compare AB+ avg stay vs others
------------------------------------------------------
select 
    Blood_Type,
    avg(datediff(day, Date_of_Admission, Discharge_Date)) as Avg_Stay
from patients_record
group by Blood_Type
order by Avg_Stay desc;

------------------------------------------------------
-- 20. Admission type with most abnormal results
------------------------------------------------------
select top 1
    Admission_Type,
    count(*) as Abnormal_Count
from patients_record
where Test_Results = 'Abnormal'
group by Admission_Type
order by Abnormal_Count desc;

------------------------------------------------------
-- 21. Doctor performance metric (avg billing per day stayed) & rank
------------------------------------------------------
with cte as (
    select 
        Doctor,
        round(avg(Billing_Amount / nullif(datediff(day, Date_of_Admission, Discharge_Date), 0)), 2) as Avg_Billing_Per_Day
    from patients_record
    group by Doctor
)
select 
    Doctor,
    Avg_Billing_Per_Day,
    dense_rank() over(order by Avg_Billing_Per_Day desc) as Rank_Position
from cte;

------------------------------------------------------
-- 22. Top 3 hospitals with highest abnormal rate
------------------------------------------------------
select top 3
    Hospital,
    round(sum(case when Test_Results = 'Abnormal' then 1 else 0 end) * 100.0 / count(*), 2) as Abnormal_Rate
from patients_record
group by Hospital
order by Abnormal_Rate desc;

------------------------------------------------------
-- 23. Gender–Medication distribution
------------------------------------------------------
select 
    Gender,
    Medication,
    count(*) as Patient_Count
from patients_record
group by Gender, Medication
order by Gender, Patient_Count desc;

------------------------------------------------------
-- 24. Most cost-effective medication
------------------------------------------------------
select top 1
    Medication,
    floor(avg(Billing_Amount)) as Avg_Billing
from patients_record
group by Medication
order by Avg_Billing asc;

------------------------------------------------------
-- 25. Insurance provider with highest emergency admission ratio
------------------------------------------------------
select top 1
    Insurance_Provider,
    round(sum(case when Admission_Type = 'Emergency' then 1 else 0 end) * 100.0 / count(*), 2) as Emergency_Percentage
from patients_record
group by Insurance_Provider
order by Emergency_Percentage desc;

------------------------------------------------------
-- 26. Billing tiers + abnormal result percentage
------------------------------------------------------
with tiers as (
    select 
        Name,
        Billing_Amount,
        Test_Results,
        case 
            when Billing_Amount > 35000 then 'High'
            when Billing_Amount between 20000 and 35000 then 'Mid'
            when Billing_Amount < 20000 then 'Low'
        end as Tier
    from patients_record
)
select 
    Tier,
    count(*) as Total_Patients,
    count(case when Test_Results = 'Abnormal' then 1 end) as Abnormal_Count,
    round(count(case when Test_Results = 'Abnormal' then 1 end) * 100.0 / count(*), 1) as Abnormal_Percentage
from tiers
group by Tier
order by Abnormal_Count desc;

------------------------------------------------------
-- 27. Doctors with only normal results
------------------------------------------------------
select distinct Doctor
from patients_record p1
where not exists (
    select 1 
    from patients_record p2
    where p2.Doctor = p1.Doctor 
      and p2.Test_Results in ('Abnormal', 'Inconclusive')
);

------------------------------------------------------
-- 28. Monthly avg billing trend
------------------------------------------------------
select
    format(Discharge_Date, 'yyyy-MM') as Month_Year,
    round(avg(Billing_Amount), 2) as Avg_Billing
from patients_record
group by format(Discharge_Date, 'yyyy-MM')
order by Month_Year;

------------------------------------------------------
-- 29. Most common diagnosis–medication mismatch
------------------------------------------------------
select top 1
    Medical_Condition,
    Medication,
    count(*) as Mismatch_Count
from patients_record
group by Medical_Condition, Medication
having (Medical_Condition = 'Asthma' and Medication = 'Aspirin') 
   or (Medical_Condition = 'Arthritis' and Medication not in ('Aspirin', 'Paracetamol'))
order by Mismatch_Count desc;

------------------------------------------------------
-- 30. BONUS – Age group analysis by admission type
------------------------------------------------------
select
    Admission_Type,
    case 
        when Age < 30 then 'Under 30'
        when Age between 30 and 50 then '30-50'
        else '50+'
    end as Age_Group,
    count(*) as Patient_Count
from patients_record
group by Admission_Type, 
         case 
            when Age < 30 then 'Under 30'
            when Age between 30 and 50 then '30-50'
            else '50+'
         end
order by Admission_Type, Age_Group;
