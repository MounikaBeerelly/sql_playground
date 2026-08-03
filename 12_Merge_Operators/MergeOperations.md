## Merge Operations:
--------------------

- If you want to perform more than one operation in single table, use Merge operations.
- Example :
```
CREATE TABLE emp10 AS SELECT * FROM emp WHERE deptno = 10;

CREATE TABLE emp_merg AS SELECT * FROM emp;

SELECT * FROM emp_merg ORDER BY deptno;

DELETE FROM emp_merg WHERE empno = 7782;

UPDATE emp_merg SET sal=4000 WHERE empno = 7839;

SELECT * FROM emp_merg ORDER BY deptno;

MERGE Operation:
----------------
MERGE INTO emp_merg T
USING emp10 S
ON (T.Empno = S.Empno)
WHEN MATCHED THEN
UPDATE SET T.Sal = S.sal
WHEN NOT MATCHED THEN
INSERT(T.empno, T.ename, T.Job, T.Mgr,T.Hiredate, T.Sal, T.Comm, T.Deptno)
VALUES(S.Empno, S.Ename, S.Job, S.Mgr, S.hiredate, S.Sal, S.Comm, S.Deptno)
;
```
