### 1. What is the difference between `CHAR` and `VARCHAR2`?
- `CHAR` is a fixed-length datatype. It always stores the full defined length by padding extra spaces if needed.
- `VARCHAR2` is a variable-length datatype. It stores only the actual data without padding, making it more storage efficient for values of varying lengths.


## Objects:
-----------------
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
```