## Analytical Functions:
------------------------
- Analytical (Window) Functions perform calculations across a group of rows related to the current row without grouping the rows into a single result.
- Unlike aggregate functions (SUM, AVG, COUNT), analytical functions return a value for every row.

### Types of Analytical Functions:
1. **Avg** :
- The Avg function returns the average value of expression.
- Example :
```
SELECT empno, deptno, sal, AVG(Sal) OVER() AS avg_of_current_sal
FROM emp
;

SELECT empno,
       deptno,
       Sal,
       (SELECT Avg(Sal) from emp) AS avg_sal
FROM emp
;
```
```
SELECT empno,
       deptno,
       sal,
       AVG(Sal) OVER(PARTITION BY deptno ORDER BY deptno) AS avg_of_current_sal
FROM emp
;
```
2. **SUM** :
- The Sum function returns the sum value of an expression
- Example :
```
SELECT empno, deptno, sal, SUM(Sal) OVER() AS sum_of_current_sal
FROM emp
;
```
```
SELECT empno,
       deptno,
       sal,
       SUM(Sal) OVER(PARTITION BY deptno ORDER BY deptno) AS sum_of_current_sal
FROM emp
;
```
3. **MIN** :
- The Min function returns the minimum value of an expression
- Example :
```
SELECT empno, deptno, sal, MIN(Sal) OVER() AS min_of_current_sal
FROM emp
;
```
```
SELECT empno,
       deptno,
       sal,
       MIN(Sal) OVER(PARTITION BY deptno ORDER BY deptno) AS min_of_current_sal
FROM emp
;
```
4. **MAX** :
- The Max function returns the maximum value of an expression
- Example :
```
SELECT empno, deptno, sal, MAX(Sal) OVER() AS max_of_current_sal
FROM emp
;
```
```
SELECT empno,
       deptno,
       sal,
       MAX(Sal) OVER(PARTITION BY deptno ORDER BY deptno) AS max_of_current_sal
FROM emp
;
```
5. **COUNT(*)** :
- The Count function returns the number of rows in a query.
- Example :
```
SELECT empno, deptno, sal, COUNT(*) OVER() AS count
FROM emp
;
```
```
SELECT empno,
       deptno,
       sal,
       COUNT(*) OVER(PARTITION BY deptno ORDER BY deptno) AS count
FROM emp
;
```
6. **RANK** :
- RANK() is an analytical function that assigns a rank to rows based on the ORDER BY clause. Rows with equal values receive the same rank, and the next rank is skipped. It is commonly used to find the highest, second-highest, or nth-highest values in a dataset.
- Example :
```
SELECT empno,
       deptno,
       Sal,
       RANK() OVER( ) "rank"
FROM emp
WHERE deptno = 30
;

SELECT empno,
       deptno,
       Sal,
       RANK() OVER( ORDER BY Sal) "rank"
FROM emp
WHERE deptno = 30
;

SELECT empno,
       deptno,
       Sal,
       RANK() OVER( ORDER BY Sal DESC) "rank"
FROM emp
WHERE deptno = 30
;
```
```
SELECT empno,
       deptno,
       Sal,
       RANK() OVER( PARTITION BY deptno ORDER BY Sal) "rank"
FROM emp
;

SELECT empno,
       deptno,
       Sal,
       RANK() OVER( PARTITION BY ORDER BY Sal DESC) "rank"
FROM emp
;

SELECT * FROM (
    SELECT empno,
       deptno,
       Sal,
       RANK() OVER( PARTITION BY deptno ORDER BY Sal DESC) rnk
    FROM emp )
WHERE rnk = 1
;
```
7. **DENSE_RANK** :
- The DENSE_RANK function acts like the RANK function except that it assigns consecutive ranks.
- Same values get the same rank, but no ranks are skipped.
- Example :
```
SELECT empno,
       deptno,
       Sal,
       DENSE_RANK() OVER(ORDER BY Sal) AS rnk
FROM emp
;

SELECT empno,
       deptno,
       Sal,
       DENSE_RANK() OVER(ORDER BY Sal) AS rnk
FROM emp
WHERE deptno = 30
;

SELECT empno,
       deptno,
       Sal,
       DENSE_RANK() OVER(PARTITION BY deptno ORDER BY Sal DESC) AS rnk
FROM emp
;

SELECT * FROM (
        SELECT empno,
              deptno,
              Sal,
              DENSE_RANK() OVER(ORDER BY Sal) sal_rnk
        FROM emp)
WHERE sal_rnk = 1
;
```
8. **LISTAGG** :
- The `LISTAGG` analytic function was introduced in Oracle 11g Release, making it very easy to aggregate strings.
- LISTAGG() is an aggregate function that combines multiple row values into a single string, separated by a delimiter (such as a comma).
- It is commonly used to display multiple values in one row.
- This function is it also allows us to order the elements in the concatenated list.
- Example :
```
SELECT deptno,
       LISTAGG(ename, ',') WITHIN GROUP (ORDER BY ename) AS employees
FROM emp
GROUP BY deptno
;

SELECT deptno,
    ename,
    hiredate,
    LISTAGG(ename, ',')
    WITHIN GROUP (ORDER BY ename)
    OVER (PARTITION BY deptno) AS employees
FROM emp
;
```
9. **WM_CONCAT** :
- This function is used to aggregate strings
- It is actually an example of a user defined aggregate function.
- Example :
```
SELECT deptno,
    wm_concat(ename) as employees
FROM emp
GROUP BY deptno
;
```
#### Difference between `wm_concat` and `list_agg` :
1. wm_concat is undocumented and unsupported by orance, thsus rendering production systems unsupported. listagg is documented and supported by oracle.
2. wm_concat allows distinct option. listagg does not allow it.
    ```SELECT wm_concat(distinct ename) AS enames FROM emp;
    ```
3. listagg allows to decide string concat order. wm_concat does not allows it.
    ```
    SELECT listagg(ename, ',')
    WITHIN GROUP( ORDER BY empno desc)
    AS enames
    FROM emp
    ;
    ```
4. listagg allows to decide delimiter. wm_concat does not allows it.
    ```
    SELECT listagg(ename, '****') WITHIN GROUP (ORDER BY empno DESC) AS enames
    FROM emp
    ;
    ```
5. Listagg will support max length of 4000 bytes only i.e varchar2 length.

---------------------------------------
10. **ROLLUP**:
- ROLLUP is an extension of the GROUP BY clause that generates subtotals and a grand total automatically.
- Instead of writing multiple GROUP BY queries with UNION, you can use ROLLUP.
- Example :
```
SELECT deptno,
       SUM(sal)
FROM emp
GROUP BY deptno
;

SELECT deptno,
       SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno)
;
```
```
SELECT deptno,
       job,
       SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno, job)
;
```
```
SELECT NVL(to_char(deptno), 'Grand Total') deptno, nvl(ename, 'subtotal') ename, sum(sal) Sal
FROM emp
GROUP By ROLLUP(deptno, ename)
;
```
11. **CUBE** :
- CUBE is an extension to ROLLUP.
```
SELECT deptno,
       job,
       SUM(sal) AS Total
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job
;
```
```
SELECT nvl(to_char(deptno), 'grandtotal') deptno, nvl(ename, 'subtotal') ename, sum(Sal) Sal
FROM emp
group by cube(deptno, ename)
;
```
12. **GROUPING** :
- It accepts a column and returns either 0 or 1
- Returns 1 when column value is NULL and 0 when the column value is NOT NULL
- This function can be used only upon the queries which that used ROLLUP or CUBE.
- Example :
```
SELECT deptno, GROUPING(deptno), job, SUM(Sal)
FROM emp
GROUP BY CUBE(deptno, job);

SELECT deptno, GROUPING(job), job, SUM(Sal)
FROM emp
GROUP BY CUBE(deptno, job);
```
13.**DECODE** :
- The DECODE function is analogus to the `If THEN ELSE` conditional statement.
- DECODE works with values, columns, and expressions of all data types.
- Example :
    - Simple :
        ```
        SELECT DECODE(NULL, NULL, 'EQUAL', 'NOT EQUAL') FROM DUAL;
        ```
    - Complex :
        ```
        SELECT EMPNO, DEPTNO,
               DECODE(DEPTNO,
                            10, 'ACCOUNTING',
                            20, 'RESEARCH',
                            30, 'SALES',
                            40, 'OPERATIONS') DNAME
        FROM emp
        ;
        ```

#### Convert Rows into Columns
```
SELECT TO_CHAR(Hiredate, 'YYYY') Year, COUNT(*) EmpCnt
    FROM emp
    GROUP BY ROLLUP(TO_CHAR(Hiredate, 'YYYY'));
```
```
SELECT SUM(DECODE(TO_CHAR(Hiredate, 'YYYY'), 1980, 1, 0)) "1980",
       SUM(DECODE(TO_CHAR(Hiredate, 'YYYY'), 1981, 1, 0)) "1981",
       SUM(DECODE(TO_CHAR(Hiredate, 'YYYY'), 1982, 1, 0)) "1982",
       SUM(DECODE(TO_CHAR(Hiredate, 'YYYY'), 1983, 1, 0)) "1983",
       COUNT(*) Total
FROM emp
;
```
14. **CASE** :
- The CASE expression was first added to SQL on Oracle8i. Oracle9i extends its support to Pl/SQL.
- There are two types of case expressions are there
    1. Value Match Case
    2. Searched Case

    1. `Value Match Case` :
        - The CASE expression is a more flecible version of the DECODE function. In its simplest form it is used to return a value when a match is found.
        - Example :
        ```
        SELECT ename, empno,
            (CASE deptno
                WHEN 10 THEN 'ACCOUNTING'
                WHEN 20 THEN 'RESEARCH'
                WHEN 30 THEN 'SALES'
                WHEN 40 THEN'OPERATIONS'
                ELSE 'Unknown'
            END) department
        FROM emp
        ORDER BY ename
        ;
        ```
    2. Searched Case :
        - A more complex version is th eSearched CASE expression where a comparison expression is used to find a match.
        - In this form the comparison is not limited to a single column.
        - Example :
        ```
        SELECT ename, empno,
            (CASE
                WHEN sal < 1000 THEN 'Low'
                WHEN sal BETWEEN 1000 AND 3000 THEN 'Medium'
                WHEN sal > 3000 THEN 'High'
                ELSE 'N/A'
            END) salary
        FROM emp
        ORDER BY ename
        ;
        ```