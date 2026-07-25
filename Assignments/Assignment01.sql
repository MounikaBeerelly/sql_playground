1. Create a table employee with empno number(4),ename varchar2(40),job varchar2(20),mgr number(4),
 hiredate date,sal number(10,2),comm number(10)

CREATE TABLE EMPLOYEE1(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(40),
    JOB VARCHAR2(20),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(10,2),
    COMM NUMBER(10)
 );

2.add a column deptno varchar2(2) to employee

ALTER TABLE EMPLOYEE1 ADD DEPTNO VARCHAR2(2);

3.change the deptno datatype to number.

ALTER TABLE EMPLOYEE1 MODIFY DEPTNO NUMBER(2);

4.rename employee table as employ

RENAME EMPLOYEE1 TO EMPLOY;

5.drop table employ

DROP TABLE EMPLOY;

6. insert 5 unique rows into employee table

INSERT INTO EMPLOY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(1101, 'John', 'Manager', 1001, Date '2022-07-10', 60000.00, 3000, 20);

INSERT INTO EMPLOY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(1102, 'Jane Smith', 'Analyst', 1101, Date '2021-03-22', 60000.00, 3000, 20);

INSERT INTO EMPLOY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(1103, 'Mike Johnson', 'Clerk', 1102, Date '2022-07-10', 40000.00, 2000, 30);

INSERT INTO EMPLOY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(1104, 'Emily Davis', 'Salesperson', 1101, Date '2019-11-05', 55000.00, 2500, 10);

INSERT INTO EMPLOY (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(1105, 'David Wilson', 'Technician', 1103, Date '2023-02-18', 45000.00, 1500, 20);

7. update sal of employees by 10%

UPDATE EMPLOY SET SAL = SAL * 1.10;

8.delete all the employees of dept 10

DELETE FROM EMPLOY WHERE DEPTNO = 10;

9.increase commission for deptno 20 employees.

UPDATE EMPLOY SET COMM = COMM + 500 WHERE DEPTNO = 20;

10.Display the total salary and total commission to all employees

SELECT SUM(SAL) AS TOTAL_SALARY,
       SUM(COMM) AS TOTAL_COMMISSION
FROM EMPLOY;

11. Display the maximum salary from emp table

SELECT MAX(SAL) FROM EMPLOY;

12.Display the minimum salary from emp table

SELECT MIN(SAL) FROM EMPLOY;

13.Display the average salary from emp table

SELECT AVG(SAL) FROM EMPLOY;

14. Display the maximum salary being paid to CLERK

SELECT MAX(SAL) FROM EMP WHERE JOB = 'CLERK';

15.Display the maximum salary being paid in dept no 20

SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 20;

16.Display the minimum salary being paid to any SALESMAN

SELECT MIN(SAL) FROM EMP WHERE JOB = 'SALESMAN';

17.Display the average salary drawn by managers

SELECT AVG(SAL) FROM EMP WHERE JOB = 'MANAGER';

18.Display the total salary drawn by analyst working in dept no 40
SELECT SUM(SAL) AS TOTAL_SALARY
FROM EMP
WHERE JOB = 'ANALYST', DEPTNO = 40;

19. Display Department numbers and total number of employees working in each Department?
SELECT DEPTNO, COUNT(*) AS TOTAL_EMPLOYEES FROM EMP GROUP BY DEPTNO;

20. Display the various jobs and total number of employees working in each job group?
SELECT JOB, COUNT(*) AS TOTAL_EMPLOYEES FROM EMP GROUP BY JOB;

21.Display department numbers and Total Salary for each Department?
SELECT DEPTNO, SUM(SAL) AS TOTAL_SALARY FROM EMP GROUP BY DEPTNO;

22.Display department numbers and Maximum Salary from each Department?
SELECT DEPTNO, MAX(SAL) AS MAXIMUM_SALARY FROM EMP GROUP BY DEPTNO;

23.Display various jobs and Total Salary for each job?
SELECT JOB, SUM(SAL) AS TOTAL_SALARY FROM EMP GROUP BY JOB;

24.Display each job along with min of salary being paid in each job group?
SELECT JOB, MIN(SAL) AS MINIMUN_SALARY FROM EMP GROUP BY JOB;

25. Display the department Number with more than three employees in each department?
SELECT DEPTNO, COUNT(*) AS TOTAL_EMPLOYEES FROM EMP GROUP BY DEPTNO HAVING COUNT(*) > 3;

26. Display various jobs along with total salary for each of the job where total salary is greater than 40000?
SELECT JOB, SUM(SAL) AS TOTAL_SALARY FROM EMP GROUP BY JOB HAVING SUM(SAL) > 40000;

27. Display the various jobs along with total number of employees in each job.The
output should contain only those jobs with more than three employees?

SELECT JOB, COUNT(*) AS TOTAL_EMPLOYEES FROM EMP GROUP BY JOB HAVING COUNT(*) > 3;

28. Display the names of employees in Upper Case?
SELECT UPPER(ENAME) AS EMPLOYEE_NAME FROM EMP;

29. Display the names of employees in Lower Case?
SELECT LOWER(ENAME) AS EMPLOYEE_NAME FROM EMP;

30. Find the length of your name using Appropriate Function?
SELECT LENGTH('William') AS NAME_LENGTH FROM DUAL;

31. Display the length of all the employee names?
SELECT LENGTH(ENAME) AS NAME_LENGTH FROM EMP;

32. Display the name of employee Concatinate with Employee Number?
SELECT CONCAT(ENAME, EMPNO) AS EMPLOYEE_INFO FROM EMP;

33. Use appropriate function and extract 3 characters starting from 2 characters from the following string 'Oracle' i.e., the out put should be ac?
select substr('oracle', 3, 2) as extracted_string from dual;

34. Find the first occurance of character a from the following string Computer Maintenance Corporation?
SELECT INSTR('COMPUTER MAINTENANCE CORPORATION', 'A') AS FIRST_OCCURRENCE FROM DUAL;

35. Display the information from the employee table . where ever job Manager is found it should be displayed as Boss?
SELECT EMPNO, ENAME, JOB,
       DECODE (JOB,
        'MANAGER', 'BOSS',
        JOB
       ) AS NEW_JOB
FROM emp;

SELECT EMPNO, ENAME, JOB,
         CASE
            WHEN JOB = 'MANAGER' THEN 'BOSS'
            ELSE JOB
            END AS NEW_JOB
FROM emp;

36. Display employ records in the format of "Scott has joined the company on 13th August ninteen ninety"
SELECT ENAME || ' has joined the company on ' || TO_CHAR(HIREDATE, 'DDTH MONTH YYYY') AS EMPLOYEE_INFO FROM EMP;

37. Find the nearest Saturday after Current date?
SELECT NEXT_DAY(SYSDATE, 'SATURDAY') AS NEAREST_SATURDAY FROM DUAL;

38. Display the current time?
SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24"MI"SS') AS CURRENT_TIME FROM DUAL;

39. Display the date three months before the Current date?
SELECT ADD_MONTHS(SYSDATE, -3) AS DATE_THREE_MONTHS_AGO FROM DUAL;

40. find how many " o's " we have in a word, example:- If I pass 'Corporation' it should return 3
SELECT LENGTH('CORPORATION') - LENGTH(REPLACE('CORPORATION', 'O', '')) AS COUNT_OF_O FROM DUAL;