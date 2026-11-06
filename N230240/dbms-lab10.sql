use gram_panchayat;
DELIMITER //
CREATE PROCEDURE citizen_application_summary(IN p_citizen_id INT)
BEGIN
declare v_name varchar(100);
declare v_total int;
declare v_approved int;
declare v_pending int;
declare v_rejected int;
declare continue handler for not found
begin
select "citizen not found" as message;
end ;
select full_name into v_name from citizen where citizen_id=p_citizen_id;
select count(*),sum(application_status="approved"),sum(application_status='pending'),sum(application_status='rejected') into v_total,v_approved,v_pending,v_rejected from certificate_application where citizen_id=p_citizen_id;
select v_name as full_name,v_total as total_application,v_approved as approved_applications,v_pending as pending_Applications,v_rejected as rejected_applications;
end //
DELIMITER ;
call citizen_application_summary(101);

-- q2
DELIMITER //
create function get_certificate_type(p_type_id int)
returns varchar(100)
deterministic
begin
declare v_type varchar(100);
select certifcate_type_name into v_type from certificate_type where certificate_type_id=p_type_id;
return v_type;
end //
delimiter ;

-- q3
delimiter //
create procedure process_application(in p_application_id int)
begin
declare v_status varchar(20);
declare continue handler for not found
begin
select "application not found" as message;
end ;
select application_status into v_status from certificate_application where application_id=p_application_id;
if v_status ="approved" then select "certificate ready for collection" as processing_message;
elseif v_status="pending" then select "application under verification" as processing_message;
elseif v_status="rejected" then select "application closed" as processing_message;
else select "unknown status" as processing_message;
end if;
end //
delimiter ;
call process_application(1001);

-- level2
-- q1
DELIMITER //

CREATE PROCEDURE pending_applications()
BEGIN
    DECLARE done INT DEFAULT 0;

    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_type VARCHAR(100);
    DECLARE v_status VARCHAR(20);
    DECLARE v_date DATE;

    DECLARE cur CURSOR FOR
        SELECT ca.application_id,
               c.full_name,
               ct.certificate_name,
               ca.application_status,
               ca.application_date
        FROM Certificate_Application ca
        JOIN Citizen c
            ON ca.citizen_id = c.citizen_id
        JOIN Certificate_Type ct
            ON ca.certificate_id = ct.certificate_type_id
        WHERE ca.application_status = 'Pending';

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_id, v_name, v_type, v_status, v_date;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        SELECT v_id AS Application_ID,
               v_name AS full_Name,
               v_type AS Certificate_Type,
               v_status AS Application_Status,
               v_date AS Application_Date;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
call pending_applications();

-- q2
DELIMITER //
CREATE PROCEDURE classify_all_applications()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_type VARCHAR(100);
    DECLARE v_status VARCHAR(20);
    DECLARE v_category VARCHAR(50);
    DECLARE cur CURSOR FOR
        SELECT ca.application_id,
               c.full_name,
               ct.certificate_name,
               ca.application_status
        FROM Certificate_Application ca
        JOIN Citizen c
            ON ca.citizen_id = c.citizen_id
        JOIN Certificate_Type ct
            ON ca.certificate_id = ct.certificate_type_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;
    OPEN cur;
    read_loop: LOOP
        FETCH cur
        INTO v_id, v_name, v_type, v_status;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        IF v_status = 'Approved' THEN
            SET v_category = 'Completed';
        ELSEIF v_status = 'Pending' THEN
            SET v_category = 'In Progress';
        ELSEIF v_status = 'Rejected' THEN
            SET v_category = 'Closed';
        ELSE
            SET v_category = 'Unknown';
        END IF;
        SELECT v_id AS Application_ID,
               v_name AS Citizen_Name,
               v_type AS Certificate_Type,
               v_status AS Application_Status,
               v_category AS Processing_Category;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- q3
DELIMITER //
CREATE PROCEDURE update_application_status(
    IN p_application_id INT,
    IN p_new_status VARCHAR(20)
)
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*)
    INTO v_count
    FROM Certificate_Application
    WHERE application_id = p_application_id;
    IF v_count = 0 THEN
        SELECT 'Application not found' AS Message;
    ELSEIF p_new_status NOT IN ('Approved', 'Pending', 'Rejected') THEN
        SELECT 'Invalid application status' AS Message;
    ELSE
        UPDATE Certificate_Application
        SET application_status = p_new_status
        WHERE application_id = p_application_id;
        SELECT *
        FROM Certificate_Application
        WHERE application_id = p_application_id;
    END IF;
END //
DELIMITER ;

-- q4
DELIMITER //
CREATE PROCEDURE application_exception_handling(
    IN p_application_id INT
)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_type VARCHAR(100);
    DECLARE v_status VARCHAR(20);
    DECLARE v_found INT DEFAULT 1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_found = 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'SQL error occurred' AS Message;
    END;
    SELECT c.citizen_name,
           ct.certificate_name,
           ca.application_status
    INTO v_name, v_type, v_status
    FROM Certificate_Application ca
    JOIN Citizen c
        ON ca.citizen_id = c.citizen_id
    JOIN Certificate_Type ct
        ON ca.certificate_id = ct.certificate_type_id
    WHERE ca.application_id = p_application_id;
    IF v_found = 0 THEN
        SELECT 'Application not found' AS Message;
    ELSE
        SELECT v_name AS Citizen_Name,
               v_type AS Certificate_Type,
               v_status AS Application_Status;
    END IF;
END //
DELIMITER ;

-- level3
-- q1
DELIMITER //

CREATE PROCEDURE process_certificate_application(
    IN p_application_id INT
)
BEGIN
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_type VARCHAR(100);
    DECLARE v_status VARCHAR(20);
    DECLARE v_date DATE;
    DECLARE v_remarks VARCHAR(255);
    DECLARE v_category VARCHAR(50);
    DECLARE v_found INT DEFAULT 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_found = 0;

    SELECT ca.application_id,
           c.citizen_name,
           ct.certificate_type_name,
           ca.application_status,
           ca.application_date,
           ca.remarks
    INTO v_id, v_name, v_type, v_status, v_date, v_remarks
    FROM Certificate_Application ca
    JOIN Citizen c
        ON ca.citizen_id = c.citizen_id
    JOIN Certificate_Type ct
        ON ca.certificate_type_id = ct.certificate_type_id
    WHERE ca.application_id = p_application_id;

    IF v_found = 0 THEN
        SELECT 'Application not found' AS Message;

    ELSE

        IF v_status = 'Pending' THEN
            SET v_category = 'Further Verification Required';

        ELSEIF v_status = 'Approved' THEN
            SET v_category = 'Certificate Ready';

        ELSEIF v_status = 'Rejected' THEN
            SET v_category = 'Application Closed';

        ELSE
            SET v_category = 'Unknown Status';
        END IF;

        SELECT 'CERTIFICATE APPLICATION REPORT' AS Report;

        SELECT v_id AS Application_ID,
               v_name AS Citizen_Name,
               v_type AS Certificate_Type,
               v_status AS Application_Status,
               v_category AS Processing_Category,
               v_date AS Application_Date,
               v_remarks AS Remarks;
    END IF;
END //

DELIMITER ;

-- q2
DELIMITER //
CREATE PROCEDURE citizen_application_cursor()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_total INT;
    DECLARE v_approved INT;
    DECLARE v_pending INT;
    DECLARE v_rejected INT;
    DECLARE cur CURSOR FOR
        SELECT citizen_id, full_name
        FROM Citizen;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_id, v_name;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        SELECT COUNT(*)
        INTO v_total
        FROM Certificate_Application
        WHERE citizen_id = v_id;
        SELECT COUNT(*)
        INTO v_approved
        FROM Certificate_Application
        WHERE citizen_id = v_id
          AND application_status = 'Approved';
        SELECT COUNT(*)
        INTO v_pending
        FROM Certificate_Application
        WHERE citizen_id = v_id
          AND application_status = 'Pending';
        SELECT COUNT(*)
        INTO v_rejected
        FROM Certificate_Application
        WHERE citizen_id = v_id
          AND application_status = 'Rejected';
        SELECT v_id AS Citizen_ID,
               v_name AS full_Name,
               v_total AS Number_of_Applications,
               v_approved AS Approved_Applications,
               v_pending AS Pending_Applications,
               v_rejected AS Rejected_Applications;

    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- q3
DELIMITER //
CREATE PROCEDURE citizen_application_category()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_count INT;
    DECLARE v_category VARCHAR(50);
    DECLARE cur CURSOR FOR
        SELECT citizen_id, full_name
        FROM Citizen;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_id, v_name;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        SET v_count = get_application_count(v_id);
        IF v_count = 0 THEN
            SET v_category = 'No Application';
        ELSEIF v_count BETWEEN 1 AND 2 THEN
            SET v_category = 'Regular Applicant';
        ELSE
            SET v_category = 'Frequent Applicant';
        END IF;
        SELECT v_id AS Citizen_ID,
               v_name AS full_Name,
               v_count AS Application_Count,
               v_category AS Citizen_Application_Category;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;