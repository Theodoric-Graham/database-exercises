USE employees;
-- Find all the employees with the same hire date as employee 101010 using a subquery. 69 Rows
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date IN (SELECT hire_date
                    FROM employees
                    WHERE emp_no = 101010);
-- Find all the titles held by all employees with the first name Aamod. 314 total titles, 6 unique titles
SELECT title, COUNT(title)
FROM titles
WHERE emp_no IN (
    SELECT emp_no
    FROM employees
    WHERE first_name = 'Aamod'
    )
GROUP BY title;
-- Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
    WHERE to_date = '9999-01-01'

) AND gender = 'F';

-- BONUS
-- Find all the department names that currently have female managers.
select d.dept_name
from departments as d
where d.dept_no IN
(select dm.dept_no
FROM dept_manager as dm
JOIN employees e on dm.emp_no = e.emp_no
where dm.to_date = '9999-01-01' and e.gender = 'F');
-- Find the first and last name of the employee with the highest salary.
select first_name, last_name
FROM employees as e
WHERE e.emp_no =
(select s.emp_no
from salaries as s
ORDER BY salary DESC
LIMIT 1);






