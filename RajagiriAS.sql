drop table Event_Registration;
drop table Event;
drop table Result;
drop table Enrollment;
drop table Course;
drop table Faculty;
drop table Student;
drop table Department;

create table Department
(	dept_id char(5) constraint dept_id primary key,
	dept_name varchar2(35) unique not null,
	hod_name varchar2(15),
	office_location varchar2(15),
	contact_number varchar(12)
);
create table Student
(	student_id varchar2(10) constraint student_id primary key,
	student_name varchar2(15), dob date,
	gender char(1) check(gender in('M','F')),
	mobile_number char(12),
	email_id varchar2(25) unique,
	dept_id char(5) references Department(dept_id),
	admission_date date, 
	cgpa number(3,2) check(cgpa >=0 and cgpa <=10)
);
create table Faculty
(	faculty_id char(5) constraint faculty_id primary key,
	faculty_name varchar2(15),
	qualification varchar2(35),
	designation varchar2(25),
	joining_date date,
	salary numeric(10,2) check(salary>0),
	email_id varchar2(35),
	dept_id char(5) references Department(dept_id)
);
create table Course
(	course_id char(5) constraint course_id primary key, 
	course_name varchar2(35) not null, 
	credits char(1) check(credits>=1 and credits<=6),
	semester number(1) check(semester >=1 and semester<=8),
	dept_id char(5) references Department(dept_id),
	faculty_id char(5) references Faculty(faculty_id)
);
create table Enrollment
(	enrollment_id char(5) constraint enrollment_id primary key,
	student_id varchar2(10) references Student(student_id),
	course_id char(5) references Course(course_id),
	enrollment_date date default sysdate,
	academic_year varchar2(10), 
	unique(student_id,course_id)
);
create table Result
(	result_id char(5) constraint result_id primary key,
	enrollment_id char(5) references Enrollment(enrollment_id),
	internal_marks number(2) check(internal_marks>=0 and internal_marks<=50),
	external_marks number(2) check(external_marks>=0 and external_marks<=50),
	total_marks number(3),
	grade char(1) check(grade in('A','B','C','D','E','F')),
	result_status char(4) check(result_status in('PASS','FAIL'))
);
create table Event
(	event_id char(5) constraint event_id primary key,
	event_name varchar2(15),
	event_date date,
	venue varchar2(15),
	faculty_id char(5) references Faculty(faculty_id),
	max_participants number(10) check(max_participants>0),
	registration_fee number(5) check(registration_fee>0)
);
create table Event_Registration
(	registration_id char(5) constraint registration_id primary key,
	event_id char(5) references Event(event_id),
	student_id varchar2(10) references Student(student_id),
	registration_date date default sysdate,
	participation_status varchar2(12) check(participation_status in('REGISTERED','ATTENDED','ABSENT'))
);



insert into department values('msccs','Computer Science','Biju','First Floor',9874545689);
insert into department values('msw','Social Work','Shiju','Second Floor',9995588745);
insert into department values('mba','Business','Bindhu','Third Floor',9562145214);
insert into department values('bca','Computer Science1','Binu','First Floor',9254787214);
insert into department values('bba','Business1','Saju','Second Floor',9789654214);


insert into student values('11111','Jose','12-jan-2000','M',9985457895,'msccs1245@gmail.com','msccs','12-june-2020',9);
insert into student values('22222','Mary','15-dec-2002','F',9865457841,'msw1244@gmail.com','msw','25-july-2022',8);
insert into student values('33333','Mark','19-dec-2003','M',9812445689,'mba4542gmail.com','mba','05-sep-2022',9.5);
insert into student values('44444','Dipu','18-jan-2002','M',9865454541,'bca1247@gmail.com','bca','01-july-2022',8);
insert into student values('55555','Jiss','21-sep-2003','M',9814575689,'bba4578@gmail.com','bba','12-sep-2022',9.5);


insert into faculty values('msc11','Manju','MCA','Asst Professor','25-feb-2015',75000,'msccs11@gmail.com','msccs');
insert into faculty values('msw25','Albin','MSW','Asst Professor','30-mar-2019',50000,'msw25@gmail.com','msw');
insert into faculty values('mba78','Shijo','MBA','Guest Lecturer','05-apr-2017',65000,'mba78@gmail.com','mba');
insert into faculty values('bca25','Albin','BCA','Asst Professor','29-mar-2019',59000,'bca25@gmail.com','bca');
insert into faculty values('bba78','Shijo','BBA','Guest Lecturer','18-apr-2017',60000,'bba78@gmail.com','bba');



insert into course values('msc01','Computer Science',4,5,'msccs','msc11');
insert into course values('msw01','Social Work',3,7,'msw','msw25');
insert into course values('mba01','Business Studies',4,2,'mba','mba78');
insert into course values('bca01','Computer Science1',3,7,'bca','bca25');
insert into course values('bba01','Business1',4,2,'bba','bba78');


insert into enrollment (enrollment_id,student_id,course_id,academic_year) values('12345','11111','msc01','2020-2022');
insert into enrollment (enrollment_id,student_id,course_id,academic_year) values('12346','22222','msw01','2020-2022');
insert into enrollment (enrollment_id,student_id,course_id,academic_year) values('12347','33333','mba01','2020-2022');
insert into enrollment (enrollment_id,student_id,course_id,academic_year) values('12348','44444','bca01','2020-2022');
insert into enrollment (enrollment_id,student_id,course_id,academic_year) values('12349','55555','bba01','2020-2022');


insert into result values('msc11','12345',45,49,94,'A','PASS');
insert into result values('msw01','12346',49,49,98,'A','PASS');
insert into result values('mba01','12347',46,44,90,'A','PASS');
insert into result values('bca01','12348',47,48,98,'A','PASS');
insert into result values('bba01','12349',49,46,90,'A','PASS');


insert into event values('msc00','Convocation','25-jun-2026','Carmel Hall','msc11',500,2500);
insert into event values('msw00','Investiture','20-jun-2024','Chavara Hall','msw25',200,3000);
insert into event values('mba00','Graduation','20-mar-2026','Darshana Hall','mba78',600,1500);
insert into event values('bca00','Investiture','20-jan-2024','Chavara Hall','bca25',300,3000);
insert into event values('bba00','Graduation','20-mar-2026','Darshana Hall','bba78',600,1500);


insert into event_registration values('78454','msc00','11111','14-jun-2026','REGISTERED');
insert into event_registration values('45612','msw00','22222','19-nov-2024','ABSENT');
insert into event_registration values('78945','mba00','33333','30-oct-2022','ATTENDED');
insert into event_registration values('45623','bca00','44444','19-dec-2024','ABSENT');
insert into event_registration values('78998','bba00','55555','30-sep-2022','ATTENDED');


alter table department add hod_faculty_id char(5) references Faculty(faculty_id);
alter table department drop column hod_name;