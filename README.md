# SQL Playground

- Check all the tables : `select * from tab;`
- dummy table to perform operations: `select 5+6 from dummy;`
- format number column : `col empno for 9999;`
    - empno column occupy 4 digits
    - It change only display size
- format char column : `col ename for a6;`
- Operators are not capable of handling null values.
- In SQL data is case sensitive.

-------------------------------------------------------------
- **Cardinality** : Cardinality describes how data in one entity (table) related to data in another entity.
    - One to One relationship
    - One to Many
    - Many to many
- **Data** : Storage representation of objeccts and events
    - Actual information stored in database.
- **Metadata** : Data about data
    - It describes the structure and properties of the actual data
- **Schema** : Structure of the database.
    - User account with objects is called as schema. User with no objects in his account then we called as `user account not schema`.
- **SQL** : Structure Query Language
    - It is designed for managing the data in the Relational database Management System.
- If we want to store the data in the databases form of tables. Tables are combination of columns and rows.
-