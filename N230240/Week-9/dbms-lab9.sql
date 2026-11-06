use gram_panchayat;
show tables;
select * from citizen;
select * from certificate_type;
select * from certificate_application;
select * from panchayat_office;
-- partA
-- task2
DELIMITER //
create procedure welcome_panchayat()
BEGIN
SELECT 'welcome gram panchayat certificate system' as message;
end //
DELIMITER ;
call welcome_panchayat();
-- task4
delimiter //
create procedure get_citizen_name(in p_citizen_id int)
begin
declare v_name varchar(100);
select full_name into v_name from citizen where citizen_id=p_citizen_id;
select v_name as full_name;
end //
delimiter ;
call get_citizen_name(101);

-- task5
delimiter //
create procedure show_application_details(in p_application_id int)
begin
select application_id,application_status from certificate_application where application_id=p_application_id;
end //
delimiter ;
call show_application_details(1001);

-- level0
-- q1
delimiter //
create procedure display_citizen_details(in p_citizen_id int)
begin
select citizen_id,full_name from citizen where citizen_id=p_citizen_id;
end //
delimiter ;
call display_citizen_details(101);
-- q2
delimiter //
create procedure get_citizen_details(in p_citizen_id int)
begin
select * from citizen where citizen_id=p_citizen_id;
end //
delimiter ;
call get_citizen_details(101);

-- q3
delimiter //
create procedure checkstatus(in p_status varchar(30))
begin
if p_status='approved' then select 'certificate approved' as message;
elseif p_status='pending' then select 'application under processing' as message;
elseif p_status='rejected' then select 'application rejected' as message;
else select "unknown status" as message;
end if;
end //
delimiter ;
call checkstatus('approved');

-- q4
delimiter //
create function get_application_status(p_application_id int)
returns varchar(30)
deterministic
begin
declare v_status varchar(30);
select application_status into v_status from certificate_application where application_id=p_application_id;
return v_status;
end //
delimiter ;
select get_application_status(1002);

-- q5
delimiter //
create procedure number_loop()
begin
declare v_count int default 1;
count_loop: loop
select v_count as number;
set v_count=v_count+1;
if v_count>5 then leave count_loop;
end if;
end loop;
end //
delimiter ;
call number_loop();

-- level1
-- q1
delimiter //
create procedure classify_application(in p_application_id int)
begin
declare v_status varchar(30);
select application_status into v_status from certificate_application where application_id=p_application_id;
if v_status='approved' then select 'certificate ready' as message;
elseif v_status="rejected" then select 'application rejected' as message;
elseif v_status='pending' then select 'application pending' as message;
else select 'unknown status' as message;
end if;
end //
delimiter ;
call classify_application(2);

-- q2
delimiter //
create function count_application ( p_citizen_id int)
returns int
deterministic
begin
declare v_count int;
select count(*) into v_count from certificate_application where citizen_id=p_citizen_id;
return v_count;
end //
delimiter ;
select count_application(103);

-- level2
-- q1
DELIMITER //

CREATE PROCEDURE display_pending_applications()
BEGIN
    DECLARE done INT DEFAULT FALSE;

    DECLARE v_application_id INT;
    DECLARE v_citizen_id INT;
    DECLARE v_status VARCHAR(30);

    DECLARE application_cursor CURSOR FOR
        SELECT application_id,
               citizen_id,
               application_status
        FROM Certificate_Application
        WHERE application_status = 'Pending';

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN application_cursor;

    read_loop: LOOP

        FETCH application_cursor
        INTO v_application_id, v_citizen_id, v_status;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT
            v_application_id AS application_id,
            v_citizen_id AS citizen_id,
            v_status AS application_status;

    END LOOP;

    CLOSE application_cursor;
END //

DELIMITER ;
call display_pending_applications();

-- q2
DELIMITER //

CREATE PROCEDURE find_application(
    IN p_application_id INT
)
BEGIN
    DECLARE v_status VARCHAR(30);

    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
        SELECT 'Application not found' AS message;
    END;

    SELECT application_status
    INTO v_status
    FROM Certificate_Application
    WHERE application_id = p_application_id;

    SELECT
        p_application_id AS application_id,
        v_status AS application_status;
END //
DELIMITER ;
call find_application(1002);