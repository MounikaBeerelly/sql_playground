### Constraints
    - set of Rules/conditions applied to the table columns.
    - creating table, inserting/altering data to the tables follow some rules/conditions. 

1. **Unique** 
    - If you want allow only unique values into columns use `unique` constraint.
    - Example without constraint
    ```
        SQL> create table SampleNN03
        (
            SampID NUMBER(2) UNIQUE,
            SampName VARCHAR(10),
            SampDate DATE,
            SampNotNull VARCHAR(20) NOT NULL
        );
    ```
    - Example with constraint
    ```
        create table SampleUNQ04
        (
            SampID NUMBER(2) CONSTRAINT SampleUNQ04_SampID_UNQ UNIQUE,
            SampName VARCHAR(10),
            SampDate DATE,
            SampleNotNull VARCHAR(20) NOT NULL
        );
    ```
    - Example with constraint table level
    ```
        create table SampleUNQ05
        (
            SampID NUMBER(2),
            SampName VARCHAR(10),
            SampDate DATE,
            CONSTRAINT SampleUNQ05_SampIDSampName_U UNIQUE(SampID,SampNAme),
            CONSTRAINT SampUNQ05_SampDate_U UNIQUE(SampDate)
        );
    ```
2. **Not Null**
    - If you don't want to allow null values into the column use `not null` constraint
    - Example without constraint
    ```
        SQL> create table SampleNN01
        (
            SampID NUMBER(2) NOT NULL,
            SampName VARCHAR(10) NOT NULL,
            SampDate DATE
        );
    ```
    - Example with constraint
    ```
        create table SampleNN01
        (
            SampID NUMBER(2) CONSTRAINT SampleNN01_SampID_NN NOT NULL,
            SampName VARCHAR(10) CONSTRAINT SampleNN01_SampName_NN NOT NULL,
            SampDate DATE
        );
    ```
    - Example with constraint table level
    ```
        create table SampleNN02
        (
            SampID NUMBER(2),
            SampName VARCHAR(10),
            SampDate DATE,
            CONSTRAINT SampleNN01_SampID_NN NOT NULL(SampID)
        );
    ```
    - We can't create not null constraints at table level.
3. **Primary Key**
    - Combination of unique and not null
    - you can create only one primary key for one table
    - ```
    create table SamplePK01
        (
            SampID NUMBER(2) Constraint SampID_PK PRIMARY KEY,
            SampName VARCHAR2(10),
            SampDate DATE
        );
    ```
    - ```
      create table SamplePK02
        (
            SampID NUMBER(2) NOT NULL,
            SampName VARCHAR2(10),
            SampDate DATE,
            Constraint SamplePK02_SampID_PK PRIMARY KEY(SampID, SampName)
        );
    ```
4. **Check**
    - Before inserting the data into the table, check all conditions/rules.
5. **Foreign Key (Referential Integrity)**
    - if you want to take the reference from one table into another table
    - Refernce column must be the primary key column of a parent table.
    - ```
        create table SampleFK01
        (
            SampId number(2) CONSTRAINT FKSAMPIF_PK PRIMARY KEY,
            SampName VARCHAR(10),
            SampDate DATE,
            FKID NUMBER(2) CONSTRAINT FKSAMPID_FK REFERENCES SAmplePK01(SampID)
        );