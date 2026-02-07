SQL window functions

Assignment

Student Names: UMUHOZA chanisse

Student ID: 27769

Group: C


  1) Problem definition
     
This project is based on a consumer electronics retail company in the retail industry. the analysis is conducted by the sales and marketing department to understand sales trend, customer behavior and product performance across regions.  

   Data Challenge
   
The company stores sales transactions for multiple products and customers across regions, but lacks insight into top selling products, inactive customers, and revenue trends over time. management needs to identify patterns into customer purchasing and product performance to support data driven marketing decisions.

 Expected outcome
 
Highlilght inactive customers and underperforming products.
Identify top performing products by region.

 2) Schema
    
CREATE TABLE customers(
customer_id NUMBER PRIMARY KEY,
customer_name VARCHAR2(100),
region VARCHAR2(50)
);

CREATE TABLE products (product_id NUMBER PRIMARY KEY, product_name VARCHAR2(100), price NUMBER(10,2));

CREATE TABLE sales (
sale_id NUMBER PRIMARY KEY,
customer_id NUMBER,
product_id NUMBER,
sale_date DATE,
quantity NUMBER,
total_amount NUMBER(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (product_id) REFERENCES products(product_id));

  ER Diagram
  
CUSTOMERS |──────< SALES >──────| PRODUCTS
     1           N        N          1

3) Join queries
   
Shows only transactions where customer and product exist.

SELECT c.customer_name, p.product_name, s.sale_date, s.total_amount
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id; 


Identifies inactive customers foR marketing.

SELECT c.customer_name
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;


Highlights unsold products.

SELECT p.product_name
FROM sales s
RIGHT JOIN products p ON s.product_id = p.product_id
WHERE s.sale_id IS NULL;



Ensures no data is missed, including unmatched records.

SELECT c.customer_name, p.product_name
FROM customers c
FULL OUTER JOIN products p ON c.customer_id = p.product_id;


Finds customers living in the same region.

SELECT c1.customer_name AS Customer1, c2.customer_name AS Customer2, c1.region
FROM customers c1
JOIN customers c2
ON c1.region = c2.region
AND c1.customer_id <> c2.customer_id;

4) Window function queries
   
SELECT p.product_name, c.region, SUM(s.total_amount) AS total_sales, RANK() OVER (PARTITION BY c.region ORDER BY SUM(s.total_amount) DESC) AS rank FROM sales s JOIN customers c ON s.customer_id = c.customer_id JOIN products p ON s.product_id = p.product_id GROUP BY p.product_name, c.region;


SELECT sale_date, total_amount, SUM(total_amount) OVER (ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total FROM sales;



SELECT sale_date, total_amount, total_amount - LAG(total_amount) OVER (ORDER BY sale_date) AS monthly_growth FROM sales;



SELECT customer_id, SUM(total_amount) AS total_spent, NTILE(4) OVER (ORDER BY SUM(total_amount)) AS quartile FROM sales GROUP BY customer_id;


SELECT sale_date, total_amount, AVG(total_amount) OVER ( ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS three_month_avg FROM sales;

5) Key insights
   
   a. Top products per region identified for marketing focus.
   
   b. customer segmentation shows top quartile drives most revenue.
   
   c. running totals and growth trends highlight peak and slow months.
   
   d.inactive customers and unsold products detected for targeted engagement.
   
   e.regional analysis supports localized marketing campaigns.

7) REFERENCES
   
   W3Schools SQL Tutorial – https://www.w3schools.com/sql/

   PostgreSQL Window Functions Guide – https://www.postgresql.org/docs/current/tutorial-window.html

9) Integrity statement
    
   I did this work myself and all the queries, explanations and screenshots are my own. 


All sources were properly cited. Implementations and analysis represent original work. no AI generated content was copied without attribution or adaptation. 
