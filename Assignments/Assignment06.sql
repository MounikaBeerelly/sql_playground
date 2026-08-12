Create the following tables and insert data into them:
------------------------------------------------------

1. Suppliers (sid: integer, sname: string, address: string)
Sid	sname				    address
1,	Acme Widget Suppliers,	"1 Grub St., Potemkin Village, IL 61801"
2,	Big Red Tool and Die,	"4 My Way, Bermuda Shorts, OR 90305"
3,	Perfunctory Parts,		"99999 Short Pier, Terra Del Fuego, TX 41299"
4,	Alien Aircaft Inc.,		"2 Groom Lake, Rachel, NV 51902"

CREATE TABLE suppliers (
    sid NUMBER(5),
    sname VARCHAR2(50),
    address VARCHAR2(30)
);

INSERT INTO suppliers (sid, sname, address)
    VALUES (1, 'Acme Widget Suppliers', '1 Grub St., Potemkin Village, IL 61801');
INSERT INTO suppliers (sid, sname, address)
    VALUES (2, 'Big Red Tool and Die', '4 My Way, Bermuda Shorts, OR 90305');
INSERT INTO suppliers (sid, sname, address)
    VALUES (3, 'Perfunctory Parts', '99999 Short Pier, Terra Del Fuego, TX 41299');
INSERT INTO suppliers (sid, sname, address)
    VALUES (4, 'Alien Aircaft Inc.', '2 Groom Lake, Rachel, NV 51902');


2. Parts (pid: integer, pname: string, color: string)
Pid	pname						            color
1	Left Handed Bacon Stretcher Cover,		Red
2,	Smoke Shifter End,				        Black
3,	Acme Widget Washer,			            Red
4	Acme Widget Washer,			            Silver
5,	I Brake for Crop Circles Sticker,		Translucent
6,	Anti-Gravity Turbine Generator,		    Cyan
7,	Anti-Gravity Turbine Generator		    Magenta
8,	Fire Hydrant Cap,				        Red
9,	7 Segment Display,				        Green

CREATE TABLE parts(
    pid NuMBER(5),
    pname VARCHAR2(30),
    color VARCHAR2(15)
);

INSERT INTO parts (pid, pname, color)
    VALUES (1, 'Left Handed Bacon Stretcher Cover', 'Red');
INSERT INTO parts (pid, pname, color)
    VALUES (2, 'Smoke Shifter End', 'Black');
INSERT INTO parts (pid, pname, color)
    VALUES (3, 'Acme Widget Washer', 'Red');
INSERT INTO parts (pid, pname, color)
    VALUES (4, 'Acme Widget Washer', 'Silver');
INSERT INTO parts (pid, pname, color)
    VALUES (5, 'I Brake for Crop Circles Sticker', 'Translucent');
INSERT INTO parts (pid, pname, color)
    VALUES (6, 'Anti-Gravity Turbine Generator', 'Cyan');
INSERT INTO parts (pid, pname, color)
    VALUES (7, 'Anti-Gravity Turbine Generator', 'Magenta');
INSERT INTO parts (pid, pname, color)
    VALUES (8, 'Fire Hydrant Cap', 'Red');
INSERT INTO parts (pid, pname, color)
    VALUES (9, '7 Segment Display', 'Green');

3. Catalog(sid: integer, pid: integer, cost: real)
Sid	pid	cost
1,	3,	0.50
1,	4,	0.50
1,	8,	11.70
2,	3,	0.55
2	8,	7.95
2,	1,	16.50
3,	8,	12.50
3,	9,	1.00
4,	5,	2.20
4,	6,	1247548.23
4,	7,	1247548.23

CREATE TABLE catalog (
    sid NUMBER(5),
    pid NUMBER(5),
    cost REAL
);

INSERT INTO catalog (sid, pid, cost)
    VALUES ( 1, 3, 0.50);
INSERT INTO catalog (sid, pid, cost)
    VALUES (1, 4, 0.50);
INSERT INTO catalog (sid, pid, cost)
    VALUES (1, 8, 11.70);
INSERT INTO catalog (sid, pid, cost)
    VALUES (2, 3, 0.55);
INSERT INTO catalog (sid, pid, cost)
    VALUES (2, 8, 7.95);
INSERT INTO catalog (sid, pid, cost)
    VALUES (2, 1, 16.50);
INSERT INTO catalog (sid, pid, cost)
    VALUES (3, 8, 12.50);
INSERT INTO catalog (sid, pid, cost)
    VALUES (3, 9, 1.00);
INSERT INTO catalog (sid, pid, cost)
    VALUES (4, 5, 2.20);
INSERT INTO catalog (sid, pid, cost)
    VALUES (4, 6, 1247548.23);
INSERT INTO catalog (sid, pid, cost)
    VALUES (4, 7, 1247548.23);


QUESTIONS:
**********

1. Find the pnames of parts for which there is no supplier
SELECT p.pname
FROM parts p
WHERE p.pid NOT IN (
    SELECT pid from catalog
);

SELECT p.pname
FROM parts p
WHERE NOT EXISTS (
    SELECT c.pid FROM catalog c
    WHERE c.pid = p.pid
);

2. Find the names of suppliers who supply every part.
SELECT s.sname
FROM suppliers s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM parts p
    WHERE NOT EXISTS (
        SELECT c.pid
        FROM catalog c
        WHERE c.pid = p.pid
            AND c.sid = s.sid
    )
);

SELECT s.sname
FROM suppliers s
JOIN catalog c
    ON s.sid = c.sid
GROUP BY s.sid, s.sname
HAVING COUNT(DISTINCT c.pid) = (
    SELECT COUNT(*)
    FROM parts
);

3. Find the names of suppliers who supply every red part.
SELECT s.sname
FROM suppliers s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM parts p
    WHERE p.color = 'Red'
        AND NOT EXISTS (
            SELECT c.pid
            FROM catalog c
            WHERE c.sid = s.sid
                AND c.pid = p.pid
        )
);


SELECT s.sname
FROM suppliers s
JOIN catalog c
    ON s.sid = c.sid
JOIN parts p
    ON p.pid = c.pid
WHERE p.color = 'Red'
GROUP BY s.sid, s.sname
HAVING COUNT(DISTINCT p.pid) = (
    SELECT COUNT(*)
    FROM parts
    WHERE color = 'Red'
);

4. Find the names of suppliers who supply a red part and a green part
SELECT s.sname
FROM suppliers s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM parts p
    WHERE p.color IN ('Red', 'Green')
        AND NOT EXISTS (
            SELECT c.pid
            FROM catalog c
            WHERE s.sid = c.sid
                AND p.pid = c.pid
        )
);

5. Find the names of suppliers who supply a red part or a green part
SELECT DISTINCT s.sname
FROM suppliers s
JOIN catalog c
    ON s.sid = c.sid
JOIN parts p
    ON c.pid = p.pid
WHERE p.color IN ('Red', 'Green');

6.	Find the pnames of parts supplied by “Alien Aircaft Inc.”
SELECT SISTINCT p.pname
FROM parts p
JOIN catalog c
    ON p.pid = c.pid
WHERE c.sid = (
    SELECT s.sid
    FROM suppliers s
    WHERE s.sname = 'Alien Aircaft Inc.'
);

SELECT DISTINCT p.pname
FROM suppliers s
JOIN catalog c
    ON s.sid = c.sid
JOIN parts p
    ON c.pid = p.pid
WHERE s.sname = 'Alien Aircaft Inc.';

7.	Find the names of suppliers who only red part
SELECT s.sname
FROM suppliers s
WHERE EXISTS (
    SELECT 1
    FROM catalog c
    JOIN parts p
        ON p.pid = c.pid
    WHERE c.sid = s.sid
      AND p.color = 'Red'
)
AND NOT EXISTS (
    SELECT 1
    FROM catalog c
    JOIN parts p
        ON p.pid = c.pid
    WHERE c.sid = s.sid
      AND p.color <> 'Red'
);

8.	For each part, find the sname of the supplier who charges most for that part.
SELECT pname, sname, cost
FROM (
    SELECT p.pname,
           s.sname,
           c.cost,
           RANK() OVER(
            PARTITION BY c.pid ORDER BY c.cost DESC
            ) rnk
           FROM catalog c
           JOIN parts p
            ON p.pid = c.pid
           JOIN suppliers s
            ON c.sid = s.sid
    )
WHERE rnk = 1;

9.	For each part, find the sname of the supplier who charges less for that part
SELECT pid, pname, sname, cost
FROM (
    SELECT p.pname,
           s.sname,
           c.cost,
           c.pid,
           RANK() OVER(PARTITION BY c.pid ORDER BY c.cost ASC) AS rnk
           FROM catalog c
           JOIN suppliers s
            ON c.sid = s.sid
           JOIN parts p
            ON c.pid = p.pid
    )
WHERE rnk = 1;

10.	Find the avg cost of the red part supplied by all suppliers.
SELECT AVG(c.cost) AS avg_cost
FROM catalog c
JOIN parts p
    ON c.pid = p.pid
WHERE p.color = 'Red';

11. For every supplier that supplies a green part and a red part. Print the name and price of the most expensive part that she supplies.
SELECT s.sname, MAX(c.cost) AS max_cost
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
JOIN parts p ON c.pid = p.pid
GROUP BY s.sid, s.sname
HAVING COUNT (
    DISTINCT CASE
        WHEN p.color IN ('Red', 'Green') THEN p.color
       END) = 2;

12. For every supplier that only supplies green parts, print the name of the supplier and the total number of parts that she supplies.
SELECT s.sname, COUNT(*) AS total_parts
FROM suppliers s
JOIN catalog c
    ON s.sid = c.sid
JOIN parts p
    ON p.pid = c.pid
GROUP BY s.sname, s.sid
HAVING COUNT(*) = SUM (
    CASE
        WHEN p.color = 'Green' THEN 1
        ELSE 0
        END
);

13.	Find the sname of supplier who doesn’t supply a red part
SELECT s.sname
FROM suppliers s
WHERE NOT EXISTS (
    SELECT c.sid
    FROM catalog c
    JOIN parts p
        ON p.pid = c.pid
    WHERE s.sid = c.sid
        AND p.color = 'Red'
);

14.	Find the sname of supplier who doesn’t supply a red part and a green part.
SELECT s.sname
FROM suppliers s
WHERE NOT EXISTS (
    SELECT c.sid
    FROM catalog c
    JOIN parts p
        ON p.pid = c.pid
    WHERE s.sid = c.sid
        AND p.color IN ('Red', 'Green')
);

15.	Find the colors of parts that supplied by ‘Acme Widget Suppliers.
SELECT DISTINCT p.color
FROM parts p
JOIN catalog c
    ON p.pid = c.pid
JOIN suppliers s
    ON c.sid = s.sid
WHERE s.sname = 'Acme Widget Suppliers';

16.	Find the most expensive part and its supplier name.
SELECT DISTINCT sname, pname, cost
FROM (
    SELECT s.sname,
           p.pname,
           c.cost,
           RANK() OVER(ORDER BY c.cost DESC) rnk
           FROM catalog c
           JOIN parts p
            ON c.pid = p.pid
           JOIN suppliers s
            ON s.sid = c.sid
    )
WHERE rnk = 1;

SELECT s.sname, p.pname, c.cost
FROM catalog c
JOIN suppliers s
    ON s.sid = c.sid
JOIN parts p
    ON p.pid = c.pid
WHERE c.cost = (
    SELECT MAX(cost)
    FROM catalog
);

17.	Calculate the no of different parts supplied by supplier ‘Big Red Tool and Die’.
SELECT COUNT(c.pid) AS count
FROM catalog c
JOIN parts p
    ON c.pid = p.pid
JOIN suppliers s
    ON s.sid = c.sid
WHERE s.sname = 'Big Red Tool and Die';

18.	Find the name of the customer who supplies part ‘Fire Hydrant Cap’.
SELECT s.sname
FROm suppliers s
JOIN catalog c
    ON s.sid = c.sid
JOIN parts p
    ON c.pid = p.pid
WHERE p.pname = 'Fire Hydrant Cap';

19.	Find the name of the parts which are supplied in color ‘Cyan’.
SELECT pname
FROM parts
WHERE color = 'Cyan';

20.	Find the name of the supplier who supplies only one part.
SELECT s.sname
FROM suppliers s
JOIN catalog c
    ON s.sid = c.sid
GROUP BY s.sid, s.sname
HAVING COUNT(c.pid) = 1;

21.	Add a column 'cmm level'(string) to supplier  table;
ALTER TABLE suppliers ADD cmm_level VARCHAR2(10);

22.	Resize the 'cmm level' column of supplier  table  to 20 char;
ALTER TABLE suppliers MODIFY cmm_level VARCHAR2(20);

23.	Rename the column ‘cmm level’ to ‘category’
ALTER TABLE suppliers RENAME COLUMN cmm_level TO category;

24. Add constraint not null on column ‘sname’ of supplier table.
ALTER TABLE suppliers MODIFY sname CONSTRAINT supp_nn NOT NULL;

25. Update the column ‘color’ of a parts table  to ‘green’ where it is red.
UPDATE parts
SET color = 'Green'
WHERE color = 'Red';

26.	Create a view ‘supp_vw’ on supplier table with this columns(sid,sname)
CREATE VIEW supp_vw
AS
SELECT sid, sname FROM suppliers;

27.	Insert a new record into view ‘supp-vw’.
INSERT INTO supp_vw(sid, sname)
    VALUES(101, 'John Berkely');

28. Add a column to view ‘‘supp_vw’.
CREATE OR REPLACE VIEW supp_vw
AS
SELECT sid, sname, address FROM suppliers;

29.	Drop the view ‘supp_vw’
DROP VIEW supp_vw;

30.	create a sequence supp_seq for supplier table.
CREATE SEQUENCE supp_sq
START WITH 1
INCREMENT BY 1;

31.	Select the current available sequence no from supp_sq
SELECT supp_sq.CURRVAL AS current_Val FROM DUAL;

32. Select the next available sequence no from supp_sq
SELECT supp_sq.NEXTVAL AS next_Val FROM DUAL;

33.	Find the remainder of a 1002.50 divided by 2.75 using a sql function
SELECT MOD(1002.50, 2.75) AS remainder FROM DUAL;

34.	 Find the square of the number 33 using sql function
SELECT POWER(33, 2) AS square FROM DUAL;

35.	Print all sname of suppliers in UPPER Case;
SELECT UPPER(sname) AS names FROM suppliers;

36.	Print all part names with first letter as capital letter.
SELECT INITCAP(pname) AS capital FROM parts;

37.	Print part  name and color in a single string using sql function.
SELECT CONCAT(CONCAT(pname, ' '), color) AS comb_string FROM parts;

38.	Print the last 3 characters of sname column of supplier table.
SELECT SUBSTR(sname, -3) AS last_three_char FROM suppliers;

39.	Print all values of column ‘color’ suffixing with ‘prokarama’.
SELECT CONCAT(color, 'prokarma') AS suffix FROM parts;

40.	Replace all occurrences of value green with black.
UPDATE parts
SET color = 'Black'
WHERE color = 'Green';

41.	Create an index on column sid of supplier table.
CREATE INDEX suppliersid ON suppliers(sid);

42.	Print the current date in format (mmm-dd-yyyy:hh:mm:ss).
SELECT TO_CHAR(sysdate, 'MON-DD-YYYY:HH24:MI:SS') FROM DUAL;

43.	Return the no of months between these dates 07th jan 2008 to 27th aug 2010.
SELECT ROUND(MONTHS_BETWEEN(TO_DATE('27-AUG-2010', 'DD-MON-YYYY'), TO_DATE('07-JAN-2008', 'DD-MON-YYYY'))) AS months FROM DUAL;

44.	Print the next date of the sys date;
SELECT SYSDATE+1 AS next_day FROM DUAL;

45.	Print the last day of the month.
SELECT LAST_DAY(SYSDATE) AS last_day FROM DUAL;
