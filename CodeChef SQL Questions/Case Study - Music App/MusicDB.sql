-- -------------------------------------------------------------------
-- 1. Database Setup
-- -------------------------------------------------------------------
DROP DATABASE IF EXISTS music_streaming_db;
CREATE DATABASE music_streaming_db;
USE music_streaming_db;

-- -------------------------------------------------------------------
-- 2. Core Tables (Independent or minimally dependent)
-- -------------------------------------------------------------------

-- Table: User (U)
CREATE TABLE User (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    pincode INT
);

-- Table: Singer (SG) - Note: Added user_id as nullable as per data, but it's likely a typo in the original data if intended for FK
CREATE TABLE Singer (
    singer_id INT PRIMARY KEY,
    singer_name VARCHAR(100) NOT NULL,
    user_id INT COMMENT 'If the singer is also a platform user, NULL otherwise (as per data)'
    -- We won't add an FK here because the provided user_id column in Singer is mostly NULL and would prevent data insertion.
);

-- Table: Playlist (P)
CREATE TABLE Playlist (
    playlist_id INT PRIMARY KEY,
    playlist_name VARCHAR(100) NOT NULL
);

-- Table: Song (SO) - Depends on Singer
CREATE TABLE Song (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    singer_id INT NOT NULL,
    release_date INT COMMENT 'Year of release',
    
    FOREIGN KEY (singer_id) REFERENCES Singer(singer_id)
);

-- -------------------------------------------------------------------
-- 3. Junction Tables (for Many-to-Many relationships)
-- -------------------------------------------------------------------

-- Table: Follower (F) - Tracks which user follows which singer
CREATE TABLE Follower (
    user_id INT NOT NULL,
    singer_id INT NOT NULL,
    PRIMARY KEY (user_id, singer_id),
    
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (singer_id) REFERENCES Singer(singer_id)
);

-- Table: Liked_by (LB) - Tracks which user likes which song
CREATE TABLE Liked_by (
    song_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (song_id, user_id),
    
    FOREIGN KEY (song_id) REFERENCES Song(song_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Table: Belongs_to (BT) - Tracks which song belongs to which playlist
CREATE TABLE Belongs_to (
    song_id INT NOT NULL,
    playlist_id INT NOT NULL,
    PRIMARY KEY (song_id, playlist_id),
    
    FOREIGN KEY (song_id) REFERENCES Song(song_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id)
);

-- -------------------------------------------------------------------
-- 4. Data Insertion
-- -------------------------------------------------------------------

-- Insert data into User (20 records)
INSERT INTO User (user_id, user_name, age, gender, pincode) VALUES
(1, 'Ajay Maheshwari', 20, 'Male', 323001),
(2, 'Kayleigh Hardin', 37, 'Female', 978957),
(3, 'Mahek Jain', 19, 'Female', 225001),
(4, 'Libby Benton', 24, 'Male', 359995),
(5, 'Camren Escobar', 31, 'Female', 449539),
(6, 'Emelia Fritz', 20, 'Male', 857767),
(7, 'Brogan Beasley', 18, 'Male', 434695),
(8, 'Mikayla Dodson', 25, 'Female', 576394),
(9, 'Taniya Rojas', 26, 'Male', 343793),
(10, 'Taniya Rojas', 18, 'Male', 358779), -- Duplicate Name/Different ID
(11, 'Erika Harris', 30, 'Male', 583436),
(12, 'Jermaine Jarvis', 29, 'Female', 393838),
(13, 'Salvatore Sweeney', 25, 'Female', 443356),
(14, 'Mara Costa', 27, 'Female', 989343),
(15, 'Dominique Cohen', 17, 'Female', 989633),
(16, 'Madilynn Mccoy', 22, 'Male', 676667),
(17, 'Skylar Pham', 28, 'Male', 758998),
(18, 'Tamara Li', 31, 'Female', 683769),
(19, 'Alex Pineda', 31, 'Female', 768955),
(20, 'Vivian Phelps', 34, 'Male', 769565);

-- Insert data into Singer (20 records)
INSERT INTO Singer (singer_id, singer_name, user_id) VALUES
(1, 'Phoebe Bradford', NULL),
(2, 'Jean Paul', NULL),
(3, 'Ajay Maheshwari', 1), -- Mapped to user_id 1
(4, 'Yadiel Knox', NULL),
(5, 'Gary Huerta', NULL),
(6, 'Grace Norman', NULL),
(7, 'Aaron Freeman', NULL),
(8, 'Jazmine Moyer', NULL),
(9, 'Harley Hayes', NULL),
(10, 'Liana Mcknight', NULL),
(11, 'Maximo Preston', NULL),
(12, 'Taniya Rojas', 10), -- Mapped to user_id 10
(13, 'Siena Gamble', NULL),
(14, 'Cassandra Morales', NULL),
(15, 'Aubrey Trujillo', NULL),
(16, 'Emery Ibarra', NULL),
(17, 'Britney Carlson', NULL),
(18, 'Raegan Kerr', NULL),
(19, 'Juliet Cabrera', NULL),
(20, 'Clara Braun', NULL);

-- Insert data into Playlist (20 records)
INSERT INTO Playlist (playlist_id, playlist_name) VALUES
(1, 'Romantic Songs'),
(2, 'Awkward Conversations'),
(3, 'Fly Away'),
(4, 'Sounds Of Silence'),
(5, 'Stuck On The Puzzle'),
(6, 'Action Manga'),
(7, 'Night Drive'),
(8, 'Action Action Action'),
(9, 'Warm Up 2022'),
(10, 'African Praise'),
(11, 'Breathe In Breathe Out'),
(12, 'Brave Mans Death'),
(13, 'Diamonds Dancing'),
(14, 'Argyle Stranger Things'),
(15, 'Lose My Mind'),
(16, 'Basketball Warmup'),
(17, 'Sound Of Silence'),
(18, 'Only For The Brave'),
(19, 'Breathe Breathe Breathe'),
(20, 'Awesome Mixtape');

-- Insert data into Song (20 records)
INSERT INTO Song (song_id, song_name, singer_id, release_date) VALUES
(1, 'On My Way', 3, 2019),
(2, 'Forget About Your Peace', 6, 2019),
(3, 'Pure Lines', 8, 2008),
(4, 'Afraid Of Soul', 10, 2000),
(5, 'Social Wave', 14, 2004),
(6, 'Metal Commission', 19, 2019),
(7, 'Feel Good Garden', 11, 2011),
(8, 'Bun Up The Winter', 13, 2013),
(9, 'Infinite', 5, 2015),
(10, 'Exultant Slow Down', 19, 2019),
(11, 'Powerful Hero', 4, 2004),
(12, 'New School Of Commission', 10, 2000),
(13, 'Breath Of Broken Dreams', 1, 2011),
(14, 'Different Light', 6, 2006),
(15, 'Quiet Cocktail', 13, 2013),
(16, 'Interstellar Fusion', 3, 2013),
(17, 'Exultant Slow Down', 8, 2008),
(18, 'Torpor Of Mozart', 4, 2004),
(19, 'Regretful Nature', 8, 2008),
(20, 'Discover Cold Hand', 10, 2000);

-- Insert data into Follower (Unique records only)
-- Removed duplicates: (10, 12), (3, 5), (6, 12), (3, 6), (10, 10), (1, 6)
INSERT INTO Follower (user_id, singer_id) VALUES
(10, 12), -- First occurrence kept
(6, 11),
(3, 5), -- First occurrence kept
(7, 11),
(6, 12), -- First occurrence kept
(3, 8),
(10, 6),
(12, 10),
(3, 6), -- First occurrence kept
(12, 11),
(9, 8),
(10, 9),
(5, 10),
(12, 4),
(10, 10), -- First occurrence kept
(14, 19),
(13, 13),
(1, 19),
(1, 6), -- First occurrence kept
(1, 3),
(8, 4),
(15, 10),
(11, 13),
(8, 10),
(17, 18),
(11, 14),
(8, 19),
(16, 16);

-- Insert data into Liked_by (Unique records only)
-- Removed duplicates: (12, 10), (11, 6), (5, 3), (12, 6), (16, 10), (1, 3)
INSERT INTO Liked_by (song_id, user_id) VALUES
(12, 10), -- First occurrence kept
(11, 6), -- First occurrence kept
(5, 3), -- First occurrence kept
(11, 7),
(12, 6), -- First occurrence kept
(8, 3),
(6, 10),
(10, 12),
(6, 3),
(11, 12),
(8, 9),
(9, 10),
(10, 5),
(4, 12),
(16, 10), -- First occurrence kept
(14, 19),
(19, 13),
(1, 19),
(20, 10),
(1, 6),
(1, 3), -- First occurrence kept
(7, 4),
(13, 13),
(7, 10),
(18, 18),
(13, 14),
(7, 19),
(17, 16);

-- Insert data into Belongs_to (Unique records only)
-- Removed duplicates: (8, 5), (13, 9), (11, 4), (10, 4), (15, 4), (18, 13), (5, 10), (14, 10), (14, 18)
INSERT INTO Belongs_to (song_id, playlist_id) VALUES
(8, 5), -- First occurrence kept
(11, 3),
(10, 9),
(9, 5),
(1, 6),
(13, 3),
(13, 9), -- First occurrence kept
(11, 8),
(4, 5),
(10, 3),
(11, 4), -- First occurrence kept
(10, 4), -- First occurrence kept
(12, 11),
(8, 12),
(3, 8),
(6, 4),
(10, 7),
(15, 2),
(15, 3),
(16, 2),
(17, 5),
(15, 4), -- First occurrence kept
(16, 3),
(5, 10), -- First occurrence kept
(19, 19),
(18, 13), -- First occurrence kept
(2, 19),
(19, 10),
(2, 6),
(2, 3),
(14, 4),
(18, 14),
(14, 19),
(7, 16);