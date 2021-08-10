### Files
CREATE TABLE pewlett_hackard_employee (
	primary_key SERIAL PRIMARY KEY, 
	emp_no VARCHAR,
	emp_title_id VARCHAR,
	birth_date TIMESTAMP,
	last_name varchar (59),
	first_Name varchar (30),
	sex varchar (1),
	hire_date TIMESTAMP
)

CREATE TABLE pewlett_hackard_emp_dept (
	primary_key SERIAL PRIMARY KEY, 
	emp_no VARCHAR,
	dept_no VARCHAR
)

CREATE TABLE pewlett_hackard_dept (
	primary_key SERIAL PRIMARY KEY, 
	dept_no VARCHAR,
	dept_name VARCHAR
)

CREATE TABLE pewlett_hackard_department_manager (
	primary_key SERIAL PRIMARY KEY, 
	dept_no VARCHAR,
	emp_no VARCHAR
)

CREATE TABLE pewlett_hackard_salaries (
	primary_key SERIAL PRIMARY KEY, 
	emp_no VARCHAR,
	salary INT
)

CREATE TABLE pewlett_hackard_titles (
	primary_key SERIAL PRIMARY KEY, 
	title_id VARCHAR,
	title VARCHAR
)

##View files
select * from pewlett_hackard_titles
select * from pewlett_hackard_salaries
select * from pewlett_hackard_employee
select * from pewlett_hackard_dept
select * from pewlett_hackard_department_manager


### Q1: List the following details of each employee: employee number, last name, first name, sex, and salary
select * from pewlett_hackard_employee

SELECT pewlett_hackard_employee.emp_no,
	   pewlett_hackard_employee.first_name,
	   pewlett_hackard_employee.last_name,
	   pewlett_hackard_employee.sex,
	   pewlett_hackard_salaries.salary
FROM pewlett_hackard_employee
INNER JOIN pewlett_hackard_salaries
ON (pewlett_hackard_employee.emp_no = pewlett_hackard_salaries.emp_no);


### Q2: hired in 1986
select first_name, last_name, hire_date from pewlett_hackard_employee where date_part('year', hire_date) = 1986

### Q3: List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name
SELECT pewlett_hackard_employee.emp_no,
	   pewlett_hackard_employee.first_name,
	   pewlett_hackard_employee.last_name,
	   pewlett_hackard_employee.sex,
	   pewlett_hackard_department_manager.dept_no,
	   pewlett_hackard_dept.dept_name
FROM pewlett_hackard_department_manager
INNER JOIN pewlett_hackard_employee
ON (pewlett_hackard_employee.emp_no = pewlett_hackard_department_manager.emp_no)
INNER JOIN pewlett_hackard_dept
ON (pewlett_hackard_dept.dept_no = pewlett_hackard_department_manager.dept_no)

### Q4: List the department of each employee with the following information: employee number, last name, first name, and department name
CREATE TABLE pw_employee_dept AS
	SELECT emp_no, pewlett_hackard_emp_dept.dept_no, pewlett_hackard_dept.dept_name FROM pewlett_hackard_emp_dept
	INNER JOIN pewlett_hackard_dept ON (pewlett_hackard_dept.dept_no = pewlett_hackard_emp_dept.dept_no)

CREATE TABLE pw_dept_emp AS
	SELECT pewlett_hackard_employee.emp_no,
		   pewlett_hackard_employee.first_name,
		   pewlett_hackard_employee.last_name,
		   pewlett_hackard_employee.sex,
		   pw_employee_dept.dept_name
		   FROM pw_employee_dept
		   INNER JOIN pewlett_hackard_employee
		   ON (pewlett_hackard_employee.emp_no = pw_employee_dept.emp_no)

SELECT * FROM pw_dept_emp

###5 List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B"
SELECT first_name, last_name, sex
FROM pewlett_hackard_employee
WHERE
first_name = 'Hercules'
or last_name LIKE 'B%';

### Q6 List all employees in the Sales department, including their employee number, last name, first name, and department
SELECT * FROM pw_dept_emp where dept_name = 'Sales'

### Q7 List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT * FROM pw_dept_emp where dept_name = 'Sales' or dept_name = 'Development'

### Q8 In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT
	last_name,
	COUNT (emp_no)
FROM
	pewlett_hackard_employee
GROUP BY
	last_name
ORDER BY COUNT (emp_no) DESC

