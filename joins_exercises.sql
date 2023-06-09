-- Create a database named join_test_db and run the SQL provided in the Join Example DB section above; to create the same setup used for this lesson.
USE cerberus_theo;
CREATE TABLE roles
(
    id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE users
(
    id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name    VARCHAR(100) NOT NULL,
    email   VARCHAR(100) NOT NULL,
    role_id INT UNSIGNED DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO roles (name)
VALUES ('admin');
INSERT INTO roles (name)
VALUES ('author');
INSERT INTO roles (name)
VALUES ('reviewer');
INSERT INTO roles (name)
VALUES ('commenter');

INSERT INTO users (name, email, role_id)
VALUES ('bob', 'bob@example.com', 1),
       ('joe', 'joe@example.com', 2),
       ('sally', 'sally@example.com', 3),
       ('adam', 'adam@example.com', 3),
       ('jane', 'jane@example.com', null),
       ('mike', 'mike@example.com', null);

SELECT *
FROM roles;
SELECT *
FROM users;
-- Insert 4 new users into the database. One should have a NULL role. The other three should be authors.
INSERT INTO users (name, email, role_id)
VALUES ('theo', 'theo@example.com', 2),
       ('paige', 'paige@example.com', 2),
       ('cody', 'cody@example.com', 2),
       ('cali', 'cali@example.com', NULL);
-- Use JOIN, LEFT JOIN, and RIGHT JOIN to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
-- Join/Inner Join
SELECT users.name as user_name, roles.name as role_name
FROM users
         JOIN roles ON users.role_id = roles.id;
-- Left Join
SELECT users.name AS user_name, roles.name AS role_name
FROM users
         LEFT JOIN roles ON users.role_id = roles.id;
-- Right Join
SELECT users.name AS user_name, roles.name AS role_name
FROM users
         RIGHT JOIN roles ON users.role_id = roles.id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use COUNT and the appropriate join type to get a list of roles along with the number of users that have a given role. Hint: You will also need to use GROUP BY in the query.
SELECT COUNT(role_id) AS role_count, roles.name AS role_name
FROM users
         RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY role_id;

-- Employees Database
-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
USE employees;
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees as e
         JOIN dept_emp as de
              ON de.emp_no = e.emp_no
         JOIN departments as d
              ON d.dept_no = de.dept_no
         JOIN dept_manager as dm
              ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01'
GROUP BY d.dept_name;
-- Find the name of all departments currently managed by women.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees as e
         JOIN dept_emp as de
              ON de.emp_no = e.emp_no
         JOIN departments as d
              ON d.dept_no = de.dept_no
         JOIN dept_manager as dm
              ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01'
  AND e.gender = 'F'
GROUP BY d.dept_name;
-- Find the current titles of employees currently working in the Customer Service department.
# SELECT COUNT(t.title) AS Total, t.title
# FROM employees as e
#          JOIN current_dept_emp as de
#               ON de.emp_no = e.emp_no
#          JOIN departments as d
#               ON d.dept_no = de.dept_no
#          JOIN titles as t
#               ON t.emp_no = e.emp_no
# WHERE t.to_date = '9999-01-01'
#   AND d.dept_name = 'Customer Service'
# GROUP BY t.title
# ORDER BY Total DESC;
-- review answer
SELECT titles.title AS 'title', COUNT(*) AS 'total'
FROM departments
JOIN dept_emp on dept_emp.dept_no = departments.dept_no
JOIN titles ON titles.emp_no = dept_emp.emp_no
WHERE departments.dept_name = 'Customer Service' AND titles.to_date = '9999-01-01' AND dept_emp.to_date = '9999-01-01'
GROUP BY title
ORDER BY total DESC;
-- Find the current salary of all current managers.
# SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager, s.salary
# FROM employees as e
#          JOIN dept_emp as de
#               ON de.emp_no = e.emp_no
#          JOIN departments as d
#               ON d.dept_no = de.dept_no
#          JOIN dept_manager as dm
#               ON dm.emp_no = e.emp_no
#          JOIN salaries as s
#               ON s.emp_no = e.emp_no
# Where Current Manager AND Current Salary
# WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
# GROUP BY d.dept_name;
-- review answer
SELECT departments.dept_name AS 'department name', CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager', salaries.salary AS 'Salary'
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees on employees.emp_no = dept_manager.emp_no
JOIN salaries ON employees.emp_no =  salaries.emp_no
WHERE dept_manager.to_date LIKE '9999%' AND salaries.to_date LIKE '9999%'

-- Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(e.first_name, ' ', e.last_name) as Employee,
       d.dept_name as Department,
        CONCAT(e2.first_name, ' ', e2.last_name) as Manager
FROM dept_emp as de
JOIN employees as e ON de.emp_no = e.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
JOIN dept_manager as dm on dm.dept_no = d.dept_no
AND dm.to_date = '9999-01-01'
JOIN employees as e2 on e2.emp_no = dm.emp_no
where de.to_date = '9999-01-01'



