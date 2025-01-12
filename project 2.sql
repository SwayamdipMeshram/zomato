CREATE DATABASE Project2;
USE Project2;
-- que1

CREATE TABLE employees (
    empno INT PRIMARY KEY, -- Empno cannot be null or Duplicate
    ename VARCHAR(20) not null,
    job VARCHAR(20) DEFAULT 'CLERK', -- Default Job should be Clerk
    mgr INT,
    hiredate DATE,
    sal DECIMAL(7,2) CHECK (sal >= 0), -- Salary cannot be Less then Negative or Zero
    comm DECIMAL(7,2),
    deptno INT
    );
 
INSERT INTO employees (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
    (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
    (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
    (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
    (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
    (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
    (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
    (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
    (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000.00, NULL, 20),
    (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
    (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30),
    (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, NULL, 20),
    (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30),
    (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
    (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);
    
select * from employees;

-- que 2

CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(13)
);

-- que 3
SELECT ename, sal
FROM employees
WHERE sal > 1000;

-- que 4
SELECT *
FROM employees
WHERE hiredate < '1981-09-30';

-- que 5
SELECT ename
FROM employees
WHERE ename LIKE '_I%';

-- que 6

SELECT ename AS "Employee Name", 
       sal AS "Salary", 
       sal * 0.4 AS "Allowances", 
       sal * 0.1 AS "P.F.", 
       sal + (sal * 0.4) - (sal * 0.1) AS "Net Salary"
FROM employees;

-- que 7

SELECT ename, job
FROM employees
WHERE mgr IS NULL;

-- que 8

SELECT empno, ename, sal
FROM employees
ORDER BY sal ASC;

-- que 9
SELECT COUNT(DISTINCT job) AS "Number of Jobs"
FROM employees;

-- que 10
SELECT SUM(sal) AS "Total Salesman Salary"
FROM employees
WHERE job = 'SALESMAN';

-- que 11
SELECT deptno, job, AVG(sal) AS "Average Salary"
FROM employees
GROUP BY deptno, job;

-- que 12
SELECT e.ename, e.sal, d.dname
FROM employees e
JOIN dept d ON e.deptno = d.deptno;

-- que 13

CREATE TABLE job_grades (
    grade VARCHAR(10),
    lowest_sal DECIMAL(7,2),
    highest_sal DECIMAL(7,2)
);

INSERT INTO job_grades (grade, lowest_sal, highest_sal) VALUES
    ('A', 0, 999),
    ('B', 1000, 1999),
    ('C', 2000, 2999),
    ('D', 3000, 3999),
    ('E', 4000, 5000);
    
    -- que 14
    
    SELECT e.ename, e.sal, j.grade
FROM employees e
JOIN job_grades j ON e.sal BETWEEN j.lowest_sal AND j.highest_sal;

-- que 15

SELECT e.ename || ' Reports to ' || m.ename AS "Reports To"
FROM employees e
LEFT JOIN employees m ON e.mgr = m.empno;

-- que 16

SELECT ename, (sal + NVL(comm, 0)) AS "Total Salary"
FROM employees;

-- que 17
SELECT ename, sal
FROM employees
WHERE MOD(empno, 2) != 0;

-- que 18

SELECT ename, 
       RANK() OVER (ORDER BY sal DESC) AS "Org Rank", 
       RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS "Dept Rank"
FROM employees;

-- que 19

SELECT ename
FROM employees
ORDER BY sal DESC
limit 3;

-- que 20

SELECT deptno, ename, sal
FROM employees
WHERE (deptno, sal) IN (
    SELECT deptno, MAX(sal)
    FROM employees
    GROUP BY deptno
);