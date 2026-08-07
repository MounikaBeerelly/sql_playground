### 1. What is the difference between `CHAR` and `VARCHAR2`?
- `CHAR` is a fixed-length datatype. It always stores the full defined length by padding extra spaces if needed.
- `VARCHAR2` is a variable-length datatype. It stores only the actual data without padding, making it more storage efficient for values of varying lengths.

## JOINS :
### 1. What is a JOIN?
- A JOIN is used to combine rows from two or more tables based on a related column.
- Example :
    ```
    SELECT e.ename, d.dname
    FROM emp e
    JOIN dept d
    ON e.deptno = d.deptno
    ;

    Output:
    =======
    ENAME      DNAME
    --------   ----------
    SMITH      RESEARCH
    ALLEN      SALES
    WARD       SALES
    JONES      RESEARCH
    MARTIN     SALES
    BLAKE      SALES
    CLARK      ACCOUNTING
    SCOTT      RESEARCH
    KING       ACCOUNTING
    TURNER     SALES
    ADAMS      RESEARCH
    JAMES      SALES
    FORD       RESEARCH
    MILLER     ACCOUNTING
    ```
- Types of Joins are :
    - Inner Join
    - Left Outer Join
    - Right Outer Join
    - Full Outer Join
    - Cross Join
    - Self Join
    - Natural Join
### 2. Difference between INNER JOIN and OUTER JOIN?
- Inner Join returns only matching records in both tables
    ```
    SELECT ename, dept.deptno, dname, loc
    FROM emp inner join dept
    On emp.deptno = dept.deptno;

    Output:
    =======
    ENAME          DEPTNO DNAME          LOC
    ---------- ---------- -------------- ----------
    SMITH              20 RESEARCH       DALLAS
    ALLEN              30 SALES          CHICAGO
    WARD               30 SALES          CHICAGO
    JONES              20 RESEARCH       DALLAS
    MARTIN             30 SALES          CHICAGO
    BLAKE              30 SALES          CHICAGO
    CLARK              10 ACCOUNTING     NEW YORK
    SCOTT              20 RESEARCH       DALLAS
    KING               10 ACCOUNTING     NEW YORK
    TURNER             30 SALES          CHICAGO
    ADAMS              20 RESEARCH       DALLAS
    JAMES              30 SALES          CHICAGO
    FORD               20 RESEARCH       DALLAS
    MILLER             10 ACCOUNTING     NEW YORK
    ```
- Left Join returns all rows from left table
    ```
    SELECT ename, dept.deptno, dname, loc
    FROM emp left join dept
    ON emp.deptno = dept.deptno ;

    Output:
    =======
    ENAME          DEPTNO DNAME          LOC
    ---------- ---------- -------------- -------------
    MILLER             10 ACCOUNTING     NEW YORK
    KING               10 ACCOUNTING     NEW YORK
    CLARK              10 ACCOUNTING     NEW YORK
    FORD               20 RESEARCH       DALLAS
    ADAMS              20 RESEARCH       DALLAS
    SCOTT              20 RESEARCH       DALLAS
    JONES              20 RESEARCH       DALLAS
    SMITH              20 RESEARCH       DALLAS
    JAMES              30 SALES          CHICAGO
    TURNER             30 SALES          CHICAGO
    BLAKE              30 SALES          CHICAGO
    MARTIN             30 SALES          CHICAGO
    WARD               30 SALES          CHICAGO
    ALLEN              30 SALES          CHICAGO
    ```
- Right join returns all rows from right table
    ```
    SELECT ename, dept.deptno, dname, loc
    FROM emp RIGHT JOIN dept
    ON emp.deptno = dept.deptno ;

    Output:
    =======
    ENAME          DEPTNO DNAME          LOC
    ---------- ---------- -------------- -------------
    SMITH              20 RESEARCH       DALLAS
    ALLEN              30 SALES          CHICAGO
    WARD               30 SALES          CHICAGO
    JONES              20 RESEARCH       DALLAS
    MARTIN             30 SALES          CHICAGO
    BLAKE              30 SALES          CHICAGO
    CLARK              10 ACCOUNTING     NEW YORK
    SCOTT              20 RESEARCH       DALLAS
    KING               10 ACCOUNTING     NEW YORK
    TURNER             30 SALES          CHICAGO
    ADAMS              20 RESEARCH       DALLAS
    JAMES              30 SALES          CHICAGO
    FORD               20 RESEARCH       DALLAS
    MILLER             10 ACCOUNTING     NEW YORK
                       40 OPERATIONS     BOSTON
    ```
- Full join returns all the records
    ```
    SELECT ename, dept.deptno, dname, loc
    FROM emp FULL JOIN dept
    ON emp.deptno = dept.deptno ;

    Output:
    =======
    ENAME          DEPTNO DNAME          LOC
    ---------- ---------- -------------- -------------
    SMITH              20 RESEARCH       DALLAS
    ALLEN              30 SALES          CHICAGO
    WARD               30 SALES          CHICAGO
    JONES              20 RESEARCH       DALLAS
    MARTIN             30 SALES          CHICAGO
    BLAKE              30 SALES          CHICAGO
    CLARK              10 ACCOUNTING     NEW YORK
    SCOTT              20 RESEARCH       DALLAS
    KING               10 ACCOUNTING     NEW YORK
    TURNER             30 SALES          CHICAGO
    ADAMS              20 RESEARCH       DALLAS
    JAMES              30 SALES          CHICAGO
    FORD               20 RESEARCH       DALLAS
    MILLER             10 ACCOUNTING     NEW YORK
                       40 OPERATIONS     BOSTON
    ```
### 3. Difference between JOIN and UNION?
| JOIN               | UNION                     |
| ------------------ | ------------------------- |
| Combines columns   | Combines rows             |
| Needs relationship | Doesn't need relationship |
| Horizontal merge   | Vertical merge            |
### 4. Difference between JOIN and SUBQUERY?
| JOIN                     | Subquery                           |
| ------------------------ | ---------------------------------- |
| Combines multiple tables | Query inside another query         |
| Usually faster           | Used for filtering or calculations |
### 5. What is SELF JOIN?
- Joining a table with itself.
- Example:
    ```
    SELECT e.ename Employee,
        m.ename Manager
    FROM emp e
    LEFT JOIN emp m
    ON e.mgr = m.empno;

    Output:
    =======
    EMPLOYEE   MANAGER
    ---------- ----------
    FORD       JONES
    SCOTT      JONES
    JAMES      BLAKE
    TURNER     BLAKE
    MARTIN     BLAKE
    WARD       BLAKE
    ALLEN      BLAKE
    MILLER     CLARK
    ADAMS      SCOTT
    CLARK      KING
    BLAKE      KING
    JONES      KING
    SMITH      FORD
    KING
    ```
### 6. What is Equi Join?
- If there is a common column between two tables, join those tables with `=` operator.
    ```
    SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    ```
### 7. What is Non-Equi Join?
- We don't have common column between two tables, but data is same. Use non-equi joins to merge tables.
- A Non-Equi Join is a join that uses a non-equality operator in the condition: (>, <, >=, <=, BETWEEN, etc.)
- These joins are used when tables are related by ranges rather than exact matches.
     ```
     select empno,ename,sal,grade
     from emp, salgrade
     where sal between losal and hisal;
     ```
### 8. How do you find employees without departments?
```
SELECT e.*
FROM emp e
LEFT JOIN dept d
ON e.deptno=d.deptno
WHERE d.deptno IS NULL;
```
### 9. Find departments with no employees.
```
SELECT d.*
FROM dept d
LEFT JOIN emp e
ON d.deptno=e.deptno
WHERE e.empno IS NULL;
```
### 10. How do you display employee names with their manager names?
    ```
    SELECT e.ename AS emp_name,
        m.ename AS mng_name
    FROM emp e
    LEFT JOIN emp m
    ON e.mgr = m.empno;

    Output:
    =======
    EMP_NAME   MNG_NAME
    ---------- ----------
    FORD       JONES
    SCOTT      JONES
    JAMES      BLAKE
    TURNER     BLAKE
    MARTIN     BLAKE
    WARD       BLAKE
    ALLEN      BLAKE
    MILLER     CLARK
    ADAMS      SCOTT
    CLARK      KING
    BLAKE      KING
    JONES      KING
    SMITH      FORD
    KING
    ```
### 11. Find employees earning more than their managers.
    ```
    SELECT e.ename AS empname,
           e.sal AS empSal,
           m.ename AS mgrName,
           m.sal AS mgrSal
    FROM emp e
    LEFT JOIN emp m
    ON e.mgr = m.empno
    WHERE e.sal > m.sal ;

    Output:
    =======
    EMPNAME        EMPSAL MGRNAME        MGRSAL
    ---------- ---------- ---------- ----------
    FORD             3000 JONES            2975
    SCOTT            3000 JONES            2975
    ```
### 12. Find the maximum number of employees in each department.
    ```
    SELECT d.dname,
           COUNT(*) AS totalEmployees
    FROM emp e
    JOIN dept d
    ON e.deptno = d.deptno
    GROUP BY d.dname
    ORDER BY totalEmployees DESC
    ```
### 13. Display employees along with salary grade
    ```
    SELECT e.ename,
           e.Sal,
           s.grade
    FROM emp e
    JOIN salgrade s
    ON e.sal BETWEEN s.losal AND s.hisal;

    Output:
    =======
    ENAME             SAL      GRADE
    ---------- ---------- ----------
    SMITH             800          1
    ADAMS            1100          1
    JAMES             950          1
    WARD             1250          2
    MARTIN           1250          2
    MILLER           1300          2
    ALLEN            1600          3
    TURNER           1500          3
    JONES            2975          4
    BLAKE            2850          4
    CLARK            2450          4

    ENAME             SAL      GRADE
    ---------- ---------- ----------
    SCOTT            3000          4
    FORD             3000          4
    KING             5000          5
    ```
### 14. Find employees who do not have a manager.
    ```
    SELECT ename
    FROM emp
    WHERE mgr IS NULL;

    Output:
    =======
    ENAME
    ----------
    KING
    ```
### 15. List each employee with their department name and manager name.
    ```
    SELECT e.ename empName,
           d.dname deptName,
           m.ename mgrName
    FROM emp e
    JOIN dept d
        ON e.deptno = d.deptno
    LEFT JOIN emp m
        ON e.mgr = m.empno;

    OUTPUT:
    =======
    EMPNAME    DEPTNAME       MGRNAME
    ---------- -------------- ----------
    FORD       RESEARCH       JONES
    SCOTT      RESEARCH       JONES
    JAMES      SALES          BLAKE
    TURNER     SALES          BLAKE
    MARTIN     SALES          BLAKE
    WARD       SALES          BLAKE
    ALLEN      SALES          BLAKE
    MILLER     ACCOUNTING     CLARK
    ADAMS      RESEARCH       SCOTT
    CLARK      ACCOUNTING     KING
    BLAKE      SALES          KING
    JONES      RESEARCH       KING
    SMITH      RESEARCH       FORD
    KING       ACCOUNTING
    ```

## SubQueries;
### 1. What is a subquery?
- A subquery is a query written inside another SQL statement.
- It is enclosed within parentheses and executes before the outer query.
- Example
    ```
    SELECT ename
    FROM emp
    WHERE sal >
    (
        SELECT AVG(sal)
        FROM emp
    );
    ```
### 2. What are the different types of subqueries?
1. Single-row subquery
    - Returns only one row
    - Use operators like =, <=, >=, <>
    - Example
        ```
        SELECT ename
        FROM emp
        WHERE deptno =
        (
            SELECT deptno
            FROM dept
            WHERE dname='SALES'
        );
        ```
2. Multiple-row subquery
    - Returns multiple rows.
    - Use operators like: IN, ANY, ALL, EXISTS
    - Example :
        ```
        SELECT ename
        FROM emp
        WHERE deptno IN
        (
            SELECT deptno
            FROM dept
            WHERE loc='NEW YORK'
        );
        ```
3. Multiple-column subquery
4. Correlated subquery
5. Nested subquery
    - A subquery inside another subquery.
    - Example
        ```
        SELECT ename
        FROM emp
        WHERE deptno =
        (
            SELECT deptno
            FROM dept
            WHERE loc =
            (
                SELECT loc
                FROM dept
                WHERE dname='ACCOUNTING'
            )
        );
        ```
### 3. What happens if a single-row subquery returns multiple rows?
- Oracle throws
    ```
    ORA-01427:
    single-row subquery returns more than one row
    ```
- Example
    ```
    SELECT *
    FROM emp
    WHERE deptno =
    (
        SELECT deptno
        FROM dept
    );
    ```
### 4. Find employees earning more than the average salary of their department.
```
SELECT e1.ename,
       e1.deptno,
       e1.sal
FROM emp e1
WHERE e1.sal >
(
    SELECT AVG(e2.sal)
        FROM emp e2
    WHERE e1.deptno = e2.deptno
);

Output:
=======
ENAME          DEPTNO        SAL
---------- ---------- ----------
ALLEN              30       1600
JONES              20       2975
BLAKE              30       2850
SCOTT              20       3000
KING               10       5000
FORD               20       3000
```
### 5. Find departments that have no employees.
```
SELECT *
FROM dept d
WHERE NOT EXISTS
(
   SELECT 1
   FROM emp e
   WHERE e.deptno = d.deptno
);

OUTPUT:
-------
    DEPTNO DNAME          LOC
---------- -------------- -------------
        40 OPERATIONS     BOSTON
```


## Objects:
### 1. What are SQL Objects?
- SQL objects are database structures used to store, organize, retrieve, and manipulate data.
- Examples:
    - Tables
    - Views
    - Indexes
    - Sequences
    - Synonyms
    - Constraints
### 2. What is a View?
- A View is a virtual table based on the result of a SQL query. It does not store data itself (except for materialized views). It stores only the SQL statement.
- **Advantages** :
    - Security - Hide sensitive columns.
    - Simplify Complex Queries - Instead of writing joins repeatedly
    - Data Abstraction - If the base table changes, applications can continue using the view
- **Types** :
    1. `Simple View`
        - Based on one table
        - No GROUP BY
        - No aggregate functions
        - Can usually perform:
            - INSERT
            - UPDATE
            - DELETE
    2. `Complex View`
        - Multiple tables
        - Joins
        - GROUP BY
        - Aggregate functions
        - DISTINCT
### 3. Can we insert into a View?
- Yes, if the view is simple we can insert data.
- If the view contains `GROUP BY, DISTINCT, Aggregate functions, JOIN (sometimes), UNION` then generally it is not updatable.
### 4. What is an Index?
- An index is a database object that stores the indexed column values and their corresponding ROWIDs to speed up data retrieval.
- It improves the performance
- Types of Indexes :
    1. Simple/Normal Index
    2. Unique Index
    3. Composite/Composite Unique Index
    4. Function based Index
### 5. What is a Sequence ?
 - A sequence is a database object that automatically generates unique numeric values, most commonly used to assign primary key values.
### 6. Difference between NEXTVAL and CURRVAL
| NEXTVAL | CURRVAL |
| ------- | ------- |
| Generates next value | Returns current generated value. Cannot use before NEXTVAL |
### 7. What is a Synonym?
- A synonym is an alias for a database object.
- Example
    ```
    CREATE SYNONYM emp_syn
    FOR emp;
    ```
- Types of Synonyms
    1. Private Synonym : Visible only to owner.
    2. Public Synonym : Visible to all the users
### 8. Can we create a View without a Table?
No. The base table must exist.
### 9. Can we create a Synonym without a Table?
No. Target object must exist.
### 10. Can we insert into a Synonym?
Yes. A synonym is just another name.

## Hierarchical Queries
### 1. What is a Hierarchical Query?
- A hierarchical query retrieves data organized in a tree-like structure (parent-child relationship).
- Examples:
    - Employee → Manager
    - Folder → Subfolder
    - Category → Subcategory
### 2. What is START WITH?
It specifies the root row.
### 3. What is CONNECT BY?
Defines the parent-child relationship
### 4. What does PRIOR mean?
PRIOR refers to the parent row.
### 5. Reverse Hierarchy
Display employees from child to parent
### 6. What is LEVEL?
Defines the hierarchy level
### 7. Display Hierarchy with Indentation
```
SELECT LPAD(' ', (LEVEL-1)*4) || ename Employee
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;

Output
------
KING
    JONES
        SCOTT
        FORD
            SMITH
    BLAKE
```
### 8. What is CONNECT_BY_ROOT?
Returns the root node.
### 9. What is SYS_CONNECT_BY_PATH?
Returns the complete hierarchy path.
### 10. Find all employees under JONES
```
SELECT ename
FROM emp
START WITH ename = 'JONES'
CONNECT BY PRIOR empno = mgr;

Output:
-------
ENAME
----------
JONES
SCOTT
ADAMS
FORD
SMITH
```
### 11. Find Manager Chain of SMITH
```
SELECT ename
FROM emp
START WITH ename = 'SMITH'
CONNECT BY PRIOR mgr = empno;

Output:
-------
ENAME
----------
SMITH
FORD
JONES
KING
```
### 12. Count Employees Under Each Manager
```
SELECT manager,
       COUNT(*) - 1 AS total_employees
FROM (
    SELECT CONNECT_BY_ROOT ename AS manager
    FROM emp
    START WITH mgr IS NULL
    CONNECT BY PRIOR empno = mgr
)
GROUP BY manager;

Output:
-------
MANAGER    TOTAL_EMPLOYEES
---------- ---------------
KING                    13
```
### 13. Find the hierarchy path for every employee.
```
SELECT ename,
       SYS_CONNECT_BY_PATH(ename,'/') AS Path
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;

Output:
-------

ENAME      PATH
---------------------------------------------
KING       /KING
JONES      /KING/JONES
SCOTT      /KING/JONES/SCOTT
ADAMS      /KING/JONES/SCOTT/ADAMS
FORD       /KING/JONES/FORD
SMITH      /KING/JONES/FORD/SMITH
BLAKE      /KING/BLAKE
ALLEN      /KING/BLAKE/ALLEN
WARD       /KING/BLAKE/WARD
MARTIN     /KING/BLAKE/MARTIN
TURNER     /KING/BLAKE/TURNER
JAMES      /KING/BLAKE/JAMES
CLARK      /KING/CLARK
MILLER     /KING/CLARK/MILLER

```
### 14. Find employees who don't manage anyone.
```
SELECT ename
FROM emp
WHERE CONNECT_BY_ISLEAF = 1
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;

Output:
-------
ENAME
----------
ADAMS
SMITH
ALLEN
WARD
MARTIN
TURNER
JAMES
MILLER
```
### 15. Display the manager chain for employee FORD
```
SELECT ename
FROM emp
START WITH ename='FORD'
CONNECT BY PRIOR mgr = empno;

Output:
-------
ENAME
----------
FORD
JONES
KING
```

## Pseudo Columns
### 1. What are pseudocolumns in Oracle?
- Pseudocolumns are special columns provided by Oracle. They behave like table columns but are not physically stored in the table.
- Examples:
    - ROWID
    - ROWNUM
    - LEVEL
    - NEXTVAL
    - CURRVAL
### 2. What is the difference between a column and a pseudocolumn?
| Column                  | Pseudocolumn                  |
| ----------------------- | ----------------------------- |
| Physically stored       | Not stored physically         |
| Can be inserted/updated | Cannot be inserted or updated |
| Defined by user         | Generated by Oracle           |
| Occupies storage        | Doesn't occupy storage        |
### 3. What is ROWNUM?
- ROWNUM assigns numbers to rows as Oracle retrieves them.
- ROWNUM is assigned before ORDER BY.
- Example
    ```
    SELECT ROWNUM, ename
    FROM emp;

    Output
    -------
    ROWNUM ENAME
    ------ -----
    1      SMITH
    2      ALLEN
    3      WARD
    ```
### 4. Why does this query return no rows?
    ```
    SELECT *
    FROM emp
    WHERE ROWNUM > 5;
    ```
- ROWNUM starts with 1.
- Oracle checks the first row:
- ROWNUM = 1  => 1 > 5 → False
- Since no row qualifies, Oracle never assigns ROWNUM 2, 3, etc.
- Hence 0 rows
### 5. How do you fetch the first 5 rows?
    ```
    SELECT *
    FROM emp
    WHERE ROWNUM <= 5;
    ```
### 6. How do you fetch the highest-paid employee using ROWNUM?
    ```
    SELECT *
    FROM (
        SELECT *
        FROM emp
        ORDER BY sal DESC
    )
    WHERE ROWNUM = 1;
    ```
### 7.What is ROWID?
- ROWID uniquely identifies the physical location of a row.
- It contains
    - Data Object Number
    - File Number
    - Block Number
    - Row Number
- ROWID can change when we alter or move table
- It can be useful for
    - Fastest row access
    - Removing duplicates
    - Troubleshooting
### 8. What is LEVEL?
- LEVEL is used in hierarchical queries to show the level.
### 9. Fetch the top 3 highest-paid employees using ROWNUM
```
SELECT *
FROM (
    SELECT *
    FROM emp
    ORDER BY sal DESC
)
WHERE ROWNUM <= 3;
```
### 10. Find employees at Level 3
```
SELECT LEVEL,
       ename
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr
WHERE LEVEL = 3;
```
### 11. Display the hierarchy with levels.
```
SELECT LPAD(' ', LEVEL*3) || ename Employee
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;

Output:
-------
EMPLOYEE
---------------------
   KING
      JONES
         SCOTT
            ADAMS
         FORD
            SMITH
      BLAKE
         ALLEN
         WARD
         MARTIN
         TURNER
         JAMES
      CLARK
         MILLER
```