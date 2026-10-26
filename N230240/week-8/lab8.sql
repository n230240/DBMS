use gram_panchayat_db;
show tables;
select * from citizen;
select * from certificate_Application;
select * from certificate_type;
select * from panchayat_office;


set autocommit=0;
select @@autocommit;
start transaction;
update certificate_Application 
set remarks='Approved after Verification'
where application_id=1002;
select remarks from certificate_Application where application_id=1002;

start transaction;
update certificate_application
set application_status='Approved',remarks='approved it after the verification'
where application_id=1002;
commit;
select application_status,remarks from certificate_application where application_id=1002;

start transaction;
update certificate_application
set application_status='Under Review',remarks='takes time to approval'
where application_id=1002;
select application_status,remarks from certificate_application where application_id=1002;
rollback;
select application_status,remarks from certificate_application where application_id=1002;

start transaction;
delete from citizen where citizen_id=107;
insert into citizen values(107,'mohith','2007-08-15','Male','9553450220','ENTREPRENUER','Nellore',1,null);
select * from citizen;

start transaction;
insert into certificate_application values (1007,107,'2026-07-07','nothing','Under Reiview',70,'GP20260007','2024-06-08',7,7,NULL);

start transaction;
delete from  certificate_application where application_id=1006;
rollback;
select application_id from certificate_application where citizen_id=106;
select * from panchayat_office;
start transaction; 
update  panchayat_office
set village_name='NELLORE',office_name='Nellore Gram Panchayat' where office_id=3;
commit;
select * from panchayat_office;
-- part C
start transaction;
update  panchayat_office
set village_name='Ramapuram' where office_id=3;
savepoint application_update;
update panchayat_office
set office_name='Ramapuram Gram Panchayat' where office_id=3;
Rollback to savepoint application_update;
select * from panchayat_office;
start transaction;
update panchayat_office
set office_name='Ramapuram Gram Panchayat' where office_id=3;
savepoint office_name_update;
update panchayat_office
set office_name='Nellore panchayat_office' where office_id=1;
savepoint nellore_update;
update panchayat_office
set office_name='Ramapuram panchayat_office' where office_id=1;
update panchayat_office
set office_email='Nellore@gp.example' where office_id=1;
rollback to savepoint office_name_update;





