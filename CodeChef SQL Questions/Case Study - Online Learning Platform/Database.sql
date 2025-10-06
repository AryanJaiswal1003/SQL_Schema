-- -------------------------------------------------------------------
-- Database Setup
-- -------------------------------------------------------------------

-- Drop the database if it already exists to ensure a clean start
DROP DATABASE IF EXISTS online_learning_platform;

-- Create the new database
CREATE DATABASE online_learning_platform;

-- Select the database for subsequent operations
USE online_learning_platform;

-- -------------------------------------------------------------------
-- 1. Create 'instructors' table
-- This must be created first because 'courses' depends on it.
-- -------------------------------------------------------------------
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- -------------------------------------------------------------------
-- 2. Create 'courses' table
-- Includes a Foreign Key to 'instructors'
-- -------------------------------------------------------------------
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    instructor_id INT NOT NULL,
    price INT NOT NULL, -- Assuming whole dollar/unit prices
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

-- -------------------------------------------------------------------
-- 3. Create 'subscribers' table
-- Includes a Foreign Key to 'courses'
-- -------------------------------------------------------------------
CREATE TABLE subscribers (
    subscriber_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


-- -------------------------------------------------------------------
-- Data Insertion
-- -------------------------------------------------------------------

-- -------------------------------------------------------------------
-- Insert data into 'instructors'
-- -------------------------------------------------------------------
INSERT INTO instructors (instructor_id, first_name, last_name) VALUES
(1, 'John', 'Smith'),
(2, 'Sarah', 'Johnson'),
(3, 'Michael', 'Williams'),
(4, 'Emily', 'Jones'),
(5, 'Christopher', 'Davis'),
(6, 'Jessica', 'Anderson'),
(7, 'Andrew', 'Martinez'),
(8, 'Olivia', 'Wilson'),
(9, 'Daniel', 'Taylor'),
(10, 'Sophia', 'Brown'),
(11, 'Matthew', 'Thomas'),
(12, 'Elizabeth', 'Miller'),
(13, 'David', 'Clark'),
(14, 'Emma', 'Jackson'),
(15, 'Alexander', 'Anderson'),
(16, 'Benjamin', 'Taylor'),
(17, 'Ava', 'Davis'),
(18, 'Joseph', 'Johnson'),
(19, 'Mia', 'Williams'),
(20, 'William', 'Smith');

-- -------------------------------------------------------------------
-- Insert data into 'courses'
-- -------------------------------------------------------------------
INSERT INTO courses (course_id, course_name, instructor_id, price) VALUES
(1, 'Introduction to Programming', 1, 100),
(2, 'Data Structures and Algorithms', 2, 150),
(3, 'Web Development Basics', 1, 120),
(4, 'Database Design and Management', 3, 180),
(5, 'Machine Learning Fundamentals', 4, 200),
(6, 'Computer Networks', 2, 130),
(7, 'Software Engineering Principles', 3, 170),
(8, 'Artificial Intelligence Applications', 4, 220),
(9, 'Mobile App Development', 1, 140),
(10, 'Operating Systems', 2, 160),
(11, 'Introduction to Cryptography', 3, 190),
(12, 'Data Visualization', 4, 150),
(13, 'Cloud Computing Fundamentals', 1, 110),
(14, 'Network Security', 2, 170),
(15, 'Software Testing and QA', 3, 180),
(16, 'Natural Language Processing', 4, 210),
(17, 'Computer Graphics', 1, 140),
(18, 'Data Mining', 2, 160),
(19, 'Parallel Computing', 3, 190),
(20, 'Information Retrieval', 4, 150);

-- -------------------------------------------------------------------
-- Insert data into 'subscribers'
-- -------------------------------------------------------------------
INSERT INTO subscribers (subscriber_id, first_name, last_name, course_id) VALUES
(1, 'David', 'Brown', 2),
(2, 'David', 'Brown', 5),
(3, 'Jennifer', 'Taylor', 1),
(4, 'Jennifer', 'Taylor', 6),
(5, 'Andrew', 'Miller', 5),
(6, 'Andrew', 'Miller', 9),
(7, 'Jessica', 'Anderson', 3),
(8, 'Jessica', 'Anderson', 10),
(9, 'Christopher', 'Thomas', 4),
(10, 'Christopher', 'Thomas', 8),
(11, 'Christopher', 'Thomas', 12),
(12, 'Ashley', 'Martinez', 7),
(13, 'Ashley', 'Martinez', 13),
(14, 'Matthew', 'Wilson', 6),
(15, 'Matthew', 'Wilson', 11),
(16, 'Matthew', 'Wilson', 14),
(17, 'Elizabeth', 'Anderson', 10),
(18, 'Elizabeth', 'Anderson', 15),
(19, 'Daniel', 'Davis', 8),
(20, 'Daniel', 'Davis', 16),
(21, 'Olivia', 'Jackson', 12),
(22, 'Olivia', 'Jackson', 17),
(23, 'Emily', 'Smith', 2),
(24, 'Emily', 'Smith', 4),
(25, 'William', 'Johnson', 6),
(26, 'William', 'Johnson', 9),
(27, 'Ella', 'Williams', 10),
(28, 'Ella', 'Williams', 12),
(29, 'Daniel', 'Jones', 14),
(30, 'Daniel', 'Jones', 16),
(31, 'Sophia', 'Brown', 18),
(32, 'Sophia', 'Brown', 20),
(33, 'James', 'Davis', 3),
(34, 'James', 'Davis', 5),
(35, 'Oliver', 'Miller', 7),
(36, 'Oliver', 'Miller', 11),
(37, 'Ava', 'Taylor', 15),
(38, 'Ava', 'Taylor', 19),
(39, 'Mia', 'Anderson', 15),
(40, 'Mia', 'Anderson', 17),
(41, 'Liam', 'Clark', 19),
(42, 'Liam', 'Clark', 20),
(43, 'Emily', 'Johnson', 1),
(44, 'Emily', 'Johnson', 3),
(45, 'Aiden', 'Williams', 5),
(46, 'Aiden', 'Williams', 7);
