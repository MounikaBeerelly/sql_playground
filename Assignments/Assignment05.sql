Create and insert data into tables for based on the following schema and data:
----------------------------------OoO------------------------------------------
1. Student( snum: integer, sname: string, major: string, level: string, age: integer)
Snum	     Sname			  Major			    level	 age
051135593,	Maria White,	  English,		    SR,	     21
060839453,	Charles Harris,	  Computer Science	SR,	     22
099354543,	Susan Martin,	  Law,			    JR,	     20
112348546,	Joseph Thompson,  Computer Science,	SR,	     19
573284895,	Steven Green,	  Kinesiology,		SR,	     19
574489456,	Betty Adams,	  Economics,		JR,	     20

SQL> CREATE TABLE student (
        snum NUMBER(10),
        sname VARCHAR2(50),
        major VARCHAR2(50),
        student_level VARCHAR2(20),
        age NUMBER(3)
     );

INSERT INTO student(snum, sname, major, student_level, age) VALUES(051135593, 'Maria White', 'English', 'SR', 21);
INSERT INTO student(snum, sname, major, student_level, age) VALUES(060839453, 'Charles Harris', 'Computer Science', 'SR', 22);
INSERT INTO student(snum, sname, major, student_level, age) VALUES(099354543, 'Susan Martin', 'Law', 'JR', 20);
INSERT INTO student(snum, sname, major, student_level, age) VALUES(112348546, 'Joseph Thompson', 'Computer Science', 'SR', 19);
INSERT INTO student(snum, sname, major, student_level, age) VALUES(573284895, 'Steven Green', 'Kinesiology', 'SR', 19);
INSERT INTO student(snum, sname, major, student_level, age) VALUES(574489456, 'Betty Adams', 'Economics', 'JR', 20);

2. Class(name : string, meets_at: time, room: string, fid: integer)
CName		        meets_at		    Room		Fid
Data Structures,	MWF 10,		        R128,		142519864
Database Systems,	MWF 12:30-1:45,1	320 DCL,	142519864
Operating System,	TuTh 12-1:20,20 	AVW,		242518965
Archaeology,		MWF 3-4:15,		    R128,		356187925
Aviation Accident,	TuTh 1-2:50,		Q3,		    254099823
Air Quality,		TuTh 10:30-11:45,	R15,		011564812

SQL> CREATE TABLE class (
        cname VARCHAR2(50),
        meets_at VARCHAR2(20),
        room VARCHAR2(20),
        fid NUMBER(10)
     );

INSERT INTO class(cname, meets_at, room, fid) VALUES('Data Structures', 'MWF 10', 'R128', 142519864);
INSERT INTO class(cname, meets_at, room, fid) VALUES('Database Systems', 'MWF 12:30-1:45', '320 DCL', 142519864);
INSERT INTO class(cname, meets_at, room, fid) VALUES('Operating System', 'TuTh 12-1:20', 'AVW', 242518965);
INSERT INTO class(cname, meets_at, room, fid) VALUES('Archaeology', 'MWF 3-4:15', 'R128', 356187925);
INSERT INTO class(cname, meets_at, room, fid) VALUES('Aviation Accident', 'TuTh 1-2:50', 'Q3', 254099823);
INSERT INTO class(cname, meets_at, room, fid) VALUES('Air Quality', 'TuTh 10:30-11:45', 'R15', 011564812);

3. Enrolled(snum:integer, cname:string)
Snum		    Cname
112348546,		Database Systems
060839453,		Database Systems
051135593,		Operating System Design
112348546,		Operating System Design
573284895,		Air Quality Engineering
060839453,		Data Structures

SQL> CREATE TABLE enrolled (
        snum NUMBER(10),
        cname VARCHAR2(50)
     );

INSERT INTO enrolled(snum, cname) VALUES(112348546, 'Database Systems');
INSERT INTO enrolled(snum, cname) VALUES(060839453, 'Database Systems');
INSERT INTO enrolled(snum, cname) VALUES(051135593, 'Operating System Design');
INSERT INTO enrolled(snum, cname) VALUES(112348546, 'Operating System Design');
INSERT INTO enrolled(snum, cname) VALUES(573284895, 'Air Quality Engineering');
INSERT INTO enrolled(snum, cname) VALUES(060839453, 'Data Structures');

4. Faculty(fid: integer, fname: string, deptid: integer)
Fid			    Fname			Deptid
142519864,		Ivana Teach,		20
242518965,		James Smith,		68
141582651,		Mary Johnson,		20
011564812,		John Williams,	    68
254099823,		Patricia Jones,		68
356187925,		Robert Brown,		12

SQL> CREATE TABLE faculty (
        fid NUMBER(10),
        fname VARCHAR2(50),
        deptid NUMBER(10)
     );

INSERT INTO faculty(fid, fname, deptid) VALUES(142519864, 'Ivana Teach', 20);
INSERT INTO faculty(fid, fname, deptid) VALUES(242518965, 'James Smith', 68);
INSERT INTO faculty(fid, fname, deptid) VALUES(141582651, 'Mary Johnson', 20);
INSERT INTO faculty(fid, fname, deptid) VALUES(011564812, 'John Williams', 68);
INSERT INTO faculty(fid, fname, deptid) VALUES(254099823, 'Patricia Jones', 68);
INSERT INTO faculty(fid, fname, deptid) VALUES(356187925, 'Robert Brown', 12);

Questions:
..........

1. Find the names of all juniors(jr) who are enrolled in a class  taught by ‘Ivana Teach’
SELECT s.sname
FROM student s
JOIN enrolled e
    ON s.snum = e.snum
JOIN class c
	ON e.cname = c.cname
JOIN faculty f
	ON c.fid = f.fid
WHERE f.fname = 'Ivana Teach'
	AND s.student_level = 'JR';

2. Find the age of oldest student who is either computer science major or enrolled in a course taught by ‘John Williams’

STEP 1: Find the age of oldest student who is a computer science major
SELECT MAX(s.age) AS oldest_age
FROM student s
WHERE s.major = 'Computer Science';

STEP 2: Find the number of the student who is enrolled in a course taught by ‘John Williams’
SELECT s.snum
FROM student s
JOIN enrolled e
    ON s.snum = e.snum
JOIN class c
	ON e.cname = c.cname
JOIN faculty f
	ON c.fid = f.fid
WHERE f.fname = 'John Williams';

STEP 3: Find the age of the oldest student who is either a computer science major or enrolled in a course taught by ‘John Williams’
SELECT MAX(s.age) AS oldest_age
FROM student s
WHERE s.major = 'Computer Science'
    OR s.snum IN (
        SELECT s.snum
        FROM student s
        JOIN enrolled e
            ON s.snum = e.snum
        JOIN class c
            ON e.cname = c.cname
        JOIN faculty f
            ON c.fid = f.fid
        WHERE f.fname = 'John Williams'
    );

3. Find the names of all classes that either meet in room ‘R128’ or have two or more students enrolled.

STEP 1: Find the names of all classes that meet in room ‘R128’
SELECT c.cname
FROM class c
WHERE c.room = 'R128';

STEP 2: Find the names of all classes that have two or more students enrolled
SELECT c.cname
FROM class c
JOIN enrolled e
    ON c.cname = e.cname
GROUP BY c.cname
HAVING COUNT(e.snum) >= 2;

STEP 3: Find the names of all classes that either meet in room ‘R128’ or have two or more students enrolled
SELECT c.cname
FROM class c
WHERE c.room = 'R128'
    OR c.cname IN (
        SELECT c.cname
        FROM class c
        JOIN enrolled e
            ON c.cname = e.cname
        GROUP BY c.cname
        HAVING COUNT(e.snum) >= 2
    );

4. Find the names of two students who are enrolled in two classes or  comes to the same class twice in a day

STEP 1: Find the names of students who are enrolled in two classes
SELECT s.sname
FROM student s
JOIN enrolled e
    ON s.snum = e.snum
GROUP BY s.sname
HAVING COUNT(e.cname) >= 2;

STEP 2: Find the names of students who come to the same class twice in a day
SELECT s.sname
FROM student s
JOIN enrolled e
    ON s.snum = e.snum
JOIN class c
    ON e.cname = c.cname
GROUP BY s.sname, c.cname, c.meets_at
HAVING COUNT(*) >= 2;

STEP 3: Find the names of two students who are enrolled in two classes or come to the same class twice in a day
SELECT s.sname
FROM student s
JOIN enrolled e
    ON s.snum = e.snum
JOIN class c
    ON e.cname = c.cname
GROUP BY s.sname, c.cname, c.meets_at
HAVING COUNT(*) >= 2
    OR s.sname IN (
        SELECT s.sname
        FROM student s
        JOIN enrolled e
            ON s.snum = e.snum
        GROUP BY s.sname
        HAVING COUNT(e.cname) >= 2
    );

5.	Find the names of all faculty who teach classes in at least two rooms
SELECT f.fname
FROM faculty f
JOIN class c
	ON f.fid = c.fid
GROUP BY f.fname
HAVING COUNT(c.room) >=2;

6. Print the level and average age of students for that level, each level.
SELECT student_level, AVG(age) AS average_age
FROM student
GROUP BY student_level;

7. Print the names of faculty members that has taught class only in ‘R15’
SELECT f.fname
FROM faculty f
JOIN class c
	ON f.fid = c.fid
WHERE c.room = 'R15'
	AND f.fid NOT IN (
		SELECT f.fid
		FROM faculty f
		JOIN class c
			ON f.fid = c.fid
		WHERE c.room != 'R15'
	);

8. Find the names of students enrolled in max no of classes.
SELECT s.sname
FROM student s
JOIN enrolled e
    ON s.snum = e.snum
GROUP BY s.sname
HAVING COUNT(e.cname) = (
    SELECT MAX(class_count)
    FROM (
        SELECT COUNT(cname) AS class_count
        FROM enrolled
        GROUP BY snum
    ) counts
);

9. Find the names of students not enrolled even in any class.
SELECT s.sname
FROM student s
WHERE s.snum NOT IN (
    SELECT e.snum
    FROM enrolled e
);

10. Find the names of faculties who have not assigned at least a class.
SELECT f.fname
from faculty f
WHERE f.fid NOT IN (
    SELECT c.fid
    FROM class c
);

11.	Find the youngest student  for each level(SR,JR)
SELECT s.student_level, MIN(s.age) AS youngest_age
FROM student s
GROUP BY s.student_level;

SELECT student_level, sname, age
FROM (
    SELECT student_level, age, sname,
        ROW_NUMBER() OVER(PARTITION BY student_level ORDER BY age) AS row_num
        FROM student
)
WHERE row_num = 1;

12. Find the faculty name that belongs to dept  20 and teaches a class to student name ‘Charles Harris’.

STEP 1: Find the faculty name that belongs to dept 20
SELECT f.fname
FROM faculty f
WHERE f.deptid = 20;

STEP 2: Find the faculty name that teaches a class to student name ‘Charles Harris’
SELECT f.fname
FROM faculty f
JOIN class c
    ON f.fid = c.fid
JOIN enrolled e
    ON c.cname = e.cname
JOIN student s
    ON e.snum = s.snum
WHERE s.sname = 'Charles Harris';

STEP 3: Find the faculty name that belongs to dept 20 and teaches a class to student name ‘Charles Harris’
SELECT DISTINCT f.fname
FROM faculty f
JOIN class c
    ON f.fid = c.fid
JOIN enrolled e
    ON c.cname = e.cname
JOIN student s
    ON e.snum = s.snum
WHERE f.deptid = 20
    AND s.sname = 'Charles Harris';

13.	Find the deptno in which max no of faculties are working and print their names and class names.
SELECT f.deptid, f.fname, c.cname
FROM faculty f
JOIN class c
    ON f.fid = c.fid
WHERE f.deptid = (
    SELECt deptid
    FROM (
        SELECT deptid, COUNT(fid) AS faculty_count
        FROM faculty
        GROUP BY deptid
        ORDER BY faculty_count DESC
    )
    WHERE ROWNUM = 1
);

14.	Find the name(cname) of the class in which max no of students enrolled along with the count
STEP 1: Find the class name with the number of students enrolled
SELECT cname, COUNT(snum) AS student_count
FROM enrolled
GROUP BY cname;

STEP 2: Find the maximum number of students enrolled in class
SELECT MAX(student_count) AS max_student_count
FROM (
    SELECT cname, COUNT(snum) AS student_count
    FROM enrolled
    GROUP BY cname
);

STEP 3: Find the name(cname) of the class in which max no of students enrolled along with the count
SELECT cname, COUNT(*) AS student_count
FROM enrolled
GROUP BY cname
HAVING COUNT(*) = (
    SELECT MAX(class_count)
    FROM (
        SELECT COUNT(*) AS class_count
        FROM enrolled
        GROUP BY cname
    ) counts
);

15.	Find the snum, sname, age, cname of students who have enrolled for Database systems and age must be in between 19 to 22
SELECT s.snum, s.sname, s.age, e.cname
FROM student s
JOIN enrolled e
    ON s.snum = e.snum
WHERE e.cname = 'Database Systems'
    AND s.age BETWEEN 19 AND 22;

16.	Find the name of the class in which no student is enrolled.
SELECT c.cname
FROM class c
WHERE c.cname NOT IN (
    SELECT e.cname FROM enrolled e
);

17.	Print snum, sname, cname, fname for the students who have enrolled.
SELECT s.snum, s.sname, e.cname, f.fname
FROM enrolled  e
JOIN student s
	ON e.snum = s.snum
JOIN class c
	ON e.cname = c.cname
JOIN faculty f
	ON c.fid= f.fid;

18.	Add a  column 'address'(string) to student  table;
ALTER TABLE student ADD address VARCHAR2(40);

19.	Resize the 'address' column of  student  table  to 20 char;
ALTER TABLE student MODIFY address VARCHAR2(20);

20.	Rename the column 'address' to 'postal'
ALTER TABLE student RENAME COLUMN address TO postal;

21.	Add constraint not null on column 'sname' of students table.
ALTER TABLE student MODIFY sname CONSTRAINT student_nn NOT NULL;

22.	Update the column 'room' of a class table where cname is data structures.
UPDATE class
SET room  = 'NEW ROOM'
WHERE cname = 'Data Structures';

23.	Create a view 'view_stu' on students table with this columns(snum, sname, age)
CREATE VIEW view_stu
AS
SELECT snum, sname, age FROM student;

24.	Insert a new record into view 'view-stu'.
INSERT INTO view_stu(snum, sname, age)
VALUES(101, 'Jakes', 32);

25.	Drop the view 'view-stu'
DROP VIEW view_stu;

26.	create a sequence stu_seq for student table.
CREATE SEQUENCE stu_seq
START WITH 1
INCREMENT BY 1;

27.	Select the current available sequence no from stu_sq
SELECT stu_seq.CURRVAL FROM DUAL;

28.	Select the next available sequence no from stu_sq
SELECT stu_seq.NEXTVAL FROM DUAL;

29.	Find the remainder of a 12023.50 divided by 34.550 using a sql function
SELECT MOD(12023.50, 34.550) AS remainder FROM DUAL;

30.	Print all sname students in UPPER Case;
SELECT UPPER(sname) AS names FROM student;

31.	Print all cname of class table with first letter as capital letter.
SELECT INITCAP(cname) AS class_names FROM class;

32.	Print class name and room in a single string using sql function.
SELECT CONCAT(cname, room) AS class_room FROM class;

33.	Print the last 3 characters of sname column of students table.
SELECT SUBSTR(sname, -3) AS last_three_char FROM student;

34.	Print the name of class along with its length using sql function.
SELECT cname, length(cname) AS length FROM class;

35.	Print all faculty names from 2nd char to 5th char using sql function.
SELECT SUBSTR(fname, 2, 5) AS sub_string FROM faculty;

36.	Print all values of column 'cname' suffixing with 'prokarama'.
SELECT CONCAT(cname, 'prokarma') AS suffix FROM class;

37.	Make default value for column 'room' of class table as 'R15'.
ALTER TABLE class
MODIFY room DEFAULT 'R15';

38.	Give select and insert privilege on class  table to user dba99
GRANT SELECT, INSERT
ON class
TO dba99;

39. Create a table emp_stu with the same structure  as student table;
CREATE TABLE emp_stu
AS
SELECT * FROM student
WHERE 1 = 2;

40. Insert records into emp_stu from student  table.
INSERT INTO emp_stu
SELECT *
FROM student;

41. Remove select, insert privilege on class table from  user dba99.
REVOKE SELECT, INSERT
ON class
FROM dba99;

42. Create an index on column snum of studnets table.
CREATE INDEX studentsnum ON student(snum);

43. Print the current date in format (mmm-dd-yyyy:hh:mm:ss).
SELECT TO_CHAR(sysdate, 'MON-DD-YYYY:HH24:MI:SS') FROM DUAL;

44.	Return the no of months between these dates 07th jan 2008 to 27th aug 2010.
SELECT ROUND(MONTHS_BETWEEN(TO_DATE('27-AUG-2010', 'DD-MON-YYYY'), TO_DATE('07-JAN-2008', 'DD-MON-YYYY'))) AS months FROM DUAL;

45.	Print the last day of the month.
SELECT LAST_DAY(sysdate) AS last_day FROM DUAL;

46.	Update level  of all employees according to the following conditions
Age 	updated value  [use 'case']
19		JR
20		JR
21		SR
22		SR

UPDATE student
SET student_level = (
	CASE age
		WHEN 19 THEN 'JR'
		WHEN 20 THEN 'JR'
		WHEN 21 THEN 'SR'
		WHEN 22 THEN 'SR'
        END
    );
