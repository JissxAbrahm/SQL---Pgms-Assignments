create table sales_person
(
	sid varchar(10),
	sname varchar2(15),
	city varchar(15),
	state varchar(20)
);

insert into sales_person values('C00001', 'Rahul Sharma', 'Mumbai', 'Maharashtra');
insert into sales_person values('C00002', 'Eric Sheldon', 'Madras', 'TamilNadu');
insert into sales_person values('C00003', 'Rama Krishnan', 'Mumbai',  'Maharashtra');
insert into sales_person values('C00004', 'Evonne Eric', 'Bangalore', 'Karnataka');
insert into sales_person values('C00005', 'Manasa Binu', 'Mumbai', 'Maharashtra');
insert into sales_person values('C00006', 'Ani Rose', 'Mangalore', 'Karnataka');

select name from cust_master where city='Mumbai' union select sname from sales_person where city='Mumbai';

 select name from cust_master where city='Mangalore' union select sname from sales_person where city='Mangalore';

select name from cust_master intersect select sname from sales_person;select name from cust_master intersect select sname from sales_person;

select name from cust_master minus select sname from sales_person; //7

select city from cust_master intersect select city from sales_person;//8

select state from cust_master intersect select state from sales_person;//9

select name from cust_master where state='Maharastra' union select sname from sales_person where state='Maharashtra';//10

select name from cust_master where state='Karnataka' union all select sname from sales_person where state='Karnataka';//11

select name from cust_master where state='Karnataka' minus select sname from sales_person where state='Karnataka'; //13


SELECT Name
FROM Cust_Master
WHERE City IN ('Mumbai', 'Bangalore')

UNION

SELECT Sname
FROM Sales_Person
WHERE City IN ('Mumbai', 'Bangalore'); // 14


SELECT State, COUNT(*) AS Number_of_Clients
FROM Cust_Master
GROUP BY State; //15











