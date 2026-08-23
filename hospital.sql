DROP TABLE Payment;
DROP TABLE Prescription;
DROP TABLE Medicine;
DROP TABLE Treatment;
DROP TABLE Appointment;
DROP TABLE Bill;
DROP TABLE Patient;
DROP TABLE Doctor;
DROP TABLE Department;


CREATE TABLE Department
(
    department_id CHAR(5) PRIMARY KEY,
    department_name VARCHAR2(40) UNIQUE NOT NULL,
    description VARCHAR2(100)
);


CREATE TABLE Doctor
(
    doctor_id CHAR(5) PRIMARY KEY,
    doctor_name VARCHAR2(40) NOT NULL,
    department_id CHAR(5) REFERENCES Department(department_id),
    specialization VARCHAR2(40),
    mobile_number CHAR(12),
    email_id VARCHAR2(50) UNIQUE,
    consultation_fee NUMBER(8,2) CHECK (consultation_fee > 0)
);


CREATE TABLE Patient
(
    patient_id CHAR(5) PRIMARY KEY,
    patient_name VARCHAR2(40) NOT NULL,
    gender VARCHAR2(10) CHECK (gender IN ('MALE','FEMALE','OTHER')),
    date_of_birth DATE,
    mobile_number CHAR(12),
    email_id VARCHAR2(50) UNIQUE,
    address VARCHAR2(100),
    city VARCHAR2(30)
);


CREATE TABLE Appointment
(
    appointment_id CHAR(5) PRIMARY KEY,
    patient_id CHAR(5) REFERENCES Patient(patient_id),
    doctor_id CHAR(5) REFERENCES Doctor(doctor_id),
    appointment_date DATE DEFAULT SYSDATE,
    appointment_time VARCHAR2(10),
    appointment_status VARCHAR2(15)
        CHECK (appointment_status IN ('SCHEDULED','COMPLETED','CANCELLED'))
);


CREATE TABLE Treatment
(
    treatment_id CHAR(5) PRIMARY KEY,
    appointment_id CHAR(5) REFERENCES Appointment(appointment_id),
    diagnosis VARCHAR2(100),
    treatment_description VARCHAR2(150),
    treatment_date DATE DEFAULT SYSDATE,
    treatment_cost NUMBER(10,2) CHECK (treatment_cost >= 0)
);


CREATE TABLE Medicine
(
    medicine_id CHAR(5) PRIMARY KEY,
    medicine_name VARCHAR2(50) NOT NULL,
    manufacturer VARCHAR2(50),
    unit_price NUMBER(8,2) CHECK (unit_price > 0),
    quantity_available NUMBER(6) CHECK (quantity_available >= 0),
    expiry_date DATE
);


CREATE TABLE Prescription
(
    prescription_id CHAR(5) PRIMARY KEY,
    treatment_id CHAR(5) REFERENCES Treatment(treatment_id),
    medicine_id CHAR(5) REFERENCES Medicine(medicine_id),
    dosage VARCHAR2(30),
    duration VARCHAR2(30),
    quantity NUMBER(5) CHECK (quantity > 0),
    UNIQUE (treatment_id, medicine_id)
);


CREATE TABLE Bill
(
    bill_id CHAR(5) PRIMARY KEY,
    patient_id CHAR(5) REFERENCES Patient(patient_id),
    appointment_id CHAR(5) REFERENCES Appointment(appointment_id),
    bill_date DATE DEFAULT SYSDATE,
    total_amount NUMBER(10,2) CHECK (total_amount >= 0),
    payment_status VARCHAR2(10)
        CHECK (payment_status IN ('PAID','UNPAID','PARTIAL'))
);


CREATE TABLE Payment
(
    payment_id CHAR(5) PRIMARY KEY,
    bill_id CHAR(5) REFERENCES Bill(bill_id),
    payment_date DATE DEFAULT SYSDATE,
    amount_paid NUMBER(10,2) CHECK (amount_paid > 0),
    payment_mode VARCHAR2(15)
        CHECK (payment_mode IN ('CASH','CARD','UPI','BANK_TRANSFER'))
);


INSERT INTO Department VALUES
('D001','Cardiology','Heart and cardiovascular treatment');

INSERT INTO Department VALUES
('D002','Neurology','Brain and nervous system treatment');

INSERT INTO Department VALUES
('D003','Orthopedics','Bones and joint treatment');

INSERT INTO Department VALUES
('D004','Pediatrics','Medical care for children');

INSERT INTO Department VALUES
('D005','Dermatology','Skin related treatment');


INSERT INTO Doctor VALUES
('DR001','Arun Kumar','D001','Cardiologist','9876543210','arun@hospital.com',1500);

INSERT INTO Doctor VALUES
('DR002','Meera Thomas','D002','Neurologist','9876543211','meera@hospital.com',1800);

INSERT INTO Doctor VALUES
('DR003','Rahul Joseph','D003','Orthopedic Surgeon','9876543212','rahul@hospital.com',1200);

INSERT INTO Doctor VALUES
('DR004','Anita Mathew','D004','Pediatrician','9876543213','anita@hospital.com',1000);

INSERT INTO Doctor VALUES
('DR005','David George','D005','Dermatologist','9876543214','david@hospital.com',900);


INSERT INTO Patient VALUES
('P001','Akhil Raj','MALE',DATE '2001-05-10','9988776655','akhil@gmail.com','MG Road','Kochi');

INSERT INTO Patient VALUES
('P002','Maria Thomas','FEMALE',DATE '1998-08-15','9988776656','maria@gmail.com','Town Road','Thrissur');

INSERT INTO Patient VALUES
('P003','Thomas Joseph','MALE',DATE '1995-03-20','9988776657','thomas@gmail.com','Market Road','Kozhikode');

INSERT INTO Patient VALUES
('P004','Neha Sharma','FEMALE',DATE '2003-11-25','9988776658','neha@gmail.com','Beach Road','Kannur');

INSERT INTO Patient VALUES
('P005','Arjun Nair','MALE',DATE '1999-07-30','9988776659','arjun@gmail.com','Temple Road','Kottayam');


INSERT INTO Appointment VALUES
('A001','P001','DR001',DATE '2025-06-01','09:00 AM','COMPLETED');

INSERT INTO Appointment VALUES
('A002','P002','DR002',DATE '2025-06-02','10:00 AM','COMPLETED');

INSERT INTO Appointment VALUES
('A003','P003','DR003',DATE '2025-06-03','11:00 AM','COMPLETED');

INSERT INTO Appointment VALUES
('A004','P004','DR004',DATE '2025-06-04','02:00 PM','SCHEDULED');

INSERT INTO Appointment VALUES
('A005','P005','DR005',DATE '2025-06-05','03:00 PM','COMPLETED');


INSERT INTO Treatment VALUES
('T001','A001','Heart Pain','ECG and cardiac evaluation',DATE '2025-06-01',5000);

INSERT INTO Treatment VALUES
('T002','A002','Migraine','Neurological examination',DATE '2025-06-02',4500);

INSERT INTO Treatment VALUES
('T003','A003','Fracture','X-Ray and bone treatment',DATE '2025-06-03',7000);

INSERT INTO Treatment VALUES
('T004','A004','Fever','General pediatric consultation',DATE '2025-06-04',2000);

INSERT INTO Treatment VALUES
('T005','A005','Skin Allergy','Skin examination and medication',DATE '2025-06-05',3000);


INSERT INTO Medicine VALUES
('M001','Paracetamol','Cipla',5,500,DATE '2027-01-01');

INSERT INTO Medicine VALUES
('M002','Aspirin','Bayer',8,300,DATE '2027-02-01');

INSERT INTO Medicine VALUES
('M003','Amoxicillin','Sun Pharma',12,250,DATE '2026-12-01');

INSERT INTO Medicine VALUES
('M004','Cetirizine','Dr Reddy',6,400,DATE '2027-03-01');

INSERT INTO Medicine VALUES
('M005','Ibuprofen','Abbott',10,350,DATE '2027-04-01');


INSERT INTO Prescription VALUES
('PR001','T001','M002','1 tablet','5 days',5);

INSERT INTO Prescription VALUES
('PR002','T002','M001','1 tablet','3 days',3);

INSERT INTO Prescription VALUES
('PR003','T003','M005','2 tablets','5 days',10);

INSERT INTO Prescription VALUES
('PR004','T004','M001','1 tablet','3 days',3);

INSERT INTO Prescription VALUES
('PR005','T005','M004','1 tablet','7 days',7);


INSERT INTO Bill VALUES
('B001','P001','A001',DATE '2025-06-01',6500,'PAID');

INSERT INTO Bill VALUES
('B002','P002','A002',DATE '2025-06-02',6300,'PARTIAL');

INSERT INTO Bill VALUES
('B003','P003','A003',DATE '2025-06-03',8200,'UNPAID');

INSERT INTO Bill VALUES
('B004','P004','A004',DATE '2025-06-04',3000,'UNPAID');

INSERT INTO Bill VALUES
('B005','P005','A005',DATE '2025-06-05',3900,'PAID');


INSERT INTO Payment VALUES
('PM001','B001',DATE '2025-06-01',6500,'CARD');

INSERT INTO Payment VALUES
('PM002','B002',DATE '2025-06-02',3000,'UPI');

INSERT INTO Payment VALUES
('PM003','B003',DATE '2025-06-04',4000,'CASH');

INSERT INTO Payment VALUES
('PM004','B005',DATE '2025-06-05',3900,'BANK_TRANSFER');

INSERT INTO Payment VALUES
('PM005','B002',DATE '2025-06-05',2000,'CARD');
```
