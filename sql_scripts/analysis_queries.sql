-- ##############################################################
-- ##### E-COMMERCE SALES ANALYSIS - SQL QUERIES              #####
-- ##############################################################

-- This file contains the SQL queries used for the analysis of "TheLook" e-commerce dataset.
-- The queries progress from initial exploration to the final cleaned view used in the dashboard.


-- ********************************************************************
-- Query 1: Calculate total revenue from completed orders.
-- This query joins order items with orders to filter for 'Complete' status.
-- ********************************************************************

SELECT
  ROUND(SUM(oi.sale_price), 2) AS total_revenue
FROM
  `bigquery-public-data.thelook_ecommerce.order_items` AS oi
INNER JOIN
  `bigquery-public-data.thelook_ecommerce.orders` AS o
  ON oi.order_id = o.order_id
WHERE
  o.status = 'Complete';


-- ********************************************************************
-- Query 2: Identify the top 10 best-selling products by revenue.
-- This helps the business understand which products are driving the most sales.
-- ********************************************************************

SELECT
  p.name AS product_name,
  ROUND(SUM(oi.sale_price), 2) AS product_revenue
FROM
  `bigquery-public-data.thelook_ecommerce.order_items` AS oi
INNER JOIN
  `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
GROUP BY
  product_name
ORDER BY
  product_revenue DESC
LIMIT 10;


-- ********************************************************************
-- Query 3: Investigate the data anomaly / outlier.
-- This query was used to find the latest date in the dataset to identify the source of the unrealistic spike in the time-series chart.
-- ********************************************************************

SELECT
  MAX(created_at) AS latest_date
FROM
  `bigquery-public-data.thelook_ecommerce.orders`;


-- ********************************************************************
-- Query 4: Create the final, cleaned view for the Looker Studio Dashboard.
-- This view joins all four tables (orders, order_items, products, users) and
-- filters out both incomplete orders and the identified data anomaly to provide a
-- clean and reliable data source for visualization.
-- NOTE: You must replace `your-project-id.your_dataset_name` with your actual
-- BigQuery project ID and dataset name before running this.
-- ********************************************************************

CREATE OR REPLACE VIEW `your-project-id.your_dataset_name.ecommerce_sales_view` AS (
  SELECT
    -- From Orders table
    o.order_id,
    o.created_at AS order_date,

    -- From Order_Items table
    oi.sale_price,

    -- From Products table
    p.name AS product_name,
    p.category AS product_category,

    -- From Users table
    u.id AS user_id,
    CONCAT(u.first_name, " ", u.last_name) AS user_name
  FROM
    `bigquery-public-data.thelook_ecommerce.orders` AS o
  INNER JOIN
    `bigquery-public-data.thelook_ecommerce.order_items` AS oi
    ON o.order_id = oi.order_id
  INNER JOIN
    `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
  INNER JOIN
    `bigquery-public-data.thelook_ecommerce.users` AS u
    ON o.user_id = u.id
  WHERE
    o.status = 'Complete' -- Only include completed orders
    AND o.created_at < '2025-10-01' -- Filter out the data anomaly/outlier
);
