use gram_panchayat_db;
show tables;
select * from citizen;
select * from certificate_type;
alter table certificate_type drop citizen_id;
select * from certificate_application;
insert into certificate_application(application_id ) values(1007);
select * from panchayat_office;

select c.full_name , ct.certificate_name , ca.application_date from citizen c inner join certificate_application ca on c.citizen_id = ca.citizen_id inner join certificate_type ct on ca.certificate_id = ct.certificate_id;
 
 select c.full_name , po.office_name from citizen c inner join certificate_application ca on c.citizen_id = ca.citizen_id inner join panchayat_office po on ca.office_id = po.office_id ; 
  
 select ca.application_id,c.full_name , ca.application_status from citizen c inner join certificate_application ca on c.citizen_id = ca.citizen_id ;
 
 
 select c.full_name , ct.certificate_name , ca.application_date from citizen c inner join certificate_application ca on c.citizen_id = ca.citizen_id inner join certificate_type ct on ca.certificate_id = ct.certificate_id ;
 
 
 select c.full_name , ct.certificate_name , ca.application_status , po.office_name from citizen c inner join certificate_application ca on c.citizen_id = ca.citizen_id inner join certificate_type ct on ca.certificate_id = ct.certificate_id inner join panchayat_office po on po.office_id = ca.office_id ;
 
 select c.full_name , ct.certificate_name , po.office_name from citizen c inner join certificate_application ca on c.citizen_id = ca.citizen_id inner join certificate_type ct on ca.certificate_id = ct.certificate_id inner join panchayat_office po on ca.office_id = po.office_id where ct.certificate_name = "Income Certificate";
 select c.full_name , po.office_name from citizen c inner join certificate_application ca on c.citizen_id = ca.citizen_id inner join panchayat_office po on po.office_id = ca.office_id where po.office_name = "Nuzvid gram Panchayat";
 select ct.certificate_name , ct.description ,ca.application_status from certificate_application ca inner join certificate_type ct on ca.certificate_id = ct.certificate_id; 

 select c.full_name , c.village_name , ct.certificate_name , ca.application_date , po.office_name
 from citizen c 
 inner join certificate_application ca 
 on c.citizen_id = ca.citizen_id 
 inner join certificate_type ct
 on ca.certificate_id = ct.certificate_id 
 inner join panchayat_office po
 on po.office_id = ca.office_id ;
 


 select c.full_name , c.village_name ,ct.certificate_name , ca.application_status,ca.application_date , po.office_name
 from citizen c 
 inner join certificate_application ca 
 on c.citizen_id = ca.citizen_id 
 inner join certificate_type ct
 on ca.certificate_id = ct.certificate_id 
 inner join panchayat_office po
 on po.office_id = ca.office_id ;
 
 
select c.full_name , ca.application_id
from citizen c
left outer join certificate_application ca
on c.citizen_id = ca.citizen_id;



 
 select ca.application_id ,ca.certificate_id , ct.certificate_name 
 from certificate_application ca
 right outer join certificate_type ct
 on ca.certificate_id = ct.certificate_id;
 
 
 select c.full_name , ca.certificate_id 
 from citizen c
 left join certificate_application ca
 on c.citizen_id = ca.citizen_id 
 union 
  select c.full_name , ca.certificate_id 
 from citizen c
 right join certificate_application ca
 on c.citizen_id = ca.citizen_id ;
 
 -- task 14
 select c.full_name ,ct.certificate_name
 from citizen c
 cross join certificate_type ct;
 
 select c1.full_name as Citizen1,
 c2.full_name as Citizen2,
 c1.village_name
 from citizen c1
 join citizen c2
 on c1.village_name = c2.village_name 
 where c1.citizen_id < c2.citizen_id;