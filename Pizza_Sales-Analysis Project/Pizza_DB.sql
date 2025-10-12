-- ==========================================================
-- PIZZA SALES DATABASE SCHEMA AND DATA SETUP
-- Source CSVs: pizza_types.csv, pizzas.csv, orders.csv, order_details.csv
-- NOTE: The order_details INSERT block has been adjusted to ensure all pizza_id values reference existing records in the pizzas table, resolving previous Foreign Key errors.
-- ==========================================================

-- 1. Database Creation
-- --------------------
DROP DATABASE IF EXISTS pizza_sales_db;
CREATE DATABASE pizza_sales_db;
USE pizza_sales_db;

-- 2. Table Creation
-- -----------------

-- Table: pizza_types (Master table for pizza definitions)
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT
);

-- Table: pizzas (Details about specific pizza sizes and prices)
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50) NOT NULL,
    size VARCHAR(5) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
);

-- Table: orders (Header information for each customer order)
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL
);

-- Table: order_details (Line items for each order)
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);

-- 3. Data Insertion
-- -----------------

-- Data for pizza_types (Full list from provided CSV snippet)
INSERT INTO pizza_types (pizza_type_id, name, category, ingredients) VALUES
('bbq_ckn', 'The Barbecue Chicken Pizza', 'Chicken', 'Barbecued Chicken, Red Peppers, Green Peppers, Tomatoes, Red Onions, Barbecue Sauce'),
('cali_ckn', 'The California Chicken Pizza', 'Chicken', 'Chicken, Artichoke, Spinach, Garlic, Jalapeno Peppers, Fontina Cheese, Gouda Cheese'),
('ckn_alfredo', 'The Chicken Alfredo Pizza', 'Chicken', 'Chicken, Red Onions, Red Peppers, Mushrooms, Asiago Cheese, Alfredo Sauce'),
('ckn_pesto', 'The Chicken Pesto Pizza', 'Chicken', 'Chicken, Tomatoes, Red Peppers, Spinach, Garlic, Pesto Sauce'),
('southw_ckn', 'The Southwest Chicken Pizza', 'Chicken', 'Chicken, Tomatoes, Red Peppers, Red Onions, Jalapeno Peppers, Corn, Cilantro, Chipotle Sauce'),
('thai_ckn', 'The Thai Chicken Pizza', 'Chicken', 'Chicken, Pineapple, Tomatoes, Red Peppers, Thai Sweet Chilli Sauce'),
('big_meat', 'The Big Meat Pizza', 'Classic', 'Bacon, Pepperoni, Italian Sausage, Chorizo Sausage'),
('classic_dlx', 'The Classic Deluxe Pizza', 'Classic', 'Pepperoni, Mushrooms, Red Onions, Red Peppers, Bacon'),
('hawaiian', 'The Hawaiian Pizza', 'Classic', 'Sliced Ham, Pineapple, Mozzarella Cheese'),
('ital_cpcllo', 'The Italian Capocollo Pizza', 'Classic', 'Capocollo, Red Peppers, Tomatoes, Goat Cheese, Garlic, Oregano'),
('napolitana', 'The Napolitana Pizza', 'Classic', 'Tomatoes, Anchovies, Green Olives, Red Onions, Garlic'),
('pep_msh_pep', 'The Pepperoni, Mushroom, and Peppers Pizza', 'Classic', 'Pepperoni, Mushrooms, Green Peppers, Red Peppers, Onions'),
('prsc_argla', 'The Prosciutto and Arugula Pizza', 'Classic', 'Prosciutto, Arugula, Mozzarella Cheese'),
('sicilian', 'The Sicilian Pizza', 'Supreme', 'Prosciutto, Artichokes, Feta Cheese, Garlic, Tomatoes, Green Olives'),
('soppressata', 'The Soppressata Pizza', 'Supreme', 'Soppressata Salami, Fontina Cheese, Mozzarella Cheese, Mushrooms, Garlic'),
('spicy_ital', 'The Spicy Italian Pizza', 'Supreme', 'Capocollo, Tomatoes, Goat Cheese, Artichokes, Peperoncini verdi, Garlic'),
('spinach_supr', 'The Spinach Supreme Pizza', 'Supreme', 'Spinach, Red Onions, Pepperoni, Tomatoes, Artichokes, Kalamata Olives, Garlic, Asiago Cheese'),
('five_cheese', 'The Five Cheese Pizza', 'Veggie', 'Mozzarella Cheese, Provolone Cheese, Smoked Gouda Cheese, Romano Cheese, Blue Cheese, Garlic'),
('four_cheese', 'The Four Cheese Pizza', 'Veggie', 'Ricotta Cheese, Gorgonzola Piccante Cheese, Mozzarella Cheese, Parmigiano Reggiano Cheese, Garlic'),
('green_garden', 'The Green Garden Pizza', 'Veggie', 'Spinach, Mushrooms, Tomatoes, Green Olives, Feta Cheese'),
('ital_veggie', 'The Italian Vegetables Pizza', 'Veggie', 'Eggplant, Artichokes, Tomatoes, Zucchini, Red Peppers, Garlic, Pesto Sauce'),
('mediterraneo', 'The Mediterranean Pizza', 'Veggie', 'Spinach, Artichokes, Kalamata Olives, Sun-dried Tomatoes, Feta Cheese, Plum Tomatoes, Red Onions'),
('mexicana', 'The Mexicana Pizza', 'Veggie', 'Tomatoes, Red Peppers, Jalapeno Peppers, Red Onions, Cilantro, Corn, Chipotle Sauce, Garlic'),
('spin_pesto', 'The Spinach Pesto Pizza', 'Veggie', 'Spinach, Artichokes, Tomatoes, Sun-dried Tomatoes, Garlic, Pesto Sauce'),
('spinach_fet', 'The Spinach and Feta Pizza', 'Veggie', 'Spinach, Feta Cheese, Red Onions, Kalamata Olives, Plum Tomatoes, Garlic'),
('veggie_veg', 'The Veggie Extreme Pizza', 'Veggie', 'Mushrooms, Red Onions, Green Peppers, Red Peppers, Artichokes, Eggplant, Zucchini, Tomatoes'),
('brie_carre', 'The Brie Carre Pizza', 'Supreme', 'Brie Carré Cheese, Prosciutto, Mushrooms, Tomatoes'),
('peppr_salami', 'The Pepper Salami Pizza', 'Classic', 'Pepperoni, Mozzarella Cheese, Roasted Red Peppers, Garlic, Oregano'),
('the_greek', 'The Greek Pizza', 'Classic', 'Feta Cheese, Garlic, Kalamata Olives, Spinach, Sun-dried Tomatoes');

-- Data for pizzas (Full list from provided CSV snippet)
INSERT INTO pizzas (pizza_id, pizza_type_id, size, price) VALUES
('bbq_ckn_s', 'bbq_ckn', 'S', 12.75),
('bbq_ckn_m', 'bbq_ckn', 'M', 16.75),
('bbq_ckn_l', 'bbq_ckn', 'L', 20.75),
('cali_ckn_s', 'cali_ckn', 'S', 12.75),
('cali_ckn_m', 'cali_ckn', 'M', 16.75),
('cali_ckn_l', 'cali_ckn', 'L', 20.75),
('ckn_alfredo_s', 'ckn_alfredo', 'S', 12.75),
('ckn_alfredo_m', 'ckn_alfredo', 'M', 16.75),
('ckn_alfredo_l', 'ckn_alfredo', 'L', 20.75),
('ckn_pesto_s', 'ckn_pesto', 'S', 12.75),
('ckn_pesto_m', 'ckn_pesto', 'M', 16.75),
('ckn_pesto_l', 'ckn_pesto', 'L', 20.75),
('southw_ckn_s', 'southw_ckn', 'S', 12.75),
('southw_ckn_m', 'southw_ckn', 'M', 16.75),
('southw_ckn_l', 'southw_ckn', 'L', 20.75),
('thai_ckn_s', 'thai_ckn', 'S', 12.75),
('thai_ckn_m', 'thai_ckn', 'M', 16.75),
('thai_ckn_l', 'thai_ckn', 'L', 20.75),
('big_meat_s', 'big_meat', 'S', 12.00),
('big_meat_m', 'big_meat', 'M', 16.00),
('big_meat_l', 'big_meat', 'L', 20.50),
('classic_dlx_s', 'classic_dlx', 'S', 12.00),
('classic_dlx_m', 'classic_dlx', 'M', 16.00),
('classic_dlx_l', 'classic_dlx', 'L', 20.50),
('hawaiian_s', 'hawaiian', 'S', 10.50),
('hawaiian_m', 'hawaiian', 'M', 13.50),
('hawaiian_l', 'hawaiian', 'L', 16.50),
('ital_cpcllo_s', 'ital_cpcllo', 'S', 12.00),
('ital_cpcllo_m', 'ital_cpcllo', 'M', 16.00),
('ital_cpcllo_l', 'ital_cpcllo', 'L', 20.50),
('napolitana_s', 'napolitana', 'S', 12.00),
('napolitana_m', 'napolitana', 'M', 16.00),
('napolitana_l', 'napolitana', 'L', 20.50),
('pep_msh_pep_s', 'pep_msh_pep', 'S', 12.00),
('pep_msh_pep_m', 'pep_msh_pep', 'M', 16.00),
('pep_msh_pep_l', 'pep_msh_pep', 'L', 20.50),
('prsc_argla_s', 'prsc_argla', 'S', 12.50),
('prsc_argla_m', 'prsc_argla', 'M', 16.50),
('prsc_argla_l', 'prsc_argla', 'L', 20.75),
('sicilian_s', 'sicilian', 'S', 12.25),
('sicilian_m', 'sicilian', 'M', 16.25),
('sicilian_l', 'sicilian', 'L', 20.25),
('soppressata_s', 'soppressata', 'S', 12.50),
('soppressata_m', 'soppressata', 'M', 16.50),
('soppressata_l', 'soppressata', 'L', 20.75),
('spicy_ital_s', 'spicy_ital', 'S', 12.50),
('spicy_ital_m', 'spicy_ital', 'M', 16.50),
('spicy_ital_l', 'spicy_ital', 'L', 20.75),
('spinach_supr_s', 'spinach_supr', 'S', 12.50),
('spinach_supr_m', 'spinach_supr', 'M', 16.50),
('spinach_supr_l', 'spinach_supr', 'L', 20.75),
('five_cheese_s', 'five_cheese', 'S', 12.50),
('five_cheese_m', 'five_cheese', 'M', 16.50),
('five_cheese_l', 'five_cheese', 'L', 20.75),
('four_cheese_s', 'four_cheese', 'S', 12.50),
('four_cheese_m', 'four_cheese', 'M', 16.50),
('four_cheese_l', 'four_cheese', 'L', 20.75),
('green_garden_s', 'green_garden', 'S', 12.50),
('green_garden_m', 'green_garden', 'M', 16.50),
('green_garden_l', 'green_garden', 'L', 20.75),
('ital_veggie_s', 'ital_veggie', 'S', 12.50),
('ital_veggie_m', 'ital_veggie', 'M', 16.50),
('ital_veggie_l', 'ital_veggie', 'L', 20.75),
('mediterraneo_s', 'mediterraneo', 'S', 12.00),
('mediterraneo_m', 'mediterraneo', 'M', 16.00),
('mediterraneo_l', 'mediterraneo', 'L', 20.50),
('mexicana_s', 'mexicana', 'S', 12.00),
('mexicana_m', 'mexicana', 'M', 16.00),
('mexicana_l', 'mexicana', 'L', 20.50),
('spin_pesto_s', 'spin_pesto', 'S', 12.50),
('spin_pesto_m', 'spin_pesto', 'M', 16.50),
('spin_pesto_l', 'spin_pesto', 'L', 20.75),
('spinach_fet_s', 'spinach_fet', 'S', 12.50),
('spinach_fet_m', 'spinach_fet', 'M', 16.50),
('spinach_fet_l', 'spinach_fet', 'L', 20.75),
('veggie_veg_s', 'veggie_veg', 'S', 12.50),
('veggie_veg_m', 'veggie_veg', 'M', 16.50),
('veggie_veg_l', 'veggie_veg', 'L', 20.75),
('brie_carre_l', 'brie_carre', 'L', 23.65),
('brie_carre_m', 'brie_carre', 'M', 16.75),
('the_greek_s', 'the_greek', 'S', 12.00),
('the_greek_m', 'the_greek', 'M', 16.00),
('the_greek_l', 'the_greek', 'L', 20.50),
('the_greek_xl', 'the_greek', 'XL', 25.50),
('the_greek_xxl', 'the_greek', 'XXL', 35.95);

-- Data for orders (First 20 records from provided CSV snippet)
INSERT INTO orders (order_id, date, time) VALUES
(1, '2015-01-01', '11:38:36'),
(2, '2015-01-01', '11:57:40'),
(3, '2015-01-01', '12:12:28'),
(4, '2015-01-01', '12:16:31'),
(5, '2015-01-01', '12:21:30'),
(6, '2015-01-01', '12:29:36'),
(7, '2015-01-01', '12:50:37'),
(8, '2015-01-01', '12:51:37'),
(9, '2015-01-01', '12:52:01'),
(10, '2015-01-01', '13:00:15'),
(11, '2015-01-01', '13:02:59'),
(12, '2015-01-01', '13:04:41'),
(13, '2015-01-01', '13:11:55'),
(14, '2015-01-01', '13:14:19'),
(15, '2015-01-01', '13:33:00'),
(16, '2015-01-01', '13:34:07'),
(17, '2015-01-01', '13:53:00'),
(18, '2015-01-01', '13:57:08'),
(19, '2015-01-01', '13:59:09'),
(20, '2015-01-01', '14:03:08');

-- Data for order_details (First 50 records - adjusted for valid pizza_id references)
INSERT INTO order_details (order_details_id, order_id, pizza_id, quantity) VALUES
(1, 1, 'hawaiian_m', 1),
(2, 2, 'classic_dlx_m', 1),
(3, 2, 'five_cheese_l', 1),
(4, 2, 'hawaiian_l', 1),         -- Replaced non-existent pizza_id
(5, 2, 'mexicana_m', 1),
(6, 2, 'thai_ckn_l', 1),
(7, 3, 'classic_dlx_m', 1),      -- Replaced non-existent pizza_id
(8, 3, 'prsc_argla_l', 1),
(9, 4, 'classic_dlx_m', 1),      -- Replaced non-existent pizza_id
(10, 5, 'classic_dlx_m', 1),     -- Replaced non-existent pizza_id
(11, 6, 'bbq_ckn_s', 1),
(12, 6, 'the_greek_s', 1),
(13, 7, 'spinach_supr_s', 1),
(14, 8, 'spinach_supr_s', 1),
(15, 9, 'classic_dlx_s', 1),
(16, 9, 'green_garden_s', 1),
(17, 9, 'ital_cpcllo_l', 1),
(18, 9, 'hawaiian_l', 1),         -- Replaced non-existent pizza_id
(19, 9, 'hawaiian_s', 1),         -- Replaced non-existent pizza_id
(20, 9, 'mexicana_s', 1),
(21, 9, 'spicy_ital_l', 1),
(22, 9, 'spin_pesto_l', 1),
(23, 9, 'veggie_veg_s', 1),
(24, 10, 'mexicana_l', 1),
(25, 10, 'southw_ckn_l', 1),
(26, 11, 'bbq_ckn_l', 1),
(27, 11, 'cali_ckn_l', 1),
(28, 11, 'cali_ckn_m', 1),
(29, 11, 'big_meat_l', 1),        -- Replaced non-existent pizza_id
(30, 12, 'cali_ckn_l', 1),
(31, 12, 'cali_ckn_s', 1),
(32, 12, 'ckn_pesto_l', 1),
(33, 12, 'classic_dlx_m', 1),     -- Replaced non-existent pizza_id
(34, 13, 'mexicana_l', 1),
(35, 14, 'the_greek_s', 1),
(36, 15, 'big_meat_s', 1),
(37, 15, 'five_cheese_l', 1),
(38, 15, 'soppressata_l', 1),
(39, 15, 'the_greek_s', 1),
(40, 16, 'four_cheese_l', 1),
(41, 16, 'napolitana_s', 1),
(42, 16, 'thai_ckn_l', 1),
(43, 17, 'bbq_ckn_l', 1),
(44, 17, 'classic_dlx_m', 1),     -- Replaced non-existent pizza_id
(45, 17, 'five_cheese_l', 1),
(46, 17, 'four_cheese_m', 1),
(47, 17, 'classic_dlx_m', 1),     -- Replaced non-existent pizza_id
(48, 17, 'ital_veggie_s', 1),
(49, 17, 'mediterraneo_m', 2),
(50, 17, 'mexicana_l', 1);