Create and insert data into tables for based on the following schema and data:
------------------------------------------------------------------------------
1. Sailors (Sid: integer[pk], sname: string, rating: integer, age: real)
Sid	Sname	Rating	Age
22	Dustin	7	45.0
29	Brutus	1	33.0
31	Lubber	8	55.5
32	Andy	8	25.5
58	Rusty	10	35.0
64	Horatio	7	35.0
71	Zorba	10	16.0
74	Horatio	9	35.0
85	Art	3	25.5
95	Bob	3	63.5

SQL> CREATE TABLE sailors (
        sid INTEGER CONSTRAINT sailors_pk PRIMARY KEY,
        sname VARCHAR2(80),
        rating INTEGER,
        age REAL
     );

INSERT INTO sailors (sid, sname, rating, age) VALUES (22, 'Dustin', 7, 45.0);
INSERT INTO sailors (sid, sname, rating, age) VALUES (29, 'Brutus', 1, 33.0);
INSERT INTO sailors (sid, sname, rating, age) VALUES (31, 'Lubber', 8, 55.5);
INSERT INTO sailors (sid, sname, rating, age) VALUES (32, 'Andy', 8, 25.5);
INSERT INTO sailors (sid, sname, rating, age) VALUES (58, 'Rusty', 10, 35.0);
INSERT INTO sailors (sid, sname, rating, age) VALUES (64, 'Horatio', 7, 35.0);
INSERT INTO sailors (sid, sname, rating, age) VALUES (71, 'Zorba', 10, 16.0);
INSERT INTO sailors (sid, sname, rating, age) VALUES (74, 'Horatio', 9, 35.0);
INSERT INTO sailors (sid, sname, rating, age) VALUES (85, 'Art', 3, 25.5);
INSERT INTO sailors (sid, sname, rating, age) VALUES (95, 'Bob', 3, 63.5);

2. Boats (bid: integer[pk], bname: string, color: string)
Bid Bname	    Color
101	Interlake	Blue
102	Interlake	Red
103	Clipper	    Green
104	Marine	    Red

SQL> CREATE TABLE boats (
        bid INTEGER CONSTRAINT boats_pk PRIMARY KEY,
        bname VARCHAR2(30),
        color VARCHAR2(10)
     );

INSERT INTO boats (bid, bname, color) VALUES (101, 'Interlake', 'Blue');
INSERT INTO boats (bid, bname, color) VALUES (102, 'Interlake', 'Red');
INSERT INTO boats (bid, bname, color) VALUES (103, 'Clipper', 'Green');
INSERT INTO boats (bid, bname, color) VALUES (104, 'Marine', 'Red');

3. Reserves (Sid: integer[fk of sailors], bid: integer[fk of boats], day: date)
Sid	Bid	Day
22	101	10/10/98
22	102	10/10/98
22	103	10/8/98
22	104	10/7/98
31	102	11/10/98
31	103	11/6/98
31	104	11/12/98
64	101	9/5/98
64	102	9/8/98
74	103	9/8/98

SQL> CREATE TABLE reserves (
        sid INTEGER,
        bid INTEGER,
        day DATE,
        PRIMARY KEY(sid, bid),
        FOREIGN KEY(sid) REFERENCES sailors(sid),
        FOREIGN KEY(bid) REFERENCES boats(bid)
     );

INSERT INTO reserves (sid, bid, day) VALUES (22, 101, TO_DATE('10/10/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (22, 102, TO_DATE('10/10/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (22, 103, TO_DATE('10/8/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (22, 104, TO_DATE('10/7/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (31, 102, TO_DATE('11/10/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (31, 103, TO_DATE('11/6/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (31, 104, TO_DATE('11/12/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (64, 101, TO_DATE('9/5/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (64, 102, TO_DATE('9/8/98', 'MM/DD/YY'));
INSERT INTO reserves (sid, bid, day) VALUES (74, 103, TO_DATE('9/8/98', 'MM/DD/YY'));

1. Find the names and ages of all sailors.
SQL> SELECT sname, age FROM sailors;

2. Find the names of sailors who have reserved boat number 103
SQL>  SELECT s.sname
      FROM sailors s
      JOIN reserves r
        ON s.sid = r.sid
      WHERE r.bid = 103;

3. Find the names of sailors who have reserved a red boat
SQL> SELECT s.sname
     FROM sailors s
     JOIN reserves r
        ON s.sid = r.sid
     JOIN boats b
        ON r.bid = b.bid
     WHERE b.color = 'Red';

4. Find the colors of boats reserved by Lubber
SQL> SELECT DISTINCT b.color
     FROM boats b
     JOIN reserves r
        ON b.bid = r.bid
     JOIN sailors s
        ON r.sid = s.sid
     WHERE s.sname = 'Lubber';

5. Compute the increments for the ratings of persons who have sailed two different boats on same day

6. Find the names of sailors who have reserved a red and a green boat
SQL> SELECT DISTINCT s.sname
     FROM sailors s
     JOIN reserves r
        ON s.sid = r.sid
     JOIN boats b
        ON r.bid = b.bid
     WHERE b.color IN ('Red', 'Green')
     GROUP By s.sname
     HAVING COUNT(DISTINCT b.color) = 2;

7. Find Sid’s of sailors who have rating of 10 or reserved boat 104
SQL> SELECT s.sid
     FROM sailors s
     JOIN reserves r
        ON s.sid = r.sid
     WHERE s.rating = 10 OR r.bid = 104;

SQL> SELECT s.sid
     FROM sailors s
     WHERE s.rating = 10
     UNION
     SELECT r.sid
     FROM reserves r
     WHERE r.bid = 104;

8. Find the names of sailors who have reserved a red boat [use sub query]
SQL> SELECT s.sname
     FROM sailors s
     WHERE s.sid IN (
         SELECT r.sid
         FROM reserves r
         JOIN boats b
            ON r.bid = b.bid
         WHERE b.color = 'Red'
     );

9. Find sailors whose rating is better than some sailor called Horatio
SQL> SELECT * FROM sailors
     WHERE rating > ANY (
        SELECT rating FROM sailors
        WHERE sname = 'Horatio'
    );

10.	Find the sailors with highest rating
SQL> SELECT * FROM sailors
     WHERE rating = (SELECT MAX(rating) FROM sailors);

11. Find the average age of sailors
SQL> SELECT AVG(age) FROM sailors;

12. Find the name and age of oldest sailor
SQL> SELECT sname, age
     FROM sailors
     WHERE age = (
        SELECT MAX(age) FROM sailors
     );

13. Find the names of sailors who are older than oldest sailor with a rating of 10
SQL> SELECT sname FROM sailors
     WHERE age > (
        SELECT MAX(age)
        FROM sailors
        WHERE rating = 10
    );

14.	Find the age of the youngest sailor who is eligible to vote(18) for each rating level with at lest two such sailors
SQL> SELECT rating, MIN(age) AS youngest_age
     FROM sailors
     WHERE age >= 18
     GROUP BY rating
     HAVING COUNT(*) >= 2;

15.	Find the average age of sailors for each rating level that has at least two sailors
SQL> SELECT rating,  AVG(age) AS avg_age
     FROM sailors
     GROUP BY rating
     HAVING COUNT(*) >= 2;

16. Find the average age of sailors who are of voting age (18) for each rating level that has at least two such sailors
SQL> SELECT rating, AVG(age) AS avg_age
     FROM sailors
     WHERE age >= 18
     GROUP BY rating
     HAVING COUNT(*) >= 2;

17. Find those ratings for which the average age of sailors is the minimum over all ratings
SQL> SELECT rating, AVG(age) AS avg_age
     FROM sailors
     GROUP BY rating
     HAVING AVG(age) = (
        SELECT MIN(avg_age)
        FROM (
            SELECT AVG(age) AS avg_age
            FROM sailors
            GROUP BY rating
        )
     );

18.	Add a  column ‘model’(string) to boat  table;
SQL> ALTER TABLE boats ADD model VARCHAR2(10);

19.	Resize the ‘model’ column of boat table  to 20 char;
SQL> ALTER TABLE boats MODIFY model VARCHAR2(20);

20. Rename the column ‘model’ to ‘type’
SQL> ALTER TABLE boats RENAME COLUMN model TO type;

21. Add constraint not null on column ‘sname’ of sailors table.
SQL> ALTER TABLE sailors
     MODIFY sname CONSTRAINT sname_NN NOT NULL;

22.	Update the column ‘color’ of a boat table  to ‘green’ bid=10.
SQL> UPDATE boats
     SET color = 'green'
     WHERE bid = 10;

23. Create a view ‘sailor_vw’ on sailors table with this columns(sid,rating)
SQL> CREATE VIEW sailor_vw AS
     SELECT sid, rating
     FROM sailors;

24. Drop the view ‘sailor-vw’
SQL> DROP VIEW sailor_vw;

25. Create a sequence sail_seq for sailors table.
SQL> CREATE SEQUENCE sail_seq
     START WITH 1
     INCREMENT BY 1;

26. Select the current available sequence no from emp_sq
SQL> SELECT emp_sq.CURRVAL FROM DUAL;

27. Select the next available sequence no from emp_sq
SQL> SELECT emp_sq.NEXTVAL FROM DUAL;

28.	Find the remainder of a 1002.50 divided by 2.75 using a sql function
SQL> SELECT MOD(1002.50, 2.75) AS remainder FROM DUAL;

29.	Print all sname of sailors in UPPER Case;
SQL> SELECT UPPER(sname) FROM sailors;

30. Print all boat names with first letter as capital letter.
SQL> SELECT INITCAP(bname) FROM boats;

31. Print boat name and color in a single string using sql function.
SQL> SELECT CONCAT(CONCAT(bname, ' '), color) AS boat_details FROM boats;

32. Print the last 3 characters of sname column of sailors table.
SQL> SELECT SUBSTR(sname, -3) AS sub_str FROM sailors;

33. Print the name of a boat along with its length using sql function.
SQL> SELECT bname, LENGTH(bname) AS boat_length FROM boats;

34. Print all sailor names from 2nd char to 5th char using sql function.
SQL> SELECT SUBSTR(sname, 2, 5) AS sub_str FROM sailors;

35.	Print all values of column ‘color’ suffixing with ‘prokarama’.
SQL> SELECT CONCAT(color, 'PROKARMA') FROM boats ;

36. Make default value for column ‘bname’ of boat table as ‘boat99’.
SQL> ALTER TABLE boats
     MODIFY bname DEFAULT 'boat99';

37. Give select and insert privilege on boats table to user dba99
SQL> GRANT SELECT, INSERT
     ON boats
     TO dba99;

38. Create a table emp_sailor with the same structure  as sailor table;
SQL> CREATE TABLE emp_sailor
     AS
     SELECT * FROM sailors;

39.Insert records into emp_sailor from sailors table.
SQL> INSERT INTO emp_sailor
     SELECT *
     FROM sailors;

40.Remove select, insert privilege on boats table from user dba99.
SQL> REVOKE SELECT, INSERT
     ON boats
     FROM dba99;
41.	Print all dates by adding one month to the existing date on day column of a reserves table.
SQL> SELECT ADD_MONTHS(day,1) FROM reserves;

42. Print the current date in format (mmm-dd-yyyy:hh:mm:ss).
SQL> SELECT TO_CHAR(SYSDATE, 'MON-DD-YYYY:HH24:MI:SS') AS formatted_date FROM DUAL;

43. Return the no of months between these dates 07th jan 2008 to 27th aug 2010.
SQL> SELECT MONTHS_BETWEEN(TO_DATE('27-AUG-2010', 'DD-MON-YYYY'), TO_DATE('07-JAN-2008', 'DD-MON-YYYY')) AS month_diff FROM DUAL;

44. Print the next date of the sys date;
SQL> SELECT SYSDATE + 1 AS next_date FROM DUAL;

45. Update rating of all employees according to the following conditions
Rating	updated value  [use ‘case’]
 > 7	8
 5-7	7
 1-4	6

SQL> UPDATE sailors
     SET rating =
        CASE
            WHEN rating > 7 THEN 8
            WHEN rating BETWEEN 5 AND 7 THEN 7
            WHEN rating BETWEEN 1 AND 4 THEN 6
            ELSE NULL
     END;

