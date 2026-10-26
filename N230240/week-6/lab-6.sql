use gram_panchayat_db;
show tables;
select * from certificate_application;
select * from citizen;
select * from certificate_type;
select * from panchayat_office;

 -- displaying the application having the latest application date
select application_date from Certificate_Application where application_date = (select Max(application_date) from certificate_application);
-- dispalying the applications submitted after the earliest applicatioin date
select application_date from certificate_application where application_date = (select Min(application_date) from certificate_application);
select * from citizen where citizen_id in (select citizen_id from certificate_application where application_status='Approved');
select * from citizen where citizen_id not in (select citizen_id from certificate_application where application_status='Approved');

-- part B (SUBQUERIES)
select application_date from certificate_application where application_date = (select max(application_date) from certificate_application);

select application_date from certificate_application where application_date = (select min(application_date) from certificate_application);

select * from certificate_application where application_date = (select max(application_date) from certificate_application);

select * from certificate_application where application_date = (select min(application_date) from certificate_application);

-- here i am only displaying the names of the citizens
select full_name from citizen where citizen_id in (select citizen_id from certificate_application where application_status = 'Approved');

select application_id  from certificate_application where application_date > (select min(application_date) from certificate_application);

select application_id from certificate_application where application_date < (select max(application_date) from certificate_application);

select full_name  from citizen where citizen_id in (select citizen_id from certificate_application where application_status = 'Submitted');

select full_name from citizen where citizen_id not in (select citizen_id from certificate_application where application_status = 'Approved');

select certificate_name from certificate_type where certificate_id in (select certificate_id from certificate_application where application_status = 'Approved');

select certificate_name from certificate_type where certificate_id not in (select certificate_id from certificate_application where application_status = 'Approved');

select application_id from certificate_application where application_date > any (select avg(application_date) from certificate_application);

select certificate.certificate_name , ca.application_date from certificate_type certificate join certificate_application ca on certificate.certificate_id=ca.certificate_id where ca.application_date =( select max(application_date)from certificate_application); 

select po.office_name
from panchayat_office po 
join certificate_application ca 
on po.office_id=ca.office_id
group by po.office_id 
having count(po.office_id)=
(select max(total)
 from ( select count(application_id) as total
		from certificate_application group by office_id)
        as x
);

select ct.certificate_name
from certificate_type ct 
join certificate_application ca 
on ct.certificate_id=ca.certificate_id
group by ct.certificate_id,certificate_name
having count(ca.application_id)=
(select max(total)
 from ( select count(application_id) as total
		from certificate_application group by certificate_id)
        as x
);

select *
from certificate_type ct 
join certificate_application ca 
on ct.certificate_id=ca.office_id
group by ct.certificate_id
having count(ca.application_id)>
(select avg(application_id) from certificate_application);
