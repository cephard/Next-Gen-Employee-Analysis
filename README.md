# Next-Gen-Employee-Analysis
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
- **Employees Table:** Contains essential employee details like name, job title, hire date, salary, performance score, attendance rate, and department affiliation.
- **Departments Table:** Contains the list of departmentswithin NextGen Corp. (e.g., Engineering, Sales, HR, Marketing).
- **Performance Table:** Tracks monthly performance scores of employees, allowing you to analyze performance trends over time.
- **Attendance Table:** Tracks attendance records for employees, including whether they were present or absent
- **Turnover Table:** Contains data on employees who left the company, including the reason for leaving.
- **Salaries Table:** Provides salary data, including historical salary changes for each employee.

## Key Terms Used in the Project
- **Employee Retention:** The ability of a company to retain its employees over a long period. This is critical for long-term success and reducing turnover costs.
- **Employee Turnover:** The rate at which employees leave the company. High turnover can be a sign of employee dissatisfaction or organizational issues.
- **Performance Score:** A numerical score reflecting an employee’s performance. It is typically evaluated through regular performance reviews and could range from 1 to 5, with 5 being excellent.
- **Salary:** The compensation an employee receives for their work. This includes base pay and may vary based on factors such as performance, role, or tenure.
- **Attendance Rate: The percentage of days an employee is present at work compared to the total number of working days. It can indicate engagement or potential attendance issues.
- **Turnover Rate:** A metric that measures the percentage of employees who leave the company during a specific period. It can be calculated by dividing the number of employees who left by the total number of employees.
- **Data-Driven Insights:** Insights derived from analyzing large datasets. These insights can inform business decisions, such as improving employee retention strategies or ensuring fair compensation.

## Executive Summary
We learn that out of the total *60* employees, Next Gen has had *28* employees leave over a span of ... years. The dashboard also highlights **Sales** as the department with the highest number of employees (*23*) scoring above *3.5* in their performance analysis. The company has spent a total of *$4.85M* on payroll, and the highest earning employees are *26* (**in this case, salaries of $80K and above**). The *9* top performers represent the number of times employees achieved a perfect *5/5* score, and the *45* poor performers also represent instances of low scores. Therefore, these numbers might be higher than the actual number of employees who attained a perfect score or scored *3.5* or below. The top 5 longest-serving employees represent the employees’ tenure in the company, regardless of whether they are still active. With this approach, Next Gen can understand employee turnover in a more holistic way. That being said, *3* out of the *5* top-serving employees are from **Sales**, which is also the department with the most poor performers. 4 out of the 5 job titles have an average salary of $80K+ implying that majority of the employees in Next Gen can be considered as highearners, **Marketing Specialists** is the only job title with an average employee salary of 77.86K. Furthermore, the marketing departmernt has the highest turnover rate with the data showing 92.86% of the employees having left work, trhis phenomenon can be investigated further to see the correlation between renumeration adn turnover. The correlation between salary and perfromance was also conduct showing on average employees from high perfomring departmnets(marketing 4.13/5 and Engineering 4.10/5 earned ..... 
The main turnover reasons where Career Progression, Finding another job, Career Growth and Personal reasons. The lata should be treated with caution due to the broad nature of the reasons that might hide nuances that employees might have felt uncomfortable to declare.

## Dashboard
[An interactive live dashboard on can be accessed here](https://app.powerbi.com/view?r=eyJrIjoiOTNkZTE0NDEtMTU2OC00OTQzLWFhYjktMTIzMmU4ODkyM2MxIiwidCI6ImZmMGYzZTNhLTNlNTMtNDU0Zi1iMmI1LTZjNjg3NTNiOGVlNCJ9).

<img src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/Next%20gen%20Dashboard%20.png" alt="Next Gen Dashboard" width="100%"/>

## Entity Relationship Diagram
<img src="https://github.com/cephard/Next-Gen-Employee-Analysis/blob/main/charts/erd.png" alt="Entity Relationship Diagram" width="100%"/>


