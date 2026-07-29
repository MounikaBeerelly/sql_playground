CREATE TABLE driver(
    Driver_license_id NUMBER(4) CONSTRAINT DRIVERID_PK PRIMARY KEY,
    Name VARCHAR2(30),
    Address VARCHAR2(20),
    Age NUMBER(3)
);

INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1001, 'Peter', 'Newyork', 30);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1002, 'John', 'Boston', 26);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1003, 'Clark', 'Omaha', 29);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1004, 'Steve', 'Denver', 25);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1005, 'Johnson', 'Boston', 36);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1006, 'Williams', 'Omaha', 39);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1007, 'Davis', 'California', 19);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1008, 'James', 'Dallas', 21);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1009, 'Robert', 'Newyork', 29);
INSERT INTO driver (Driver_license_id, Name, Address, Age)
    VALUES(1010, 'Martin', 'California', 32);


CREATE TABLE car(
    Reg_Num Number(6) CONSTRAINT CARNUM_PK PRIMARY KEY,
    Year NUMBER(4),
    Car_Model VARCHAR2(20)
);

INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(201, 1998, 'Maruti800');
INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(202, 2005, 'Tata Indica');
INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(203, 2010, 'Maruti Swift');
INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(204, 2011, 'Mercedes Benz');
INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(205, 2003, 'Alto');
INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(206, 2006, 'Toyota Innova');
INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(207, 2010, 'Tata Nano');
INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(208, 2006, 'Hyundai i10');
INSERT INTO car (Reg_Num, Year, Car_Model)
    VALUES(209, 2009, 'Hyundai i20');


CREATE TABLE accident(
    Report_Num Number(4) CONSTRAINT ACCIDENT_PK PRIMARY KEY,
    Day_Date DATE,
    Location VARCHAR2(20)
);

INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES(3001, TO_DATE('03/18/10', 'MM/DD/YY'), 'Boston');
INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES(3002, TO_DATE('08/16/06', 'MM/DD/YY'), 'Denver');
INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES(3003, TO_DATE('11/04/08', 'MM/DD/YY'), 'Dallas');
INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES(3004, TO_DATE('07/07/11', 'MM/DD/YY'), 'Chicago');
INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES(3005, TO_DATE('04/04/01', 'MM/DD/YY'), 'Detroit');
INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES(3006, TO_DATE('12/24/10', 'MM/DD/YY'), 'Dallas');
INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES(3007, TO_DATE('03/24/09', 'MM/DD/YY'), 'Las Vegas');
INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES (3008, TO_DATE('12/16/11', 'MM/DD/YY'), 'Boston');
INSERT INTO accident(Report_Num, Day_Date, Location)
    VALUES(3009, TO_DATE('04/18/04', 'MM/DD/YY'), 'California');


CREATE TABLE claim_insurance(
    Report_Num NUMBER(4),
    Driver_Id NUMBER(4),
    Reg_Num NUMBER(6),
    Damage_amount NUMBER(10,2),
    PRIMARY KEY(Report_Num, Driver_Id, Reg_Num, Damage_amount),
    FOREIGN KEY(Report_Num) REFERENCES accident(Report_Num),
    FOREIGN KEY(Driver_Id) REFERENCES driver(Driver_license_id),
    FOREIGN KEY(Reg_Num) REFERENCES car(Reg_Num)
);

INSERT INTO claim_insurance VALUES (3006, 1010, 208, 20000);
INSERT INTO claim_insurance VALUES (3009, 1007, 209, 45000);
INSERT INTO claim_insurance VALUES (3004, 1004, 207, 4000);
INSERT INTO claim_insurance VALUES (3001, 1005, 208, 2000);
INSERT INTO claim_insurance VALUES (3002, 1010, 202, 10000);
INSERT INTO claim_insurance VALUES (3008, 1003, 207, 6000);
INSERT INTO claim_insurance VALUES (3009, 1004, 204, 4000);



1.	Display the all  details of  Driver , Car , Accident ,  Claim_insurance ( Use individual Statements)

SELECT * FROM driver;
SELECT * FROM car;
SELECT * FROM accident;
SELECT * FROM claim_insurance;

2.	Display the details of dirvers those who stays in Newyork.

SELECT * FROM driver WHERE Address = 'Newyork';

3.	Display the Details of cars whose Car_model second letter is 'a'

SELECT * FROM car WHERE Car_Model LIKE '_a%';


4.	Display the details of report number , location and the damage amount of car

SELECT A.Report_Num,
	   A.Location,
       C.Damage_amount
FROM accident A
JOIN claim_insurance C
ON a.Report_Num = C.Report_Num;

5.	Display the details of driver those who have are done more than one accident.

SELECT D.Driver_license_id, D.Name, D.Address
FROM driver D
JOIN claim_insurance C
ON D.Driver_license_id = C.Driver_Id
GROUP BY D.Driver_license_id, D.Name, D.Address
HAVING COUNT(C.Report_Num) > 1;

6.	Display the car details which are participated in more than one accident.

SELECT C.Reg_num, C.Year, C.Car_Model
FROM car C
JOIN claim_insurance CI
ON C.Reg_Num = CI.Reg_Num
GROUP BY C.Reg_num, C.Year, C.Car_Model
HAVING COUNT(CI.Report_Num) > 1;

7.	Display the driver id , reg num , and report num of car such that, the accident happend
in Dallas city.

SELECT C.Driver_id, C.Reg_Num, C.Report_Num
FROM claim_insurance C
JOIN accident A
ON C.Report_Num = A.Report_Num
WHERE A.Location = 'Dallas';

8.	Find the accident details(Report num , dirver id , dirver name , reg num , car model) of cars which are happend 400 days ago.

SELECT CI.Report_Num, CI.Driver_Id, D.Name, CI.Reg_Num, C.Car_Model
FROM claim_insurance CI
JOIN driver D
ON CI.Driver_Id = D.Driver_license_Id
JOIN car C
ON CI.Report_Num = CI.Report_Num
JOIN accident A
ON A.Report_Num = CI.Report_Num
WHERE A.Day_Date = sysdate – 400;

9.	Find out the details (driver id  , dirver name , regnum , report num) of car of higest damage amount.

SELECT CI.Driver_Id,D.Name, CI. Reg_Num, CI.Report_Num
FROM claim_insurance CI
JOIN driver D
ON CI.Driver_Id = D.Driver_license_id
WHERE CI.Damage_amount = (
    SELECT MAX(Damage_amount) FROM claim_insurance
);

10.	Display the details of claim insurance those damage amount is equal to the average damage amount.

SELECT * FROM claim_insurance CI
WHERE CI.Damage_amount = (
    SELECT AVG(Damage_amount) FROM claim_insurance
);

11.	 Display the details of claim insurance those damage amount is equal to the lowest damage amount.

SELECT * FROM claim_insurance CI
WHERE CI.Damage_amount = (
    SELECT MIN(Damage_amount) FROM claim_insurance
);

12.	Display the details of accident that accident is made by the driver called  Johnson.

SELECT * FROM accident A
JOIN claim_insurance CI
ON A.Report_Num = CI.Report_Num
JOIN driver D
ON CI.Driver_Id = D.Driver_license_id
WHERE D.Name = 'Johnson';

13.	Remove the primary key from Drivers table

ALTER TABLE DRIVER
DROP CONSTRAINT DRIVERID_PK;

14.	Add Not null constraint to Driver id of claim insurance table.

ALTER TABLE claim_insurance
MODIFY Driver_Id CONSTRAINT DRIVERID_NN NOT NULL;

16.	Add a dob column to dirver table.
ALTER TABLE driver add DOB DATE;

19.	Find the last day of the month.
SELECT LAST_DAY(SYSDATE) AS LAST_DAY_OF_MONTH FROM DUAL;

20.	Print the current date as 15th  march nineteen eighty seven.
SELECT TO_CHAR(SYSDATE, 'DDth month YYYY') AS CURRENT_DATE FROM DUAL;

21.	Display all the Driver names with prefixing 'HANDLER'
SELECT Name,
       CONCAT('HANDLER ', Name) AS DRIVER_NAME
FROM driver;

22.	Display the last three characters of Address of all drivers.
SELECT SUBSTR(Address, -3) AS Last_Three_Characters FROM driver;

23.	Display the detailes of all drivers , if a address city contains more than one driver.

SELECT *
FROM driver
WHERE Address IN (
    SELECT Address
    FROM Driver
    GROUP BY Address
    HAVING COUNT(*) > 1
);

24.	Display the details (diver id , driver name regnum , car model ,report num , locatin ) those damage amount is more than 10000.

SELECT CI.Driver_Id,
       D.Name,
       CI.Reg_Num,
       C.Car_Model,
       CI.Report_Num,
       A.Location
FROM claim_insurance CI
JOIN driver D
ON CI.Driver_Id = D.Driver_license_id
JOIN car C
ON CI.Reg_Num = C.Reg_Num
JOIN accident A
ON CI.Report_Num = A.Report_Num
WHERE CI.Damage_amount > 10000;

25.	Display the total damage amount.
SELECT SUM(Damage_amount) from claim_insurance;

26.	Display the carwise damage amount

SELECT C.Reg_Num,
       C.Car_Model,
       SUM(CI.Damage_amount) AS Total_Damage_Amount
FROM car C
JOIN claim_insurance CI
ON C.Reg_Num = CI.Reg_Num
GROUP BY C.Reg_Num, C.Car_Model;

29.	Display the next day of today.
SELECT SYSDATE + 1 FROM DUAL;

30.	Display the day of today(like monday or tuesday etc..)
SELECT TO_CHAR(SYSDATE, 'DAY') AS TODAY FROM DUAL;

31.	Create a table driver_dup from driver table.
CREATE TABLE driver_dup AS
SELECT * FROM driver;

33.	Display all  the names of drivers in lower case.
SELECT LOWER(Name) AS Driver_Name FROM driver;

34.	Display all the car models as First letter of the word should be capital.
SELECT INITCAP(Car_Model) AS Car_Model FROM car;

36.	Show the difference  between truncate and drop.
// Truncate: Delete the records, cannot rollback
TRUNCATE TABLE emp_test;
// Drop : Delete entire table
DROP TABLE emp_test;

37.	Add a column to driver table , and rename a column of driver table.
ALTER TABLE driver add Phone_Number NUMBER(10);
ALTER TABLE driver RENAME COLUMN Phone_Number TO GENDER;

38.	Find the position of Second 'a' in "Las vegas".
SELECT INSTR('Las vegas', 'a', 1, 2) FROM DUAL;

39.	Add a check constraing to the damage amount column( damage amount should not be more than 50000 and should not be less than 1000)
ALTER TABLE claim_insurance
ADD CONSTRAINT chk_amount
CHECK (Damage_amount >= 1000 AND Damage_amount <= 50000);

40.	Update driver name steve to stephen.
UPDATE driver
SET Name = 'Stephen'
WHERE Name = 'Steve';


Note: Use EMP , DEPT , SALGRADE tables for 41 to 45
----------------------------------------------------

41.	 Display the Manager Names.
SELECT DISTINCT E.ENAME AS MANAGER_NAME
FROM emp E
JOIN emp M
ON E.EMPNO = M.MGR;


42.	 Display the names of employees who earn  Highest salaries respective departments.
SELECT E.EMPNO, E.ENAME, E.DEPTNO, E.SAL
FROM EMP E
WHERE SAL = (
    SELECT MAX(SAL) FROM EMP
    WHERE DEPTNO = E.DEPTNO
);

43. Display the Employees whose manager is Jones and Display manager name also in Result.
SELECT E.ENAME AS EMPLOYEE_NAME,
       M.ENAME AS MANAGER_NAME
FROM emp E
JOIN emp M
on E.EMPNO = M.MGR
WHERE M.ENAME = 'JONES';

44.	 Display the all employees information(name, job , his manager) , if employee dont have a manager then display his manager information as NO MANAGER.
SELECT E.ENAME AS EMPLOYEE_NAME,
	   E.JOB,
    CASE
	    WHEN M.ENAME IS NULL THEN 'NO MANAGER'
        ELSE M.ENAME
    END AS MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M
ON E.MGR = M.EMPNO;

45.	  Display employee name,dept name,salary,and commission for those sal in between 2000 to 5000 while location is Chicago.
SELECT E.ENAME, D.DNAME, E.SAL, E.COMM
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.SAL BETWEEN 2000 AND 5000
AND D.LOC = 'CHICAGO';

