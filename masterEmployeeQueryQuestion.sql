-- 1> Write a SQL query to find the nth highest salary from employee table. 
-- Example: finding 3rd highest salary from employee table
select * from employee order by salary desc;
--- Limit N-1,1
select distinct salary from employee order by salary desc limit 2, 1;

-- 2> Write a SQL query to find top n records?
-- Example: finding top 5 records from employee table
select * from employee order by salary desc limit 5;

-- 3> Write a SQL query to find the count of employees working in department 'Admin'
select count(*) from employee where department = 'Admin';

-- 4> Write a SQL query to fetch department wise count employees sorted by department count in desc order.
select * from employee;

select department, count(*) as employeecount 
from employee
group by department
order by employeecount desc;

-- 5>  Write a query to fetch only the first name(string before space) from the FullName column of user_name table.
select distinct(substring_index(full_names, ' ', 1)) first_name from user_name;

-- 6> Write a SQL query to find all the employees from employee table who are also managers
select e1.first_name, e2.last_name from employee e1 
join employee e2
on e1.employee_id = e2.manager_id;

-- 7> Write a SQL query to find all employees who have bonus record in bonus table
select * from employee;
select * from bonus;

select * from employee where employee_id in (select employee_ref_id from bonus where employee.employee_id = bonus.employee_ref_id);

-- 8> Write a SQL query to find only odd rows from employee table
select * from employee where MOD(employee_id,2)<>0;

-- 9> Write a SQL query to fetch first_name from employee table in upper case
select upper(first_name) as First_Name from employee;

-- 10> Write a SQL query to get combine name (first name and last name) of employees from employee table
select concat(first_name, ' ' ,last_name) as Name from employee;

-- 11> Write a SQL query to print details of employee of employee 'Jennifer' and 'James'.
select * from employee where first_name in ('Jennifer', 'James');

-- 12> Write a SQL query to fetch records of employee whose salary lies between 
select first_name, last_name, salary from employee where salary between 100000 and 500000;

-- 13> Write a SQL query to get records of employe who have joined in Jan 2017
select * from employee;

select first_name, last_name, joining_date from employee where year(joining_date)=2017 and month(joining_date) = 1;

-- 14> Write a SQL query to get the list of employees with the same salary
select e1.first_name, e2.last_name from employee e1, employee e2 where e1.salary = e2.salary and e1.employee_id != e2.employee_id; 

-- 15> Write a SQL query to show all departments along with the number of people working there. 
select * from employee;

select department, count(*) as 'Number of employees' from employee 
group by department 
order by count(department);

-- 16> Write a SQL query to show the last record from a table.
select * from employee where employee_id = (select max(employee_id) from employee);

-- 17> Write a SQL query to show the first record from a table.
select * from employee where employee_id = (select min(employee_id) from employee);

-- 18> Write a SQL query to get last five records from a employee table.
(select * from employee order by employee_id desc limit 5) order by employee_id;

-- 19> Write a SQL query to find employees having the highest salary in each department. 
select first_name, last_name, department, max(salary) as 'Max Salary'from employee group by department order by max(salary);

-- 20> Write a SQL query to fetch three max salaries from employee table.
select distinct salary from employee order by salary desc limit 3 ;
-- OR-----
select distinct Salary from employee e1 WHERE 3 >= (SELECT count(distinct Salary) from employee e2 WHERE e1.Salary <= e2.Salary) order by e1.Salary desc;

-- 21> Write a SQL query to fetch departments along with the total salaries paid for each of them.
select department, sum(salary) as 'Total Salary' from employee group by department order by sum(salary);

-- 22> Write a SQL query to find employee with highest salary in an organization from employee table.
select first_name, last_name from employee where salary = (select max(salary) from employee);



-- =========================================
-- 5. Find Duplicate Records
-- =========================================
SELECT emp_id,
       dept,
       COUNT(*) AS duplicate_count
FROM employee
GROUP BY emp_id, dept
HAVING COUNT(*) > 1;



-- HAVING filters after aggregation
SELECT department_id,
       AVG(salary) AS avg_salary
FROM emp
GROUP BY department_id
HAVING AVG(salary) > 9500;

-- =========================================
-- 16. Second Highest Salary (Using Subquery)
-- =========================================
SELECT MAX(salary) AS second_highest_salary
FROM emp
WHERE salary < (
    SELECT MAX(salary)
    FROM emp
);

-- 15. Delete Duplicates Using RANK()

-- =========================================
-- 13. Fetch Top N Records (Top 10 Highest Salary)
-- =========================================
SELECT TOP 10 *
FROM employee
ORDER BY salary DESC;

-- =========================================
-- 2. Categorize Employees by Age (CASE WHEN)
-- =========================================
SELECT *,
       CASE 
           WHEN emp_age < 20 THEN 'Kids'
           WHEN emp_age BETWEEN 20 AND 40 THEN 'Adult'
           ELSE 'Old'
       END AS emp_age_bracket
FROM emp_mgr_age
ORDER BY emp_age;



-- 7. Employees with Highest Salary in Each Department
-- (Using JOIN)
-- =========================================
SELECT e.emp_id,
       e.emp_name,
       e.department_id,
       e.salary
FROM emp e
INNER JOIN (
    SELECT department_id, MAX(salary) AS max_salary
    FROM emp
    GROUP BY department_id
) AS m
    ON e.department_id = m.department_id
   AND e.salary = m.max_salary;


-- =========================================
-- 9. Employees with Salary Greater Than Dept Avg
-- =========================================
SELECT e.emp_id,
       e.emp_name,
       e.department_id,
       e.salary
FROM emp e
INNER JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM emp
    GROUP BY department_id
) AS d
    ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;

-- =========================================
-- 11. Employees Earning More Than Their Manager
-- =========================================
SELECT e.emp_id,
       e.emp_name,
       e.department_id,
       e.salary
FROM empm e
WHERE e.salary > (
    SELECT salary
    FROM empm
    WHERE emp_id = e.manager_id
);


## important questions
1- How to find duplicates in a table
2- How to delete duplicates from a table
3- Difference between union and union all
5- Find records in a table which are not present in another table
6- Find second highest salary employees in each department
7- Find employees with salary more than their manager's salary
11. Sort a table based on gender. E.g. if gender is Male then sort in ascending order, if Female then descending order



2.63. Find details of highest paid employee-
SELECT * FROM emp 
WHERE sal = (SELECT MAX(sal) FROM emp);
2.64. Find highest paid employee of SALES department-
SELECT * FROM emp 
WHERE sal = (
SELECT MAX(sal) FROM emp 
WHERE deptno = (SELECT deptno FROM dept WHERE dname='SALES'));


  2.117. List manager with maximum employees under him-
SELECT mgr, COUNT(*) 
FROM emp 
GROUP BY mgr 
HAVING COUNT(*) = (
SELECT MAX(COUNT(*)) FROM emp GROUP BY mgr);


  2.116. List departments with more than average employees-
SELECT d.dname 
FROM emp e, dept d 
WHERE e.deptno=d.deptno 
GROUP BY d.dname 
HAVING COUNT(*) > (
SELECT AVG(cnt) FROM (
SELECT COUNT(*) cnt FROM emp GROUP BY deptno));


  SELECT dname FROM dept 
WHERE deptno IN (
SELECT deptno FROM emp 
GROUP BY deptno 
HAVING COUNT(*) = (
SELECT MAX(COUNT(*)) FROM emp GROUP BY deptno));


  2.155. List employees earning more than department average (order by deptno)-
SELECT ename, sal, deptno 
FROM emp e
WHERE sal > (
SELECT AVG(sal) FROM emp WHERE deptno = e.deptno)
ORDER BY deptno;

  #second highest salary
#using max
select max(emp_salary) from employee where emp_salary < (select max(emp_salary) from employee);

#using limit,inner querry run first will give 2 highest salry, then order by ascending(default)
select emp_salary from (select emp_salary from employee order by  emp_salary desc limit 2) as emp order by emp_salary limit 1;


  #Q6- SECOND HIGHEST SALARY IN EACH DEPARTMENT,dec highest will rank 1


  #Q1-How to find duplicate in a given table ,IF COUNT>1 MEANS THERE ARE DUPLICATE,to put filter on agg cols we use having
select emp_id ,count(1) from empt
group by emp_id having count(1)>1;

#Q2-HOW to delete duplicate 
with cte as (select * , row_number() over(partition by emp_id order by emp_id) as rn from empt)
delete from cte where rn>1;




  -- Write an SQL query to determine the nth (say n=5) highest salary from a table.
-- There are two ways of doing it:
-- Way 1 [by using the limit keyword And the Offset Keyword]
-- The 'OFFSET' argument is used to identify the starting point to return rows from a result set. Basically, it excludes the first set of records.
-- The 'limit' keyword would be restricting the number of rows that should be given as an output.
-- The value of the OFFSET Keyword is 'n-1', it means that to get the nth highest record, you wish to start printing the values from n-1th row as indexing starts from 0.
SELECT DISTINCT(Salary) 
FROM Worker
ORDER BY Salary DESC
LIMIT 1 Offset 4;


  -- Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
SELECT Salary FROM Worker as w1
where 4  = (
  Select count(distinct(w2.salary))
  FROM Worker as w2
  WHERE w2.salary >= w1.salary
);


  -- Query 35
-- Write an SQL query to fetch the list of employees with the same salary.
-- The below query [a default Inner Join] would also do the comparison of the employee with himself/herself but we don't want this.
SELECT * FROM 
Worker as w1 , Worker as w2 
WHERE w1.salary = w2.salary;


-- Write an SQL query to show the second highest salary from a table using sub-query.
SELECT MAX(DISTINCT(Salary))
From Worker
WHERE salary < (
  SELECT MAX(DISTINCT(SALARY))
  FROM Worker
);


-- Query 40
-- Write an SQL query to fetch the departments that have less than 4 people in it.
SELECT department, COUNT(department)
FROM Worker
GROUP BY department
HAVING COUNT(department) < 4;

-- Query 41
-- Write an SQL query to show all departments along with the number of people in there.
SELECT department, COUNT(department)
FROM Worker
GROUP BY department;


-- Query 42 [Interesting]
-- Write an SQL query to show the last record from a table.
-- We know that the worker id  is self-Incrementing, therefore we'll find the the max worker_id first and print the data corresponding to it
SELECT * 
FROM Worker
where worker_id = (
  SELECT MAX(worker_id)
  FROM Worker
);

-- Query 43
-- Write an SQL query to fetch the first row of a table.
-- Similar to the previous query, but here we find the Minimum value of Worker_id
SELECT * 
FROM Worker
where worker_id = (
  SELECT MIN(worker_id)
  FROM Worker
);

-- Query 44
-- Write an SQL query to fetch the last five records from a table.
-- Again, we use the Auto Incrmenting Property of Worker_id & order them in the descending order & then limit the results
SELECT * 
FROM Worker
ORDER BY worker_id DESC
LIMIT 5;
-- But the above query is actually reversing the order in which how the values were present in the table, so we need to correct this well & reverse its output to get the original way how the rows were stored in the Table
(
  SELECT * 
  FROM Worker
  ORDER BY worker_id DESC
  LIMIT 5
)ORDER BY worker_id;

-- Query 45
-- Write an SQL query to print the name of employees having the highest salary in each department.
SELECT department, MAX(Salary) 
FROM Worker 
GROUP BY department;

-- Another way of doing it by using Joins
SELECT w.department, w.first_name, w.salary
FROM(
  SELECT MAX(Salary) as Maxsal, department
  FROM Worker
  GROUP BY Department
) AS temp
Inner Join Worker as w 
ON w.Salary = temp.MaxSal;

-- Query 46
-- Write an SQL query to fetch three max salaries from a table using co-related subquery.
Select Distinct(Salary)
From Worker as w1
where 3>= (
  SELECT COUNT(DISTINCT(Salary))
  From Worker as w2
  where w2.Salary >= w1.Salary
) ORDER By Salary Desc;

-- Its Limit Form:
SELECT Distinct(Salary)
From Worker 
ORDER By Salary DESC
LIMIT 3;

-- Query 47
-- Write an SQL query to fetch three min salaries from a table using co-related subquery
Select Distinct(Salary)
From Worker as w1
where 3>= (
  SELECT COUNT(DISTINCT(Salary))
  From Worker as w2
  where w2.Salary <= w1.Salary
) ORDER By Salary;

-- For obtaining the 'n' Minimum salaries, we can have a general form for the query like below with just the comparison values changed:
-- Select Distinct(Salary)
-- From Worker as w1
-- where n>= (
--   SELECT COUNT(DISTINCT(Salary))
--   From Worker as w2
--   where w2.Salary >= w1.Salary
-- ) ORDER By Salary;

-- Query 48
-- Write an SQL query to fetch nth max salaries from a table.
-- For obtaining the 'n' Maximum salaries, we can have a general form for the query like below:
-- Select Distinct(Salary)
-- From Worker as w1
-- where n>= (
--   SELECT COUNT(DISTINCT(Salary))
--   From Worker as w2
--   where w2.Salary <= w1.Salary
-- ) ORDER By Salary;

-- Query 49
-- Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT Department, SUM(salary) as depSal
FROM Worker
Group BY Department
ORDER BY depSal DESC;

-- Query 50
-- Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT first_name, salary
FROM Worker Where 
Salary = (
  SELECT Max(Salary)
  FROM Worker
;

-- Query 51
-- Remove the Reversed Number Pair from the given Ta


#Q5.fetch duplicates records from a table
select emp_id,dept,count(*) from employee group by emp_id , dept having count(*)>1;

#Q6.remove duplicates
delete from employee where emp_id in (select emp_id from employee group by dept having count(*)>1);


#find duplicate records in a table
SELECT emp_name,salary, COUNT(*) AS CNT  
    FROM empt  
    GROUP BY emp_name,salary 
    HAVING COUNT(*)>1 ;
#-- delete all the duplicate records in a table   
WITH cte AS (
    SELECT 
        emp_name,salary,
        ROW_NUMBER() OVER (
            PARTITION BY 
               emp_name,salary
            ORDER BY 
               emp_name,salary
        ) row_num
     FROM 
        empt
)
DELETE FROM cte WHERE row_num > 1;

# find the manager name for the employee 
 #   --where empid and managerid are on the same table
SELECT e.emp_id, e.emp_name, m.emp_name 
    FROM empt e
    LEFT JOIN empt m 
        on e.Manager_Id = m.Emp_Id;
        
# find the second highest salary
Select max(Salary) as Salary
    FROM empt
    WHERE Salary <(Select max(Salary) from empt) ;
 -- 1. Inner Query - Get the highest salary
 -- 2. Outer Query - Get the highest salary excluding the highest salary 
                    -- gives the second highest salary

-- find the employee with the second highest salary
SELECT * FROM empt where Salary in 
(SELECT max(Salary) as Salary
    FROM empt
    WHERE Salary < (Select max(Salary) FROM empt)  );
    
-- 3rd and Nth highest salary
SELECT MIN(Salary) FROM				-- OUTER QUERY 
( SELECT DISTINCT TOP 3 Salary		-- INNER QUERY
	FROM empt
	ORDER BY Salary DESC
)  AS O
-- Here 3 can be changed to N ; can be applied for any number. 
-- 1. Inner Query - Get the highest 3 salaries
-- 2. Outer Query - Get the minimum salary from those salaries

-- query to find maximum salary from each department
SELECT Department_Id, MAX(Salary) as Salary 
    FROM empt 
    GROUP BY Department_Id  
    
#--alternative for TOP clause in SQL
SELECT TOP 3 * FROM empt
#Alternative
SET ROWCOUNT 3  
Select * from empt
SET ROWCOUNT 0 

-- showing single row from a table twice in the results
SELECT dep_name FROM dept d WHERE d.dep_name='IT'  
UNION ALL
SELECT dep_name FROM dept d WHERE d.dep_name='IT'  

-- find departments that have less than 3 employees
SELECT e.department_id,d.dep_name 
    FROM  empt e
    JOIN dept d on e.department_id = d.dep_id
    GROUP BY e.department_id,d.dep_name HAVING COUNT(Emp_Id) < 3
