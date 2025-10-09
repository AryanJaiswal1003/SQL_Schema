-- -------------------------------------------------------------------
-- 1. Database Setup
-- -------------------------------------------------------------------
-- Drop the database if it exists to ensure a clean start
DROP DATABASE IF EXISTS recession_analysis;

-- Create the new database
CREATE DATABASE recession_analysis;

-- Select the database for subsequent operations
USE recession_analysis;

-- -------------------------------------------------------------------
-- 2. Master Tables (Independent)
-- -------------------------------------------------------------------

-- Table 3: Company_HeadQuarter (Stores Country/Nation data)
CREATE TABLE Company_HeadQuarter (
    Nation_id INT PRIMARY KEY,
    HeadQuaters VARCHAR(50) NOT NULL,
    Inflation DECIMAL(4, 2) COMMENT 'Inflation data for the country'
);

-- Table 2: Company_Workforce (Stores Company Size definitions)
-- Renamed PK to Company_Size_id for better clarity in FK relationships
CREATE TABLE Company_Workforce (
    Company_Size_id INT PRIMARY KEY,
    Company_Size VARCHAR(50) NOT NULL,
    Workforce_Strength VARCHAR(50),
    Male_per INT,
    Female_per INT
);

-- Table 4: Company_Performance (Stores Performance Grade definitions)
CREATE TABLE Company_Performance (
    Performance_id INT PRIMARY KEY,
    Performance_Grade VARCHAR(50) NOT NULL
);


-- -------------------------------------------------------------------
-- 3. Dependent Tables (Requires Master Tables)
-- -------------------------------------------------------------------

-- Table 5: Company_Sector (Stores Sector data and performance grades)
CREATE TABLE Company_Sector (
    Sector_id INT PRIMARY KEY,
    Sector_Name VARCHAR(50) NOT NULL,
    Performance_id INT NOT NULL,
    Effect_of_Covid VARCHAR(5) NOT NULL,
    Effect_of_CrudePrice VARCHAR(5) NOT NULL,
    -- Foreign Key to Company_Performance
    FOREIGN KEY (Performance_id) REFERENCES Company_Performance(Performance_id)
);

-- -------------------------------------------------------------------
-- 4. Central Fact Table (Requires all other tables)
-- -------------------------------------------------------------------

-- Table 1: Company_Information (Stores Company financial and demographic data)
CREATE TABLE Company_Information (
    Company_id INT PRIMARY KEY,
    Company_Name VARCHAR(100) NOT NULL,
    Q1_Result INT COMMENT 'Q1 Result in Crore Rupees',
    Q2_Result INT COMMENT 'Q2 Result in Crore Rupees',
    Q3_Result INT COMMENT 'Q3 Result in Crore Rupees',
    Q4_Result INT COMMENT 'Q4 Result in Crore Rupees',
    Company_Size_id INT NOT NULL,
    Sector_id INT NOT NULL,
    Estimated_Growth DECIMAL(5, 2),
    Last_Year_Growth DECIMAL(5, 2),
    Growth_Percent DECIMAL(5, 2),
    Company_HQ_id INT NOT NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (Company_Size_id) REFERENCES Company_Workforce(Company_Size_id),
    FOREIGN KEY (Sector_id) REFERENCES Company_Sector(Sector_id),
    FOREIGN KEY (Company_HQ_id) REFERENCES Company_HeadQuarter(Nation_id)
);


-- -------------------------------------------------------------------
-- 5. Data Insertion
-- -------------------------------------------------------------------

-- Insert data into Company_HeadQuarter
INSERT INTO Company_HeadQuarter (Nation_id, HeadQuaters, Inflation) VALUES
(1, 'India', 5.56),
(2, 'America', 7.12),
(3, 'China', 1.06),
(4, 'France', 1.96),
(5, 'Singopore', 1.56),
(6, 'U.A.E', 2.02);

-- Insert data into Company_Workforce
INSERT INTO Company_Workforce (Company_Size_id, Company_Size, Workforce_Strength, Male_per, Female_per) VALUES
(1, 'Very Small', '< 200', 40, 60),
(2, 'Small', '> 200 and < 500', 65, 35),
(3, 'Medium', '> 500 and < 5000', 60, 40),
(4, 'Large', '> 5000 and < 50000', 70, 30),
(5, 'Very Large', '> 50000', 68, 32);

-- Insert data into Company_Performance
INSERT INTO Company_Performance (Performance_id, Performance_Grade) VALUES
(1, 'Poor'),
(2, 'Good'),
(3, 'Average'),
(4, 'Best');

-- Insert data into Company_Sector
INSERT INTO Company_Sector (Sector_id, Sector_Name, Performance_id, Effect_of_Covid, Effect_of_CrudePrice) VALUES
(1, 'IT', 2, 'YES', 'NO'),
(2, 'Education', 2, 'YES', 'NO'),
(3, 'Commodities', 4, 'YES', 'YES'),
(4, 'Automobile', 4, 'YES', 'YES'),
(5, 'Bank', 1, 'NO', 'YES'),
(6, 'Airline', 3, 'YES', 'YES'),
(7, 'Agriculture', 4, 'YES', 'NO'),
(8, 'BPO', 2, 'YES', 'NO'),
(9, 'Chemicals', 2, 'NO', 'NO'),
(10, 'Defence', 4, 'NO', 'YES'),
(11, 'Health Care', 4, 'NO', 'YES');

-- Insert data into Company_Information
INSERT INTO Company_Information (
    Company_id, Company_Name, Q1_Result, Q2_Result, Q3_Result, Q4_Result,
    Company_Size_id, Sector_id, Estimated_Growth, Last_Year_Growth, Growth_Percent, Company_HQ_id
) VALUES
-- The previous error was that the last value (Company_HQ_id) was missing in some rows. This is now fixed.
(1, 'Infosys', 9800, 8802, 9076, 5, 5, 1, 6.90, 8.10, -1.20, 1),
(2, 'Wipro', 5800, 6210, 4500, 4200, 3, 7, 6.10, 7.30, -1.20, 1),
(3, 'Kaveri Seed', 507, 602, 582, 650, 3, 7, 7.10, 6.90, 0.20, 1),
(4, 'Affle', 1055, 950, 990, 910, 3, 8, 5.20, 5.70, -0.50, 1),
(5, 'UHCL', 280, 200, 250, 190, 2, 9, 5.70, 5.50, 0.20, 1),
(6, 'Hindustan Aeron', 1200, 1890, 1380, 1350, 2, 10, 4.80, 5.20, -0.40, 1),
(7, 'ATUL', 750, 650, 745, 756, 3, 9, 6.10, 6.10, 0.00, 1),
(8, 'Apollo Hospital', 1508, 1026, 1210, 1209, 3, 11, 5.80, 5.50, 0.30, 2),
(9, 'Chegg', 75, 90, 56, 50, 1, 2, 3.50, 4.10, -0.60, 2),
(10, 'Himalaya Food', 365, 430, 560, 380, 2, 7, 5.60, 5.05, 0.55, 1),
(11, 'Info Edge', 270, 350, 400, 400, 3, 8, 5.10, 5.00, 0.10, 1),
(12, 'Vedanta', 670, 560, 702, 560, 3, 9, 5.80, 5.32, 0.48, 1),
(13, 'Bharat Dynamics', 1505, 1800, 1200, 1650, 4, 10, 6.20, 5.70, 0.50, 1),
(14, 'Aster DM', 250, 350, 310, 280, 2, 11, 5.30, 4.95, 0.35, 1),
(15, 'First Republic', 280, 300, 350, 380, 3, 5, 2.10, 5.80, -3.70, 2),
(16, 'Unacademy', 1010, 1890, 1950, 1870, 3, 2, 5.60, 6.07, -0.47, 1),
(17, 'Reliance', 8700, 8450, 9000, 1100, 5, 3, 7.20, 6.50, 0.70, 1),
(18, 'Adani', 8950, 9550, 8560, 8840, 5, 3, 7.30, 5.50, 1.80, 1),
(19, 'Capgemini', 3650, 3255, 3120, 3080, 5, 1, 5.20, 6.00, -0.80, 1),
(20, 'Byjus', 1200, 1150, 900, 759, 4, 2, 4.20, 5.70, -1.50, 1),
(21, 'Cognizant', 9850, 9900, 7568, 7050, 5, 1, 5.40, 6.50, -1.10, 1),
(22, 'Effective', 87, 90, 89, 70, 1, 2, 2.30, 4.00, -1.70, 1),
(23, 'TVS Motor', 10520, 15200, 12000, 11050, 5, 4, 7.01, 6.70, 0.31, 1),
(24, 'Tata Motor', 9500, 10500, 11050, 10590, 5, 4, 6.50, 6.20, 0.30, 1),
(25, 'Jet Airways', 2560, 3500, 3810, 2850, 4, 6, 5.90, 5.90, 0.00, 1),
(26, 'Signature bank', 10200, 10200, 6500, 4520, 3, 5, 3.20, 5.20, -2.00, 2),
(27, 'Silicon Valley', 2500, 1250, 1050, 750, 3, 5, 2.30, 5.30, -2.70, 2),
(28, 'Spotnik', 8600, 7500, 8800, 7800, 4, 6, 6.10, 6.10, 0.00, 1);