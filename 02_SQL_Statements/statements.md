### SQL Statements
1. DDL
2. DML
3. TCL
4. DCL
5. DRL
-------------------------------------------------------

1. **DDL - Data Definition Language** : Deals with metadata
    1. CREATE - for creating table
        - **Syntax**
            - `create table emp-test
                (
                    empno number(5),
                    ename varchar2(10),
                    salary number(5)
                );`
    2. ALTER - Updating the existing table metadata.
        1. add - adding column to the existing table
            - **Syntax**
                - `alter table <table-name> add <column-name> <datatype>`
            - **Example**
                - `alter table emp-test add hire-date date`
        2. modify - modifying the existing column
            - **Syntax**
                - `alter table <table-name> modify(<column-name> <datatype>)`
            - **Example**
                - `alter table emp-test modify(ename varchar2(15))`
        3. rename - renaming the existing column
            - **Syntax**
                - `alter table <table-name> rename column <column-name> to <new column-name>`
            - **Example**
                - `alter table emp-test rename column hire-date to hiredate`
        4. drop -  drop the exisiting column
            - **Syntax**
                - `alter table <table-name> drop column <column-name>`
            - **Example**
                - `alter table emp-test drop column hiredate`
    3. DROP - Drop the table
        - **Syntax**
            - `drop table <table-name>`
        - **Example**
            - `drop table emp-test`
    4. RENAME - Renaming the table
        - **Syntax**
            - `rename <old table-name> to <new table-name>`
        - **Example**
            - `rename emp-test to emo-demo`
    5. TRUNCATE - Delete entire table data.
        - It will not allow to use where clause.
        - We cannot rollback the back after truncate.
        - It is auto committed command. It will commit and delete at a time.
        - All the DDL commands are auto-committed commands.
        - **Syntax** :
            - truncate table <table-name>

2. **DML - Data Manipulation Language** : Deals with actual data - modifies the data
    1. INSERT - insert the data into the table
        - **Syntax** :
            - `insert into <table-name> values(column1, column2,column3);`
        - **Example** :
            - `insert into emp-demo values(101, 'Avi', 3000);`
    2. UPDATE - Update the existing table data
        - **Syntax** :
            - `update <table-name> set <column-name>=<data> where <column-name>;`
        - **Example** :
            - `update emp-demo set salary=3000 where empno=2;`
    3. DELETE - Delete the table data
        - **Syntax** :
            - `delete from <table-name>;`
            - `delete from <table-name> where <col-name>=<value>;`
        - **Example** :
            - `delete from emp-demo;`
            - `delete from emp-demo where salary=2000;`
    4. MERGE

3. **TCL - Transactional Control Language** : Save
    1. Commit - save the data
        - **Syntax** :
            - `commit;`
    2. Rollback - Remove the data upto your previous committed state.
         - **Syntax** :
            - `rollback;`
    3. Save point

4. **DCL - Data Control Language** : Security commands comes under DCL

5. **DRL - Data Retrieval Language** : Retrieving the data.