-- In your script, use DISTINCT to find the unique titles in the titles table.
SELECT DISTINCT title FROM titles;
-- Find your query for employees whose last names start and end with 'E'. Update the query to find just the unique last names that start and end with 'E' using GROUP BY.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%E' ORDER BY emp_no ASC;
-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'E%' AND last_name LIKE '%E' GROUP BY first_name, last_name;
-- Find the unique last names with a 'q' but not 'qu'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE ('%qu%');
-- Add a COUNT() to your results and use GROUP BY to make it easier to find employees whose unusual name is shared with others.
SELECT DISTINCT last_name, COUNT(*) AS name_count FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE ('%qu%') GROUP BY last_name;
-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use count(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT gender, count(emp_no) AS count FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') GROUP BY gender;
