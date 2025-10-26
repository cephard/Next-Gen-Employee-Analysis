-- Employee Retention Analysis
-- 1. Who are the top 5 highest serving employees?
SELECT 
     CONCAT(first_name, ' ', last_name) AS employee_name,
	department_name,
    EXTRACT(YEAR FROM serving_time) AS years,
    EXTRACT(MONTH FROM serving_time) AS months,
    EXTRACT(DAY FROM serving_time) AS days,
	EXTRACT(DAY FROM serving_time) 
        + (EXTRACT(MONTH FROM serving_time) * 30) 
        + (EXTRACT(YEAR FROM serving_time) * 365) AS total_days
FROM (
    SELECT 
        e.first_name,
        e.last_name,
        CASE 
            WHEN t.turnover_date IS NULL THEN AGE(CURRENT_DATE, e.hire_date)
            ELSE AGE(t.turnover_date, e.hire_date)
        END AS serving_time,
		d.department_name
    FROM employee e
    LEFT JOIN turnover t
        ON e.employee_id = t.employee_id
	LEFT JOIN department d
	ON d.department_id = e.department_id
) AS sub
ORDER BY years DESC, months DESC, days DESC
LIMIT 5;

-- 2. What is the turnover rate for each department?
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

-- 3. Which employees are at risk of leaving based on their performance?
-- only employees not in turnover table (currently serving)
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       d.department_name,
       ROUND(AVG(p.performance_score), 2) AS score
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.department_id
LEFT JOIN performance p
    ON e.employee_id = p.employee_id
LEFT JOIN turnover t
    ON e.employee_id = t.employee_id  
WHERE t.employee_id IS NULL          
GROUP BY e.employee_id, employee_name, d.department_name
HAVING AVG(p.performance_score) < 4.0
ORDER BY score ASC;


-- 4. What are the main reasons employees are leaving the company?
SELECT
    reason_for_leaving,
    COUNT(*) AS total_leavers
FROM turnover
GROUP BY reason_for_leaving
ORDER BY total_leavers DESC;


-- Performance Analysis
-- 1. How many employees have left the company?
SELECT 
    COUNT(DISTINCT t.employee_id) AS total_employees_left,
    COUNT(DISTINCT e.employee_id) AS total_employees,
    ROUND(
        (COUNT(DISTINCT t.employee_id) * 100.0 / COUNT(DISTINCT e.employee_id)),
        2
    ) AS percentage_left
FROM employee e
LEFT JOIN turnover t
    ON t.employee_id = e.employee_id;

-- 2. How many employees have a performance score of 5.0 / below 3.5?
-- This query considers any time an employee had these perfromance and this is
-- not based on their average perfromance
SELECT 
    COUNT(DISTINCT CASE WHEN performance_score = 5.0 THEN employee_id END) AS score_5,
    COUNT(DISTINCT CASE WHEN performance_score < 3.5 THEN employee_id END) AS below_3_5
FROM performance;

-- 3. Which department has the most employees with a performance of 5.0 / below 3.5?
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

-- 4. What is the average performance score by department?
SELECT
	d.department_name,
	ROUND(AVG(p.performance_score),2) AS average_performance
FROM department d
LEFT JOIN performance p
	ON d.department_id = p.department_id
GROUP BY d.department_name
ORDER BY average_performance DESC;





-- Salary Analysis
-- 1. What is the total salary expense for the company?
SELECT SUM(salary_amount)
FROM salary;

-- 2. What is the average salary by job title?
SELECT
	e.job_title,
	ROUND(AVG(salary_amount),2) AS average_salary
FROM employee e
JOIN salary s
	ON e.employee_id = s.employee_id
GROUP BY e.job_title
ORDER BY average_salary DESC;

-- 3. How many employees earn above 80,000?
SELECT COUNT(employee_id) employees_earning_above_80k
FROM salary
WHERE salary_amount > 80000;

-- 4. How does performance correlate with salary across departments?
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





