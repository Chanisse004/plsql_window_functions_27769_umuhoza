SELECT p.product_name, c.region, SUM(s.total_amount) AS total_sales,
       RANK() OVER (PARTITION BY c.region ORDER BY SUM(s.total_amount) DESC) AS rank
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name, c.region;


SELECT sale_date, total_amount,
       SUM(total_amount) OVER (ORDER BY sale_date
                               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total FROM sales;



SELECT sale_date, total_amount,
       total_amount - LAG(total_amount) OVER (ORDER BY sale_date) AS monthly_growth FROM sales;



SELECT customer_id, SUM(total_amount) AS total_spent,
       NTILE(4) OVER (ORDER BY SUM(total_amount)) AS quartile FROM sales
GROUP BY customer_id;


SELECT sale_date, total_amount,
       AVG(total_amount) OVER (
           ORDER BY sale_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS three_month_avg FROM sales;