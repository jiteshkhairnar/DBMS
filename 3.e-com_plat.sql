CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Customer Table
CREATE TABLE CUSTOMER (
  cust_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(50) UNIQUE
);

-- Product Table
CREATE TABLE PRODUCT (
  prod_id INT AUTO_INCREMENT PRIMARY KEY,
  prod_name VARCHAR(50),
  price DECIMAL(10,2) CHECK (price > 0)
);

-- Order Master Table
CREATE TABLE ORDER_MASTER (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  cust_id INT,
  order_date DATE ,
  FOREIGN KEY (cust_id) REFERENCES CUSTOMER(cust_id)
);

-- Order Detail Table
CREATE TABLE ORDER_DETAIL (
  order_id INT,
  prod_id INT,
  quantity INT DEFAULT 1,
  PRIMARY KEY (order_id, prod_id),
  FOREIGN KEY (order_id) REFERENCES ORDER_MASTER(order_id),
  FOREIGN KEY (prod_id) REFERENCES PRODUCT(prod_id)
);

-- Sample Data
INSERT INTO CUSTOMER VALUES (1, 'Amit', 'amit@gmail.com'),
                             (2, 'Sneha', 'sneha@gmail.com');

INSERT INTO PRODUCT VALUES (1, 'Laptop', 60000),
                           (2, 'Mouse', 500),
                           (3, 'Keyboard', 1200);

INSERT INTO ORDER_MASTER (cust_id) VALUES (1), (2);

INSERT INTO ORDER_DETAIL VALUES (1,1,1), (1,2,2), (2,3,1);

-- View: Orders with Customer and Product Count
CREATE VIEW order_summary AS
SELECT om.order_id, c.name AS Customer, COUNT(od.prod_id) AS Total_Products
FROM ORDER_MASTER om
JOIN CUSTOMER c ON om.cust_id = c.cust_id
JOIN ORDER_DETAIL od ON om.order_id = od.order_id
GROUP BY om.order_id, c.name;

-- Index on price
CREATE INDEX idx_price ON PRODUCT(price);

-- View alias as synonym for PRODUCT
CREATE VIEW PRD AS SELECT * FROM PRODUCT;

-- Display results
SELECT * FROM order_summary;
SELECT * FROM PRD;
