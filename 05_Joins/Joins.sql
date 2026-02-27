-- Equi Join:
SQL> select e.empno, e.ename, e.deptno, d.dname, d.loc
     from emp e, dept d
    where e.deptno = d.deptno;

-- Non Equi Join:
SQL> select empno, ename, sal, grade
     from emp, salgrade
     where sal between losal and hisal;

-- Left Outer Join:
SQL> select e.empno, e.ename, e.deptno, d.dname, d.loc
    from emp e, dept d
    where e.deptno = d.deptno (+);

-- Right Outer Join:
SQL> select e.empno, e.ename, e.deptno, d.dname, d.loc
    from emp e, dept d
    where e.deptno(+) = d.deptno;

-- Self Join
SQL> select e.empno, e.ename, m.ename manager
    from emp e, emp m
    where e.mgr = m.empno;


-- ANSI Joins:

-- Cross Join:
SQL> select empno, ename, dept.deptno, dname, loc
     from emp cross join dept;

-- Inner Join:
SQL> select empno, ename, dept.deptno, dname, loc
     from emp inner join dept
        on emp.deptno = dept.deptno;

-- Non Equi Join:
SQL> select empno, ename, dept.deptno, dname, loc
     from emp join dept
        on emp.deptno = dept.deptno
    join salgrade
        on emp.sal between losal and hisal;

-- Left Outer Join:
SQL> select empno, ename, dept.deptno, dname, loc
     from emp left join dept
        on emp.deptno = dept.deptno;

-- Right Outer Join:
SQL> select empno, ename, dept.deptno, dname, loc
     from emp right join dept
        on emp.deptno = dept.deptno;

-- Full Outer Join:
SQL> select empno, ename, dept.deptno, dname, loc
     from emp full outer join dept
        on emp.deptno = dept.deptno;

-- Self Join:
SQL> select e.empno, e.ename, m.ename manager
    from emp e join emp m
        on e.mgr = m.empno;