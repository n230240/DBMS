-- =========================================
-- IRCTC DATABASE
-- =========================================

CREATE DATABASE IRCTC_DB;

USE IRCTC_DB;


-- =========================================
-- 1. PASSENGER TABLE
-- =========================================

CREATE TABLE PASSENGER
(
    PassengerID INT PRIMARY KEY,
    PassengerName VARCHAR(50),
    Age INT,
    Gender CHAR(1),
    City VARCHAR(30),
    Phone VARCHAR(15),
    AlternatePhone VARCHAR(15)
);


-- Insert Passenger data

INSERT INTO PASSENGER VALUES
(101, 'Rahul', 28, 'M', 'Hyderabad', '9876543210', NULL),
(102, 'Anjali', 35, 'F', 'Vijayawada', '9876543211', '9123456780'),
(103, 'Sneha', 22, 'F', 'Guntur', NULL, '9123456781'),
(104, 'Ravi', 42, 'M', 'Visakhapatnam', '9876543213', NULL),
(105, 'Priya', 31, 'F', 'Hyderabad', '9876543214', NULL),
(106, 'Kiran', 19, 'M', 'Guntur', '9876543215', '9123456782'),
(107, 'Arjun', 65, 'M', 'Vijayawada', NULL, '9123456783'),
(108, 'Rani', 27, 'F', 'Tirupati', '9876543217', NULL),
(109, 'Rahul', 38, 'M', 'Hyderabad', '9876543218', NULL),
(110, 'Suresh', 55, 'M', 'Guntur', NULL, NULL);


-- =========================================
-- 2. TRAIN TABLE
-- =========================================

CREATE TABLE TRAIN
(
    TrainID INT PRIMARY KEY,
    TrainName VARCHAR(50),
    Source VARCHAR(30),
    Destination VARCHAR(30),
    Fare DECIMAL(10,2)
);


-- Insert Train data

INSERT INTO TRAIN VALUES
(201, 'Godavari Express', 'Visakhapatnam', 'Hyderabad', 650),
(202, 'Simhadri Express', 'Visakhapatnam', 'Hyderabad', 420),
(203, 'Krishna Express', 'Vijayawada', 'Hyderabad', 550),
(204, 'Rayalaseema Express', 'Tirupati', 'Hyderabad', 700),
(205, 'Amaravati Express', 'Guntur', 'Hyderabad', 600),
(206, 'Godavari Superfast', 'Visakhapatnam', 'Vijayawada', 800),
(207, 'Narasapur Express', 'Vijayawada', 'Visakhapatnam', 500),
(208, 'Swarna Express', 'Hyderabad', 'Visakhapatnam', 750);


-- =========================================
-- 3. BOOKING TABLE
-- =========================================

CREATE TABLE BOOKING
(
    BookingID INT PRIMARY KEY,
    PassengerID INT,
    TrainID INT,
    JourneyDate DATE,
    SeatClass VARCHAR(20),
    TicketStatus VARCHAR(20),
    AmountPaid DECIMAL(10,2),
    Remarks VARCHAR(100),

    FOREIGN KEY (PassengerID)
        REFERENCES PASSENGER(PassengerID),

    FOREIGN KEY (TrainID) 
        REFERENCES TRAIN(TrainID)
);


-- Insert Booking data

INSERT INTO BOOKING VALUES
(301, 101, 201, '2026-08-20', 'AC', 'Confirmed', 650, NULL),
(302, 102, 201, '2026-08-21', 'Sleeper', 'Confirmed', 550, 'Window Seat'),
(303, 103, 202, '2026-08-22', 'AC', 'Waiting', 420, NULL),
(304, 104, 206, '2026-08-23', 'AC', 'Confirmed', 800, 'Meal Required'),
(305, 105, 205, '2026-08-24', 'Sleeper', 'Cancelled', 600, 'Cancelled by passenger'),
(306, 101, 204, '2026-08-25', 'AC', 'Confirmed', 700, NULL),
(307, 106, 203, '2026-08-26', 'Sleeper', 'Waiting', 550, NULL),
(308, 107, 201, '2026-08-27', 'AC', 'Confirmed', 650, 'Senior Citizen'),
(309, 108, 207, '2026-08-28', 'Sleeper', 'Confirmed', 500, NULL),
(310, 109, 208, '2026-08-29', 'AC', 'Cancelled', 750, 'Payment issue'),
(311, 105, 201, '2026-08-30', 'AC', 'Confirmed', 650, NULL),
(312, 102, 206, '2026-08-31', 'Sleeper', 'Confirmed', 800, NULL),
(313, 103, 203, '2026-09-01', 'Sleeper', 'Waiting', 550, NULL),
(314, 104, 201, '2026-09-02', 'AC', 'Confirmed', 650, 'Lower Berth'),
(315, 108, 204, '2026-09-03', 'AC', 'Cancelled', 700, NULL);


-- =========================================
-- 4. STATION TABLE
-- =========================================

CREATE TABLE STATION
(
    StationID INT PRIMARY KEY,
    StationName VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(30)
);


-- Insert Station data

INSERT INTO STATION VALUES
(401, 'Secunderabad Junction', 'Hyderabad', 'Telangana'),
(402, 'Visakhapatnam Junction', 'Visakhapatnam', 'Andhra Pradesh'),
(403, 'Vijayawada Junction', 'Vijayawada', 'Andhra Pradesh'),
(404, 'Guntur Junction', 'Guntur', 'Andhra Pradesh'),
(405, 'Tirupati Railway Station', 'Tirupati', 'Andhra Pradesh'),
(406, 'Hyderabad Deccan', 'Hyderabad', 'Telangana');


-- =========================================
-- CHECK ALL TABLES
-- =========================================

SELECT * FROM PASSENGER;

SELECT * FROM TRAIN;

SELECT * FROM BOOKING;

SELECT * FROM STATION;


SELECT * FROM PASSENGER;
select passengername,city from passenger;
select trainname,fare from train;
select trainname from train where fare>500; 
select passengername from passenger where age>13 and age<19;
select * from booking where ticketstatus='confirmed';
select * from passenger where city='Hyderabad';

-- if the railway administration wants to know  only the avaialable seat classes
select distinct(seatclass) from booking; 
select distinct Source,destination from train; 
select distinct city from station;

select trainname ,fare from train order by fare asc;
select * from booking where journeydate='2026-9-03';
select * from booking order by ticketstatus asc,amountpaid desc; 

select fare,fare-fare*(15/100) as discounted_total_fare from train;  
select * from train;
select * from booking;
select * from passenger;
select * from station;
select t.fare, t.fare*(20/100) as tatkal_fare_extra_Amount,t.fare+fare*(20/100) as tatkal_fare from train t join booking bo on t.trainID=bo.trainid where bo.seatclass='AC';
select t.fare, t.fare*(15/100) as tatkal_fare_extra_Amount,t.fare+fare*(15/100) as tatkal_fare from train t join booking bo on t.trainID=bo.trainid where bo.seatclass='AC';
select fare,fare+50 as total_fare from train;

select fare,fare*(18/100) as gst,fare+fare*(18/100) as total_fare from train;
select fare,fare*(20/100) as discount,fare- fare*(20/100) from train; 

-- comparison operators
select passengername from passenger where city='udipi';
select * from booking where ticketstatus != 'cancelled';
select * from passenger where age>30;
select trainname from train where fare<500;
select passengername from passenger where city !='Hyderabad';
select passengername from passenger where age>=19;
select * from booking where amountpaid != 750;
select passengername from passenger where age<30;
select passengerid,passengername from passenger where age>=60 and city='Hyderabad';

-- logical operators
select * from booking where not ticketstatus =  'cancelled';
select * from booking where  ticketstatus =  'CONFIRMED' and seatclass='AC';
select passengerid from booking where ticketstatus='cancelled' and seatclass='AC';
select trainid,trainname from train where fare>600 and destination='hyderabad';
select * from  booking where  amountpaid>500 and not ticketstatus='cancelled';
select bo.bookingid from booking bo join passenger p on p.passengerid=bo.passengerid where p.age>=60 and bo.remarks='Senior Citizen';

select passengername from passenger where passengername like 'R%';
select * from passenger;
select * from passenger where city in ('Hyderabad','Guntur','Vijayawada');
select * from passenger where Phone is null;
select * from passenger where passengerID is not null;
select * from train where fare>=500 and fare<=700;
select * from train where fare between 500 and 700 ;

select * from passenger where passengername like '%ra%';
select * from passenger where passengername like '___i';
select * from booking;
select * from train;
select * from passenger p join booking bo on  p.passengerid=bo.passengerid where p.passengerid in (101,103,105) and bo.ticketstatus='Confirmed';
select * from booking where passengerid in(101,103,105) and ticketstatus='Confirmed';
select * from train where Source='Hyderabad' order by fare asc;
select * from  train where trainname like '%Express' and fare<800 order by fare asc;
select * from passenger where city in ('Hyderabad','Guntur','Vijayawada') and phone is not null and age>25;











 












