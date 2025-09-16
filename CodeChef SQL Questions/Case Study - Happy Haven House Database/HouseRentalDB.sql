# House_Rental_DB Database
-- Create Database
CREATE DATABASE IF NOT EXISTS House_Rental_DB;
USE House_Rental_DB;

-- Table: Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- Table: Properties
CREATE TABLE Properties (
    property_id INT PRIMARY KEY,
    title VARCHAR(100),
    description TEXT,
    rating DECIMAL(2,1),
    location VARCHAR(100)
);

-- Table: Bookings
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    property_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
);

-- Table: Reviews
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    property_id INT,
    user_id INT,
    rating DECIMAL(2,1),
    comment TEXT,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Table: Amenities
CREATE TABLE Amenities (
    amenity_id INTEGER PRIMARY KEY,
    name VARCHAR(50)
);

-- Table: PropertyAmenities
CREATE TABLE PropertyAmenities (
    amenity_id INTEGER,
    property_id INTEGER,
    PRIMARY KEY (amenity_id, property_id)
);

-- Table: Favorites
CREATE TABLE Favorites (
    user_id INTEGER,
    property_id INTEGER,
    PRIMARY KEY (user_id, property_id)
);

-- Table: Payments
CREATE TABLE Payments (
    payment_id INTEGER PRIMARY KEY,
    booking_id INTEGER,
    user_id INTEGER,
    amount INTEGER,
    payment_date DATE
);

-- Insert Data into Users
INSERT INTO Users (user_id, name, email, phone, address) VALUES
(1, 'John Smith', 'john.smith@example.com', '123-456-7890', '123 Main St'),
(2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210', '456 Elm St'),
(3, 'David Johnson', 'david.johnson@example.com', '555-555-5555', '789 Oak Ave'),
(4, 'Sarah Wilson', 'sarah.wilson@example.com', '111-222-3333', '321 Pine St'),
(5, 'Michael Brown', 'michael.brown@example.com', '444-444-4444', '789 Maple Ln'),
(6, 'Emily Davis', 'emily.davis@example.com', '666-777-8888', '987 Cedar Rd'),
(7, 'Jessica Lee', 'jessica.lee@example.com', '999-888-7777', '654 Walnut St'),
(8, 'Andrew Miller', 'andrew.miller@example.com', '222-333-4444', '321 Oakwood Dr'),
(9, 'Olivia Moore', 'olivia.moore@example.com', '777-777-7777', '456 Elmwood Ave'),
(10, 'Ethan Wilson', 'ethan.wilson@example.com', '888-999-0000', '789 Pine Ave'),
(11, 'Samantha Johnson', 'sam.johnson@example.com', '555-123-4567', '123 Elm St'),
(12, 'Benjamin Davis', 'ben.davis@example.com', '111-222-3333', '456 Oak Ave'),
(13, 'Ava Wilson', 'ava.wilson@example.com', '777-888-9999', '789 Maple Dr'),
(14, 'Noah Thompson', 'noah.thompson@example.com', '444-555-6666', '987 Cedar St'),
(15, 'Sophia Anderson', 'sophia.anderson@example.com', '222-111-3333', '654 Walnut Ave'),
(16, 'Mia Roberts', 'mia.roberts@example.com', '666-777-8888', '321 Oakwood Ln'),
(17, 'Ethan Johnson', 'ethan.johnson@example.com', '888-999-0000', '456 Elmwood Dr'),
(18, 'Isabella Davis', 'isabella.davis@example.com', '777-888-9999', '789 Pine St'),
(19, 'Liam Wilson', 'liam.wilson@example.com', '111-222-3333', '123 Main Ave'),
(20, 'Ava Smith', 'ava.smith@example.com', '444-555-6666', '456 Elm Dr'),
(21, 'Benjamin Johnson', 'ben.johnson@example.com', '555-123-4567', '789 Oakwood St'),
(22, 'Emma Thompson', 'emma.thompson@example.com', '777-777-7777', '987 Cedar Ave');

-- Insert Data into Properties
INSERT INTO Properties (property_id, title, description, rating, location) VALUES
(1, 'City Center Apartment', 'Conveniently located apartment in the city center.', 4.5, 'New York, NY'),
(2, 'Coastal Cottage', 'Charming cottage by the beach with ocean views.', 4.2, 'Malibu, CA'),
(3, 'Elegant Townhouse', 'Luxurious townhouse with high-end amenities.', 4.8, 'London, UK'),
(4, 'Lakeside Cabin', 'Peaceful cabin situated by a serene lake.', 4.0, 'Vancouver, Canada'),
(5, 'Mountain Chalet', 'Cozy and rustic chalet nestled in the mountains.', 4.2, 'Aspen, CO'),
(6, 'Luxury Beach House', 'Spacious beach house with lavish interiors.', 4.8, 'Miami, FL'),
(7, 'Urban Studio', 'Stylish studio apartment in the heart of the city.', 4.0, 'Paris, France'),
(8, 'Country House', 'Picturesque country house surrounded by nature.', 4.5, 'Tuscany, Italy'),
(9, 'Studio Apartment', 'Modern studio apartment with all necessary amenities.', 3.5, 'Tokyo, Japan'),
(10, 'Cozy Cabin', 'Quaint cabin perfect for a relaxing getaway.', 4.2, 'Lake Tahoe, CA'),
(11, 'Lakeside Villa', 'Luxurious villa with stunning lake views.', 4.6, 'Geneva, Switzerland'),
(12, 'Ski Resort Chalet', 'Ski-in, ski-out chalet in a popular ski resort.', 4.3, 'Whistler, Canada'),
(13, 'Historic Mansion', 'Grand mansion with a rich history and elegant interiors.', 4.7, 'Rome, Italy'),
(14, 'Modern Loft', 'Trendy loft apartment with an open floor plan.', 4.0, 'Berlin, Germany'),
(15, 'Beachfront Bungalow', 'Cozy bungalow located right on the beach.', 4.2, 'Bali, Indonesia'),
(16, 'Countryside Farmhouse', 'Quaint farmhouse surrounded by scenic countryside.', 4.5, 'Provence, France'),
(17, 'Oceanview Penthouse', 'Luxurious penthouse with breathtaking ocean views.', 4.8, 'Sydney, Australia'),
(18, 'Mountain Retreat', 'Secluded retreat nestled in the mountains.', 4.0, 'Banff, Canada'),
(19, 'Vineyard Estate', 'Estate with vineyards and stunning landscape.', 4.5, 'Napa Valley, CA'),
(20, 'City View Condo', 'Stylish condo with panoramic city views.', 4.2, 'Dubai, UAE'),
(21, 'Lakeside Resort', 'Resort with lakeside cabins and recreational activities.', 4.6, 'Lake District, UK'),
(22, 'Beachfront Villa', 'Spacious villa with direct beach access.', 4.3, 'Phuket, Thailand'),
(23, 'Rustic Log Cabin', 'Cozy log cabin with a rustic charm.', 4.7, 'Montana, USA'),
(24, 'Skyline Apartment', 'Apartment with stunning skyline views.', 4.0, 'New York, NY');

-- Insert Data into Bookings
INSERT INTO Bookings (booking_id, user_id, property_id, start_date, end_date) VALUES
(1, 2, 10, '2023-07-15', '2023-07-20'),
(2, 5, 3, '2023-08-01', '2023-08-07'),
(3, 8, 12, '2023-09-10', '2023-09-15'),
(4, 11, 17, '2023-06-25', '2023-06-30'),
(5, 14, 6, '2023-07-10', '2023-07-17'),
(6, 17, 9, '2023-08-05', '2023-08-10'),
(7, 20, 15, '2023-09-01', '2023-09-07'),
(8, 3, 4, '2023-07-20', '2023-07-27'),
(9, 6, 18, '2023-08-10', '2023-08-20'),
(10, 9, 1, '2023-09-15', '2023-09-22'),
(11, 12, 8, '2023-07-05', '2023-07-12'),
(12, 15, 13, '2023-08-15', '2023-08-22'),
(13, 18, 20, '2023-09-20', '2023-09-30'),
(14, 11, 5, '2023-07-12', '2023-07-19'),
(15, 2, 22, '2023-08-07', '2023-08-14'),
(16, 7, 2, '2023-09-05', '2023-09-12'),
(17, 10, 7, '2023-07-27', '2023-08-03'),
(18, 13, 11, '2023-08-22', '2023-08-29'),
(19, 16, 16, '2023-09-10', '2023-09-17'),
(20, 19, 19, '2023-07-30', '2023-08-06'),
(21, 2, 3, '2023-08-08', '2023-08-15'),
(22, 5, 6, '2023-09-12', '2023-09-19'),
(23, 8, 9, '2023-07-18', '2023-07-25'),
(24, 11, 15, '2023-08-05', '2023-08-12'),
(25, 14, 20, '2023-09-01', '2023-09-08'),
(26, 17, 1, '2023-09-15', '2023-09-22'),
(27, 20, 8, '2023-07-25', '2023-08-01'),
(28, 3, 13, '2023-08-12', '2023-08-19'),
(29, 6, 18, '2023-09-05', '2023-09-12'),
(30, 9, 4, '2023-07-30', '2023-08-06');

-- Insert Data into Reviews
INSERT INTO Reviews (review_id, property_id, user_id, rating, comment) VALUES
(1, 10, 2, 4.5, 'Great location and comfortable stay.'),
(2, 3, 5, 4.2, 'Beautiful views and cozy atmosphere.'),
(3, 12, 8, 4.8, 'Amazing amenities and excellent service.'),
(4, 17, 11, 4.0, 'Average experience, could be better.'),
(5, 6, 14, 4.2, 'Loved the beachfront location.'),
(6, 9, 17, 4.8, 'Clean and well-maintained studio.'),
(7, 15, 20, 4.0, 'Good value for money.'),
(8, 4, 3, 3.5, 'Basic amenities, but convenient location.'),
(9, 18, 6, 4.5, 'Serene and peaceful retreat.'),
(10, 1, 9, 4.2, 'City center convenience.'),
(11, 8, 12, 4.6, 'Stunning countryside views.'),
(12, 13, 15, 4.3, 'Historical charm and grandeur.'),
(13, 20, 18, 4.7, 'Modern and stylish loft.'),
(14, 5, 1, 4.0, 'Good beachfront location.'),
(15, 22, 4, 4.2, 'Spacious and luxurious villa.'),
(16, 2, 7, 4.0, 'Convenient urban studio.'),
(17, 7, 10, 4.6, 'Peaceful lakeside resort.'),
(18, 11, 13, 4.3, 'Perfect ski-in, ski-out location.'),
(19, 16, 16, 4.5, 'Tranquil countryside escape.'),
(20, 19, 19, 4.2, 'Scenic vineyard views.'),
(21, 3, 2, 4.8, 'Enjoyed the coastal cottage.'),
(22, 6, 5, 4.3, 'Relaxing beach house.'),
(23, 9, 8, 4.7, 'Cozy studio with all amenities.'),
(24, 15, 11, 4.0, 'Trendy loft with open floor plan.'),
(25, 20, 14, 4.2, 'Breathtaking beachfront bungalow.'),
(26, 1, 17, 4.5, 'Quaint countryside farmhouse.'),
(27, 8, 20, 4.8, 'Luxury penthouse with ocean views.'),
(28, 13, 3, 4.0, 'Historic mansion with elegant interiors.'),
(29, 18, 6, 4.5, 'Mountain retreat with scenic beauty.'),
(30, 4, 9, 4.2, 'Vineyard estate with stunning landscape.');

INSERT INTO Amenities (amenity_id, name) VALUES
(1, 'Wifi'),
(2, 'Parking'),
(3, 'Pool'),
(4, 'Gym'),
(5, 'Air Conditioning'),
(6, 'Heating'),
(7, 'Kitchen'),
(8, 'Washer'),
(9, 'Dryer'),
(10, 'Pet-Friendly'),
(11, 'Sauna');

INSERT INTO PropertyAmenities (amenity_id, property_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 4),
(7, 4),
(8, 5),
(9, 10),
(10, 7),
(11, 9),
(1, 11),
(3, 11),
(7, 12),
(9, 15);

INSERT INTO Favorites (user_id, property_id) VALUES
(1, 5),
(2, 8),
(3, 10),
(4, 12),
(5, 16),
(6, 17),
(7, 20),
(8, 24),
(9, 22),
(10, 25),
(11, 26),
(12, 30),
(13, 35),
(14, 40),
(2, 9),
(4, 15);

INSERT INTO Payments (payment_id, booking_id, user_id, amount, payment_date) VALUES
(1, 1, 2, 2000, '2023-01-15'),
(2, 2, 5, 1500, '2023-02-20'),
(3, 3, 8, 1800, '2023-03-10'),
(4, 4, 11, 2200, '2023-04-05'),
(5, 5, 14, 2200, '2023-05-12'),
(6, 6, 17, 1700, '2023-06-08'),
(7, 7, 20, 2100, '2023-07-18'),
(8, 8, 24, 2400, '2023-08-24'),
(9, 9, 2, 2300, '2023-09-02'),
(10, 10, 11, 2300, '2023-10-09'),
(11, 11, 16, 1700, '2023-06-15'),
(12, 12, 13, 1700, '2023-07-20'),
(13, 13, 18, 1900, '2023-05-25'),
(14, 14, 11, 2200, '2023-09-05'),
(15, 15, 2, 2300, '2023-10-12');