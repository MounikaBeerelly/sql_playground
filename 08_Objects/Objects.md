## Database Objects
- Whatever we are create in database i.e, object.

1. **View** - Virtual table
    - Grant permissions only to the few columns
    - Internally associated with one query (select statement)
    - View doesn't contain any data

    1. Simple View - Create views on single table
    2. Complex View - Create views on multiple tables
    - Syntax:
    ```
        CREATE [OR REPLACE] [FORCE/NOFORCE] VIEW <VIEW NAME>
        AS <SUB QUERY/QUERY>
        ;
    ```
    - Example : Simple View
    ```
        CREATE VIEW EmployeeView
        AS
        SELECT Empno "ID Number",
               Ename Name,
               Sal "Basic Salary",
               Job Designation
        FROM Emp;
    ```
    - Example : Complex View
    ```
        CREATE VIEW EmpInfo
        AS
        SELECT E.Empno EmployeeID,
               E.Ename Name,
               D.Deptno DepartmentID,
               D.Dname DepartmentName
            FROM Emp E, Dept D
        WHERE d.Deptno = E.Deptno
        ORDER BY D.Deptno;
    ```
    - Example : Complex View
    ```
        CREATE VIEW EmpGrade
        AS
        SELECT E.Ename Name,
               E.Sal Basic,
               S.Grade Grade
            FROM Emp E, Salgrade S
        WHERE E.Sal BETWEEN S.LoSal AND S.HiSal
        ORDER BY S.Grade;
    ```

2. **Synonym**
3. **Index**
4. **Sequence**