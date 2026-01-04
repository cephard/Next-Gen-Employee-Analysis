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

## Sample SQL Queries
### What is the turnover rate for each department?

```sql
SELECT
	d.department_name,
	CONCAT(ROUND(COUNT(DISTINCT t.employee_id) * 100.0 / COUNT(DISTINCT e.employee_id), 2), '%')
	AS turnover_rate
FROM employee e
LEFT JOIN department d
	ON e.department_id = d.department_id
LEFT JOIN turnover t 
	ON e.employee_id = t.employee_id
GROUP BY d.department_name
ORDER BY turnover_rate DESC;
```
This query calculates the percentage of employees who have left each department by dividing the number of distinct employees recorded in the turnover table by the total number of distinct employees in that department. It uses LEFT JOINs to ensure departments with no recorded turnover are still included, and formats the result as a percentage for easy comparison across departments.

### Which department has the most employees with a performance of 5.0 / below 3.5?

```sql
SELECT department_name, score_5, below_3_5
FROM (
    SELECT 
        e.department_id,
		d.department_name, 
        COUNT(DISTINCT CASE WHEN p.performance_score = 5.0 THEN e.employee_id END) AS score_5,
        COUNT(DISTINCT CASE WHEN p.performance_score < 3.5 THEN e.employee_id END) AS below_3_5
    FROM employee e
    JOIN performance p ON e.employee_id = p.employee_id
	JOIN department d ON d.department_id = e.department_id
    GROUP BY e.department_id,d.department_name
) AS dept_scores
ORDER BY score_5 DESC, below_3_5 ASC
LIMIT 1;
```
This query identifies the department with the strongest and weakest performance extremes by counting how many distinct employees achieved a perfect performance score of 5.0 and how many scored below 3.5. Conditional aggregation is used to calculate both metrics in a single query, allowing comparison of high and low performers within each department. The results are ordered to highlight the department with the most top performers while minimizing the number of low performers.

### How does performance correlate with salary across departments?

```sql
SELECT
    d.department_name,
    ROUND(AVG(emp_perf.avg_score), 2) AS average_performance,
    ROUND(AVG(emp_sal.avg_salary), 2) AS average_salary
FROM department d
LEFT JOIN (
    SELECT employee_id, department_id, AVG(performance_score) AS avg_score
    FROM performance
    GROUP BY employee_id, department_id
) AS emp_perf ON d.department_id = emp_perf.department_id
LEFT JOIN (
    SELECT employee_id, department_id, AVG(salary_amount) AS avg_salary
    FROM salary
    GROUP BY employee_id, department_id
) AS emp_sal ON d.department_id = emp_sal.department_id
GROUP BY d.department_name
ORDER BY average_performance DESC;
```
This query analyzes the relationship between employee performance and compensation by calculating average performance scores and average salaries at the department level. Employee-level averages are first computed using subqueries to avoid duplication, then aggregated by department. LEFT JOINs ensure all departments are included, even if salary or performance records are missing, enabling a fair cross-department comparison of pay versus performance.

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
## Employee Retention Recommendations
- Enhance Onboarding and Engagement Programs: Introduce mentorships and career development initiatives, along with regular employee satisfaction surveys to gather feedback.
- Conduct Exit Interviews: Utilize exit interviews to understand key pain points beyond “personal” such as compensation, management issues, and workload concerns.
- Promote Internal Mobility and Career Advancement: Offer regular training sessions, eLearning opportunities, and job shadowing to prepare current employees for promotions.
- Identify Early Warning Signs: Look for indicators beyond low performance and attendance, such as colleagues' willingness to accept temporary promotions or participate in internal social gatherings, to gauge engagement levels.

## Performance Recommendations
- Performance-Based Recognition Programs: Recognize and reward employees for their hard work with incentives such as in-store discounts, "Department of the Quarter" awards, and "Employee of the Month" acknowledgments.#
- Targeted Training: Implement customized training programs tailored to the specific needs of each department.
- Data-Driven Performance Tracking: Utilize dashboards and reports to visualize performance data, enabling HR teams to easily identify the lowest-performing departments.
- Balanced Workload Across Teams: Encourage regular, realtime work management across teams to ensure that workloads are distributed proportionately among employees.
  
## Salary & Compensation Recommendations
- Standardize Pay Structures: Ensure that base salaries are consistent across similar roles and pay grades.
- Introduce a Pay-forPerformance Model: Reward high performers, such as marketing specialists, with bonuses instead of incorporating these rewards into their monthly base salary.
- Regular Salary Reviews: Conduct annual compensation reviews to align with the median national wage and adjust for the cost of living accordingly.
- Address Pay Disparities Across Departments: Adjust salaries in the marketing department to align with the company-wide base salary of $80,000.
- Encourage Employee Unions: Support the formation of selfgoverned employee unions that can advocate foremployees anonymously, fostering transparency, trust, and long-term engagement.

# Caveats
- The salary dataset only projects for payroll date 2024-05-03 and should be treated with caution.
- Data is majorly dependant on quotative analysis and so the exact personal reasons for turnover have not captured the nuances of the actual turnover reason.
