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
    EMPNO	ENAME	SAL	AVG_SALARY
    7369	SMITH	800	2073
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

    DEPTNO AVG(SAL)
    10     2916
    20     2175
    30     1566
    ```
#### Analytical Function
- Does not reduce rows.
- Adds calculated values to every row.
- Example :
    ```
    SELECT ename,
        deptno,
        sal,
        AVG(sal) OVER(PARTITION BY deptno)
    FROM emp;

    Output:

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


