# 🏥 SQL Hospital Analysis

## 📌 Overview
This project contains **30 SQL queries** designed to analyze hospital patient records.  
The dataset contains patient demographics, medical conditions, hospital details, billing data, and treatment outcomes.

The goal is to derive insights into:
- Patient demographics & medical trends
- Hospital and doctor performance
- Billing patterns and cost efficiency
- Admission and discharge trends
- Medication and test result relationships

---

## 🗂 Dataset Structure
| Column Name         | Description |
|---------------------|-------------|
| `Name`              | Patient's full name |
| `Age`               | Age of the patient |
| `Gender`            | Gender of the patient |
| `Blood_Type`        | Patient's blood group |
| `Medical_Condition` | Diagnosis or medical issue |
| `Date_of_Admission` | Date when patient was admitted |
| `Doctor`            | Treating doctor |
| `Hospital`          | Hospital name |
| `Insurance_Provider`| Insurance company covering the patient |
| `Billing_Amount`    | Total bill amount in USD |
| `Room_Number`       | Assigned hospital room |
| `Admission_Type`    | Nature of admission (e.g., Urgent, Emergency, Elective) |
| `Discharge_Date`    | Date when patient was discharged |
| `Medication`        | Medicines prescribed |
| `Test_Results`      | Outcome of medical tests (Normal/Abnormal) |

---

## 📊 Analysis Scope
Below are the **30 queries** included in `hospital_analysis.sql`:

1. Medical condition with the highest average billing.
2. Number of unique doctors who treated more than one patient.
3. Patient count by insurance provider.
4. Average stay duration by admission type.
5. Doctor with the most "Urgent" admissions.
6. Percentage of patients prescribed **Lipitor**.
7. Blood type with the highest average billing.
8. Female patients diagnosed with diabetes.
9. Insurance provider with the most arthritis patients.
10. Patient admission count per hospital.
11. Hospital with the highest total billing in 2022.
12. Compare average billing for asthma vs arthritis.
13. Doctor with the lowest average billing per patient.
14. Medication with the highest proportion of abnormal results.
15. Month with the most admissions.
16. Average length of stay by hospital.
17. Room numbers with more than one medical condition.
18. Insurance provider covering the oldest patient.
19. Compare AB+ average stay vs other blood types.
20. Admission type with the most abnormal results.
21. Doctor performance ranking by average billing per day stayed.
22. Top 3 hospitals with the highest abnormal test rate.
23. Gender–medication distribution.
24. Most cost-effective medication.
25. Insurance provider with the highest emergency admission ratio.
26. Billing tiers and their abnormal result percentages.
27. Doctors with only normal results.
28. Monthly average billing trend.
29. Most common diagnosis–medication mismatch.
30. Age group analysis by admission type.

---

## ⚙️ How to Use
1. Import your hospital dataset into a database table named `patients_record`.
2. Run the queries from `hospital_analysis.sql` in your SQL environment.
3. Adjust filters and conditions to explore further insights.

---

## 🏷 License
This project is licensed under the MIT License.
