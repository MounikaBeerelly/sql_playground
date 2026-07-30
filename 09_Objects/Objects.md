## Database Objects
- Whatever we are create in database i.e, object.

1. **View** - Virtual table
    - Grant permissions only to the few columns
    - Internally associated with one query (select statement)
    - View doesn't contain any data
    - Types of Views
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
    - Synonym is a schema object, which act as an alternate name for an existing object.
    - `CREATE [OR REPLACE] SYNONYM/PUBLIC SYNONYM FOR OWNER.OBJECT_NAME;`
    - Types of Synonyms :
        1. Public
        2. Private
    - Example:
    ```
        CREATE OR REPLACE SYNONYM EMP01 FOR SCOTT.EMP;
        CREATE OR REPLACE PUBLIC SYNONYM Employee01 FOR EMP;
    ```

3. **Indexes**
    - Index table will contain addresses of each and every column.
    - Types of Indexes :
        1. Simple/Normal Index
        2. Unique Index
        3. Commosite/Composite Unique Index
        4. Function based Index
    - Syntax :
    ```
        CREATE [UNIQUE]/[BITMAP] INDEX INDEXNAME ON TABLENAME(COLUMNNAME1, COLUMNNAME2);
    ```
    - Example : Normal Index :
    ```
        CREATE INDEX EmpEmpnoIDX ON Emp(Empno);
        CREATE INDEX EmpEnameIDX ON Emp(Ename);
        CREATE INDEX EmpJobIDX ON Emp(Job);
    ```
    - Example : Normal Composite Index :
    ```
        CREATE INDEX EmpEnameJobIDX ON Emp(Ename, Job);
        CREATE INDEX EmpJobEnameIDX ON Emp(Job, Ename);
    ```
    - Example : Unique Index :
    ```
        CREATE UNIQUE INDEX EmpEnameUNQINDX ON Emp(MGR);

        CREATE UNIQUE INDEX EmpEnameUNQINDX ON Emp(EMPNO);

        INSERT INTO Emp(Empno, Ename, Deptno, Job)
            VALUES(1234, 'ADAMS', 30, 'CLERK');
    ```
    - Cannot on duplicate values
    ```
        CREATE UNIQUE INDEX EmpDeptnoUNQIDX ON Emp(Deptno);
        CREATE UNIQUE INDEX EmpDeptnoUNQIDX ON Dept(Deptno, DNAME);
    ```
    - Example : Function based Index
    ```
        SELECT Ename, Deptno, SAl, Comm, Sal + NVL(Comm, 0) TotSal
          FROM Emp
        WHERE Sal + NVL(Comm, 0) > 1000;

        CREATE INDEX EmpTotSalIDX ON Emp(Sal + NVL(Comm, 0));

        CREATE INDEX EmpAnnSalIDX ON Emp(Sal * 12);
    ```
- **When to create Index** :
    - The column is frequently used in the where clause or in a join condition.
    - The column contains large number of NULL values
    - Two or more columns are frequently used together in the where clause and join condition
    - the table is large and most queries are expected ti retrieve less than 3 to 4% of the rows
- **when not to create Index** :
    - The table is too small
    - The column are not often used as condition in the query
    - Most queries are expected ti retrieve more than 2 to 4% of the rows
    - Table updated frequently

4. **Sequence**
    - help us to generate the values automatically
    - `CURRVAL & NEXTVAL` can be applied on only on sequences.
    - An object from which multiple users may generate unique integers
    - can be used to generate `PRIMARY KEY` values automatically
    - Syntax :
    ```
        CREATE SEQUENCE <sequencename>
        INCREMENT BY <INTEGER>
        START WITH <INTEGER>
        MAXVAL INTEGER/NOMAXVALUE
        MINVAL INTEGER/NOMINVALUE
        CYCLE/NOCYCLE
        CACHE INTEGER/NOCACHE;
    ```
    - Exmaple 01 :
    ```
        CREATE TABLE Sample01
        (
            SampID NUMBER(4) Constraint SampID_PK01 PRIMARY KEY,
            SampName VARCHAR2(20),
            SampDate DATE
        );

        CREATE SEQUENCE SampleSeq01
        INCREMENT BY 1
        START WITH 0
        MINVALUE 0
        MAXVALUE 5
        NOCACHE
        NOCYCLE
        ;

        --first time without definit=ng the NEXTVAL we cannot get CURRVAL
        SELECT SampleSeq01.CURRVAL FROM DUAL;
        SELECT SampleSeq01.NEXTVAL FROM DUAL;

        SELCT SampleSeq01.CURRVAL FROM DUAL;

        -- Inserting into table using sequence for the pk column
        INSERT INTO Sample01 (SampID, SampName, SampDate)
        VALUES(SampleSeq01.NEXTVAL, 'SAMPLE', '30-AUG-05');
    ```
    - Example 02:
    ```
        CREATE TABLE Sample02
        (
            SampID NUMBER(4) Constraint SampID_PK02 PRIMARY KEY,
            SampName VARCHAR2(20),
            SampDate DATE
        );

        CREATE SEQUENCE SampleSeq02
        INCREMENT BY 1
        START WITH 0
        MINVALUE 0
        MAXVALUE 5
        NOCACHE
        CYCLE
        ;

        INSERT INTO Sample02 (SampID, SampName, SampDate)
        VALUES(SampleSeq02.NEXTVAL, 'SAMPLE', '30-AUG-05');
    ```
    - Example 03 :
    ```
        CREATE TABLE Sample03_1
        (
            SampID NUMBER(4),
            SampName VARCHAR2(20),
            SampDate DATE
        );

        CREATE TABLE Sample03_2
        (
            SampID NUMBER(4),
            SampName VARCHAR2(20),
            SampDate DATE
        );

        CREATE TABLE Sample03_3
        (
            SampID NUMBER(4),
            SampName VARCHAR2(20),
            SampDate DATE
        );

        CREATE SEQUENCE SampleSeq03
        INCREMENT BY 1
        START WITH 0
        MINVALUE 0
        MAXVALUE 20
        NOCACHE
        NOCYCLE
        ;

        INSERT INTO Sample03_1(SampId, SampName, SampDate)
        VALUES(SampSeq03.NEXTVAL, 'SAMPLE', '24-AUG-03');

        INSERT INTO Sample03_2(SampId, SampName, SampDate)
        VALUES(SampSeq03.NEXTVAL, 'SAMPLE', '24-AUG-03');

        INSERT INTO Sample03_3(SampId, SampName, SampDate)
        VALUES(SampSeq03.NEXTVAL, 'SAMPLE', '24-AUG-03');
    ```