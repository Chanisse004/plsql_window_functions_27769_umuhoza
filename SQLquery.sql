CREATE TABLE customers(
customer_id NUMBER PRIMARY KEY,
customer_name VARCHAR2(100),
region VARCHAR2(50)
);

INSERT INTO customers VALUES (1, 'Alice', 'East');
INSERT INTO customers VALUES (2, 'Chanisse', 'Kigali');

CREATE TABLE products (product_id NUMBER PRIMARY KEY, product_name VARCHAR2(100), price NUMBER(10,2));

INSERT INTO products VALUES (102, 'Phone', 500);


CREATE TABLE sales (
sale_id NUMBER PRIMARY KEY,
customer_id NUMBER,
product_id NUMBER,
sale_date DATE,
quantity NUMBER,
total_amount NUMBER(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (product_id) REFERENCES products(product_id));

INSERT INTO sales VALUES (1001, 5, 102, DATE '2026-01-05', 1, 800);




