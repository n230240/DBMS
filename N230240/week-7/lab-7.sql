use gram_panchayat_db;
show tables;
select * from certificate_application;
select * from citizen;
select * from certificate_type;
select * from panchayat_office;


create view all_certificate_application as select * from certificate_application;
select  * from all_certificate_application;

create view application_1 as select application_id,citizen_id,application_status from certificate_application;
select * from application_1;

create view approved_application as select application_id from certificate_application where application_status='Approved';

select * from approved_application;

show full tables 
where table_type="VIEW";


-- part-b

create view view1 as select ct.certificate_name,ca.application_date from certificate_type ct join certificate_application ca on ct.certificate_id=ca.certificate_id ;
select * from view1;

create view view2 as select c.full_name,ca.application_status from citizen c join certificate_application ca on c.citizen_id=ca.citizen_id ;
select * from view2;

create view view3 as select office_id,count(*) as total_application from certificate_application group by office_id;
select * from view3; 

create view view4 as select certificate_id,count(*) as total_application from certificate_application group by certificate_id;
select * from view4;

create view view5 as select office_id,count(*) as total_appliocation from panchayat_office group by office_id;
select * from view5;

create view view6 as select ct.certificate_id,ct.certificate_name from certificate_type ct join certificate_application ca  
