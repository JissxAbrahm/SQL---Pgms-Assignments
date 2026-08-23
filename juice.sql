
DROP TABLE Payment;
DROP TABLE Sales_Item;
DROP TABLE Sales;
DROP TABLE Juice_Item;
DROP TABLE Category;
DROP TABLE Customer;
DROP TABLE Supplier;


CREATE TABLE Supplier
(
    supplier_id CHAR(5) PRIMARY KEY,
    supplier_name VARCHAR2(40) NOT NULL,
    contact_person VARCHAR2(30),
    mobile_number CHAR(12),
    email_id VARCHAR2(50) UNIQUE,
    city VARCHAR2(30)
);


CREATE TABLE Customer
(
    customer_id CHAR(5) PRIMARY KEY,
    customer_name VARCHAR2(40) NOT NULL,
    mobile_number CHAR(12),
    email_id VARCHAR2(50) UNIQUE,
    city VARCHAR2(30)
);


CREATE TABLE Category
(
    category_id CHAR(5) PRIMARY KEY,
    category_name VARCHAR2(30) UNIQUE NOT NULL,
    description VARCHAR2(100)
);


CREATE TABLE Juice_Item
(
    juice_id CHAR(5) PRIMARY KEY,
    juice_name VARCHAR2(40) NOT NULL,
    category_id CHAR(5) REFERENCES Category(category_id),
    supplier_id CHAR(5) REFERENCES Supplier(supplier_id),
    price NUMBER(8,2) CHECK (price > 0),
    quantity_available NUMBER(6) CHECK (quantity_available >= 0),
    availability VARCHAR2(15)
        CHECK (availability IN ('AVAILABLE','UNAVAILABLE'))
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
    juice_id CHAR(5) REFERENCES Juice_Item(juice_id),
    quantity_sold NUMBER(5) CHECK (quantity_sold > 0),
    selling_price NUMBER(8,2) CHECK (selling_price > 0),
    UNIQUE (sales_id, juice_id)
);


CREATE TABLE Payment
(
    payment_id CHAR(5) PRIMARY KEY,
    sales_id CHAR(5) REFERENCES Sales(sales_id),
    payment_date DATE DEFAULT SYSDATE,
    amount_paid NUMBER(10,2) CHECK (amount_paid > 0),
    payment_mode VARCHAR2(15)
        CHECK (payment_mode IN ('CASH','CARD','UPI','BANK_TRANSFER'))
);


INSERT INTO Supplier VALUES
('S001','Fresh Fruits','Anil','9876543210','fresh@gmail.com','Kochi');

INSERT INTO Supplier VALUES
('S002','Green Farms','Rahul','9876543211','green@gmail.com','Thrissur');

INSERT INTO Supplier VALUES
('S003','Fruit World','Joseph','9876543212','fruitworld@gmail.com','Kozhikode');

INSERT INTO Supplier VALUES
('S004','Daily Fruits','David','9876543213','daily@gmail.com','Kannur');

INSERT INTO Supplier VALUES
('S005','Fresh Mart','John','9876543214','freshmart@gmail.com','Kottayam');


INSERT INTO Customer VALUES
('C001','Akhil Raj','9988776655','akhil@gmail.com','Kochi');

INSERT INTO Customer VALUES
('C002','Maria Thomas','9988776656','maria@gmail.com','Thrissur');

INSERT INTO Customer VALUES
('C003','Thomas Joseph','9988776657','thomas@gmail.com','Kozhikode');

INSERT INTO Customer VALUES
('C004','Neha Sharma','9988776658','neha@gmail.com','Kannur');

INSERT INTO Customer VALUES
('C005','Arjun Nair','9988776659','arjun@gmail.com','Kottayam');


INSERT INTO Category VALUES
('C001','Fresh Juice','Fresh fruit juices');

INSERT INTO Category VALUES
('C002','Milk Shake','Milk based drinks');

INSERT INTO Category VALUES
('C003','Mocktail','Cold mocktails');

INSERT INTO Category VALUES
('C004','Smoothie','Fruit smoothies');

INSERT INTO Category VALUES
('C005','Special Juice','Special juice combinations');


INSERT INTO Juice_Item VALUES
('J001','Orange Juice','C001','S001',80,50,'AVAILABLE');

INSERT INTO Juice_Item VALUES
('J002','Mango Juice','C001','S002',100,40,'AVAILABLE');

INSERT INTO Juice_Item VALUES
('J003','Banana Shake','C002','S003',120,30,'AVAILABLE');

INSERT INTO Juice_Item VALUES
('J004','Strawberry Smoothie','C004','S004',150,25,'AVAILABLE');

INSERT INTO Juice_Item VALUES
('J005','Watermelon Juice','C005','S005',70,60,'UNAVAILABLE');


INSERT INTO Sales VALUES
('SA001','C001',DATE '2025-06-01',240,'PAID');

INSERT INTO Sales VALUES
('SA002','C002',DATE '2025-06-02',200,'PAID');

INSERT INTO Sales VALUES
('SA003','C003',DATE '2025-06-03',360,'PARTIAL');

INSERT INTO Sales VALUES
('SA004','C004',DATE '2025-06-04',300,'PAID');

INSERT INTO Sales VALUES
('SA005','C005',DATE '2025-06-05',140,'UNPAID');


INSERT INTO Sales_Item VALUES
('SI001','SA001','J001',3,80);

INSERT INTO Sales_Item VALUES
('SI002','SA002','J002',2,100);

INSERT INTO Sales_Item VALUES
('SI003','SA003','J003',3,120);

INSERT INTO Sales_Item VALUES
('SI004','SA004','J004',2,150);

INSERT INTO Sales_Item VALUES
('SI005','SA005','J005',2,70);


INSERT INTO Payment VALUES
('PM001','SA001',DATE '2025-06-01',240,'UPI');

INSERT INTO Payment VALUES
('PM002','SA002',DATE '2025-06-02',200,'CASH');

INSERT INTO Payment VALUES
('PM003','SA003',DATE '2025-06-03',200,'CARD');

INSERT INTO Payment VALUES
('PM004','SA004',DATE '2025-06-04',300,'UPI');

INSERT INTO Payment VALUES
('PM005','SA005',DATE '2025-06-05',140,'CASH');
