DROP TABLE Sales_person CASCADE CONSTRAINTS;
DROP TABLE Order_Details CASCADE CONSTRAINTS;
DROP TABLE Sales_Order CASCADE CONSTRAINTS;
DROP TABLE Prod_Master CASCADE CONSTRAINTS;
DROP TABLE Cust_Master CASCADE CONSTRAINTS;
DROP TABLE c_mast;

CREATE TABLE Cust_Master
(
    ClientNo VARCHAR2(6) PRIMARY KEY CHECK(ClientNo LIKE 'C%'),
    Name VARCHAR2(20) NOT NULL,
    Address1 VARCHAR2(30),
    Address2 VARCHAR2(30),
    City VARCHAR2(15),
    Pincode NUMBER(8),
    State VARCHAR2(15),
    BalDue NUMBER(10,2)
);

CREATE TABLE Prod_Master
(
    ProductNo VARCHAR2(6) PRIMARY KEY CHECK(ProductNo LIKE 'P%'),
    Description VARCHAR2(15) NOT NULL,
    ProfitPercent NUMBER(4,2) NOT NULL,
    UnitMeasure VARCHAR2(10) NOT NULL,
    QtyOnHand NUMBER(8) NOT NULL,
    ReorderLvl NUMBER(8) NOT NULL,
    SellPrice NUMBER(8,2) CHECK(SellPrice > 0),
    CostPrice NUMBER(8,2) CHECK(CostPrice > 0)
);

CREATE TABLE Sales_Order
(
    OrderNo VARCHAR2(6) PRIMARY KEY CHECK(OrderNo LIKE 'O%'),
    ClientNo VARCHAR2(6),
    OrderDate DATE NOT NULL,
    DelyAddr VARCHAR2(25),
    DelyType CHAR(1) CHECK(DelyType IN('P','F')),
    BillYN CHAR(1) CHECK(BillYN IN('Y','N')),
    Payment_Mode VARCHAR2(15)
        CHECK(Payment_Mode IN
        ('COD','Net Banking','Credit Card','Debit Card')),
    DelyDate DATE,
    OrderStatus VARCHAR2(10)
        CHECK(OrderStatus IN
        ('In Process','Fulfilled','BackOrder','Cancelled')),
    CONSTRAINT fk_client
        FOREIGN KEY(ClientNo)
        REFERENCES Cust_Master(ClientNo)
);

CREATE TABLE Order_Details
(
    OrderNo VARCHAR2(6),
    ProductNo VARCHAR2(6),
    QtyOrdered NUMBER(8),
    QtyDisp NUMBER(8),
    CONSTRAINT pk_orderdetails PRIMARY KEY(OrderNo, ProductNo),
    CONSTRAINT fk_order FOREIGN KEY(OrderNo)
        REFERENCES Sales_Order(OrderNo),
    CONSTRAINT fk_product FOREIGN KEY(ProductNo)
        REFERENCES Prod_Master(ProductNo)
);

ALTER TABLE Cust_Master ADD Telephone NUMBER(10);

ALTER TABLE Prod_Master MODIFY SellPrice NUMBER(10,2);

ALTER TABLE Order_Details RENAME COLUMN QtyOrdered TO QtyOrd;

DROP TABLE Order_Details;

CREATE TABLE Order_Details
(
    OrderNo VARCHAR2(6),
    ProductNo VARCHAR2(6),
    QtyOrdered NUMBER(8),
    QtyDisp NUMBER(8),
    CONSTRAINT pk_orderdetails PRIMARY KEY(OrderNo, ProductNo),
    CONSTRAINT fk_order FOREIGN KEY(OrderNo)
        REFERENCES Sales_Order(OrderNo),
    CONSTRAINT fk_product FOREIGN KEY(ProductNo)
        REFERENCES Prod_Master(ProductNo)
);

INSERT INTO Cust_Master
(ClientNo,Name,Address1,Address2,City,Pincode,State,BalDue)
VALUES
('C00001','Rahul Sharma',NULL,NULL,'Mumbai',400054,'Maharashtra',15000);

INSERT INTO Cust_Master
(ClientNo,Name,Address1,Address2,City,Pincode,State,BalDue)
VALUES
('C00002','Eric Sheldon',NULL,NULL,'Madras',780001,'TamilNadu',0);

INSERT INTO Cust_Master
(ClientNo,Name,Address1,Address2,City,Pincode,State,BalDue)
VALUES
('C00003','Rama Krishnan',NULL,NULL,'Mumbai',400057,'Maharashtra',5000);

INSERT INTO Cust_Master
(ClientNo,Name,Address1,Address2,City,Pincode,State,BalDue)
VALUES
('C00004','Evonne Eric',NULL,NULL,'Bangalore',560001,'Karnataka',0);

INSERT INTO Cust_Master
(ClientNo,Name,Address1,Address2,City,Pincode,State,BalDue)
VALUES
('C00005','Manasa Binu',NULL,NULL,'Mumbai',400060,'Maharashtra',2000);

INSERT INTO Cust_Master
(ClientNo,Name,Address1,Address2,City,Pincode,State,BalDue)
VALUES
('C00006','Ani Rose',NULL,NULL,'Mangalore',560050,'Karnataka',0);

INSERT INTO Prod_Master
VALUES('P00001','T-Shirts',5,'Piece',200,50,350,250);

INSERT INTO Prod_Master
VALUES('P03453','Shirts',6,'Piece',150,50,500,350);

INSERT INTO Prod_Master
VALUES('P06734','Cotton Jeans',5,'Piece',100,20,600,450);

INSERT INTO Prod_Master
VALUES('P07865','Jeans',5,'Piece',100,20,750,500);

INSERT INTO Prod_Master
VALUES('P07868','Trousers',2,'Piece',150,50,850,550);

INSERT INTO Prod_Master
VALUES('P07885','Pull Overs',2.5,'Piece',80,30,700,450);

INSERT INTO Prod_Master
VALUES('P07965','Denim Shirts',4,'Piece',100,40,350,250);

INSERT INTO Prod_Master
VALUES('P07975','Lycra Tops',5,'Piece',70,30,300,175);

INSERT INTO Prod_Master
VALUES('P08865','Skirts',5,'Piece',75,30,450,300);

INSERT INTO Sales_Order
VALUES
('O19001','C00001',
TO_DATE('12-JUN-2014','DD-MON-YYYY'),
NULL,'F','N','COD',
TO_DATE('20-JUL-2014','DD-MON-YYYY'),
'In Process');

INSERT INTO Sales_Order
VALUES
('O19002','C00002',
TO_DATE('25-JUN-2014','DD-MON-YYYY'),
NULL,'P','N','COD',
TO_DATE('27-JUN-2014','DD-MON-YYYY'),
'Cancelled');

INSERT INTO Sales_Order
VALUES
('O46865','C00003',
TO_DATE('18-FEB-2014','DD-MON-YYYY'),
NULL,'F','Y','Net Banking',
TO_DATE('20-FEB-2014','DD-MON-YYYY'),
'Fulfilled');

INSERT INTO Sales_Order
VALUES
('O19003','C00001',
TO_DATE('03-APR-2014','DD-MON-YYYY'),
NULL,'F','Y','Credit Card',
TO_DATE('07-APR-2014','DD-MON-YYYY'),
'Fulfilled');

INSERT INTO Sales_Order
VALUES
('O46866','C00004',
TO_DATE('20-MAY-2014','DD-MON-YYYY'),
NULL,'P','N','Debit Card',
TO_DATE('22-MAY-2014','DD-MON-YYYY'),
'Cancelled');

INSERT INTO Sales_Order
VALUES
('O19008','C00005',
TO_DATE('24-MAY-2014','DD-MON-YYYY'),
NULL,'F','N','Net Banking',
TO_DATE('26-JUL-2014','DD-MON-YYYY'),
'In Process');

INSERT INTO Order_Details VALUES('O19001','P00001',4,4);
INSERT INTO Order_Details VALUES('O19001','P07965',2,1);
INSERT INTO Order_Details VALUES('O19001','P07885',2,1);
INSERT INTO Order_Details VALUES('O19002','P00001',10,0);
INSERT INTO Order_Details VALUES('O46865','P07868',3,3);
INSERT INTO Order_Details VALUES('O46865','P07885',3,1);
INSERT INTO Order_Details VALUES('O46865','P00001',10,10);
INSERT INTO Order_Details VALUES('O46865','P03453',4,4);
INSERT INTO Order_Details VALUES('O19003','P03453',2,2);
INSERT INTO Order_Details VALUES('O19003','P06734',1,1);
INSERT INTO Order_Details VALUES('O46866','P07965',1,0);
INSERT INTO Order_Details VALUES('O46866','P07975',1,0);
INSERT INTO Order_Details VALUES('O19008','P00001',10,5);
INSERT INTO Order_Details VALUES('O19008','P07975',5,3);

CREATE TABLE cust_temp AS
SELECT Name AS Client_Name, State, BalDue
FROM Cust_Master
WHERE BalDue > 1500;

UPDATE Cust_Master
SET City='Bangalore'
WHERE ClientNo='C00005';

UPDATE Cust_Master
SET BalDue=1000
WHERE ClientNo='C00001';

UPDATE Prod_Master
SET CostPrice=950
WHERE Description='Trousers';

DELETE FROM Prod_Master
WHERE ProductNo='P08865';

DELETE FROM cust_temp
WHERE State='Karnataka';

RENAME cust_temp TO c_mast;

SELECT '10/8/26 Lab work' AS message FROM dual;

CREATE TABLE Sales_person
(
    Sid VARCHAR2(5) UNIQUE,
    sname VARCHAR2(25),
    Scity VARCHAR2(20),
    state VARCHAR2(15)
);

DESC Sales_person;

INSERT ALL
    INTO Sales_person VALUES ('S201','Amit Sharma','Mumbai','Maharashtra')
    INTO Sales_person VALUES ('S202','Rohan Hegde','Mangalore','Karnataka')
    INTO Sales_person VALUES ('S203','Priya Rao','Bangalore','Karnataka')
    INTO Sales_person VALUES ('S204','Rahul Patil','Mumbai','Maharashtra')
    INTO Sales_person VALUES ('S205','Deepa Shenoy','Mangalore','Karnataka')
    INTO Sales_person VALUES ('S206','Ananya Gowda','Bangalore','Karnataka')
    INTO Sales_person VALUES ('S207','Vikram Joshi','Mumbai','Maharashtra')
    INTO Sales_person VALUES ('S208','Kiran Kumar','Bangalore','Karnataka')
    INTO Sales_person VALUES ('S209','Sneha Kulkarni','Pune','Maharashtra')
    INTO Sales_person VALUES ('S210','Arjun Shetty','Mangalore','Karnataka')
    INTO Sales_person VALUES ('S211','Arjun Shetty','Shimla','Himachal')
SELECT * FROM dual;

SELECT * FROM Sales_person;

SELECT '13/8/26 Lab work' AS message FROM dual;

SELECT sname
FROM Sales_person
WHERE Scity='Mumbai'
UNION
SELECT Name
FROM Cust_Master
WHERE City='Mumbai';

INSERT INTO Cust_Master
(ClientNo,Name,Address1,Address2,City,Pincode,State,BalDue)
VALUES
('C00007','Amit Sharma',NULL,NULL,'Mumbai',560050,'Maharashtra',0);

SELECT sname
FROM Sales_person
WHERE Scity='Mumbai'
UNION ALL
SELECT Name
FROM Cust_Master
WHERE City='Mumbai';

SELECT sname
FROM Sales_person
WHERE Scity='Bangalore'
UNION
SELECT Name
FROM Cust_Master
WHERE City='Bangalore';

SELECT sname
FROM Sales_person
WHERE Scity='Mangalore'
UNION
SELECT Name
FROM Cust_Master
WHERE City='Mangalore';

SELECT sname
FROM Sales_person
INTERSECT
SELECT Name
FROM Cust_Master;

SELECT Name
FROM Cust_Master
MINUS
SELECT sname
FROM Sales_person;

SELECT sname
FROM Sales_person
MINUS
SELECT Name
FROM Cust_Master;

SELECT Scity
FROM Sales_person
UNION
SELECT City
FROM Cust_Master;

SELECT State
FROM Sales_person
UNION
SELECT State
FROM Cust_Master;

SELECT sname
FROM Sales_person
WHERE State='Karnataka'
UNION
SELECT Name
FROM Cust_Master
WHERE State='Karnataka';

SELECT sname
FROM Sales_person
WHERE State='Maharashtra'
UNION
SELECT Name
FROM Cust_Master
WHERE State='Maharashtra';

SELECT sname
FROM Sales_person
WHERE Scity='Mumbai'
UNION ALL
SELECT Name
FROM Cust_Master
WHERE City='Mumbai';

SELECT Name
FROM Cust_Master
WHERE State='Maharashtra'
MINUS
SELECT sname
FROM Sales_person
WHERE State='Maharashtra';

SELECT sname
FROM Sales_person
WHERE State='Karnataka'
MINUS
SELECT Name
FROM Cust_Master
WHERE State='Karnataka';

SELECT sname
FROM Sales_person
WHERE Scity='Bangalore'
UNION
SELECT Name
FROM Cust_Master
WHERE City='Bangalore'
UNION
SELECT sname
FROM Sales_person
WHERE Scity='Mumbai'
UNION
SELECT Name
FROM Cust_Master
WHERE City='Mumbai';

SELECT sname
FROM Sales_person
WHERE Scity='Bangalore'
OR Scity='Mumbai'
UNION
SELECT Name
FROM Cust_Master
WHERE City='Bangalore'
OR City='Mumbai';

SELECT '14/8/26 Lab work' AS message FROM dual;

SELECT State, COUNT(Name)
FROM Cust_Master
GROUP BY State;

SELECT City, COUNT(Name)
FROM Cust_Master
GROUP BY City;

SELECT State, SUM(BalDue) AS total_BalDue
FROM Cust_Master
GROUP BY State;

SELECT City, AVG(BalDue) AS Avg_BalDue
FROM Cust_Master
GROUP BY City;

SELECT State, MAX(BalDue), MIN(BalDue)
FROM Cust_Master
GROUP BY State;

SELECT State, SUM(BalDue) AS total_BalDue
FROM Cust_Master
GROUP BY State
HAVING COUNT(State)>1;

SELECT City, COUNT(Name)
FROM Cust_Master
GROUP BY City
HAVING COUNT(City)>2;

SELECT State, AVG(BalDue) AS Avg_BalDue
FROM Cust_Master
GROUP BY State
HAVING AVG(BalDue)>=2000;

SELECT State, SUM(BalDue) AS total_BalDue
FROM Cust_Master
GROUP BY State
HAVING SUM(BalDue)>5000;

SELECT City, MAX(BalDue)
FROM Cust_Master
GROUP BY City
HAVING MAX(BalDue)>5000;

SELECT City, COUNT(Name), SUM(BalDue)
FROM Cust_Master
GROUP BY City;

SELECT State, COUNT(Name), AVG(BalDue)
FROM Cust_Master
GROUP BY State;

SELECT State, COUNT(Name), SUM(BalDue), AVG(BalDue)
FROM Cust_Master
GROUP BY State
HAVING COUNT(Name)>1;

SELECT City, MIN(BalDue), MAX(BalDue)
FROM Cust_Master
GROUP BY City
HAVING COUNT(Name)>=2;

SELECT State, SUM(BalDue)
FROM Cust_Master
GROUP BY State
HAVING COUNT(Name)>1
AND SUM(BalDue)>5000;

SELECT UnitMeasure, SUM(QtyOnHand)
FROM Prod_Master
GROUP BY UnitMeasure;

SELECT UnitMeasure, AVG(SellPrice)
FROM Prod_Master
GROUP BY UnitMeasure;

SELECT UnitMeasure, COUNT(ProductNo)
FROM Prod_Master
GROUP BY UnitMeasure;

SELECT UnitMeasure, MAX(SellPrice)
FROM Prod_Master
GROUP BY UnitMeasure;

SELECT UnitMeasure, MIN(CostPrice)
FROM Prod_Master
GROUP BY UnitMeasure;

SELECT UnitMeasure, SUM(QtyOnHand)
FROM Prod_Master
GROUP BY UnitMeasure
HAVING COUNT(ProductNo)>2;

SELECT UnitMeasure, AVG(SellPrice)
FROM Prod_Master
GROUP BY UnitMeasure
HAVING AVG(SellPrice)>500;

SELECT UnitMeasure, SUM(QtyOnHand)
FROM Prod_Master
GROUP BY UnitMeasure
HAVING SUM(QtyOnHand)>300;

SELECT Payment_Mode, COUNT(OrderNo)
FROM Sales_Order
GROUP BY Payment_Mode;

SELECT OrderStatus, COUNT(OrderNo)
FROM Sales_Order
GROUP BY OrderStatus;

SELECT DelyType, COUNT(OrderNo)
FROM Sales_Order
GROUP BY DelyType;

SELECT Payment_Mode, COUNT(OrderNo)
FROM Sales_Order
GROUP BY Payment_Mode
HAVING COUNT(OrderNo)>1;

SELECT OrderStatus, COUNT(OrderNo)
FROM Sales_Order
GROUP BY OrderStatus
HAVING COUNT(OrderNo)>1;

SELECT DelyType, COUNT(OrderNo)
FROM Sales_Order
GROUP BY DelyType
HAVING COUNT(OrderNo)>=2;

SELECT ProductNo, SUM(QtyOrdered)
FROM Order_Details
GROUP BY ProductNo;

SELECT ProductNo, SUM(QtyDisp)
FROM Order_Details
GROUP BY ProductNo;

SELECT ProductNo, AVG(QtyOrdered)
FROM Order_Details
GROUP BY ProductNo;

SELECT ProductNo, SUM(QtyOrdered)
FROM Order_Details
GROUP BY ProductNo
HAVING SUM(QtyOrdered)>5;

SELECT ProductNo, SUM(QtyDisp)
FROM Order_Details
GROUP BY ProductNo
HAVING COUNT(*)>1;

SELECT OrderNo, SUM(QtyOrdered)
FROM Order_Details
GROUP BY OrderNo;

SELECT OrderNo, SUM(QtyDisp)
FROM Order_Details
GROUP BY OrderNo;

SELECT OrderNo, COUNT(ProductNo)
FROM Order_Details
GROUP BY OrderNo;

SELECT OrderNo, SUM(QtyOrdered)
FROM Order_Details
GROUP BY OrderNo
HAVING COUNT(ProductNo)>1;

SELECT ProductNo, SUM(QtyOrdered), SUM(QtyDisp)
FROM Order_Details
GROUP BY ProductNo
HAVING SUM(QtyOrdered)>5;

SELECT State,
       COUNT(ClientNo),
       SUM(BalDue),
       AVG(BalDue)
FROM Cust_Master
WHERE Name LIKE '%a%'
AND BalDue>1000
GROUP BY State
HAVING COUNT(ClientNo)>=2;

SELECT ProductNo,
       Description,
       SellPrice,
       CostPrice,
       ROUND(((SellPrice-CostPrice)/CostPrice)*100,2)
       AS ProfitPercentage
FROM Prod_Master
WHERE Description LIKE '%Shirt%'
AND SellPrice>400;

SELECT TO_CHAR(OrderDate,'Month') AS OrderMonth,
       COUNT(OrderNo),
       MIN(OrderDate),
       MAX(DelyDate),
       AVG(DelyDate-OrderDate)
FROM Sales_Order
WHERE TO_CHAR(OrderDate,'YYYY')='2014'
GROUP BY TO_CHAR(OrderDate,'Month')
HAVING COUNT(OrderNo)>1;

SELECT City,
       COUNT(ClientNo),
       MAX(BalDue),
       MIN(BalDue)
FROM Cust_Master
GROUP BY City
HAVING COUNT(ClientNo)>=2
AND MAX(BalDue)>2000;

SELECT UnitMeasure,
       COUNT(ProductNo),
       SUM(QtyOnHand),
       AVG(SellPrice)
FROM Prod_Master
WHERE SellPrice>300
AND QtyOnHand!=ReorderLvl
GROUP BY UnitMeasure
HAVING COUNT(ProductNo)>1;

SELECT Payment_Mode,
       COUNT(OrderNo),
       AVG(DelyDate-OrderDate)
FROM Sales_Order
WHERE DelyDate-OrderDate<=60
GROUP BY Payment_Mode
HAVING COUNT(OrderNo)>1;

SELECT ProductNo,
       SUM(QtyOrdered),
       SUM(QtyDisp),
       SUM(QtyOrdered)-SUM(QtyDisp) AS Difference
FROM Order_Details
WHERE ProductNo IN
(
    SELECT ProductNo
    FROM Prod_Master
    WHERE Description LIKE '%s%'
)
GROUP BY ProductNo
HAVING SUM(QtyOrdered)>SUM(QtyDisp);

SELECT OrderNo,
       COUNT(ProductNo),
       SUM(QtyOrdered),
       SUM(QtyDisp)
FROM Order_Details
GROUP BY OrderNo
HAVING COUNT(ProductNo)>1
AND SUM(QtyOrdered)>5;

SELECT State,
       SUM(BalDue),
       AVG(BalDue),
       COUNT(ClientNo)
FROM Cust_Master
WHERE Name LIKE 'A%'
OR Name LIKE 'M%'
GROUP BY State
HAVING SUM(BalDue)>1000;

SELECT TO_CHAR(s.OrderDate,'YYYY') AS OrderYear,
       COUNT(DISTINCT d.OrderNo),
       COUNT(d.ProductNo),
       AVG(d.QtyOrdered)
FROM Order_Details d
JOIN Sales_Order s
ON d.OrderNo=s.OrderNo
GROUP BY TO_CHAR(s.OrderDate,'YYYY')
HAVING COUNT(DISTINCT d.OrderNo)>1;

SELECT ProductNo,
       Description,
       SellPrice,
       SellPrice*1.15 AS NewSellPrice
FROM Prod_Master
WHERE (Description LIKE 'T%' OR Description LIKE 'J%')
AND SellPrice BETWEEN 300 AND 800;

SELECT City,
       COUNT(ClientNo)
FROM Cust_Master
WHERE City LIKE '%a%'
GROUP BY City
HAVING COUNT(ClientNo)>=2
ORDER BY COUNT(ClientNo) DESC;

SELECT OrderStatus,
       COUNT(OrderNo),
       AVG(DelyDate-OrderDate),
       MAX(DelyDate-OrderDate)
FROM Sales_Order
WHERE TO_CHAR(DelyDate,'MM-YYYY')='07-2014'
GROUP BY OrderStatus
HAVING COUNT(OrderNo)>=2;

SELECT UnitMeasure,
       SUM(QtyOnHand),
       AVG(CostPrice),
       MIN(SellPrice),
       MAX(SellPrice)
FROM Prod_Master
GROUP BY UnitMeasure
HAVING AVG(SellPrice)>400
AND SUM(QtyOnHand)>150;

SELECT OrderNo,
       OrderDate,
       DelyDate,
       DelyDate-OrderDate AS DeliveryDuration
FROM Sales_Order
WHERE DelyDate-OrderDate>10
AND OrderStatus!='Cancelled';

SELECT ClientNo,
       Name,
       City,
       BalDue
FROM Cust_Master
WHERE LENGTH(Name)=6
AND BalDue BETWEEN 1000 AND 15000;

SELECT ProductNo,
       Description,
       QtyOnHand,
       ReorderLvl,
       ReorderLvl-QtyOnHand AS Shortage
FROM Prod_Master
WHERE QtyOnHand<ReorderLvl;

SELECT State,
       COUNT(ClientNo),
       AVG(BalDue),
       SUM(BalDue)
FROM Cust_Master
WHERE Name LIKE '%a'
GROUP BY State
HAVING COUNT(ClientNo)>=2
AND AVG(BalDue)>1000;

SELECT Payment_Mode,
       COUNT(OrderNo),
       MIN(OrderDate),
       MAX(OrderDate)
FROM Sales_Order
WHERE DelyType='F'
GROUP BY Payment_Mode
HAVING COUNT(OrderNo)>1;

SELECT ProductNo,
       COUNT(*),
       SUM(QtyOrdered),
       MAX(QtyOrdered)
FROM Order_Details
GROUP BY ProductNo
HAVING COUNT(*)>1;

SELECT OrderNo,
       SUM(QtyOrdered),
       SUM(QtyDisp),
       (SUM(QtyDisp)/SUM(QtyOrdered))*100 AS DispatchedPercentage
FROM Order_Details
GROUP BY OrderNo
HAVING COUNT(ProductNo)>1
AND ((SUM(QtyDisp)/SUM(QtyOrdered))*100)<80;

SELECT City,
       COUNT(ClientNo),
       SUM(BalDue),
       AVG(BalDue)
FROM Cust_Master
WHERE Name LIKE '%an%'
GROUP BY City
HAVING COUNT(ClientNo)>=2;

SELECT TO_CHAR(OrderDate,'Month') AS OrderMonth,
       COUNT(OrderNo),
       AVG(DelyDate-OrderDate)
FROM Sales_Order
GROUP BY TO_CHAR(OrderDate,'Month')
HAVING AVG(DelyDate-OrderDate)>10;

SELECT UnitMeasure,
       COUNT(ProductNo),
       AVG(((SellPrice-CostPrice)/CostPrice)*100),
       MAX(((SellPrice-CostPrice)/CostPrice)*100)
FROM Prod_Master
GROUP BY UnitMeasure
HAVING COUNT(ProductNo)>=2
AND AVG(((SellPrice-CostPrice)/CostPrice)*100)>3;

SELECT ProductNo,
       Description,
       SellPrice,
       CostPrice,
       ROUND(SellPrice-CostPrice,2) AS ProfitAmount
FROM Prod_Master
WHERE (((SellPrice-CostPrice)/CostPrice)*100)>4
AND SellPrice>500;

SELECT OrderNo,
       SUM(QtyOrdered),
       AVG(QtyOrdered)
FROM Order_Details
GROUP BY OrderNo
HAVING SUM(QtyOrdered)>10;

SELECT TO_CHAR(s.OrderDate,'YYYY') AS OrderYear,
       COUNT(DISTINCT d.OrderNo),
       SUM(d.QtyOrdered),
       AVG(d.QtyOrdered)
FROM Order_Details d
JOIN Sales_Order s
ON d.OrderNo=s.OrderNo
GROUP BY TO_CHAR(s.OrderDate,'YYYY')
HAVING COUNT(DISTINCT d.OrderNo)>=2;

SELECT City,
       COUNT(ClientNo),
       MAX(BalDue)
FROM Cust_Master
WHERE City LIKE 'M%'
OR City LIKE 'B%'
GROUP BY City
HAVING MAX(BalDue)>1000;

SELECT ProductNo,
       Description,
       SellPrice,
       CostPrice
FROM Prod_Master
WHERE (SellPrice>=2*CostPrice
OR ((SellPrice-CostPrice)/CostPrice)*100>5)
AND Description LIKE '%s%';

SELECT OrderNo,
       OrderDate,
       TO_CHAR(OrderDate,'Day') AS OrderDay,
       DelyDate-OrderDate AS DeliveryDuration
FROM Sales_Order
WHERE OrderDate>DATE '2014-04-01'
AND DelyDate-OrderDate<=30;

SELECT State,
       COUNT(ClientNo),
       MIN(BalDue),
       MAX(BalDue),
       SUM(BalDue)
FROM Cust_Master
WHERE BalDue!=0
GROUP BY State
HAVING COUNT(ClientNo)>1;

SELECT ProductNo,
       Description,
       QtyOnHand,
       ReorderLvl,
       ((QtyOnHand-ReorderLvl)/ReorderLvl)*100 AS ExceedPercentage
FROM Prod_Master
WHERE QtyOnHand>ReorderLvl;

SELECT Payment_Mode,
       DelyType,
       COUNT(OrderNo),
       AVG(DelyDate-OrderDate)
FROM Sales_Order
GROUP BY Payment_Mode,DelyType
HAVING COUNT(OrderNo)>1
AND AVG(DelyDate-OrderDate)>5;

SELECT OrderNo,
       COUNT(ProductNo),
       SUM(QtyOrdered),
       SUM(QtyDisp)
FROM Order_Details
GROUP BY OrderNo
HAVING COUNT(ProductNo)>=2
AND SUM(QtyOrdered)>10;

SELECT UnitMeasure,
       COUNT(ProductNo),
       SUM(QtyOnHand),
       AVG(ReorderLvl)
FROM Prod_Master
GROUP BY UnitMeasure
HAVING COUNT(ProductNo)>2
AND SUM(QtyOnHand)>250;

SELECT State,
       City,
       COUNT(ClientNo),
       SUM(BalDue)
FROM Cust_Master
GROUP BY State,City
HAVING COUNT(ClientNo)>1
AND SUM(BalDue)>2000;

SELECT ProductNo,
       SUM(QtyOrdered),
       SUM(QtyDisp),
       ((SUM(QtyOrdered)-SUM(QtyDisp))/SUM(QtyOrdered))*100
       AS UndeliveredPercentage
FROM Order_Details
GROUP BY ProductNo
HAVING SUM(QtyOrdered)>5
AND (SUM(QtyOrdered)-SUM(QtyDisp))>0;

SELECT OrderStatus,
       COUNT(OrderNo),
       MIN(DelyDate-OrderDate),
       MAX(DelyDate-OrderDate)
FROM Sales_Order
GROUP BY OrderStatus
HAVING COUNT(OrderNo)>=2
AND MAX(DelyDate-OrderDate)>20;

SELECT City,
       COUNT(ClientNo),
       AVG(BalDue),
       MAX(BalDue)
FROM Cust_Master
WHERE LENGTH(Name)>5
GROUP BY City
HAVING COUNT(ClientNo)>=2;

SELECT ProductNo,
       Description,
       SellPrice,
       CostPrice,
       SellPrice*0.90 AS DiscountedPrice
FROM Prod_Master
WHERE Description LIKE '%Jeans%'
OR Description LIKE '%Tops%';

SELECT TO_CHAR(s.OrderDate,'YYYY') AS OrderYear,
       TO_CHAR(s.OrderDate,'Month') AS OrderMonth,
       COUNT(DISTINCT d.OrderNo),
       SUM(d.QtyOrdered)
FROM Order_Details d
JOIN Sales_Order s
ON d.OrderNo=s.OrderNo
GROUP BY TO_CHAR(s.OrderDate,'YYYY'),
         TO_CHAR(s.OrderDate,'Month')
HAVING COUNT(DISTINCT d.OrderNo)>1;

SELECT OrderNo,
       OrderDate,
       DelyDate,
       DelyDate-OrderDate AS DeliveryDuration
FROM Sales_Order
WHERE (TO_CHAR(OrderDate,'DY')='MON'
OR TO_CHAR(OrderDate,'DY')='FRI')
AND OrderStatus!='Cancelled';

SELECT UnitMeasure,
       COUNT(ProductNo),
       AVG(SellPrice),
       AVG(CostPrice)
FROM Prod_Master
GROUP BY UnitMeasure
HAVING (AVG(SellPrice)-AVG(CostPrice))>150;

SELECT State,
       COUNT(ClientNo),
       SUM(BalDue),
       AVG(BalDue)
FROM Cust_Master
GROUP BY State
HAVING COUNT(ClientNo)>=2
AND SUM(BalDue)>5000
AND AVG(BalDue)>1500;

SELECT ProductNo,
       Description,
       QtyOnHand,
       CASE
           WHEN QtyOnHand<=ReorderLvl
           THEN 'REORDER'
           ELSE 'SUFFICIENT'
       END AS StockStatus
FROM Prod_Master
WHERE Description LIKE '%s%';

SELECT TO_CHAR(s.OrderDate,'Month') AS OrderMonth,
       COUNT(DISTINCT d.OrderNo),
       SUM(d.QtyOrdered),
       AVG(d.QtyOrdered)
FROM Order_Details d
JOIN Sales_Order s
ON d.OrderNo=s.OrderNo
WHERE s.OrderDate>=DATE '2014-02-01'
AND s.OrderDate<DATE '2014-07-01'
GROUP BY TO_CHAR(s.OrderDate,'Month')
HAVING COUNT(DISTINCT d.OrderNo)>=2;

SELECT Payment_Mode,
       COUNT(OrderNo),
       AVG(DelyDate-OrderDate),
       SUM(DelyDate-OrderDate)
FROM Sales_Order
GROUP BY Payment_Mode
HAVING COUNT(OrderNo)>1
AND SUM(DelyDate-OrderDate)>30;

SELECT ProductNo,
       COUNT(*),
       SUM(QtyOrdered),
       SUM(QtyDisp),
       MAX(QtyOrdered)
FROM Order_Details
GROUP BY ProductNo
HAVING COUNT(*)>=2
AND SUM(QtyOrdered)>5;

SELECT ClientNo,
       Name,
       City,
       State
FROM Cust_Master
WHERE LOWER(SUBSTR(Name,1,1))
      NOT IN ('a','e','i','o','u')
AND BalDue>0
AND City LIKE '%a%'
ORDER BY State,Name;

SELECT ProductNo,
       Description,
       SellPrice,
       CostPrice,
       ROUND(SellPrice-CostPrice,2) AS PriceDifference
FROM Prod_Master
WHERE (SellPrice>500 OR CostPrice>400)
AND (((SellPrice-CostPrice)/CostPrice)*100)<6;

COMMIT;
