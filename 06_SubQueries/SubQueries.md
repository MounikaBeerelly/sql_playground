## SubQueries

- Query inside another query

1. **Single row sub query**
    - Inside query returning only one row
2. **Multiple row sub query**
    - Subquery is returning more than one value
3. **Multiple column sub query**
    - Inside query returning more than one column
4. **Co-related Sub query**
    - Inner query going to be execute for each and every row

### Examples

1. **Dispaly records of employee whose salary is greater than the employee whose employee number is 7566**
    ```
    1. select sal from emp where empno = 7566;
    2. select ename,sal,job
        from emp
        where sal > 2975;
    3. Using subquery
        select Ename,sal,job
        from emp
        where sal > (select sal from emp where empno=7566);
    ```

2. **Get the details of employees whose job is similer to the Smith's designation**
```
    1. select job
        from emp
        where ename='SMITH';
    2. select empno,ename,job,sal
        from emp
        where job='CLERK';
    3. Using subquery
        select empno,ename,job,sal
            from emp
        where job = (select job
                        from emp
                        where ename = 'SMITH');
```
- exclude the record of 'SMITH'
```
select empno,ename,job,sal
    from emp
    where job = (select job
                    from emp
                  where ename='SMITH')
    and ename<>'SMITH';

```
3. **Display the details of employees who joined after TURNER joined**
- ```
    select empno,ename,hiredate,sal
      from emp
     where hiredate > (select hiredate
                        from emp
                        where ename='TURNER'
                    );
    ```
4. **Get the details of employees whose belong to the 'SALES' department**
- ```
    select empno,ename,sal,job
     from emp
    where deptno = (select deptno
                     from dept
                     where dname='SALES'
                    );
```
- Using Joins
    ```
    select empno,ename,sal,job
       from emp,dept
    where emp.deptno = dept.deptno
        and dept.dname = 'SALES';
```
5. **Get the details of employees whose salary is equla to the highest salary**
    ```
    select empno,ename,sal,job
        from emp
        where sal = (select Max(sal)
                        from emp
                        );
    ```
    ```
     select empno,ename,sal,job
        from emp
        where sal = (select Avg(sal)
                        from emp
                        );
    ```

6. **Get the details of employees whose salary greater than equals to the MILLER's salry and lessthan or equals to the JONES salary**
- ```
    select * from emp
        where sal between
            (
                select Sal
                    from emp
                     where ename='MILLER'
            )
    and
            (
                select Sal
                   from emp
                     where ename='JONES'
            );
    ```

7. **Get only sales department on above employee**
```
    select * from emp
        where sal between
            (
                select Sal
                    from emp
                     where ename='MILLER'
            )
    and
            (
                select Sal
                   from emp
                     where ename='JONES'
            )
    and ename not in ('MILLER', 'JONES')
    and deptno = ( select deptno
                    from dept
                    where dname='SALES'
                    );
    ```

8. **get the equivalent to ALLEN's designation**
```
    select * from emp
        where sal between
            (
                select Sal
                    from emp
                     where ename='MILLER'
            )
    and
            (
                select Sal
                   from emp
                     where ename='JONES'
            )
    and ename not in ('MILLER', 'JONES')
    and deptno = ( select deptno
                    from dept
                    where dname='SALES'
                    )
    and job = (select job
                from emp
                 where ename='ALLEN'
                );
    ```

## Multiple Row subqueries

1. **Find the details of all the employees whose earning maximum salary of each department**

- `select * from emp where sal IN (select max(sal) from emp group by deptno);`

2.
```
select *
    from emp
    where sal IN (select sal
                    from emp
                    where ename = 'WARD'
                )
    or sal IN (select sal
                from emp
                where ename = 'FORD'
        );
```

3. **Get the details of employees whose joining date is equivalent to the joining date of RESEARCH department**

```
    select empno,ename,job,sal,hiredate,deptno
        from emp
        where hiredate IN (
                select hiredate
                    from emp
                    where deptno = (
                        select deptno
                        from dept
                        where dname='RESEARCH'
                    )
                );
```

- When you are using `Not IN` operator, if you are seeing null values in the subquery use `nvl` function to display any value.