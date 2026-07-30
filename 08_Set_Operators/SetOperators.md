## Set Operators
- Combining/Merging the rows (actual data) into single set.
- **Syntax:**
```
    SELECT ColumnName
       FROM TableName
    WHERE ColumnName = Condition
    <SET OPERATOR>
    SELECT ColumnName
       FROM TableName
    WHERE ColumnName = Condition
    ;
```
- **Rules and Restrictions**
    - Result set of both queries must have same number of columns
    - The data type of each column in the second result set must match the datatype of its corresponding column in the first result set.

#### 1. Union :
   - Combine result set
   - Example :
   ```
    1.  SELECT Ename
            FROM Emp
        UNION
        SELECT Dname
            FROM Dept
        ;

    2.  SELECT Deptno
            FROM Emp
        UNION
        SELECT Deptno
            FROM Dept
        ;

    3.  SELECT Ename, Deptno
            FROM Emp
        UNION
        SELECT Dname, Deptno
            FROM Dept
        ;

    4.  SELECT Ename, Deptno
            FROM Emp
        UNION
        SELECT Dname
            FROM Dept
        ;

    5. SELECT Ename, Deptno
            FROM Emp
        UNION
        SELECT Deptno, Dname
            FROM Dept
        ;

    6. SELECT Ename, Deptno
            FROM Emp
        UNION
        SELECT Dname, Deptno
            FROM Dept
        ORDER BY Ename
        ;

    7. SELECT Ename
         FROM Emp
        WHERE Deptno = 10
       UNION
       SELECT Ename
          FROM Emp
        WHERE Deptno = 30
       ;
```

#### 2. Union all
   - Extension to union
   - Combine two result sets and remove the duplicates
   - Example :
```
    1. SELECT Ename
           FROM Emp
        WHERE Deptno = 10
        UNION ALL
        SELECT Job
           FROM Emp
        WHERE Deptno = 30
        ;
```

#### 3. Intersect
   - It will display common result set
   - Example
```
    1.  SELECT Ename
            FROM Emp
        WHERE DEPTNO = 10
        INTERSECT
        SELECT Ename
            FROM Emp
        WHERE Deptno = 30
        ;

    2.  SELECT Job
           FROM Emp
        WHERE Deptno = 10
        INTERSECT
        SELECT Job
           FROM Emp
        WHERE Deptno = 30
        ;
```

#### 4. Minus
   - If any extra values in the first result set compared to second result set, dispaly the values
   - Example :
```
    1.  SELECT Ename
          FROM Emp
         WHERE Deptno = 10
        MINUS
        SELECT Ename
           FROM EMp
          WHERE Deptno = 30
        ;

    2.  SELECT Job
           FROM Emp
        WHERE Deptno = 10
        MINUS
        SELECT Job
           FROM Emp
        WHERE Deptno = 30
        ;
```

- Examples
----------
```
1. SELECT Job
      FROM Emp
    WHERE Deptno = 10
   UNION
   SELECT Job
        FROM Emp
     WHERE Deptno = 20
   INTERSECT
   SELECT Job
      FROM Emp
    WHERE Deptno = 30
    ;

2.  SELECT Deptno, Dname
        FROM Dept
      WHERE Deptno = &GDeptno1
    UNION
    SELECT Ename, Sal, HireDate
        FROM Emp
      WHERE Deptno = &GDeptno2
    ;

3. SELECT Deptno, Dname, NULL Ename, NULL Sal, NULL Hiredate
   FROM Dept
   WHERE Deptno = &GDeptno1
   UNION
   SELECT NULL, NULL, Ename, SAl, Hiredate
   FROM Emp
   WHEREDeptno = &GDeptno2
   ;

3.   SELECT Deptno, Job, SUM(Sal) SalSum
        FROM EMP
       GROUP BY Deptno, Job
     UNION
     SELECT Deptno, NULL, SUM(Sal)
        FROM Emp
       GROUP BY Deptno
     UNION
     SELECT NULL, NULL, SUM(Sal)
      FROM Emp
    ;
```