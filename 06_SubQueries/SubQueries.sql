--- Handle Null values in the sub query
- When you are using `Not IN` operator, if you are seeing null values in the subquery use `nvl` function to display any value.

-- Get the details of employees who are managers in my organization

SELECT E.Ename
    FROM Emp E
WHERE E.Empno IN(SELECT M.Mgr FROM Emp M);

-- display only unique values use distinct operator
SELECT Ename, Sal, Comm
    FROM Emp
WHERE Comm NOT IN(SELECT NVL(Comm,0)
                    FROM Emp);

--- >ANY
-- >ANY: More than the minimum value in the list
SELECT *
    FROM Emp
WHERE Sal >ANY(1100,2750,950);

SELECT *
    FROM Emp
WHERE Sal>1100 OR Sal>2750 OR Sal>950;

  --- If any employee is having more salary of the 30th department of the employee salary

SELECT *
    FROM Emp
WHERE Sal > ANY(SELECT Sal
                    FROM Emp
                WHERE Deptno=30
                );

--- <ANY
-- <ANY: Less than the maximum value in the list
SELECT *
    FROM Emp
WHERE Sal <ANY(1100,2750,950);

SELECT *
    FROM Emp
WHERE Sal<1100 OR Sal<2750 OR Sal<950;

  --- If any employee is having less salary of the 30th department of the employee salary

SELECT *
    FROM Emp
WHERE Sal < ANY(SELECT Sal
                    FROM Emp
                WHERE Deptno=30
                );

---  >ALL (similer to AND)
---  >ALL : More than the maximum value in the value

SELECT Empno, Ename, Job, Sal
    FROM Emp
WHERE Sal >ALL(SELECT AVG(Sal)
                FROM Emp
               GROUP BY Deptno
               );

SELECT Empno, Ename, Job, Sal
   FROM Emp
WHERE Sal >ALL(SELECT Max(AVG(Sal))
                  FROM Emp
                GROUP BY Deptno
           );

---  <ALL
---  <ALL: Less than the minimum values in the list
SELECT Empno, Ename, Job, Sal
    FROM Emp
WHERE Sal <ALL(SELECT AVG(Sal)
                FROM Emp
               GROUP BY Deptno
               );

SELECT Empno, Ename, Job, Sal
   FROM Emp
WHERE Sal <ALL(SELECT Min(AVG(Sal))
                  FROM Emp
                GROUP BY Deptno
           );

--- Applying sub queries in FROM clause:

-- Display the details of employees along with their department average salaries:

SELECT Ename, E.Deptno, Sal, AvgSal
    FROM Emp E, (SELECT Deptno,Avg(sal) AvgSal
                    FROM Emp
                 GROUP BY Deptno
                ) E1
WHERE E.Deptno = E1.Deptno
ORDER BY 2;

--  Get the details of employees with their department average salry and salary differences

SELECT E.Ename, E.Deptno, E.Sal,
       ROUND(E1.SalAvg,2) DeptAvgSal,
       ROUND(E.sal - E1.SalAvg) DiffSalAvg
  FROM Emp E, (SELECT Deptno, AVG(Sal) SalAvg
                  FROM Emp
                GROUP BY Deptno) E1
 WHERE E.Deptno = E1.Deptno
ORDER By Deptno;

-- Dispaly the details of employees along with their department sum salaries:
SELECT E.Ename, E.Deptno, E.Sal, E1.SalSum
  FROM Emp E, (SELECT Deptno, Sum(Sal) SalSum
                  FROM Emp
                GROUP BY Deptno) E1
 WHERE E.Deptno = E1.Deptno
ORDER By Deptno;

--- Get the details of departments along with their count

SELECT T1.Deptno, Dname, Staff
    FROM Dept T1, (SELECT Deptno, COUNT(*) AS Staff
                        FROM Emp
                    GROUP BY Deptno) T2
WHERE T1.Deptno = T2.Deptno;


SELECT E.Deptno, Dname, COUNT(*) Staff
    FROM EMP E, Dept D
WHERE E.Deptno = D.Deptno
GROUP By E.Deptno,Dname;


--- Display the details of employees, count and salgrade count

SELECT E.EmpCount, D.DeptCount, S.GradeCount
    FROM (SELECT COUNT(*) EmpCount FROM Emp) E,
         (SELECT COUNT(*) DeptCount FROM Dept) D,
         (SELECT COUNT(*) GradeCount FROM SalGrade) S;

--- Details of the employees along with their employees and salaries percentages

SELECT A.Deptno "Department Number",
       (A.NumEmp / B.TotalCount) * 100 "%Employees",
       (A.SalSum / B.TotalSal) * 100 "%Salary"
    FROM (SELECT Deptno, COUNT(*) NumEmp, SUM(Sal) SalSum
            FROM Emp
           GROUP By Deptno) A,
         (SELECT COUNT(*) TotalCount, SUM(Sal) TotalSal
            FROM Emp) B;


--- Sub queries in the SELECT Clause:

SELECT Ename, Sal, (SELECT SUM(Sal) FROM Emp) OrgSal From emp;

SELECT Ename, Sal, (SELECT SUM(Sal) FROM Emp) OrgSum,
                   (SELECT Avg(Sal) FROM Emp) OrgAvg
        From emp;


-- Co-related Sub queries
-------------------------

-- Display the details of employees whose salary is greater than the average salary of their department

SELECT Ename, Deptno, Sal
    FROM Emp OE
WHERE OE.Sal > (SELECT AVG(Sal)
                   FROM EMP IE
                WHERE IE.Deptno = OE.Deptno
            );


SELECT Ename, OE.Deptno, Sal
    FROM Emp OE, (SELECT Deptno, AVG(Sal) SalAvg
                    FROM Emp
                  GROUP By Deptno
                ) IE
WHERE OE.Deptno = IE.Deptno AND
      OE.Sal > IE.SalAvg;

-- Display the details of employees whose salary is greater than their managers salary of their department

SELECT Ename, E.Deptno, Sal, Mgr
    FROM Emp E
WHERE E.Sal > (SELECT M.Sal
                   FROM EMP M
                WHERE M.Empno = E.Mgr
            );


-- EXISTS and NOT EXISTS
------------------------

-- EXISTS : Similer to IN operator. If we found any match value it stop execution.
-- NOT EXISTS : Similer to IN operator. If we found any unmatching value it stop execution.

select Deptno, Dname
    FROM Dept D
WHERE EXISTS (SELECT *
                FROM Emp E
              WHERE E.Deptno = D.Deptno
            );

select Deptno, Dname
    FROM Dept D
WHERE NOT EXISTS (SELECT *
                FROM Emp E
              WHERE E.Deptno = D.Deptno
            );