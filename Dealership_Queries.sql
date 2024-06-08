-- Hayden Gentry -- 
-- 1a -- 

DROP DATABASE IF EXISTS DEALERSHIP;
CREATE DATABASE DEALERSHIP;
USE DEALERSHIP;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE VEHICLE
	(VID INT NOT NULL,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    MDate DATE NOT NULL,
    Color VARCHAR(50) NOT NULL,
    UNIQUE(VID),
    PRIMARY KEY(VID));
    
CREATE TABLE ASSOCIATE
	(AID CHAR(10) NOT NULL,
    AName VARCHAR(100) NOT NULL,
    Position VARCHAR(25) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    SuperAID CHAR(10) NULL,
    UNIQUE(AID),
    PRIMARY KEY(AID),
    FOREIGN KEY(SuperAID) REFERENCES ASSOCIATE(AID));
    
CREATE TABLE CUSTOMER
	(Ssn CHAR(9) NOT NULL,
    CName VARCHAR(100) NOT NULL,
    Details VARCHAR(250) NULL,
    PRIMARY KEY(Ssn));
    
CREATE TABLE VTRANSACTION
	(TID INT NOT NULL,
    TTime DATETIME NOT NULL, 
    VID INT NOT NULL,
    AID CHAR(10) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Price DECIMAL(10,2),
    UNIQUE(VID, AID),
    PRIMARY KEY(TID),
    FOREIGN KEY(VID) REFERENCES VEHICLE(VID),
    FOREIGN KEY(AID) REFERENCES ASSOCIATE(AID),
    FOREIGN KEY(Ssn) REFERENCES CUSTOMER(Ssn));

INSERT INTO VEHICLE
	VALUES
(1, 'Model X','Firebird','2010-01-01','Burnt Orange'),
(2, 'Model X','Firebird','2012-03-01','Bright Red'),
(3, 'Model X','Phoenix','2018-06-01','Burnt Orange'),
(4, 'Model Y','Tracker','2015-09-01','Deep Green'),
(5, 'Model Y','Tracker','2016-02-01','Steel Blue'),
(6, 'Model Y','Seeker','2020-02-01','Sky Blue');

INSERT INTO ASSOCIATE
	VALUES
('AAAAA11111', 'Alice Ko','CEO',160000,NULL),
('BBBBB22222', 'Bob Jones','Sales Director',100000,'AAAAA11111'),
('CCCCC33333', 'Addy Wallace','Sales Representative',60000,'BBBBB22222'),
('DDDDD44444', 'Tim Serran','Sales Representative',50000,'BBBBB22222');

INSERT INTO CUSTOMER
	VALUES
('123456789', 'Customer 1',NULL),
('999999999', 'Customer 2','Sales Credit: 23000'),
('987654321', 'Customer 3','Banned from Dealership'),
('111111111', 'Customer 4',NULL);

INSERT INTO VTRANSACTION
	VALUES
(101, '2015-07-12 08:00:00',1,'BBBBB22222','123456789', 20500),
(102, '2016-03-09 09:30:00',2,'BBBBB22222','999999999', 22000),
(103, '2016-09-22 11:10:00',4,'BBBBB22222','987654321', -12001),
(104, '2018-11-18 16:40:00',3,'DDDDD44444','123456789', 24400),
(105, '2020-11-17 12:40:00',6,'CCCCC33333','111111111', 28400),
(106, '2020-11-17 12:40:00',5,'CCCCC33333','111111111', -15731),
(107, '2021-03-04 18:10:00',3,'BBBBB22222','123456789', -17061);

SET FOREIGN_KEY_CHECKS = 1;

-- 1b --
-- Q1: Find the CName,TID, and VID identifying each CUSTOMER, VTRANSACTION, and VEHICLE pairing involving a 'Burnt Orange' vehicle --
SELECT C.CName, T.TID, V.VID
FROM CUSTOMER AS C JOIN VTRANSACTION AS T ON C.Ssn = T.Ssn JOIN VEHICLE AS V ON V.VID = T.VID
WHERE V.Color = 'Burnt Orange';

-- Q2: Pair every the AName of every ASSOCIATE with the TID, TTime, and Price of every transaction with which he/she is paired. --
-- If he/she is not paired with a transaction, he or she should appear once alongside NULL values --
SELECT A.Aname, T.TID, T.TTime, T.Price
FROM ASSOCIATE AS A JOIN VTRANSACTION AS T ON A.AID = T.AID;

-- Q3. Find the total amount of money passed through the dealership. --
-- Purchases (denoted with a negative value in the transaction table) MUST be added instead of deducted from the total --
SELECT SUM(Price) AS NetRevenue
FROM VTRANSACTION;

-- Q4. Find the total count of associates who have had a purchase transaction (i.e Price is negative) --
SELECT COUNT(DISTINCT A.AID) AS Associates
FROM ASSOCIATE AS A JOIN VTRANSACTION AS T ON A.AID = T.AID 
WHERE T.Price < 0;

-- Q5: Find the vehicle id, associate name, and transaction price for the highest total sales (pos. values only) in the database. --
SELECT T.VID, A.Aname, T.Price
FROM ASSOCIATE AS A JOIN VTRANSACTION AS T ON A.AID = T.AID 
WHERE T.Price = (SELECT MAX(T.Price)
				FROM VTRANSACTION AS T);