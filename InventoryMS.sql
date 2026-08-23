DROP TABLE Payment;
DROP TABLE Sales_Item;
DROP TABLE Sales;
DROP TABLE Purchase_Item;
DROP TABLE Purchase;
DROP TABLE Product;
DROP TABLE Customer;
DROP TABLE Category;
DROP TABLE Supplier;


CREATE TABLE Supplier 
(
    supplier_id CHAR(5) PRIMARY KEY,
    supplier_name VARCHAR2(30) NOT NULL,
    contact_person VARCHAR2(30),
    mobile_number CHAR(12),
    email_id VARCHAR2(40) UNIQUE,
    address VARCHAR2(100),
    city VARCHAR2(30)
);


CREATE TABLE Category 
(
    category_id CHAR(5) PRIMARY KEY,
    category_name VARCHAR2(30) UNIQUE NOT NULL,
    description VARCHAR2(100)
);


CREATE TABLE Product 
(
    product_id CHAR(5) PRIMARY KEY,
    product_name VARCHAR2(40) NOT NULL,
    category_id CHAR(5) REFERENCES Category(category_id),
    supplier_id CHAR(5) REFERENCES Supplier(supplier_id),
    unit_price NUMBER(10,2) CHECK (unit_price > 0),
    reorder_level NUMBER(5) CHECK (reorder_level >= 0),
    quantity_available NUMBER(6) CHECK (quantity_available >= 0)
);


CREATE TABLE Purchase 
(
    purchase_id CHAR(5) PRIMARY KEY,
    supplier_id CHAR(5) REFERENCES Supplier(supplier_id),
    purchase_date DATE DEFAULT SYSDATE,
    total_amount NUMBER(10,2) CHECK (total_amount >= 0)
);


CREATE TABLE Purchase_Item 
(
    purchase_item_id CHAR(5) PRIMARY KEY,
    purchase_id CHAR(5) REFERENCES Purchase(purchase_id),
    product_id CHAR(5) REFERENCES Product(product_id),
    quantity_purchased NUMBER(5) CHECK (quantity_purchased > 0),
    purchase_price NUMBER(10,2) CHECK (purchase_price > 0),
    UNIQUE (purchase_id, product_id)
);


CREATE TABLE Customer 
(
    customer_id CHAR(5) PRIMARY KEY,
    customer_name VARCHAR2(30) NOT NULL,
    mobile_number CHAR(12),
    email_id VARCHAR2(40) UNIQUE,
    address VARCHAR2(100),
    city VARCHAR2(30)
);


CREATE TABLE Sales 
(
    sales_id CHAR(5) PRIMARY KEY,
    customer_id CHAR(5) REFERENCES Customer(customer_id),
    sales_date DATE DEFAULT SYSDATE,
    total_amount NUMBER(10,2) CHECK (total_amount >= 0),
    payment_status VARCHAR2(10)
        CHECK (payment_status IN ('PAID','UNPAID','PARTIAL'))
);


CREATE TABLE Sales_Item 
(
    sales_item_id CHAR(5) PRIMARY KEY,
    sales_id CHAR(5) REFERENCES Sales(sales_id),
    product_id CHAR(5) REFERENCES Product(product_id),
    quantity_sold NUMBER(5) CHECK (quantity_sold > 0),
    selling_price NUMBER(10,2) CHECK (selling_price > 0),
    UNIQUE (sales_id, product_id)
);



CREATE TABLE Payment 
(
    payment_id CHAR(5) PRIMARY KEY,
    sales_id CHAR(5) REFERENCES Sales(sales_id),
    payment_date DATE DEFAULT SYSDATE,
    amount_paid NUMBER(10,2) CHECK (amount_paid > 0),
    payment_mode VARCHAR2(15) CHECK (payment_mode IN ('CASH','CARD','UPI','BANK_TRANSFER'))
);



INSERT INTO Supplier VALUES ('S001','ABC Traders','Anil','9876543210','abc@gmail.com','MG Road','Kochi');
INSERT INTO Supplier VALUES ('S002','Global Supplies','Rahul','9876543211','global@gmail.com','Main Road','Thrissur');
INSERT INTO Supplier VALUES ('S003','Prime Distributors','Joseph','9876543212','prime@gmail.com','Market Road','Kozhikode');
INSERT INTO Supplier VALUES ('S004','Star Agencies','David','9876543213','star@gmail.com','Beach Road','Kannur');
INSERT INTO Supplier VALUES ('S005','Metro Suppliers','John','9876543214','metro@gmail.com','Town Road','Kottayam');


INSERT INTO Category VALUES ('C001','Electronics','Electronic Items');
INSERT INTO Category VALUES ('C002','Furniture','Office Furniture');
INSERT INTO Category VALUES ('C003','Stationery','Office Stationery');
INSERT INTO Category VALUES ('C004','Groceries','Daily Essentials');
INSERT INTO Category VALUES ('C005','Sports','Sports Equipment');


INSERT INTO Product VALUES ('P001','Laptop','C001','S001',55000,5,20);
INSERT INTO Product VALUES ('P002','Office Chair','C002','S002',4500,10,40);
INSERT INTO Product VALUES ('P003','Notebook','C003','S003',50,100,500);
INSERT INTO Product VALUES ('P004','Rice Bag','C004','S004',1200,20,80);
INSERT INTO Product VALUES ('P005','Football','C005','S005',900,15,60);


INSERT INTO Purchase VALUES ('PU001','S001',DATE '2025-01-10',110000);
INSERT INTO Purchase VALUES ('PU002','S002',DATE '2025-02-15',45000);
INSERT INTO Purchase VALUES ('PU003','S003',DATE '2025-03-20',25000);
INSERT INTO Purchase VALUES ('PU004','S004',DATE '2025-04-25',60000);
INSERT INTO Purchase VALUES ('PU005','S005',DATE '2025-05-30',18000);


INSERT INTO Purchase_Item VALUES ('PI001','PU001','P001',2,55000);
INSERT INTO Purchase_Item VALUES ('PI002','PU002','P002',10,4500);
INSERT INTO Purchase_Item VALUES ('PI003','PU003','P003',500,50);
INSERT INTO Purchase_Item VALUES ('PI004','PU004','P004',50,1200);
INSERT INTO Purchase_Item VALUES ('PI005','PU005','P005',20,900);


INSERT INTO Customer VALUES ('CU001','Akhil','9988776655','akhil@gmail.com','MG Road','Kochi');
INSERT INTO Customer VALUES ('CU002','Maria','9988776656','maria@gmail.com','Town Road','Thrissur');
INSERT INTO Customer VALUES ('CU003','Thomas','9988776657','thomas@gmail.com','Market Road','Kozhikode');
INSERT INTO Customer VALUES ('CU004','Neha','9988776658','neha@gmail.com','Beach Road','Kannur');
INSERT INTO Customer VALUES ('CU005','Arjun','9988776659','arjun@gmail.com','Temple Road','Kottayam');


INSERT INTO Sales VALUES ('SA001','CU001',DATE '2025-06-01',60000,'PAID');
INSERT INTO Sales VALUES ('SA002','CU002',DATE '2025-06-02',9000,'UNPAID');
INSERT INTO Sales VALUES ('SA003','CU003',DATE '2025-06-03',5000,'PARTIAL');
INSERT INTO Sales VALUES ('SA004','CU004',DATE '2025-06-04',2400,'PAID');
INSERT INTO Sales VALUES ('SA005','CU005',DATE '2025-06-05',1800,'PAID');


INSERT INTO Sales_Item VALUES ('SI001','SA001','P001',1,60000);
INSERT INTO Sales_Item VALUES ('SI002','SA002','P002',2,4500);
INSERT INTO Sales_Item VALUES ('SI003','SA003','P003',100,50);
INSERT INTO Sales_Item VALUES ('SI004','SA004','P004',2,1200);
INSERT INTO Sales_Item VALUES ('SI005','SA005','P005',2,900);


INSERT INTO Payment VALUES ('PM001','SA001',DATE '2025-06-01',60000,'CARD');
INSERT INTO Payment VALUES ('PM002','SA002',DATE '2025-06-03',3000,'UPI');
INSERT INTO Payment VALUES ('PM003','SA003',DATE '2025-06-04',2500,'CASH');
INSERT INTO Payment VALUES ('PM004','SA004',DATE '2025-06-04',2400,'BANK_TRANSFER');
INSERT INTO Payment VALUES ('PM005','SA005',DATE '2025-06-05',1800,'CARD');
