### 1. What are Analytical Functions in SQL?
- Analytical functions perform calculations across a group of rows related to the current row without grouping the result set.
- It returns result in each row.
- They use the OVER() clause.
- Example:
    ```
    SELECT empno,
        ename,
        sal,
        AVG(sal) OVER() AS avg_salary
    FROM emp
    ;

    Output:
    -------
    EMPNO	ENAME	SAL	    AVG_SALARY
    7369	SMITH	800	    2073
    7499	ALLEN	1600	2073
    ```
- Every row gets the overall average salary.

### 2. Difference between GROUP BY and Analytical Functions?
##### GROUP BY
- Combines rows into one row per group.
- Reduces number of rows.
- Example:
    ```
    SELECT deptno, AVG(sal)
    FROM emp
    GROUP BY deptno;

    Output:
    -------
    DEPTNO AVG(SAL)
    10     2916
    20     2175
    30     1566
    ```
#### Analytical Function
- Adds calculated values to every row.
- Does not reduce rows.
- Example :
    ```
    SELECT ename,
        deptno,
        sal,
        AVG(sal) OVER(PARTITION BY deptno)
    FROM emp;

    Output:
    -------
    ENAME   DEPTNO SAL  AVG
    SMITH   20     800  2175
    JONES   20     2975 2175
    ```

### 3. What is the difference between RANK(), DENSE_RANK(), and ROW_NUMBER()?
| ROW_NUMBER() | RANK() | DENSE_RANK() |
|------------- | ------ | ------------ |
| Assigns a unique number to each row. | Assigns the same rank to duplicate values. | Assigns the same rank to duplicate values. |
| Duplicate values receive different numbers. | Duplicate values receive the same rank. | Duplicate values receive the same rank. |
| No gaps in numbering. | Skips the next rank after duplicates. | Does not skip the next rank after duplicates. |
| SELECT ename, sal, ROW_NUMBER() OVER(ORDER BY sal DESC) rn FROM emp; | SELECT empno, deptno, Sal, RANK() OVER(PARTITION BY deptno ORDER BY Sal) "rank" FROM emp; | SELECT empno, deptno, Sal, DENSE_RANK() OVER(PARTITION BY deptno ORDER BY Sal) AS rnk FROM emp; |
### 4. Find the second highest salary in employee table using Analytical Function
```
SELECT * FROM
(
    SELECT ename,
           sal,
           DENSE_RANK() OVER(ORDER BY Sal DESC) rnk
    FROM emp
)
WHERE rnk = 2
;

Output:
-------
ENAME             SAL        RNK
SCOTT            3000          2
FORD             3000          2
```
### 5. Difference between PARTITION BY and GROUP BY?
#### GROUP BY
- `GROUP BY` groups rows into a single row per group and is used with aggregate functions.
- It reduces the number of rows.
- Example :
```
SELECT deptno,
       MAX(Sal) AS max_salary
FROM emp
GROUP BY deptno;

Output:
-------
DEPTNO   MAX_SALARY
  30       2850
  20       3000
  10       5000
```
#### PARTITION BY
- `PARTITION BY` divides rows into partitions for window functions while keeping all rows
- It is used with window (analytic) functions inside the OVER() clause.
- It does not reduce rows
- Example :
```
SELECT deptno,
        ename,
        Sal,
        MAX(Sal) OVER(PARTITION BY deptno) AS max_salary
    FROM emp;

Output:
-------
DEPTNO	ENAME	SAL	MAX_SALARY
10	    CLARK	2450	5000
10	    KING	5000	5000
20	    SMITH	800	3000
20	    SCOTT	3000	3000
30	    ALLEN	1600	2850
30	    BLAKE	2850	2850
```
### 6. Find highest salary of employee in each department
```
SELECT * FROM
(
    SELECT ename,
           deptno,
           sal,
           RANK() OVER(
            PARTITION BY deptno ORDER BY sal DESC
           ) rnk
        FROM emp
)
WHERE rnk = 1
;

Output:
------
ENAME    DEPTNO   SAL     RNK
KING     10       5000    1
SCOTT    20       3000    1
FORD     20       3000    1
BLAKE    30       2850    1
```
### 7. Difference between LAG and LEAD?
- `LAG()` function returns previous row value.
- `LEAD()` function returns next row value.
- Example :
```
SELECT ename,
       sal,
       LAG(sal) OVER(ORDER BY empno) previous_salary,
       LEAD(sal) OVER(ORDER BY empno) next_salary
    FROM EMP;

Output:
-------
ENAME	SAL	PREVIOUS_SALARY	NEXT_SALARY
SMITH	800	   NULL	            1600
ALLEN	1600	800	            1250
WARD	1250	1600	        2975
JONES	2975	1250	        1250
MARTIN	1250	2975	        2850
BLAKE	2850	1250	        2450
CLARK	2450	2850	        5000
KING	5000	2450	        NULL
```
### 8. Find duplicate records using Analytical Function
```
SELECT * FROM
(
    SELECT e.*,
           COUNT(*) OVER(PARTITION BY ename) cnt
        FROM emp e
)
WHERE cnt > 1;
```
### 9. Find top 3 salaries in each department.
```
SELECT * FROM
(
    SELECT ename,
           sal,
           deptno,
           DENSE_RANK() OVER(
            PARTITION BY deptno ORDER BY sal DESC
           ) rnk
        FROM emp
)
WHERE rnk <= 3;

Output:
-------
ENAME             SAL     DEPTNO        RNK
---------- ---------- ---------- ----------
KING             5000         10          1
CLARK            2450         10          2
MILLER           1300         10          3
SCOTT            3000         20          1
FORD             3000         20          1
JONES            2975         20          2
ADAMS            1100         20          3
BLAKE            2850         30          1
ALLEN            1600         30          2
TURNER           1500         30          3
```

#### ROLLUP
- ROLLUP is an extension of the GROUP BY clause that generates subtotals and a grand total automatically.
- Instead of writing multiple GROUP BY queries with UNION, you can use ROLLUP.
- Example :
```
SELECT deptno,
       job,
       SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno, job)
;

Output:
------
DEPTNO      JOB         SUM(SAL)
---------- --------- ----------
        10 CLERK           1300
        10 MANAGER         2450
        10 PRESIDENT       5000
        10                 8750
        20 CLERK           1900
        20 ANALYST         6000
        20 MANAGER         2975
        20                10875
        30 CLERK            950
        30 MANAGER         2850
        30 SALESMAN        5600
        30                 9400
                          29025
```
#### CUBE
- CUBE is an extension to ROLLUP.
- It generates subtotals and a grand totals for all the possible combinations
```
SELECT deptno,
       job,
       SUM(sal) AS Total
    FROM emp
    GROUP BY CUBE(deptno, job)
    ORDER BY deptno, job
;

Output:
-------

    DEPTNO JOB            TOTAL
---------- --------- ----------
        10 CLERK           1300
        10 MANAGER         2450
        10 PRESIDENT       5000
        10                 8750
        20 ANALYST         6000
        20 CLERK           1900
        20 MANAGER         2975
        20                10875
        30 CLERK            950
        30 MANAGER         2850
        30 SALESMAN        5600
        30                 9400
           ANALYST         6000
           CLERK           4150
           MANAGER         8275
           PRESIDENT       5000
           SALESMAN        5600
                          29025
```
