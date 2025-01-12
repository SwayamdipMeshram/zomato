CREATE DATABASE Project;
USE Project;

-- Q.1
CREATE TABLE Salespeople(snum INT PRIMARY KEY,
						 sname VARCHAR(50) NOT NULL,
                         city VARCHAR(50) NOT NULL,
                         comm DECIMAL(10,2) );
                         
INSERT INTO Salespeople VALUES (1001, "Peel", "London", 0.12),
						       (1002, "Serres", "San Jose", 0.13),
                               (1003, "Axelrod", "New york", 0.10),
                               (1004, "Motika", "London", 0.11),
                               (1007, "Rafkin", "Barcelona", 0.15);
                               
SELECT * FROM Salespeople;

-- Q.2

CREATE TABLE Custtable(cnum INT PRIMARY KEY,
					   cname VARCHAR(50) NOT NULL,
                       city VARCHAR(50) NOT NULL,
                       rating INT NOT NULL,
                       snum INT,
                       FOREIGN KEY (snum) REFERENCES Salespeople(snum)
                       );
INSERT INTO Custtable VALUES(2001, "Hoffman", "London", 100, 1001),
							(2002, "Giovanne", "Rome", 200, 1003),
                            (2003, "Liu", "San Jose", 300, 1002),
                            (2004, "Grass", "Berlin", 100, 1002),
                            (2006, "Clemens", "London", 300, 1007),
                            (2007, "Pereira", "Rome", 100, 1004),
							(2008, "James", "London", 200, 1007);

SELECT * FROM Custtable;

-- Q.3

CREATE TABLE Orders (onum INT PRIMARY KEY,
					amt DECIMAL(10,5) NOT NULL,
                    odate DATE,
                    cnum INT ,
                    snum INT, 
                    FOREIGN KEY (cnum) REFERENCES Custtable(cnum),
                    FOREIGN KEY (snum) REFERENCES Salespeople(snum) 
                    ON UPDATE CASCADE ON DELETE CASCADE );

INSERT INTO Orders VALUES
    (3001, 18.69, '1994-10-03', 2008, 1007),
    (3002, 1900.10, '1994-10-03', 2007, 1004),
    (3003, 767.19, '1994-10-03', 2001, 1001),
    (3005, 5160.45, '1994-10-03', 2003, 1002),
    (3006, 1098.16, '1994-10-04', 2008, 1007),
    (3007, 75.75, '1994-10-05', 2004, 1002),
    (3008, 4723.00, '1994-10-05', 2006, 1001),
    (3009, 1713.23, '1994-10-04', 2002, 1002),
    (3010, 1309.95, '1994-10-06', 2004, 1002),
    (3011, 9891.88, '1994-10-06', 2006, 1001);
    
-- Q.4
SELECT * 
FROM Salespeople s
JOIN Custtable c ON s.city = c.city;

-- Q.5 
SELECT c.cname AS CustomerName, s.sname AS SalespersonName
FROM Custtable c
JOIN Salespeople s ON c.snum = s.snum;

-- Q.6
SELECT o.onum, o.amt, o.odate, c.cname AS CustomerName, s.sname AS SalespersonName
FROM Orders o
JOIN Custtable c ON o.cnum = c.cnum
JOIN Salespeople s ON c.snum = s.snum
WHERE c.city <> s.city;

-- Q.7
SELECT o.onum AS OrderNumber, c.cname AS CustomerName
FROM Orders o
JOIN Custtable c ON o.cnum = c.cnum;


-- Q.8
SELECT c1.cname AS Customer1, c2.cname AS Customer2, c1.rating AS Rating
FROM Custtable c1
JOIN Custtable c2 ON c1.rating = c2.rating
WHERE c1.cnum < c2.cnum;

-- Q.9
SELECT c1.cname AS Customer1, c2.cname AS Customer2, s.sname AS Salesperson
FROM Custtable c1
JOIN Custtable c2 ON c1.snum = c2.snum
JOIN Salespeople s ON c1.snum = s.snum
WHERE c1.cnum < c2.cnum;

-- Q.10
SELECT s1.sname AS Salesperson1, s2.sname AS Salesperson2, s1.city AS City
FROM Salespeople s1
JOIN Salespeople s2 ON s1.city = s2.city
WHERE s1.snum < s2.snum;

-- Q.11
SELECT o.onum AS OrderNumber, o.amt AS Amount, o.odate AS OrderDate, s.sname AS SalespersonName
FROM Orders o
JOIN Custtable c ON o.cnum = c.cnum
JOIN Salespeople s ON c.snum = s.snum
WHERE s.snum = (SELECT snum FROM Custtable WHERE cnum = 2008);

-- Q.12
SELECT *
FROM Orders
WHERE amt > (SELECT AVG(amt) FROM Orders WHERE odate = '1994-10-04');

-- Q.13
SELECT o.*,s.sname As SalesPerson, s.city
FROM Orders o
JOIN Custtable c ON o.cnum = c.cnum
JOIN Salespeople s ON c.snum = s.snum
WHERE s.city = 'London';

-- Q.14
SELECT * 
FROM Custtable 
WHERE cnum = (SELECT snum + 1000 FROM Salespeople WHERE sname = 'Serres');


-- Q.15
SELECT COUNT(*) 
FROM Custtable
WHERE rating > (SELECT AVG(rating) FROM Custtable WHERE city = 'San Jose');

-- Q.16
SELECT s.sname, COUNT(c.cnum) AS CustomerCount
FROM Salespeople s
JOIN Custtable c ON s.snum = c.snum
GROUP BY s.sname;