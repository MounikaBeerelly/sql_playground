## Joins
- If you want to read the data from more than one table, use joins.
- combine data from two or more tables based on a related column between them

1. **Equi joins**
    - If there is a common column between two tables, join those tables with `=` operator.
    - It returns only the rows where the specified columns of both tables are equal.
    - `select empno,ename,emp.deptno,dname,loc from emp,dept where emp.deptno = dept.deptno;`
    ```
    SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    ```
2. **Non equi joins**
    - We don't have common column between two tables, but data is same. Use non-equi joins to merge tables.
    - A Non-Equi Join is a join that uses a non-equality operator in the condition:
    (>, <, >=, <=, BETWEEN, etc.)
    - These joins are used when tables are related by ranges rather than exact matches.
    - ` select empno,ename,sal,grade from emp, salgrade where sal>=losal and sal<=hisal;`
    ```
     select empno,ename,sal,grade
     from emp, salgrade
     where sal between losal and hisal;
     ```
3. **Outer joins**
    - if you want to see complete details from one table and there is no matching records, use + operator. It will allow us to display unmatched records.
    1. Left outer join
        - + operator right side
    2. Right outer join
        - + operator left side
    ```
     select empno,ename,emp.deptno,dname,loc
     from emp,dept
     where emp.deptno(+) = dept.deptno;
    ```
    ```
     select empno,ename,emp.deptno,dname,loc
     from emp,dept
     where emp.deptno = dept.deptno(+);
    ```
4. **Self joins**
- A Self Join is a join where a table is joined with itself.
-   ```
    select e.empno,e.ename,m.ename manager
    from emp e, emp m
    where e.mgr=m.empno;
    ```

### ANSI Joins

1. **Cross Join**
    - cartesian product
    - `select ename,dept.deptno,dname,loc from emp cross join dept;`
2. **Natural Join**
    - search for the common columns between the two tables and join the data.
    - `select ename,deptno,dname,loc from emp natural join dept;`
    - **Using Clause** - same as NAtural join. But when we have two same columns in two tables, go for Using clause
        - `select ename,deptno,dname,loc from emp join dept using(deptno);`
3. **Equi Joins**
4. **Non Equi joins**
    ```
    select ename, sal,grade, dept.deptno,dname,
    from emp join dept
            on emp.deptno=dept.deptno
    join salgrade
        on emp.sal between losal and hisal;
    ```
5. Outer joins
    a. Left Outer Join
        ```
        select ename,dept.deptno,dname,loc
            from emp left join dept
                on emp.deptno = dept.deptno;
        ```
    b. Right Outer Join
        ```
        select ename,dept.deptno,dname,loc
            from emp right join dept
                on emp.deptno = dept.deptno;
        ```
    c. Full Outer Join
        ```
        select ename,dept.deptno,dname,loc
            from emp full join dept
                on emp.deptno = dept.deptno;
        ```
6. **Self join**
    ```
    select e.ename employee,
           m.ename manager
    from emp E INNER JOIN emp M
            on(e.mgr=m.empno);
    ```
7. **Inner Join**
    ```
    select ename,dept.deptno,dname,loc
    from emp inner join dept
    on emp.deptno = dept.deptno;
    ```
