
DROP TABLE Payment;
DROP TABLE Service_Part;
DROP TABLE Service_Job;
DROP TABLE Part;
DROP TABLE Service;
DROP TABLE Vehicle;
DROP TABLE Mechanic;
DROP TABLE Customer;


CREATE TABLE Customer
(
    customer_id CHAR(5) PRIMARY KEY,
    customer_name VARCHAR2(40) NOT NULL,
    mobile_number CHAR(12),
    email_id VARCHAR2(50) UNIQUE,
    address VARCHAR2(100),
    city VARCHAR2(30)
);


CREATE TABLE Mechanic
(
    mechanic_id CHAR(5) PRIMARY KEY,
    mechanic_name VARCHAR2(40) NOT NULL,
    specialization VARCHAR2(40),
    mobile_number CHAR(12),
    salary NUMBER(10,2) CHECK (salary > 0)
);


CREATE TABLE Vehicle
(
    vehicle_id CHAR(5) PRIMARY KEY,
    customer_id CHAR(5) REFERENCES Customer(customer_id),
    vehicle_number VARCHAR2(15) UNIQUE NOT NULL,
    vehicle_model VARCHAR2(40),
    vehicle_type VARCHAR2(20)
        CHECK (vehicle_type IN ('CAR','BIKE','SCOOTER','VAN')),
    manufacturing_year NUMBER(4),
    mileage NUMBER(8,2) CHECK (mileage >= 0)
);


CREATE TABLE Service
(
    service_id CHAR(5) PRIMARY KEY,
    service_name VARCHAR2(50) UNIQUE NOT NULL,
    description VARCHAR2(100),
    service_cost NUMBER(10,2) CHECK (service_cost > 0)
);


CREATE TABLE Service_Job
(
    job_id CHAR(5) PRIMARY KEY,
    vehicle_id CHAR(5) REFERENCES Vehicle(vehicle_id),
    mechanic_id CHAR(5) REFERENCES Mechanic(mechanic_id),
    service_id CHAR(5) REFERENCES Service(service_id),
    job_date DATE DEFAULT SYSDATE,
    problem_description VARCHAR2(150),
    job_status VARCHAR2(15)
        CHECK (job_status IN ('RECEIVED','IN_PROGRESS','COMPLETED','CANCELLED')),
    total_amount NUMBER(10,2) CHECK (total_amount >= 0)
);


CREATE TABLE Part
(
    part_id CHAR(5) PRIMARY KEY,
    part_name VARCHAR2(50) NOT NULL,
    manufacturer VARCHAR2(40),
    unit_price NUMBER(10,2) CHECK (unit_price > 0),
    quantity_available NUMBER(6) CHECK (quantity_available >= 0),
    reorder_level NUMBER(5) CHECK (reorder_level >= 0)
);


CREATE TABLE Service_Part
(
    service_part_id CHAR(5) PRIMARY KEY,
    job_id CHAR(5) REFERENCES Service_Job(job_id),
    part_id CHAR(5) REFERENCES Part(part_id),
    quantity_used NUMBER(5) CHECK (quantity_used > 0),
    part_price NUMBER(10,2) CHECK (part_price > 0),
    UNIQUE (job_id, part_id)
);


CREATE TABLE Payment
(
    payment_id CHAR(5) PRIMARY KEY,
    job_id CHAR(5) REFERENCES Service_Job(job_id),
    payment_date DATE DEFAULT SYSDATE,
    amount_paid NUMBER(10,2) CHECK (amount_paid > 0),
    payment_mode VARCHAR2(15)
        CHECK (payment_mode IN ('CASH','CARD','UPI','BANK_TRANSFER'))
);


INSERT INTO Customer VALUES
('C001','Akhil Raj','9988776655','akhil@gmail.com','MG Road','Kochi');

INSERT INTO Customer VALUES
('C002','Maria Thomas','9988776656','maria@gmail.com','Town Road','Thrissur');

INSERT INTO Customer VALUES
('C003','Thomas Joseph','9988776657','thomas@gmail.com','Market Road','Kozhikode');

INSERT INTO Customer VALUES
('C004','Neha Sharma','9988776658','neha@gmail.com','Beach Road','Kannur');

INSERT INTO Customer VALUES
('C005','Arjun Nair','9988776659','arjun@gmail.com','Temple Road','Kottayam');


INSERT INTO Mechanic VALUES
('ME001','Arun Kumar','Engine Specialist','9876543210',35000);

INSERT INTO Mechanic VALUES
('ME002','Rahul Thomas','Brake Specialist','9876543211',32000);

INSERT INTO Mechanic VALUES
('ME003','Joseph George','Electrical Specialist','9876543212',30000);

INSERT INTO Mechanic VALUES
('ME004','David Mathew','General Mechanic','9876543213',28000);

INSERT INTO Mechanic VALUES
('ME005','John Varghese','AC Specialist','9876543214',33000);


INSERT INTO Vehicle VALUES
('V001','C001','KL07AB1234','Toyota Hyryder','CAR',2024,18000);

INSERT INTO Vehicle VALUES
('V002','C002','KL08CD5678','Honda City','CAR',2022,35000);

INSERT INTO Vehicle VALUES
('V003','C003','KL10EF9012','Royal Enfield Classic','BIKE',2021,22000);

INSERT INTO Vehicle VALUES
('V004','C004','KL13GH3456','Hyundai i20','CAR',2023,15000);

INSERT INTO Vehicle VALUES
('V005','C005','KL05IJ7890','Honda Activa','SCOOTER',2020,28000);


INSERT INTO Service VALUES
('S001','Oil Change','Engine oil replacement',1200);

INSERT INTO Service VALUES
('S002','Brake Service','Brake inspection and repair',2500);

INSERT INTO Service VALUES
('S003','Engine Service','Complete engine inspection',5000);

INSERT INTO Service VALUES
('S004','AC Service','Air conditioning inspection',3000);

INSERT INTO Service VALUES
('S005','General Service','Complete vehicle inspection',2000);


INSERT INTO Service_Job VALUES
('J001','V001','ME001','S003',DATE '2025-06-01',
'Engine noise and low performance','COMPLETED',6500);

INSERT INTO Service_Job VALUES
('J002','V002','ME002','S002',DATE '2025-06-02',
'Brake vibration','COMPLETED',3500);

INSERT INTO Service_Job VALUES
('J003','V003','ME004','S001',DATE '2025-06-03',
'Regular maintenance','COMPLETED',1500);

INSERT INTO Service_Job VALUES
('J004','V004','ME005','S004',DATE '2025-06-04',
'AC cooling problem','IN_PROGRESS',4000);

INSERT INTO Service_Job VALUES
('J005','V005','ME004','S005',DATE '2025-06-05',
'Regular service','RECEIVED',2500);


INSERT INTO Part VALUES
('P001','Engine Oil','Castrol',800,50,10);

INSERT INTO Part VALUES
('P002','Brake Pad','Bosch',1500,30,5);

INSERT INTO Part VALUES
('P003','Oil Filter','Mann',500,40,10);

INSERT INTO Part VALUES
('P004','Air Filter','K&N',900,25,5);

INSERT INTO Part VALUES
('P005','AC Filter','Mahle',700,20,5);


INSERT INTO Service_Part VALUES
('SP001','J001','P001',4,800);

INSERT INTO Service_Part VALUES
('SP002','J001','P003',1,500);

INSERT INTO Service_Part VALUES
('SP003','J002','P002',2,1500);

INSERT INTO Service_Part VALUES
('SP004','J003','P001',1,800);

INSERT INTO Service_Part VALUES
('SP005','J004','P005',1,700);


INSERT INTO Payment VALUES
('PM001','J001',DATE '2025-06-01',6500,'CARD');

INSERT INTO Payment VALUES
('PM002','J002',DATE '2025-06-02',2000,'UPI');

INSERT INTO Payment VALUES
('PM003','J003',DATE '2025-06-03',1500,'CASH');

INSERT INTO Payment VALUES
('PM004','J004',DATE '2025-06-04',2000,'BANK_TRANSFER');

INSERT INTO Payment VALUES
('PM005','J005',DATE '2025-06-05',2500,'CARD');
