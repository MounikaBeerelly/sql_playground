## OPERATORS

1. Arithmetic Operators
2. Comparison Operators
    - Lessthan: <
    - greaterthan: >
    - lessthan equal to : <=
    - greaterthan equal to: >=
    - not equal to: <>/!=
3. Logical Operators
    - AND
    - OR
    - NOT
4. SQL * plus operators
    - IN : extension to OR operator
        - `select * from emp where deptno IN(10,30);`
        - `select * from emp where deptno NOT IN(10,30);`
    - BETWEEN AND: Extension to >= and <=
        - `select * from emp where sal>=2000 and sal<=5000;`
        - `select * from emp where sal between 2000 and 5000;`
    - LIKE : pattern matching
        - _ : single char
            - `select * from emp where ename like '_L%';`
        - % : multiple char
            - `select * from emp where ename like 'J%';`
            - ` select * from emp where ename like '%S';`
    - IS NULL : to check the null values
        - `select * from emp where comm is null;`
        - `select * from emp where comm is null or comm=0;`
        - `select * from emp where comm is  not null;`

