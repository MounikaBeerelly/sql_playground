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
