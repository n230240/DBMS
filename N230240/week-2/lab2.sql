use gram_panchayat_db;
show tables;
-- now the program starts 
-- built in string methods
select upper(full_name) as Full_name  from Citizen;
select lower(village_name) as village_name from Citizen;
select Full_name,length(Full_name) as name_LENGTH from Citizen;
select reference_number,LEFT(reference_number,4) as first_four from certificate_application;
select concat(full_name,"-", village_name) as details from Citizen;
select replace(certificate_name,"Certificate","Cert") from certificate_Type;
select trim(certificate_name) as certificate_name from certificate_Type;
select substring(full_name,1,locate(' ',full_name)-1) from Citizen;
select concat("citizen : ",full_name," village :",village_name) from Citizen;
select * from certificate_application where left(reference_number,6) = "GP2026";
select * from certificate_application;

-- built in numeric functions

alter table certificate_type modify column application_fee decimal(8,2);
select * from certificate_type;
alter table certificate_application modify column fee_paid float(10);
select * from certificate_application;
select application_fee , round(application_fee) from certificate_type;
select processing_days , abs(processing_days-10) as absolute_value from certificate_type ;
select processing_days , power(processing_days,2) as square from certificate_type;
select processing_days , mod(processing_days,3) as remainder from certificate_type;
select application_fee , round(application_fee,1) as rounded_fee from certificate_type;
select application_fee , ceil(application_fee) as ceiling_fee , floor(application_fee) as floor_value from certificate_type;
select floor(1+rand()*100);
select processing_days,sqrt(processing_days) as square_root from certificate_type;
select certificate_name, processing_days, (processing_days * 2) as doubled_processing_days from certificate_type;

-- date functions

select curdate()as today_date;
select now() as current_date_time;
select application_date,year(application_date) as year from certificate_application;
select application_date,month(application_date) as month from certificate_application;
select application_date,day(application_date) as day from certificate_application;
select date_add(application_date,interval processing_days day) as expected_date_of_issue from certificate_application ca join certificate_type ct on ca.certificate_name = ct.certificate_name;
select date_add(application_date , interval 30 day) as after_30_days from certificate_application;
select date_sub(application_date , interval 7 day) as before_30 from certificate_application;
select datediff(curdate(),application_date)as date_diff from certificate_application;
select * from certificate_application where( year(curdate()) = year(application_date));


-- conversion functions

select cast(application_fee as signed) as application_fee_in_int from certificate_type;
select cast(processing_days as char) as processing_days_char from certificate_type;
select cast(application_date as datetime) as application_datetime from certificate_application;
select cast(processing_days as decimal) as processing_decimal from certificate_type;
select cast(application_fee as char) as application_string from certificate_type;
select cast(application_fee as signed) + 10 as new_fee from certificate_type;
