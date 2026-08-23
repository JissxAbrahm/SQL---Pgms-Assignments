DROP TABLE Order_Details;
DROP TABLE Sales_Order;
DROP TABLE Prod_Master;
DROP TABLE Cust_Master;


CREATE TABLE Cust_Master (
    Clientno VARCHAR2(6),
    Name VARCHAR2(20) NOT NULL,
    Address1 VARCHAR2(30),
    Address2 VARCHAR2(30),
    City VARCHAR2(15),
    Pincode NUMBER(8),
    State VARCHAR2(15),
    BalDue NUMBER(10,2),
    CONSTRAINT pk_cust_master PRIMARY KEY (Clientno),
    CONSTRAINT chk_clientno CHECK (Clientno LIKE 'C%')
);

CREATE TABLE Prod_Master (
    Productno VARCHAR2(6),
    Description VARCHAR2(15) NOT NULL,
    Profitpercent NUMBER(4,2) NOT NULL,
    Unitmeasure VARCHAR2(10) NOT NULL,
    Qtyonhand NUMBER(8) NOT NULL,
    Reorderlvl NUMBER(8) NOT NULL,
    Sellprice NUMBER(8,2) NOT NULL,
    Costprice NUMBER(8,2) NOT NULL,
    CONSTRAINT pk_prod_master PRIMARY KEY (Productno),
    CONSTRAINT chk_productno CHECK (Productno LIKE 'P%'),
    CONSTRAINT chk_sellprice CHECK (Sellprice <> 0),
    CONSTRAINT chk_costprice CHECK (Costprice <> 0)
);

CREATE TABLE Sales_Order (
    Orderno VARCHAR2(6),
    Clientno VARCHAR2(6),
    Orderdate DATE NOT NULL,
    DelyAddr VARCHAR2(25),
    Delytype CHAR(1) DEFAULT 'F',
    Billyn CHAR(1),
    Payment_mode VARCHAR2(15),
    Delydate DATE,
    Orderstatus VARCHAR2(10),
    CONSTRAINT pk_sales_order PRIMARY KEY (Orderno),
    CONSTRAINT fk_sales_order_client FOREIGN KEY (Clientno) REFERENCES Cust_Master(Clientno),
    CONSTRAINT chk_orderno CHECK (Orderno LIKE 'O%' OR Orderno LIKE '0%'),
    CONSTRAINT chk_delytype CHECK (Delytype IN ('P', 'F')),
    CONSTRAINT chk_payment_mode CHECK (Payment_mode IN ('COD', 'Net Banking', 'Credit Card', 'Debit Card')),
    CONSTRAINT chk_delydate CHECK (Delydate >= Orderdate),
    CONSTRAINT chk_orderstatus CHECK (Orderstatus IN ('In Process', 'Fulfilled', 'Fullfilled', 'BackOrder', 'Cancelled'))
);

CREATE TABLE Order_Details (
    Orderno VARCHAR2(6),
    Productno VARCHAR2(6),
    Qtyordered NUMBER(8),
    Qtydisp NUMBER(8),
    CONSTRAINT pk_order_details PRIMARY KEY (Orderno, Productno),
    CONSTRAINT fk_order_details_order FOREIGN KEY (Orderno) REFERENCES             Sales_Order(Orderno),
    CONSTRAINT fk_order_details_product FOREIGN KEY (Productno) REFERENCES Prod_Master(Productno)
);


INSERT INTO Cust_Master (Clientno, Name, City, Pincode, State, BalDue, Telephone) 
VALUES ('C00001', 'Rahul Sharma', 'Mumbai', 400054, 'Maharashtra', 15000, 9876543210);

INSERT INTO Cust_Master (Clientno, Name, City, Pincode, State, BalDue, Telephone) 
VALUES ('C00002', 'Eric Sheldon', 'Madras', 780001, 'TamilNadu', 0, 9876543211);

INSERT INTO Cust_Master (Clientno, Name, City, Pincode, State, BalDue, Telephone) 
VALUES ('C00003', 'Rama Krishnan', 'Mumbai', 400057, 'Maharashtra', 5000, 9876543212);

INSERT INTO Cust_Master (Clientno, Name, City, Pincode, State, BalDue, Telephone) 
VALUES ('C00004', 'Evonne Eric', 'Bangalore', 560001, 'Karnataka', 0, 9876543213);

INSERT INTO Cust_Master (Clientno, Name, City, Pincode, State, BalDue, Telephone) 
VALUES ('C00005', 'Manasa Binu', 'Mumbai', 400060, 'Maharashtra', 2000, 9876543214);

INSERT INTO Cust_Master (Clientno, Name, City, Pincode, State, BalDue, Telephone) 
VALUES ('C00006', 'Ani Rose', 'Mangalore', 560050, 'Karnataka', 0, 9876543215);

-- Insert into Prod_Master
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P00001', 'T-Shirts', 5, 'Piece', 200, 50, 350, 250);
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P03453', 'Shirts', 6, 'Piece', 150, 50, 500, 350);
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P06734', 'Cotton Jeans', 5, 'Piece', 100, 20, 600, 450);
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P07865', 'Jeans', 5, 'Piece', 100, 20, 750, 500);
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P07868', 'Trousers', 2, 'Piece', 150, 50, 850, 550);
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P07885', 'Pull Overs', 2.5, 'Piece', 80, 30, 700, 450);
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P07965', 'Denim Shirts', 4, 'Piece', 100, 40, 350, 250);
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P07975', 'Lycra Tops', 5, 'Piece', 70, 30, 300, 175);
INSERT INTO Prod_Master (Productno, Description, Profitpercent, Unitmeasure, Qtyonhand, Reorderlvl, Sellprice, Costprice) VALUES ('P08865', 'Skirts', 5, 'Piece', 75, 30, 450, 300);

-- Insert into Sales_Order
INSERT INTO Sales_Order (Orderno, Clientno, Orderdate, Delytype, Payment_mode, Billyn, Delydate, Orderstatus) VALUES ('019001', 'C00001', TO_DATE('12-06-2014', 'DD-MM-YYYY'), 'F', 'COD', 'N', TO_DATE('20-07-2014', 'DD-MM-YYYY'), 'In Process');
INSERT INTO Sales_Order (Orderno, Clientno, Orderdate, Delytype, Payment_mode, Billyn, Delydate, Orderstatus) VALUES ('019002', 'C00002', TO_DATE('25-06-2014', 'DD-MM-YYYY'), 'P', 'COD', 'N', TO_DATE('27-06-2014', 'DD-MM-YYYY'), 'Cancelled');
INSERT INTO Sales_Order (Orderno, Clientno, Orderdate, Delytype, Payment_mode, Billyn, Delydate, Orderstatus) VALUES ('046865', 'C00003', TO_DATE('18-02-2014', 'DD-MM-YYYY'), 'F', 'Net Banking', 'Y', TO_DATE('20-02-2014', 'DD-MM-YYYY'), 'Fullfilled');
INSERT INTO Sales_Order (Orderno, Clientno, Orderdate, Delytype, Payment_mode, Billyn, Delydate, Orderstatus) VALUES ('019003', 'C00001', TO_DATE('03-04-2014', 'DD-MM-YYYY'), 'F', 'Debit Card', 'Y', TO_DATE('07-04-2014', 'DD-MM-YYYY'), 'Fullfilled');
INSERT INTO Sales_Order (Orderno, Clientno, Orderdate, Delytype, Payment_mode, Billyn, Delydate, Orderstatus) VALUES ('046866', 'C00004', TO_DATE('20-05-2014', 'DD-MM-YYYY'), 'P', 'Net Banking', 'N', TO_DATE('22-05-2014', 'DD-MM-YYYY'), 'Cancelled');
INSERT INTO Sales_Order (Orderno, Clientno, Orderdate, Delytype, Payment_mode, Billyn, Delydate, Orderstatus) VALUES ('019008', 'C00005', TO_DATE('24-05-2014', 'DD-MM-YYYY'), 'F', 'Credit Card', 'N', TO_DATE('26-07-2014', 'DD-MM-YYYY'), 'In Process');

INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('019001', 'P00001', 4, 4);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('019001', 'P07965', 2, 1);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('019001', 'P07885', 2, 1);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('019002', 'P00001', 10, 0);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('046865', 'P07868', 3, 3);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('046865', 'P07885', 3, 1);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('046865', 'P00001', 10, 10);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('046865', 'P03453', 4, 4);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('019003', 'P03453', 2, 2);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('019003', 'P06734', 1, 1);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('046866', 'P07965', 1, 0);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('046866', 'P07975', 1, 0);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('019008', 'P00001', 10, 5);
INSERT INTO Order_Details (Orderno, Productno, Qtyordered, Qtydisp) VALUES ('019008', 'P07975', 5, 3);






CREATE TABLE Order_Details (Orderno VARCHAR2(6),Productno VARCHAR2(6),QtyOrd NUMBER(8),Qtydisp NUMBER(8),CONSTRAINT pk_order_details PRIMARY KEY (Orderno, Productno),
CONSTRAINT fk_order_details_order FOREIGN KEY (Orderno) REFERENCES Sales_Order(Orderno),
CONSTRAINT fk_order_details_product FOREIGN KEY (Productno) REFERENCES Prod_Master(Productno));