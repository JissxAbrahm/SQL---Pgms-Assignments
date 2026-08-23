
DROP TABLE Payment;
DROP TABLE Order_Item;
DROP TABLE Orders;
DROP TABLE Menu_Item;
DROP TABLE Category;
DROP TABLE Customer;
DROP TABLE Employee;
DROP TABLE Supplier;


CREATE TABLE Supplier
(
    supplier_id CHAR(5) PRIMARY KEY,
    supplier_name VARCHAR2(40) NOT NULL,
    contact_person VARCHAR2(30),
    mobile_number CHAR(12),
    email_id VARCHAR2(50) UNIQUE,
    address VARCHAR2(100),
    city VARCHAR2(30)
);


CREATE TABLE Employee
(
    employee_id CHAR(5) PRIMARY KEY,
    employee_name VARCHAR2(40) NOT NULL,
    job_role VARCHAR2(20)
        CHECK (job_role IN ('CHEF','WAITER','MANAGER','CASHIER')),
    mobile_number CHAR(12),
    salary NUMBER(10,2) CHECK (salary > 0)
);


CREATE TABLE Customer
(
    customer_id CHAR(5) PRIMARY KEY,
    customer_name VARCHAR2(40) NOT NULL,
    mobile_number CHAR(12),
    email_id VARCHAR2(50) UNIQUE,
    address VARCHAR2(100),
    city VARCHAR2(30)
);


CREATE TABLE Category
(
    category_id CHAR(5) PRIMARY KEY,
    category_name VARCHAR2(30) UNIQUE NOT NULL,
    description VARCHAR2(100)
);


CREATE TABLE Menu_Item
(
    item_id CHAR(5) PRIMARY KEY,
    item_name VARCHAR2(50) NOT NULL,
    category_id CHAR(5) REFERENCES Category(category_id),
    price NUMBER(8,2) CHECK (price > 0),
    availability VARCHAR2(10)
        CHECK (availability IN ('AVAILABLE','UNAVAILABLE'))
);


CREATE TABLE Orders
(
    order_id CHAR(5) PRIMARY KEY,
    customer_id CHAR(5) REFERENCES Customer(customer_id),
    employee_id CHAR(5) REFERENCES Employee(employee_id),
    order_date DATE DEFAULT SYSDATE,
    table_number NUMBER(3),
    total_amount NUMBER(10,2) CHECK (total_amount >= 0),
    order_status VARCHAR2(15)
        CHECK (order_status IN ('PLACED','PREPARING','SERVED','CANCELLED'))
);


CREATE TABLE Order_Item
(
    order_item_id CHAR(5) PRIMARY KEY,
    order_id CHAR(5) REFERENCES Orders(order_id),
    item_id CHAR(5) REFERENCES Menu_Item(item_id),
    quantity NUMBER(4) CHECK (quantity > 0),
    item_price NUMBER(8,2) CHECK (item_price > 0),
    UNIQUE (order_id, item_id)
);


CREATE TABLE Payment
(
    payment_id CHAR(5) PRIMARY KEY,
    order_id CHAR(5) REFERENCES Orders(order_id),
    payment_date DATE DEFAULT SYSDATE,
    amount_paid NUMBER(10,2) CHECK (amount_paid > 0),
    payment_mode VARCHAR2(15)
        CHECK (payment_mode IN ('CASH','CARD','UPI','BANK_TRANSFER'))
);


INSERT INTO Supplier VALUES
('S001','Fresh Foods','Anil','9876543210','fresh@gmail.com','MG Road','Kochi');

INSERT INTO Supplier VALUES
('S002','Royal Supplies','Rahul','9876543211','royal@gmail.com','Main Road','Thrissur');

INSERT INTO Supplier VALUES
('S003','Green Farms','Joseph','9876543212','green@gmail.com','Market Road','Kozhikode');

INSERT INTO Supplier VALUES
('S004','Daily Needs','David','9876543213','daily@gmail.com','Beach Road','Kannur');

INSERT INTO Supplier VALUES
('S005','Food World','John','9876543214','foodworld@gmail.com','Town Road','Kottayam');


INSERT INTO Employee VALUES
('E001','Arun Kumar','CHEF','9988776655',35000);

INSERT INTO Employee VALUES
('E002','Meera Thomas','WAITER','9988776656',22000);

INSERT INTO Employee VALUES
('E003','Rahul Joseph','MANAGER','9988776657',45000);

INSERT INTO Employee VALUES
('E004','Anita Mathew','CASHIER','9988776658',25000);

INSERT INTO Employee VALUES
('E005','David George','CHEF','9988776659',38000);


INSERT INTO Customer VALUES
('C001','Akhil Raj','9999990001','akhil@gmail.com','MG Road','Kochi');

INSERT INTO Customer VALUES
('C002','Maria Thomas','9999990002','maria@gmail.com','Town Road','Thrissur');

INSERT INTO Customer VALUES
('C003','Thomas Joseph','9999990003','thomas@gmail.com','Market Road','Kozhikode');

INSERT INTO Customer VALUES
('C004','Neha Sharma','9999990004','neha@gmail.com','Beach Road','Kannur');

INSERT INTO Customer VALUES
('C005','Arjun Nair','9999990005','arjun@gmail.com','Temple Road','Kottayam');


INSERT INTO Category VALUES
('CA001','Starters','Appetizers and snacks');

INSERT INTO Category VALUES
('CA002','Main Course','Main food items');

INSERT INTO Category VALUES
('CA003','Beverages','Hot and cold beverages');

INSERT INTO Category VALUES
('CA004','Desserts','Sweet dishes');

INSERT INTO Category VALUES
('CA005','Fast Food','Quick food items');


INSERT INTO Menu_Item VALUES
('M001','Chicken 65','CA001',250,'AVAILABLE');

INSERT INTO Menu_Item VALUES
('M002','Chicken Biryani','CA002',220,'AVAILABLE');

INSERT INTO Menu_Item VALUES
('M003','Fresh Lime','CA003',80,'AVAILABLE');

INSERT INTO Menu_Item VALUES
('M004','Chocolate Cake','CA004',150,'AVAILABLE');

INSERT INTO Menu_Item VALUES
('M005','Veg Burger','CA005',180,'UNAVAILABLE');


INSERT INTO Orders VALUES
('O001','C001','E002',DATE '2025-06-01',5,470,'SERVED');

INSERT INTO Orders VALUES
('O002','C002','E002',DATE '2025-06-02',8,440,'SERVED');

INSERT INTO Orders VALUES
('O003','C003','E001',DATE '2025-06-03',3,500,'PREPARING');

INSERT INTO Orders VALUES
('O004','C004','E002',DATE '2025-06-04',10,300,'PLACED');

INSERT INTO Orders VALUES
('O005','C005','E004',DATE '2025-06-05',2,440,'SERVED');


INSERT INTO Order_Item VALUES
('OI001','O001','M001',1,250);

INSERT INTO Order_Item VALUES
('OI002','O001','M003',1,80);

INSERT INTO Order_Item VALUES
('OI003','O001','M004',1,150);

INSERT INTO Order_Item VALUES
('OI004','O002','M002',2,220);

INSERT INTO Order_Item VALUES
('OI005','O003','M001',2,250);


INSERT INTO Payment VALUES
('P001','O001',DATE '2025-06-01',480,'CARD');

INSERT INTO Payment VALUES
('P002','O002',DATE '2025-06-02',440,'UPI');

INSERT INTO Payment VALUES
('P003','O003',DATE '2025-06-03',300,'CASH');

INSERT INTO Payment VALUES
('P004','O004',DATE '2025-06-04',300,'BANK_TRANSFER');

INSERT INTO Payment VALUES
('P005','O005',DATE '2025-06-05',440,'CARD');
