flights(fno: integer, from: string, to: string, distance: integer,departs: time, arrives: time, price: real)

CREATE TABLE flights (
	FNO NUMBER,
	FROM_CITY VARCHAR2(30),
    TO_CITY VARCHAR2(30),
    DISTANCE INTEGER,
    DEPARTS DATE,
    ARRIVES DATE,
    PRICE NUMBER(10,2)
);

aircraft(aid: integer, aname: string, cruisingrange: integer)

CREATE TABLE aircraft (
	AID NUMBER,
	ANAME VARCHAR2(30),
	CRUISINGRANGE NUMBER
);

certifed(eid: integer, aid: integer)

CREATE TABLE certified (
	EID NUMBER,
	AID NUMBER
);

employees(eid: integer, ename: string, salary: integer)

CREATE TABLE EMPLOYEES (
	EID NUMBER,
	ENAME VARCHAR2(30),
    SALARY NUMBER
);


1.	find the names of aircraft such that all pilots certified
    to operate them have salaries more than $80,000.

SELECT ENAME FROM employees where SALARY > 80000;

2.	for each pilot who is certified for more than three aircraft,
    find the eid and the maximum cruising range of the aircraft for which she or he is certified.

SELECT EID FROM certified WHERE AID > 3;
SELECT MAX(CRUISINGRANGE) FROM aircraft ;

SELECT C.EID,
    MAX(CRUISINGRANGE) AS MAX_CRUISING_RANGE
FROM certified C JOIN aircraft A
ON C.AID = A.AID
GROUP BY C.EID
HAVING COUNT(C.AID) > 3;

3.	find the names of pilots whose salary is less than the price of the cheapest
    route from los angeles to honolulu.

SELECT MIN(PRICE) FROM flights WHERE FROM_CITY = 'los angeles' AND TO_CITY = 'Honolulu';

SELECT E.ENAME FROM employees E
WHERE E.SALARY < (SELECT MIN(F.PRICE) FROM flights F
    WHERE F.FROM_CITY = 'los angeles' AND F.TO_CITY = 'Honolulu');

4.	find the names of pilots certified for some boeing aircraft.

SELECT A.AID FROM aircraft A WHERE A.ANAME LIKE 'boeing%';

SELECT DISTINCT E.ENAME
FROM employees E JOIN certified C
ON E.EID = C.EID
JOIN aircraft A
ON C.AID = A.AID
WHERE A.ANAME LIKE 'boeing%';

5.	find the aids of all aircraft that can be used on routes from los angeles to chicago.
SELECT F.DISTANCE FROM flights F WHERE F.FROM_CITY = 'los angeles' AND F.TO_CITY = 'Chicago';

SELECT A.AID FROM aircraft A
WHERE A.CRUISINGRANGE >= (
    SELECT F.DISTANCE FROM flights F WHERE F.FROM_CITY = 'los angeles' AND F.TO_CITY = 'Chicago'
);

6.	identify the routes that can be piloted by every pilot who makes more than $100,000.

SELECT EID, ENAME FROM employees WHERE SALARY > 100000;

SELECT C.AID
FROM certified C JOIN employees E
ON E.EID = C.EID
WHERE E.SALARY > 100000;

SELECT F.FROM_CITY, F.TO_CITY
FROM flights F
WHERE NOT EXISTS (
    SELECT E.EID
    FROM employees E
    WHERE E.SALARY > 100000
    AND NOT EXISTS (
        SELECT C.AID
        FROM certified C
        WHERE C.EID = E.EID AND C.AID IN (
            SELECT A.AID
            FROM aircraft A
            WHERE A.CRUISINGRANGE >= F.DISTANCE
        )
    )
)

7.	print the enames of pilots who can operate planes with cruisingrange greater than 3000 miles
    but are not certified on any boeing aircraft.

SELECT A.AID, A.CRUISINGRANGE
FROM aircraft A
WHERE A.CRUISINGRANGE > 3000
AND A.ANAME NOT LIKE 'boeing%';

SELECT C.EID
FROM certified C JOIN aircraft A
ON C.AID = A.AID
WHERE A.CRUISINGRANGE > 3000
AND A.ANAME NOT LIKE 'boeing%';

SELECT DISTINCT E.ENAME
FROM employees E JOIN certified C
ON E.EID = C.EID
WHERE C.AID IN (
    SELECT A.AID
    FROM aircraft A
    WHERE A.CRUISINGRANGE > 3000
    AND A.ANAME NOT LIKE 'boeing%'
);

8.	compute the deference between the average salary of a pilot
    and the average salary of all employees (including pilots).

SELECT AVG(SALARY) as EMP_SALARY FROM employees;

SELECT AVG(SALARY) AS PILOT_SALARY FROM employees E WHERE E.EID IN (SELECT C.EID FROM certified C);

SELECT (
    SELECT AVG(SALARY) as EMP_SALARY FROM employees
) - (
    SELECT AVG(SALARY) AS PILOT_SALARY FROM employees E WHERE E.EID IN (SELECT C.EID FROM certified C)
)
AS SLARY_DIFFERENCE FROM DUAL;

9.	print the name and salary of every nonpilot whose salary
    is more than the average salary for pilots.

SELECT ENAME, SALARY
FROM employees E
WHERE E.EID NOT IN (SELECT C.EID FROM certified C)
AND E.SALARY > (
    SELECT AVG(SALARY)
    FROM employees E2
    WHERE E2.EID
    IN (
        SELECT C2.EID FROM certified C2
        )
);

10.	print the names of employees who are certified only on aircrafts with
    cruising range longer than 1000 miles.

SELECT AID, CRUISINGRANGE FROM aircraft WHERE CRUISINGRANGE > 1000;

SELECT E.ENAME FROM employees E
WHERE E.EID IN (
    SELECT C.EID FROM certified C
    WHERE C.AID IN (
        SELECT A.AID FROM aircraft A
        WHERE A.CRUISINGRANGE > 1000
    )
);

11.	print the names of employees who are certified only on aircrafts with cruising range
    longer than 1000 miles, but on at least two such aircrafts.

SELECT E.ENAME FROM employees E
WHERE E.EID IN (
    SELECT C.EID FROM certified C
    WHERE C.AID IN (
        SELECT A.AID FROM aircraft A
        WHERE A.CRUISINGRANGE > 1000
    )
)
AND (
    SELECT COUNT(*) FROM certified C2
    WHERE C2.EID = E.EID
    AND C2.AID IN (
        SELECT A.AID FROM aircraft A
        WHERE A.CRUISINGRANGE > 1000
    )
) >= 2

12.	print the names of employees who are certified only on aircrafts with cruising range
    longer than 1000 miles and who are certified on some boeing aircraft.

SELECT E.ENAME FROM employees E
WHERE E.EID IN (
    SELECT C.EID FROM certified C
    WHERE C.AID IN (
        SELECT A.AID FROM aircraft A
        WHERE A.CRUISINGRANGE > 1000
    )
)
AND E.EID IN (
    SELECT C.EID FROM certified C
    WHERE C.AID IN (
        SELECT A.AID FROM aircraft A
        WHERE A.ANAME LIKE 'boeing%'
    )
)

13.	find the eids of pilots certified for some boeing aircraft.

SELECT DISTINCT C.EID
FROM certified C
WHERE C.AID IN (
    SELECT A.AID FROM aircraft A
    WHERE A.ANAME LIKE 'boeing%'
);

14.	find the names of pilots certified for some boeing aircraft.

SELECT DISTINCT E.ENAME
FROM employees E
JOIN certified C ON C.EID = E.EID
WHERE C.AID IN (
    SELECT A.AID FROM aircraft A
    WHERE A.ANAME LIKE 'boeing%'
);

15.	find the aids of all aircraft that can be used on non-stop flights from bonn to madras.

SELECT F.DISTANCE FROM flights F WHERE F.FROM_CITY = 'bonn' AND F.TO_CITY = 'madras';

SELECT A.AID FROM aircraft A
WHERE A.CRUISINGRANGE >= (
    SELECT F.DISTANCE FROM flights F WHERE F.FROM_CITY = 'bonn' AND F.TO_CITY = 'madras'
);

16.	identify the  flights that can be piloted by every pilot whose salary is more than $100,000.

SELECT SALARY FROM employees WHERE SALARY > 100000;

SELECT C.EID FROM certified C JOIN employees E ON E.EID = C.EID WHERE E.SALARY > 100000;

SELECT F.FROM_CITY, F.TO_CITY
FROM flights F
WHERE NOT EXISTS (
    SELECT E.EID
    FROM employees E
    WHERE E.SALARY > 100000
    AND NOT EXISTS (
        SELECT C.AID
        FROM certified C
        WHERE C.EID = E.EID AND C.AID IN (
            SELECT A.AID
            FROM aircraft A
            WHERE A.CRUISINGRANGE >= F.DISTANCE
        )
    )
);

17.	find the names of pilots who can operate planes with a range greater than 3,000 miles but
    are not credited on any boeing aircraft.

SELECT DISTINCT E.ENAME
FROM employees E
WHERE E.EID IN (
    SELECT C.EID FROM certified C
    WHERE C.AID IN (
        SELECT A.AID FROM aircraft A
        WHERE A.CRUISINGRANGE > 3000
    )
)
AND E.EID NOT IN (
    SELECT C.EID FROM certified C
    WHERE C.AID IN (
        SELECT A.AID FROM aircraft A
        WHERE A.ANAME LIKE 'boeing%'
    )
);

18.	find the eids of employees who make the highest salary.

SELECT EID
FROM employees
WHERE SALARY = (
    SELECT MAX(SALARY) FROM employees
);

19.	find the eids of employees who make the second highest salary.

SELECT EID
FROM employees
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM employees
    WHERE SALARY < (
        SELECT MAX(SALARY) FROM employees
    )
);

20.	find the eids of employees who are credited for the largest number of aircraft.

SELECT EID, COUNT(EID)
FROM certified
GROUP BY EID
HAVING COUNT(EID) = (
    SELECT MAX(COUNT(EID))
    FROM certified
    GROUP BY EID
);

21.	find the eids of employees who are credited for exactly three aircraft.

SELECT EID
FROM certified
GROUP BY EID
HAVING COUNT(EID) = 3;

22.	find the total amount paid to employees as salaries.

SELECT SUM(SALARY) AS TOTAL_SALARY FROM employees;

23.	add a column age to the employees table.

ALTER TABLE employees ADD (AGE NUMBER);

24.	change the primary key column on flights table from fno to fno and departs column (composite).

ALTER TABLE flights ADD CONSTRAINT PK_FLIGHTS PRIMARY KEY (FNO, DEPARTS);

25.	add a not null column sex to the employee table with default value as ‘m’.

ALTER TABLE employees ADD (SEX VARCHAR2(6) DEFAULT 'm' NOT NULL);

Note:use emp  , dept , salgrade  tables for following questions.

26.	 display the manager names.
SELECT ENAME FROM emp WHERE JOB = 'MANAGER';

SELECT DISTINCT E.ENAME AS MANAGER_NAME
FROM emp E
JOIN emp M
ON E.EMPNO = M.MGR;

27.	 display the names of employees who earn  highest salaries respective departments.
SELECT E.ENAME, E.SAL, E.DEPTNO
FROM emp E
WHERE E.SAL = (
    SELECT MAX(SAL) FROM emp
    WHERE DEPTNO = E.DEPTNO
);

28.	display the employees whose manager is jones and display manager name also in result.
SELECT E.ENAME AS EMPLOYEE_NAME,
       M.ENAME AS MANAGER_NAME
FROM emp E
JOIN emp M
ON E.MGR = m.EMPNO
WHERE M.ENAME = 'JONES';

29.	  display employee name,dept name,salary,and commission for those sal in between 2000 to 5000 while location is chicago.
SELECT ENAME, DNAME, SAL, COMM
FROM emp E
JOIN dept D
ON E.DEPTNO = D.DEPTNO
WHERE SAL BETWEEN 2000 AND 5000
AND LOC = 'CHICAGO';



