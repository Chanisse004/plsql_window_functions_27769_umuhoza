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