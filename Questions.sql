1. Write a query to find the employee details of highest salary in each department.
-----------------------------------------------------------------------------------
SQL>SELECT ename, deptno, sal
    FROM emp
    WHERE sal IN (
        SELECT MAX(Sal)
        FROM emp
        GROUP BY deptno
    );

SQL>SELECT * FROM
    (
        SELECT ename,
            deptno,
            sal,
            DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) AS rnk
            FROM emp
    )
    WHERE rnk = 1;

SQL>SELECT e.ename, e.sal, e.deptno
    FROM emp e
    JOIN (
        SELECT deptno, MAX(sal) AS max_Sal
        FROM emp
        GROUP BY deptno
    ) m
    ON e.deptno = m.deptno
    AND e.sal = m.max_Sal;

2. How to find the unique records from a table?
-------------------------------------------------
SQL>SELECT DISTINCT * FROM emp;

SQL>SELECT ename, deptno, sal
    FROM emp
    GROUP BY ename, sal, deptno
    HAVING COUNT(*) = 1;

SQL> SELECT * FROM
     (
        SELECT ename, deptno, sal,
            ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) AS rn
        FROM emp
     )
    WHERE rn = 1;

3. How to delete duplicate records from a table?
-------------------------------------------------
STEP 1: Identify the duplicate records using ROW_NUMBER() function.
SQL> SELECT * FROM
     (
        SELECT ename, deptno, sal,
            ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) AS rn
        FROM emp
     )
    WHERE rn = 1;

STEP 2: FIND THE ROWID of the duplicate records using ROWID
SQL> SELECT ROWID FROM
        (
            SELECT ROWID, ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) AS rn
            FROM emp
        )
    WHERE rn > 1;

STEP3 : DELETE the duplicate records using ROWID
SQL>DELETE FROM emp WHERE ROWID IN
    (
        SELECT ROWID FROM
        (
            SELECT ROWID, ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) AS rn
            FROM emp
        )
        WHERE rn > 1;
    );

4. How to find top 5 records from a table?
-------------------------------------------------
SQL> SELECT * FROM emp WHERE ROWNUM <= 5;

5. How to find the second highest salary from a table?
-------------------------------------------------------
SQL> SELECT MAX(sal) AS second_highest_salary
    FROM emp
    WHERE sal < (SELECT MAX(sal) FROM emp);

SQL>SELECT * FROM
    (
        SELECT sal, DENSE_RANK() OVER(ORDER BY sal DESC) AS rnk
        FROM emp
    )
    WHERE rnk = 2;

6. How to update records in a table based on the values from another table using a SQL query?
---------------------------------------------------------------------------------------------
Scenario-1: Update Salary of all employees by 5% belonging to department id 20

SQL> UPDATE emp
     SET sal = sal * 1.05
     WHERE deptno = 20;

Scenario-2: Update Salary of all employees by 5% belonging to IT department

STEP 1: Find the department ID of IT department
SQL>SELECT deptno FROM dept WHERE dname ='IT';

STEP 2: Update salary for all employees belonging to IT department
UPDATE emp
SET sal = sal * 1.05
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'IT');

7. How to delete records in a table based on the values from another table using a SQL query?
---------------------------------------------------------------------------------------------
Scenario-1: Delete records of all employees by belonging to department id 20

SQL> DELETE FROM emp WHERE deptno = 20;

Scenario-2: Delete records of all employees belonging to IT department

SQL > DELETE FROM emp
      WHERE deptno = (
        SELECT deptno FROM dept WHERE dname = 'IT'
     );