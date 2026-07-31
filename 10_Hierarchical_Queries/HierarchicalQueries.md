## Hierarchical Queries:

- Help us to represent data in hierarchical manner
- We can select rows in a hierarchical order using the hierarchical query clause, If that table having hierarchical data.
- `CONNECT BY` will be used to specify the relationship between parent rows and child rows of the hierarchy.
- `PRIOR` is a unary operator, It evaluates/identifies the immediately following parent row of the current row in a hierarchical manner.
- `START WITH` is a keyword which is used to specify the root row(s) of the hierarchy.

### Examples:

- `START WITH` is not mandatory, But recommand to use to get accurate hierarchy.

    ```
    SELECT Ename, Empno, Mgr, Job
        FROM Emp
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job
        FROM Emp
        START WITH Job = 'PRESIDENT'
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job
        FROM Emp
        START WITH Ename = 'KING'
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job
        FROM Emp
        START WITH Ename = 'JAMES'
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job, Sal
        FROM Emp
        START WITH Sal = 5000
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
- `PRIOR` other side
    ```
    SELECT Ename, Empno, Mgr, Job, Sal
        FROM Emp
        START WITH Sal = 5000
        CONNECT BY Empno = PRIOR MGR
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job, Sal
        FROM Emp
        START WITH Sal = 3000
        CONNECT BY Empno = PRIOR MGR
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job
        FROM Emp
        START WITH Ename = 'BLAKE'
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job
        FROM Emp
        START WITH Ename = 'SMITH'
        CONNECT BY Empno = PRIOR MGR
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job
        FROM Emp
        START WITH Job = 'SALESMAN'
        CONNECT BY Empno = PRIOR MGR
    ;
    ```
- We can't use `START WITH` without CONNECT BY
    ```
    SELECT Ename, Empno, Mgr, Job, Sal
        FROM Emp
        START WITH Sal = (SELECT MAX(Sal) FROM Emp)
    ;
    ```
    ```
    SELECT Ename, Empno, Mgr, Job, Sal
        FROM Emp
        START WITH Sal = (SELECT MAX(Sal) FROM Emp)
        CONNECT BY PRIOR Empno = MGR
    ;
    ```

### CONNECT_BY_ROOT
- It is a function, it will display immediate parent
- If you want to display immediate parent as seperate column, use CONNECT_BY_ROOT
- Example :
    ```
    SELECT Ename, Sal, Job, CONNECT_BY_ROOT(Job) BossJob
        FROM Emp
        START WITH Ename = 'KING'
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
    ```
    SELECT Ename,
           Sal,
           Job,
           CONNECT_BY_ROOT(Sal) BossSal,
           CONNECT_BY_ROOT(Sal) - Sal DiffBossEmpSal
        FROM Emp
        START WITH Ename = 'KING'
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
    ```
    SELECT Ename,
           Sal,
           Job,
           CONNECT_BY_ROOT(Ename) BossName
        FROM Emp
        START WITH Ename = 'BLAKE'
        CONNECT BY Empno = PRIOR MGR
    ;
    ```

### SYS_CONNECT_BY_PATH function :
- SYS_CONNECT_BY_PATH is valid only in hierarchical queries.
- It returns the path of a column value from root to node, with column values seperated by char for each row returned by CONNECT BY condition.
- Example :

    ```
    SELECT EName,
           SYS_CONNECT_BY_PATH(Ename, '/') "Path"
        FROM EMP
        START WITH Ename = 'KING'
        CONNECT BY PRIOR Empno = MGR
    ;

    col Path for a50
    ```
    ```
    SELECT EName,
           SYS_CONNECT_BY_PATH(Ename, ',') "Path"
        FROM EMP
        START WITH Ename = 'KING'
        CONNECT BY PRIOR Empno = MGR
    ;
    ```
    ```
    SELECT EName,
           SYS_CONNECT_BY_PATH(Ename, '/') "Path"
        FROM EMP
        START WITH Ename = 'BLAKE'
        CONNECT BY Empno = PRIOR MGR
    ;
    ```

### LEVEL
- to show the hierarchy level

    ```
    SELECT Ename, Empno, MGR, Job, level
        FROM Emp
        START WITH Job = 'PRESIDENT'
        CONNECT BY PRIOR Empno = MGR
    ;
    ```

