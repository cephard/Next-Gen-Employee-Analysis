# Next-Gen-Employee-Analysis
![SQL](https://img.shields.io/badge/Tool-SQL-blue?logo=postgresql) 
![PostgreSQL](https://img.shields.io/badge/Tool-PostgreSQL-lightblue?logo=postgresql)
![Power BI](https://img.shields.io/badge/Tool-Power%20BI-yellow?logo=powerbi)
![Power BI Service](https://img.shields.io/badge/Platform-Power%20BI%20Service-blue?logo=powerbi)
![Neon](https://img.shields.io/badge/Platform-Neon-purple)
![Last Commit](https://img.shields.io/github/last-commit/cephard/NovaMed-Solutions)

## Project Background
NextGen Corp. is a growing technology company focused on developing innovative solutions in the software
and hardware spaces. The company prides itself on attracting top talent and maintaining high employee
satisfaction to drive growth. However, there are increasing concerns regarding employee turnover,
performance variability, and salary disparities within departments.

To ensure continued success, NextGen Corp. needs to optimize employee retention, track employee
performance consistently, and maintain fair salary structures across departments. The HR department needs a
data-driven approach to:
- dentify trends and patterns in employee retention and turnover.
- Track and evaluate performance across different departments.
- Assess the relationship between salary and performance to ensure fairness and employee satisfaction.
  
Insights and recommendations are provided on the following key areas:
- **Employee Retention Analysis** 
- **Performance Analysis** 
- **Salary Analysis**  

The SQL queries used to inspect and clean the data for this analysis can be found here [link](https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/Next%20Gen%20SQL%20Queries.sql).  
An interactive PowerBI dashboard used to report and explore the analysis can be found here [link](https://app.powerbi.com/view?r=eyJrIjoiOTNkZTE0NDEtMTU2OC00OTQzLWFhYjktMTIzMmU4ODkyM2MxIiwidCI6ImZmMGYzZTNhLTNlNTMtNDU0Zi1iMmI1LTZjNjg3NTNiOGVlNCJ9).

## Data Structure & Initial Checks
The companies main database structure as seen below consists of the following tables:

| **Table Name** | **Description** |
|-------------|------------------|
| **Employees Table:**     | Contains essential employee details like name, job title, hire date, salary, performance score, attendance rate, and department affiliation. |
| **Departments Table:**   | Contains the list of departmentswithin NextGen Corp. (e.g., Engineering, Sales, HR, Marketing). |
| **Performance Table:**   | Tracks monthly performance scores of employees, allowing you to analyze performance trends over time. |
| **Attendance Table:**    | Tracks attendance records for employees, including whether they were present or absent |
| **Turnover Table:**      | Contains data on employees who left the company, including the reason for leaving. |
| **Salaries Table:**      | Provides salary data, including historical salary changes for each employee. |

## Technical Summary
The database schema employs one-to-many relationships between the tables using primary and foreign keys to ensure data integrity and normalization. For instance, the `department_id` is a unique primary key in the `department` table but appears as a foreign key in multiple records within the `performance`, `employee`, `salary`, and `turnover` tables. This design adheres to the principles of Third Normal Form (3NF) by:
- Eliminating data redundancy through separation of entities.
- Preventing transitive dependencies by ensuring that non-key attributes depend only on the primary key.
- Enhancing data quality and source profiling by maintaining consistent references across related tables.
- Supporting scalability and efficient querying by structuring data around well-defined relationships.
This approach facilitates robust data management, simplifies updates, and improves analytical accuracy across employee-related metrics such as attendance, performance, compensation, and turnover.

## Entity Relationship Diagram
<img src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/erd.png" alt="Entity Relationship Diagram" width="100%"/>

## Executive Summary
We learn that out of the total *60* employees, Next Gen has had *28* employees leave over a span of ... years. The dashboard highlights **Sales** as the department with the highest number of employees (*23*) scoring above *3.5* in their performance analysis.  

The company has spent a total of *$4.85M* on payroll, and the highest earning employees are *26* (**in this case, salaries of $80K and above**). The *9* top performers represent the number of times employees achieved a perfect *5/5* score, while the *45* poor performers represent instances of low scores. These numbers might be higher than the actual number of employees who attained a perfect score or scored *3.5* or below.  

The top 5 longest-serving employees represent tenure in the company, regardless of whether they are still active. With this approach, Next Gen can understand employee turnover in a more holistic way. Interestingly, *3* out of the *5* top-serving employees are from **Sales**, which is also the department with the most poor performers.  

Looking at salaries by job title, *4 out of the 5* top roles have an average salary of *$80K+*, suggesting that the majority of employees at Next Gen can be considered high earners. **Marketing Specialists** is the only job title with an average salary of *$77.86K*.  

The **Marketing department** has the highest turnover rate, with data showing that *92.86%* of employees have left. This phenomenon can be investigated further to explore the correlation between remuneration and turnover.  

A correlation analysis between salary and performance shows an interesting trend. On average, employees from high-performing departments Marketing *4.13/5* and Engineering *4.10/5* earned lower salaries compared to employees in HR *4.05/5* and Sales *4.0/5*. Overall, the average salary by department was above *$80K*, indicating that, despite some differences, most employees at Next Gen are considered high earners.

The main turnover reasons reported were **Career Progression, Finding Another Job, Career Growth, and Personal Reasons**. However, this data should be treated with caution, as the broad nature of these reasons might hide nuances that employees were uncomfortable declaring.

## Dashboard
[An interactive live dashboard on can be accessed here](https://app.powerbi.com/view?r=eyJrIjoiOTNkZTE0NDEtMTU2OC00OTQzLWFhYjktMTIzMmU4ODkyM2MxIiwidCI6ImZmMGYzZTNhLTNlNTMtNDU0Zi1iMmI1LTZjNjg3NTNiOGVlNCJ9).

<img src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/Next%20gen%20Dashboard%20.png" alt="Next Gen Dashboard" width="100%"/>

# Insights Deep Dive
## Employee Retention Analysis

### Longest serving employees
<p align="center">
  <img 
    src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/Longest%20Serving%20Employees.png" 
    alt="Longest Serving Employee" 
    width="50%" 
  />
</p>

- David Moore – most loyal employee, over 10 years at Next Gen Corp.
- John Johnson – close to reaching the decade mark.
- 3 of top 5 are from Sales; 1 from HR, 1 from Marketing.
- No engineers on the list → possible burnout or low pay issues.

### Department Turnover rate
<p align="center">
  <img 
    src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/Department%20Turnover%20rate.png" 
    alt="Longest Serving Employee" 
    width="50%" 
  />
</p>

- Marketing shows the highest turnover at 92.86%.
- 66.67% of Engineering employees have left.
- Sales and HR have the lowest turnover (<30%).

### Employees at risk of leaving
<p align="center">
  <img 
    src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/Employees%20At%20risk.png" 
    alt="Longest Serving Employee" 
    width="50%" 
  />
</p>

- Most of the lowest-performing employees are from the Sales and HR departments, with the majority in Sales.
- This suggests that the Sales department’s commission-based structure may be impacting overall performance.
- Some of the HR underperformers appear to hold managerial roles, where limited oversight might influence performance outcomes.

### Main reason for turnover
<p align="center">
  <img 
    src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/Turnover%20reasons.png" 
    alt="Longest Serving Employee" 
    width="50%" 
  />
</p>

- It is 39.29% most likely for turnover to be personal reasons.
- Its also 25% likely for an employee to find another job.
- Both career growth and Retire have a 17.86% contribution to turnover.

## Performance Analysis
### Total employees that left
- 46.67% of employees have left the company, in 2024 (15) and 2025 (13), mostly due to personal reasons, and only 25% leaving for other jobs rather than career growth.

### score of 5.0 / below 3.5?
- In the entire company tenure, its has only happened 9 times that a colleague got a 5/5 performance score, while 45 times employees performed at 3.5/5 and below.
- Out of the 9 times, 6 of these emerged from sales department.

### Department Performance#
<p align="center">
  <img 
    src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/Department%20performance.png" 
    alt="Longest Serving Employee" 
    width="50%" 
  />
  
- All departments have a performance average of above 4.0+.

## Salary Analysis
### Total Salary Expense
- 4.85M Is the total salary Next Gen Has Spent on employee compensation based on 2024-05-03 salary compensations.

### Salary By Job Title
- Majority of the departments have a compensation of 80K and above, only Marketing specialists' compensation is 77.86k.

### Employees Earning More than 80K
- 26 Are high earners Majority being sales representatives.

### Department to salary correlation
- Departments with the highest salaries are showing lower performance.
- Marketing & Engineering: Performance 4.10–4.13, Salary $80k → solid performance with moderate pay.
- HR: Highest Salary $83k, Performance 4.05 → high pay, slightly lower performance.
- Sales: Salary $82.86k, Performance 4.0 → highest pay among low performers.

## Insight Deep Dive
- Sales emerged as the department with most employees getting a perfect average performance score of 5.0. However, this number signposted to the 23 employees getting an average of 3.5 and below is alarming. This shows that the best department is also the poorest in performance.
- It is shocking that sales managers receive 80k while they colleagues under their management, the sales representatives are earning an average of 84.29K.
- This nuance might be a possibility that sales representatives are getting commissions and incentives.
- HR tends to reward the employees from HR favourably than any other department this explains why HR has the lowest turnover rate of all departments.
- Marketing specialists being the only departments with an average salary below 77.86k correlates with the 92.86 turnover rate in this department, furthermore this is the top performing department.

# Recommendations
