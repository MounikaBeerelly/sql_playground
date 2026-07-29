## Basic Commands

1. `create table <table-name> (col1 datatype, col2 datatype);` : creates table
2. `desc <table-name>` : Show the table with all the columns and data types.
3. `alter table <table-name> add <column-name> <datatype>` : adding column to the existing table
4. `alter table <table-name> modify(<column-name> <datatype>)` : modifying the exisitng table column
5. `alter table <table-name> rename column <column-name> to <new column-name>` : renaming the existing table column
6. `alter table <table-name> drop column <column-name>` : drop the existing table column
7. `drop table <table-name>` : Drop the existing table
8. `rename <old table-name> to <new table-name>` : Rename the existing table
9. `insert into <table-name> values(column1, column2,column3);` : Insert the data into the table
10. `insert into <table-name>(col1,col2,col4) values(val1, val2,val3);` : Insert few columns of the data into the table
11. `select * from <table-name>;` : View the table data
12. `update emp-demo set salary=3000 where empno=2;` : Update the existing data
13. `commit;` : save the updated data
14. `rollback;` : Remove the data upto your previous committed state
15. `delete from <table-name>;` : delete all the data from the table
16. `delete from <table-name> where <col-name>=<value>;` : Delete particular data from the table
17. `truncate table <table-name>;` : delete complete table data and commit

```
**How to give DBA permissions to the user
**
    C:\Users\upend>sqlplus scott/tiger
    SQL> conn / as sysdba
    Connected.
    SQL> grant dba to scott;
    Grant succeeded.
```