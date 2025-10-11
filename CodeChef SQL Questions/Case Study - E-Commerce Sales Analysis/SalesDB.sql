-- -------------------------------------------------------------------
-- 1. Database Setup
-- -------------------------------------------------------------------
-- Drop the database if it exists to ensure a clean start
DROP DATABASE IF EXISTS ecommerce_db;

-- Create the new database
CREATE DATABASE ecommerce_db;

-- Select the database for subsequent operations
USE ecommerce_db;

-- -------------------------------------------------------------------
-- 2. Table Creation
-- -------------------------------------------------------------------

-- Table: Customers (Parent Table for Orders)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(200),
    phone_number VARCHAR(20)
);

-- Table: Products (Parent Table for Order_Items)
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    quantity INT COMMENT 'Available quantity of the product',
    description VARCHAR(500),
    created_at DATETIME
);

-- Table: Orders (Relies on Customers)
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    -- Foreign Key Constraint
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table: Order_Items (Junction Table, relies on Orders and Products)
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL COMMENT 'Quantity of the product in this specific order item',
    item_price DECIMAL(10, 2) NOT NULL COMMENT 'Price of the product at the time of purchase',
    -- Foreign Key Constraints
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- -------------------------------------------------------------------
-- 3. Data Insertion
-- -------------------------------------------------------------------

-- Insert data into Customers Table (9 records)
INSERT INTO Customers (customer_id, name, email, address, phone_number) VALUES
(1, 'John Doe', 'johndoe@gmail.com', '123 Main St, City', '+1 123-456-7890'),
(2, 'Jane Smith', 'janesmith@gmail.com', '456 Elm St, Village', '+1 987-654-3210'),
(3, 'David Johnson', 'davidjohnson@gmail.com', '789 Oak St, Village', '+1 555-123-4567'),
(4, 'Sarah Davis', 'sarahdavis@gmail.com', '321 Maple St, City', '+1 777-888-9999'),
(5, 'Michael Brown', 'michaelbrown@gmail.com', '654 Pine St, Town', '+1 111-222-3333'),
(6, 'Emily Wilson', 'emilywilson@gmail.com', '987 Cedar St, Village', '+1 444-555-6666'),
(7, 'Daniel Lee', 'danielle@gmail.com', '852 Birch St, City', '+1 777-999-8888'),
(8, 'Olivia Moore', 'oliamoore@gmail.com', '159 Spruce St, Town', '+1 333-444-5555'),
(9, 'David Wee', 'davidwee1@gmail.com', '243, MapleSt, City', '+1 435- 768-8924');


-- Insert data into Products Table (21 records)
INSERT INTO Products (product_id, name, category, price, quantity, description, created_at) VALUES
(1, 'Laptop', 'Electronics', 999.99, 30, 'High-performance laptop with SSD', '2022-05-01 09:15:00'),
(2, 'Smartphone', 'Electronics', 699.99, 50, 'Latest smartphone with dual cameras', '2022-05-02 14:30:00'),
(3, 'T-Shirt', 'Clothing', 19.99, 50, 'Comfortable cotton t-shirt', '2022-05-03 13:45:00'),
(4, 'Headphones', 'Electronics', 89.99, 30, 'Noise-canceling headphones', '2022-05-04 11:20:00'),
(5, 'Watch', 'Accessories', 149.99, 25, 'Stylish watch with leather strap', '2022-05-05 16:55:00'),
(6, 'Jeans', 'Clothing', 59.99, 50, 'Slim-fit jeans made of high-quality denim', '2022-05-06 09:40:00'),
(7, 'Camera', 'Electronics', 399.99, 20, 'DSLR camera with multiple lenses', '2022-05-07 13:25:00'),
(8, 'Sneakers', 'Footwear', 79.99, 40, 'Athletic sneakers with cushioned sole', '2022-05-08 12:15:00'),
(9, 'Backpack', 'Accessories', 49.99, 25, 'Durable backpack with multiple pockets', '2022-05-09 08:55:00'),
(10, 'Dress', 'Clothing', 79.99, 50, 'Elegant dress for special occasions', '2022-05-10 17:30:00'),
(11, 'Tablet', 'Electronics', 299.99, 40, 'Portable tablet with high-resolution display', '2022-05-11 11:10:00'),
(12, 'Sunglasses', 'Accessories', 39.99, 40, 'UV-protected sunglasses', '2022-05-12 14:20:00'),
(13, 'Sweatshirt', 'Clothing', 29.99, 30, 'Cozy sweatshirt with hood', '2022-05-13 09:40:00'),
(14, 'Printer', 'Electronics', 199.99, 25, 'All-in-one printer with wireless connectivity', '2022-05-14 10:05:00'),
(15, 'Running Shoes', 'Footwear', 89.99, 20, 'Lightweight running shoes', '2022-05-15 15:45:00'),
(16, 'Handbag', 'Accessories', 69.99, 25, 'Stylish handbag with adjustable strap', '2022-05-16 11:30:00'),
(17, 'Hoodie', 'Clothing', 49.99, 50, 'Comfortable hoodie with front pocket', '2022-05-17 13:55:00'),
(18, 'Bluetooth Speaker', 'Electronics', 49.99, 25, 'Portable speaker with built-in microphone', '2022-05-18 09:25:00'),
(19, 'Wallet', 'Accessories', 29.99, 30, 'Slim leather wallet with card slots', '2022-05-19 16:10:00'),
(20, 'Shorts', 'Clothing', 24.99, 35, 'Casual shorts for warm weather', '2022-05-20 10:50:00'),
(21, 'Smart TV', 'Electronics', 799.99, 20, '55-inch smart TV with 4K resolution', '2022-05-21 12:15:00');


-- Insert data into Orders Table (15 records)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-05-01', 2089.88),
(2, 2, '2023-05-02', 759.96),
(3, 3, '2023-05-03', 429.95),
(4, 4, '2023-05-04', 159.96),
(5, 5, '2023-05-05', 1749.95),
(6, 6, '2023-05-06', 599.96),
(7, 7, '2023-05-06', 2099.97),
(8, 8, '2023-05-08', 1599.87),
(9, 4, '2023-05-09', 799.98),
(10, 6, '2023-05-10', 1549.71),
(11, 2, '2023-05-10', 5669.73),
(12, 8, '2023-05-11', 4059.69),
(13, 3, '2023-05-12', 919.84),
(14, 5, '2023-05-12', 6999.90),
(15, 1, '2023-05-12', 749.87);

-- Insert data into Order_Items Table (30 records)
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, item_price) VALUES
(1, 1, 2, 1, 1999.89), -- Note: The item_price here differs significantly from the product price (699.99). Using the provided item_price.
(2, 1, 4, 1, 89.99),
(3, 2, 1, 1, 699.99),
(4, 2, 3, 3, 59.97),
(5, 3, 6, 2, 119.98),
(6, 3, 5, 1, 149.99),
(7, 3, 8, 2, 159.98),
(8, 4, 12, 4, 159.96),
(9, 5, 17, 3, 149.97),
(10, 5, 21, 2, 1599.98),
(11, 6, 5, 4, 599.96),
(12, 7, 2, 3, 2099.97),
(13, 7, 8, 5, 399.95),
(14, 8, 5, 8, 1199.92),
(15, 8, 2, 2, 799.98),
(16, 9, 7, 2, 799.98),
(17, 10, 18, 7, 349.93),
(18, 10, 15, 10, 899.90),
(19, 10, 20, 12, 299.88),
(20, 11, 13, 9, 269.91),
(21, 11, 11, 18, 5399.82),
(22, 12, 10, 15, 1199.85),
(23, 12, 19, 6, 179.94),
(24, 12, 21, 3, 2399.97),
(25, 12, 12, 7, 279.93),
(26, 13, 4, 3, 269.97),
(27, 13, 9, 13, 649.87),
(28, 14, 2, 10, 6999.90),
(29, 15, 17, 8, 399.92),
(30, 15, 16, 5, 349.95);