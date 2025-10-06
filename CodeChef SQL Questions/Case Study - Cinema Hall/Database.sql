-- -------------------------------------------------------------------
-- Database Setup
-- -------------------------------------------------------------------
cost
-- Drop the database if it already exists to ensure a clean start
DROP DATABASE IF EXISTS movie_booking_system;

-- Create the new database
CREATE DATABASE movie_booking_system;

-- Select the database for subsequent operations
USE movie_booking_system;

-- -------------------------------------------------------------------
-- 1. Create 'movies' table
-- -------------------------------------------------------------------
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    genre VARCHAR(50),
    -- Stored as VARCHAR to keep the "X.X/10" format as shown in the data
    rating VARCHAR(10),
    running_time INT COMMENT 'Runtime in minutes'
);

-- -------------------------------------------------------------------
-- 2. Create 'customers' table
-- -------------------------------------------------------------------
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    email_id VARCHAR(100) UNIQUE,
    age INT
);

-- -------------------------------------------------------------------
-- 3. Create 'bookings' table
-- This table includes Foreign Keys to link back to 'customers' and 'movies'
-- -------------------------------------------------------------------
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    movie_id INT NOT NULL,
    booking_date DATE NOT NULL,
    ticket_quantity INT,
    timings TIME,
    cost INT COMMENT 'Total cost of the booking',
    -- Define Foreign Key Constraints
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);


-- -------------------------------------------------------------------
-- Data Insertion
-- -------------------------------------------------------------------

-- -------------------------------------------------------------------
-- Insert data into 'movies'
-- -------------------------------------------------------------------
INSERT INTO movies (movie_id, title, release_date, genre, rating, running_time) VALUES
(1, 'The Shawshank Redemption', '1994-10-14', 'Drama', '9.3/10', 142),
(2, 'The Godfather', '1972-03-24', 'Crime', '9.2/10', 175),
(3, 'The Dark Knight', '2008-07-18', 'Action', '8.9/10', 152),
(4, 'The Godfather Part II', '1974-12-20', 'Crime', '9.0/10', 202),
(5, 'Pulp Fiction', '1994-10-14', 'Crime', '8.9/10', 154),
(6, '12 Angry Men', '1957-04-10', 'Drama', '9.0/10', 96),
(7, 'Schindlers List', '1993-12-15', 'Drama', '9.2/10', 195),
(8, 'The Lord of the Rings: The Return of the King', '2003-12-17', 'Adventure', '8.9/10', 201),
(9, 'The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 'Adventure', '8.9/10', 178),
(10, 'The Lord of the Rings: The Two Towers', '2002-12-18', 'Adventure', '8.8/10', 179),
(11, 'Inception', '2010-07-16', 'Action', '8.8/10', 148),
(12, 'The Matrix', '1999-03-31', 'Action', '8.7/10', 136),
(13, 'The Matrix Reloaded', '2003-05-15', 'Action', '7.9/10', 138),
(14, 'The Matrix Revolutions', '2003-11-05', 'Action', '7.7/10', 129),
(15, 'Interstellar', '2014-11-05', 'Sci-Fi', '8.6/10', 169);

-- -------------------------------------------------------------------
-- Insert data into 'customers'
-- -------------------------------------------------------------------
INSERT INTO customers (customer_id, name, gender, email_id, age) VALUES
(1, 'John Doe', 'Male', 'johndoe@exp.com', 30),
(2, 'Jane Doe', 'Female', 'janedoe@exp.com', 25),
(3, 'Mary Smith', 'Female', 'marysmith@exp.com', 40),
(4, 'Michael Jones', 'Male', 'michaeljones@exp.com', 35),
(5, 'Sarah Brown', 'Female', 'sarahbrown@exp.com', 20),
(6, 'David Green', 'Male', 'davidgreen@exp.com', 25),
(7, 'Susan White', 'Female', 'susanwhite@exp.com', 30),
(8, 'Peter Black', 'Male', 'peterblack@exp.com', 35),
(9, 'Kate Blue', 'Female', 'kateblue@exp.com', 20),
(10, 'Alex Rod', 'Male', 'alexrod@exp.com', 40),
(11, 'Ben Green', 'Male', 'bengreen@exp.com', 25),
(12, 'Cindy White', 'Female', 'cindywhite@exp.com', 35),
(13, 'David Brown', 'Male', 'davidbrown@exp.com', 30),
(14, 'Peter Smith', 'Male', 'petersmith@exp.com', 40),
(15, 'Jane Black', 'Female', 'janeb@exp.com', 20);

-- -------------------------------------------------------------------
-- Insert data into 'bookings'
-- -------------------------------------------------------------------
INSERT INTO bookings (booking_id, customer_id, movie_id, booking_date, ticket_quantity, timings, cost) VALUES
(2, 15, 1, '2023-09-01', 3, '20:30:00', 30),
(3, 2, 7, '2023-09-01', 2, '20:00:00', 20),
(4, 15, 4, '2023-09-02', 2, '17:30:00', 20),
(5, 7, 3, '2023-09-03', 1, '18:15:00', 10),
(6, 4, 5, '2023-09-03', 3, '19:45:00', 30),
(7, 6, 5, '2023-09-03', 4, '21:00:00', 40),
(8, 2, 2, '2023-09-04', 1, '14:30:00', 10),
(9, 13, 9, '2023-09-04', 3, '17:45:00', 30),
(10, 3, 4, '2023-09-05', 2, '19:30:00', 20),
(11, 1, 12, '2023-09-05', 1, '13:45:00', 10),
(12, 15, 2, '2023-09-05', 2, '18:15:00', 20),
(13, 1, 15, '2023-09-05', 4, '19:30:00', 40),
(14, 2, 6, '2023-09-06', 1, '20:00:00', 10),
(15, 8, 8, '2023-09-07', 4, '19:30:00', 40),
(16, 11, 7, '2023-09-07', 3, '17:30:00', 30),
(17, 14, 13, '2023-09-08', 2, '16:45:00', 20),
(18, 12, 14, '2023-09-08', 1, '19:15:00', 10),
(19, 6, 4, '2023-09-09', 2, '21:30:00', 20),
(20, 9, 9, '2023-09-09', 1, '14:15:00', 10),
(21, 2, 2, '2023-09-10', 4, '17:30:00', 40),
(22, 3, 15, '2023-09-10', 3, '20:00:00', 30),
(23, 10, 6, '2023-09-10', 3, '20:30:00', 30),
(24, 5, 8, '2023-09-11', 2, '15:45:00', 20),
(25, 11, 10, '2023-09-11', 1, '16:00:00', 10),
(26, 10, 11, '2023-09-11', 4, '18:45:00', 40),
(27, 11, 11, '2023-09-12', 3, '21:15:00', 30),
(28, 13, 13, '2023-09-13', 2, '18:00:00', 20),
(29, 9, 8, '2023-09-14', 3, '17:30:00', 30),
(30, 8, 12, '2023-09-15', 1, '17:30:00', 10),
(31, 15, 14, '2023-09-16', 2, '19:45:00', 20),
(32, 12, 15, '2023-09-16', 4, '21:00:00', 40);
