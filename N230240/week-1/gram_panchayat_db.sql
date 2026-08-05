show databases;
use  gram_panchayat_db;
create table Citizen(citizen_id int primary key,full_name varchar(100) not null,date_of_birth date not null,gender varchar(10) not null,mobile_number varchar(15) unique not null,occupation varchar(50),village_name varchar(50)not null,is_active boolean not null);
insert into Citizen values(101,"Ravi Kumar",'1995-06-15',"Male",986750001,"Farmer","Ramapuram",true);
insert into Citizen values(102,"Lakshmi Devi",'1988-11-22',"FeMale",986750002,"Tailor","Ramapuram",true);
insert into Citizen values(103,"Suresh Babu",'1992-03-10',"Male",986750003,"Shopkeeper","Seethampeta",true);
insert into Citizen values(104,"Anjali Rao",'2000-08-05',"FeMale",986750004,"Student","Raamapuram",true);
insert into Citizen values(105,"Kiran Kumar",'1985-01-18',"Male",986750005,"Electrician","Seethampeta",true);
insert into Citizen values(106,"Meena Kumari",'1998-12-30',"FeMale",986750006,"Teacher","Lakshmipuram",false);

create table Certificate_Type(certificate_type_id int primary key,certificate_name varchar(100)unique not null,description varchar(200) not null,processing_days int not null,application_fee decimal(8,2) not null,is_available boolean not null);
insert into Certificate_type values(1,"Residence Certificate","Certifies the declared place of residence",7,30,true);
insert into Certificate_type values(2,"Birth Record Request","Request for a locally maintained birth record",5,20,true);
insert into Certificate_type values(3,"Death Record Request","Request for a locally maintained death record",5,20,true);
insert into Certificate_type values(4,"Family Member Certificate","Records declared family-member information",10,40,true);
insert into Certificate_type values(5,"Property Certificate","Certificate related to locally maintained property certificate",15,50,true);
insert into Certificate_type values(6,"No-Dues Certificate","Indicates applicable local dues status",7,25,false);

create table Certificate_Application(application_id int primary key,citizen_id int not null,certificate_name varchar(100) not null,application_date date not null,purpose varchar(200) not null,application_status varchar(30) not null,fee_paid decimal(8,2) not null,reference_number varchar(30) unique not null);
insert into Certificate_Application values(1001,101,"Residence Certificate","2026-07-01","Bank account documentation","Submitted",30,"GP20260001");
insert into Certificate_Application values(1002,102,"Family member certificate","2026-07-02","Welfarae scheme application","Under Review",40,"GP20260002");
insert into Certificate_Application values(1003,103,"Property certificate","2026-07-03","Property document","Submitted",50,"GP20260003");
insert into Certificate_Application values(1004,104,"Residence Certificate","2026-07-04","College admision","Approved",30,"GP20260004");
insert into Certificate_Application values(1005,105,"No-dues Certificate","2026-07-05","Local Service requirement","Under review",25,"GP20260005");
insert into Certificate_Application values(1006,106,"Birth Record Request","2026-07-06","Personal documentation","Rejected",20,"GP20260006");

create table Panchayat_Office(office_id int primary key,office_name varchar(100) not null,village_name varchar(50) not null,pincode varchar(6) not null,contact_number varchar(15) unique,office_email varchar(100) unique,opening_time time not null,is_operational boolean not null);
insert into Panchayat_Office values(1,"Ramapuram Gram Panchayat","Ramapuram",521101,086600001,"ramapuram@gp.example","09:00:00",true);
insert into Panchayat_Office values(2,"Seethampeta Gram Panchayat","Seethampeta",521102,086600002,"seethampeta@gp.example","09:30:00",true);
insert into Panchayat_Office values(3,"Lakshmipuram Gram Panchayat","Lakshmipuram",521103,086600003,"lakshmipuram@gp.example","09:00:00",true);
insert into Panchayat_Office values(4,"Krishnapuram Gram Panchayat","Krishnapuram",521104,086600004,"krishnapuram@gp.example","10:00:00",true);
insert into Panchayat_Office values(5,"Venkatapuram Gram Panchayat","Venkatapuram",521105,086600005,"venkatapuram@gp.example","09:30:00",true);
insert into Panchayat_Office values(6,"Gopalapuram Gram Panchayat","Gopalapuram",521106,086600006,"gopalapuram@gp.example","09:00:00",false);


insert into Citizen values(107,"Apashyam kirikiri","204-07-16","Male",9876543210,"House husband","Ramayapalem",true);
insert into Certificate_type values(7,"Income certificate","Certifies the income of the family anually",10,50,true);
update Certificate_Application set application_status="Under Review" where application_id=1001;
update Certificate_Application set application_status="Approved" where application_id=1002;
update Citizen set occupation="Electrical Technician" where citizen_id=105;
update Certificate_type set processing_days=12 where certificate_type_id=5;
update Certificate_type set is_available=true where certificate_name="No-Dues Certificate";
delete from Citizen where citizen_id=107;

alter table Citizen add address varchar(200);
alter table Certificate_Application add issued_date date not null default '2024-06-08';
alter table Certificate_Application modify purpose varchar(500);
alter table Panchayat_Office add closing_time time not null;
  
select * from Citizen;
select *from Certificate_type;
select * from Certificate_Application;
select * from Panchayat_Office;

create table Temporary_Request(request_id int primary key,request_name varchar(100) not null,request_date date not null);
insert into Temporary_Request values(1,"sdfas","1999-08-09");
insert into Temporary_Request values(2,"qeewdbdfd","1993-08-09");
insert into Temporary_Request values(3,"sreert","1996-08-09");
select * from Temporary_Request;
truncate Temporary_Request;
drop table Temporary_Request;

insert into Citizen values(101,"asdfasdf","2004-02-09","Male",374829272,"goldsmith","nellore",false,"asdf");
/*DUPLICATE ENTRY '101' FOR KEY 'CITIZEN.PRIMARY'*/
insert into Citizen values(123,"asdfasdf","2004-02-09","Male",986750001,"goldsmith","nellore",false,"asdf");
/*Duplicate entry '986750001' for 'cirtizen.mobile_number'*/
insert into Certificate_type values(8,"asdfsdfre",34,29,false);
/*column count doesnot math value count at row 1*/
insert into Certificate_Application values(1007,107,"Caste Certificate","2026-07-07","Personal Documnetation","Approved",55,"GP20260001","2024-06-08");
/*Duplicate entry 'GP20260001' for 'citizen_application.reference_number'*/
