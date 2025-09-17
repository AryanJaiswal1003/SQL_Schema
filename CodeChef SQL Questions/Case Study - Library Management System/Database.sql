-- Create the Library database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    publication_year YEAR,
    genre VARCHAR(100)
);

-- Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);

-- Members table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100),
    address VARCHAR(255),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Loans table
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Reservations table
CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    reservation_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Books (book_id, title, author, publication_year, genre) VALUES
(1, 'Introduction to Algorithms', 'Thomas H. Cormen', 2009, 'Computer Science'),
(2, 'Electric Machinery Fundamentals', 'Stephen J. Chapman', 2018, 'Electrical'),
(3, 'The Art of Electronics', 'Paul Horowitz', 2015, 'Electronics'),
(4, 'Engineering Mechanics: Statics', 'R.C. Hibbeler', 2020, 'Mechanical'),
(5, 'Reinforced Concrete Design', 'George F. Limbrunner', 2017, 'Civil'),
(6, 'Database Systems: The Complete Book', 'Hector Garcia-Molina', 2021, 'Computer Science'),
(7, 'Microelectronic Circuits', 'Adel S. Sedra', 2016, 'Electronics'),
(8, 'Signals and Systems', 'Alan V. Oppenheim', 1997, 'Electrical'),
(9, 'Heat Transfer: Principles and Applications', 'Yunus A. Cengel', 2014, 'Mechanical'),
(10, 'Structural Analysis', 'Russell C. Hibbeler', 2019, 'Civil'),
(11, 'Computer Networking: A Top-Down Approach', 'James F. Kurose', 2020, 'Computer Science'),
(12, 'Power System Analysis and Design', 'J. Duncan Glover', 2017, 'Electrical'),
(13, 'Digital Design and Computer Architecture', 'David Money Harris', 2012, 'Computer Science'),
(14, 'Mechanics of Materials', 'Ferdinand P. Beer', 2015, 'Mechanical'),
(15, 'Geotechnical Engineering: Principles and Practices', 'Donald P. Coduto', 2018, 'Civil'),
(16, 'Artificial Intelligence: A Modern Approach', 'Stuart Russell', 2021, 'Computer Science'),
(17, 'Electronic Devices and Circuit Theory', 'Robert L. Boylestad', 2019, 'Electronics'),
(18, 'Control Systems Engineering', 'Norman S. Nise', 2016, 'Electrical'),
(19, 'Fluid Mechanics', 'Frank M. White', 2014, 'Mechanical'),
(20, 'Transportation Engineering', 'C. Jotin Khisty', 2017, 'Civil'),
(21, 'Operating System Concepts', 'Abraham Silberschatz', 2018, 'Computer Science'),
(22, 'Digital Signal Processing', 'John G. Proakis', 2013, 'Electrical'),
(23, 'Fundamentals of Electric Circuits', 'Charles K. Alexander', 2020, 'Electronics'),
(24, 'Materials Science and Engineering', 'William D. Callister', 2016, 'Mechanical'),
(25, 'Highway Engineering', 'Daniel J. Findley', 2019, 'Civil'),
(26, 'Data Structures and Algorithms in Python', 'Michael T. Goodrich', 2014, 'Computer Science'),
(27, 'Introduction to Embedded Systems', 'Edward Ashford Lee', 2011, 'Electrical'),
(28, 'Power Electronics: Circuits, Devices, and Applications', 'Muhammad H. Rashid', 2017, 'Electrical'),
(29, 'Engineering Vibrations', 'Daniel J. Inman', 2020, 'Mechanical'),
(30, 'Environmental Engineering', 'Howard S. Peavy', 2015, 'Civil');

INSERT INTO Authors (author_id, author_name) VALUES
(1, 'Thomas H. Cormen'),
(2, 'Stephen J. Chapman'),
(3, 'Paul Horowitz'),
(4, 'R.C. Hibbeler'),
(5, 'George F. Limbrunner'),
(6, 'Hector Garcia-Molina'),
(7, 'Adel S. Sedra'),
(8, 'Alan V. Oppenheim'),
(9, 'Yunus A. Cengel'),
(10, 'Russell C. Hibbeler'),
(11, 'James F. Kurose'),
(12, 'J. Duncan Glover'),
(13, 'David Money Harris'),
(14, 'Ferdinand P. Beer'),
(15, 'Donald P. Coduto'),
(16, 'Stuart Russell'),
(17, 'Robert L. Boylestad'),
(18, 'Norman S. Nise'),
(19, 'Frank M. White'),
(20, 'C. Jotin Khisty'),
(21, 'Abraham Silberschatz'),
(22, 'John G. Proakis'),
(23, 'Charles K. Alexander'),
(24, 'William D. Callister'),
(25, 'Daniel J. Findley'),
(26, 'Michael T. Goodrich'),
(27, 'Edward Ashford Lee'),
(28, 'Muhammad H. Rashid'),
(29, 'Daniel J. Inman'),
(30, 'Howard S. Peavy');

INSERT INTO Members (member_id, member_name, address, email, phone_number) VALUES
(1, 'Neha Sharma', '123 Main Street, Mumbai', 'neha.sharma@gmail.com', '+91 9876543210'),
(2, 'Rajesh Patel', '456 Park Avenue, Delhi', 'rajesh.patel@gmail.com', '+91 9876543211'),
(3, 'Priya Verma', '789 Central Road, Kolkata', 'priya.verma@gmail.com', '+91 9876543212'),
(4, 'Sanjay Singh', '246 Street Lane, Chennai', 'sanjay.singh@gmail.com', '+91 9876543213'),
(5, 'Aishwarya Reddy', '135 Green Garden, Bengaluru', 'aishwarya.reddy@gmail.com', '+91 9876543214'),
(6, 'Arjun Gupta', '789 Pearl Street, Hyderabad', 'arjun.gupta@gmail.com', '+91 9876543215'),
(7, 'Anjali Desai', '456 Rose Avenue, Mumbai', 'anjali.desai@gmail.com', '+91 9876543216'),
(8, 'Rakesh Sharma', '123 Sunshine Road, Delhi', 'rakesh.sharma@gmail.com', '+91 9876543217'),
(9, 'Deepika Patel', '789 Silver Square, Kolkata', 'deepika.patel@gmail.com', '+91 9876543218'),
(10, 'Abhishek Verma', '456 Diamond Lane, Chennai', 'abhishek.verma@gmail.com', '+91 9876543219'),
(11, 'Sneha Singh', '246 Gold Garden, Bengaluru', 'sneha.singh@gmail.com', '+91 9876543220'),
(12, 'Rahul Kumar', '135 Platinum Road, Hyderabad', 'rahul.kumar@gmail.com', '+91 9876543221'),
(13, 'Pooja Shah', '789 Sapphire Street, Mumbai', 'pooja.shah@gmail.com', '+91 9876543222'),
(14, 'Manish Joshi', '456 Emerald Avenue, Delhi', 'manish.joshi@gmail.com', '+91 9876543223'),
(15, 'Shweta Gupta', '123 Pearl Lane, Kolkata', 'shweta.gupta@gmail.com', '+91 9876543224'),
(16, 'Vikram Deshmukh', '789 Rose Garden, Chennai', 'vikram.deshmukh@gmail.com', '+91 9876543225'),
(17, 'Ananya Reddy', '246 Green Road, Bengaluru', 'ananya.reddy@gmail.com', '+91 9876543226'),
(18, 'Prakash Verma', '135 Skyline Avenue, Hyderabad', 'prakash.verma@gmail.com', '+91 9876543227'),
(19, 'Natasha Sharma', '789 Sunrise Square, Mumbai', 'natasha.sharma@gmail.com', '+91 9876543228'),
(20, 'Rohit Patel', '456 Sunset Lane, Delhi', 'rohit.patel@gmail.com', '+91 9876543229');

INSERT INTO Loans (loan_id, member_id, book_id, loan_date, return_date) VALUES
(1, 5, 3, '2022-05-10', '2022-05-25'),
(2, 10, 7, '2022-05-12', '2022-05-28'),
(3, 2, 1, '2022-05-15', '2022-05-30'),
(4, 7, 5, '2022-05-20', '2022-06-05'),
(5, 12, 10, '2022-05-25', '2022-06-10'),
(6, 3, 2, '2022-06-01', '2022-06-16'),
(7, 16, 9, '2022-06-05', '2022-06-20'),
(8, 10, 6, '2022-06-08', '2022-06-23'),
(9, 2, 4, '2022-06-12', '2022-06-27'),
(10, 7, 8, '2022-06-15', '2022-06-30'),
(11, 14, 14, '2022-06-18', '2022-07-03'),
(12, 1, 12, '2022-06-21', '2022-07-06'),
(13, 4, 11, '2022-06-24', '2022-07-09'),
(14, 6, 3, '2022-06-27', '2022-07-12'),
(15, 8, 16, '2022-06-30', '2022-07-15'),
(16, 2, 18, '2022-07-03', '2022-07-18'),
(17, 11, 20, '2022-07-06', '2022-07-21'),
(18, 13, 13, '2022-07-09', '2022-07-24'),
(19, 7, 15, '2022-07-12', '2022-07-27'),
(20, 5, 19, '2022-07-15', '2022-07-30'),
(21, 2, 6, '2022-07-18', '2022-08-02'),
(22, 7, 2, '2022-07-21', '2022-08-05'),
(23, 12, 10, '2022-07-24', '2022-08-08'),
(24, 3, 9, '2022-07-27', '2022-08-11'),
(25, 10, 4, '2022-07-30', '2022-08-14'),
(26, 16, 7, '2022-08-02', '2022-08-17'),
(27, 10, 3, '2022-08-05', '2022-08-20'),
(28, 2, 8, '2022-08-08', '2022-08-23'),
(29, 7, 11, '2022-08-11', '2022-08-26'),
(30, 14, 1, '2022-08-14', '2022-08-29');

INSERT INTO Reservations (reservation_id, member_id, book_id, reservation_date) VALUES
(1, 5, 3, '2022-05-05'),
(2, 10, 7, '2022-05-10'),
(3, 2, 1, '2022-05-12'),
(4, 7, 5, '2022-05-18'),
(5, 12, 10, '2022-05-20'),
(6, 3, 2, '2022-05-25'),
(7, 16, 9, '2022-06-01'),
(8, 10, 6, '2022-06-06'),
(9, 2, 4, '2022-06-09'),
(10, 7, 8, '2022-06-12'),
(11, 14, 14, '2022-06-15'),
(12, 1, 12, '2022-06-18'),
(13, 4, 11, '2022-06-22'),
(14, 6, 3, '2022-06-26'),
(15, 8, 16, '2022-06-28'),
(16, 2, 18, '2022-07-01'),
(17, 11, 20, '2022-07-03'),
(18, 13, 13, '2022-07-06'),
(19, 7, 15, '2022-07-09'),
(20, 5, 19, '2022-07-11'),
(21, 2, 6, '2022-07-15'),
(22, 7, 2, '2022-07-17'),
(23, 12, 10, '2022-07-20'),
(24, 3, 9, '2022-07-22'),
(25, 10, 4, '2022-07-25'),
(26, 16, 7, '2022-07-28'),
(27, 10, 3, '2022-08-01'),
(28, 2, 8, '2022-08-03'),
(29, 7, 11, '2022-08-06'),
(30, 14, 1, '2022-08-09');
