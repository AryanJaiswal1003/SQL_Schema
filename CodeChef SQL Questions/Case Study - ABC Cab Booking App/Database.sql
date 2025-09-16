-- Create Database
CREATE DATABASE cab_booking_db;
USE cab_booking_db;

CREATE TABLE cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50)
);

CREATE TABLE complaint_category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE user_information (
    id INT PRIMARY KEY,
    user_id INT UNIQUE,
    full_name VARCHAR(50),
    email VARCHAR(50) UNIQUE
);

CREATE TABLE customer_segments (
    segment_id INT PRIMARY KEY,
    segment_name VARCHAR(30)
);

CREATE TABLE drivers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    city_id INT,
    rating_count INT,
    experience_yrs INT,
    current_status VARCHAR(20),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE partner_companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(50),
    industry VARCHAR(40)
);

CREATE TABLE user_complaints (
    complaint_id INT PRIMARY KEY,
    user_id INT,
    category_id INT,
    subcategory_id VARCHAR(5),
    created DATE,
    FOREIGN KEY (user_id) REFERENCES user_information(user_id),
    FOREIGN KEY (category_id) REFERENCES complaint_category(category_id)
);

CREATE TABLE category_description (
    id INT PRIMARY KEY,
    category_id INT,
    subcategory_id VARCHAR(5),
    reason VARCHAR(50),
    FOREIGN KEY (category_id) REFERENCES complaint_category(category_id)
);

CREATE TABLE complaint_status (
    id INT PRIMARY KEY,
    complaint_id INT,
    status VARCHAR(30),
    updated DATE,
    FOREIGN KEY (complaint_id) REFERENCES user_complaints(complaint_id)
);

CREATE TABLE user_rides (
    id INT PRIMARY KEY,
    user_id INT,
    start_time VARCHAR(10),
    end_time VARCHAR(10),
    distance INT,
    fare INT,
    ride_status VARCHAR(20),
    date DATE,
    rating INT,
    FOREIGN KEY (user_id) REFERENCES user_information(user_id)
);

CREATE TABLE driver_feedback (
    fd_id INT PRIMARY KEY,
    driver_id INT,
    user_id INT,
    rating INT,
    comment VARCHAR(255),
    date DATE,
    FOREIGN KEY (driver_id) REFERENCES drivers(id),
    FOREIGN KEY (user_id) REFERENCES user_information(user_id)
);

-- Populate cities
INSERT INTO cities VALUES
(1,'New York'),
(2,'London'),
(3,'Tokyo'),
(4,'Mumbai'),
(5,'Sydney');

-- Populate complaint_category
INSERT INTO complaint_category VALUES
(1,'driver behavior'),
(2,'overcharging'),
(3,'poor navigation'),
(4,'cleanliness'),
(5,'payment issues');

-- Populate user_information
INSERT INTO user_information VALUES
(1,10111,'Tinker Bell','tb@xyz.com'),
(2,10112,'Jasmine T','jt@abc.com'),
(3,10113,'Rosetta PW','rpw@abc.com'),
(4,10114,'Zarina Leo','zl@xyz.com'),
(5,10115,'Peter Cyrus','pc11@abc.com'),
(6,10116,'Pan Peter','pp@xyz.com'),
(7,10117,'Daisy T','dt_dt@xyz.com'),
(8,10118,'Captain Hook','capt@xyz.com'),
(9,10119,'Marina','marina@abc.com');

-- Populate customer_segments
INSERT INTO customer_segments VALUES
(1,'Business'),
(2,'Tourist'),
(3,'Students'),
(4,'Families'),
(5,'Solo Travelers');

-- Populate drivers
INSERT INTO drivers VALUES
(151,'Paul',1,1000,10,'active'),
(172,'Sam',2,1500,8,'on leave'),
(158,'Ava',3,2200,3,'active'),
(194,'Cleo',3,200,4,'inactive'),
(156,'Skipper',2,150,1,'active');

-- Populate partner_companies
INSERT INTO partner_companies VALUES
(1,'Hotel Chain A','Hospitality'),
(2,'Car Rental B','Transportation'),
(3,'Food Delivery C','Food & Beverage'),
(4,'Tour Package D','Travel'),
(5,'Retail Brand E','Retail');

-- Populate user_complaints
INSERT INTO user_complaints VALUES
(1,10114,5,'5c','2023-05-20'),
(2,10115,3,'3b','2023-05-09'),
(3,10117,1,'1b','2023-05-17'),
(4,10115,3,'3a','2023-03-05'),
(5,10111,4,'4b','2023-01-26'),
(7,10116,4,'4a','2023-04-08'),
(8,10117,2,'2a','2023-01-03'),
(9,10112,4,'4b','2023-03-31'),
(10,10115,5,'5a','2023-05-11');

-- Populate category_description
INSERT INTO category_description VALUES
(1,1,'1a','unprofessional'),
(2,1,'1b','drunk'),
(3,1,'1c','reckless driving'),
(4,1,'1d','rude'),
(5,2,'2a','taking longer routes'),
(6,2,'2b','tampering with fares'),
(7,2,'2c','demanding toll charges'),
(8,3,'3a','taking incorrect routes'),
(9,3,'3b','relying too much on GPS'),
(10,3,'3c','drivers getting lost'),
(11,4,'4a','unclean vehicles'),
(12,4,'4b','unpleasant odors'),
(13,5,'5a','disputed charges'),
(14,5,'5b','payment failures'),
(15,5,'5c','issues with refunds');

-- Populate complaint_status (removed invalid complaint_ids 6,15,17)
INSERT INTO complaint_status VALUES
(1,5,'in review','2023-01-26'),
(2,5,'resolved','2023-01-27'),
(3,10,'in review','2023-05-12'),
(4,7,'in review','2023-04-08'),
(5,7,'in progress','2023-05-18'),
(6,9,'in review','2023-03-31'),
(7,9,'failed to resolve','2023-04-02'),
(8,3,'in review','2023-05-17'),
(9,3,'resolved','2023-05-17'),
(10,8,'escalated','2023-05-19'),
(11,2,'in review','2023-05-09'),
(12,2,'in progress','2023-05-09'),
(13,1,'in review','2023-05-20'),
(14,1,'escalated','2023-05-20'),
(17,4,'contacted user','2023-03-06'),
(18,4,'legal action taken','2023-03-10');

-- Populate user_rides
INSERT INTO user_rides VALUES
(1,10112,'08:00','08:30',3,150,'ongoing','2023-05-30',NULL),
(2,10114,'10:30','10:45',1,50,'completed','2023-05-11',95),
(3,10115,'22:30','23:10',5,250,'ongoing','2023-05-30',NULL),
(4,10118,'19:15','19:50',6,300,'completed','2023-05-10',100),
(5,10114,'08:00','09:00',10,500,'completed','2023-05-20',0);

-- Populate driver_feedback
INSERT INTO driver_feedback VALUES
(1,151,10112,30,'asking personal questions','2023-05-30'),
(2,172,10114,95,'fun ride','2023-05-11'),
(3,158,10115,10,'took different route','2023-05-30'),
(4,194,10118,100,'awesome driving','2023-05-10'),
(5,172,10114,0,'trying to get too friendly','2023-05-20');
