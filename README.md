# E-commerce Sales Performance Analysis

## Project Overview
This project analyzes sales data from "TheLook," a fictional e-commerce platform. The goal was to identify top-selling products, key customers, and overall revenue trends to inform sales strategy. The analysis involved joining multiple tables (orders, order_items, products, and users) to create a comprehensive dataset.

A key part of the analysis was identifying and handling a significant data anomaly in the time-series data. This outlier was investigated and filtered out at the data source level using the SQL `VIEW` to provide a more accurate and reliable representation of sales trends.

## Tools Used
- **Google BigQuery:** For querying, joining, and preparing the data.
- **Looker Studio:** For building the final interactive dashboard.
- **SQL:** The language used for data manipulation, with a focus on JOINs and data cleaning.

## Data Source
The data is from the `bigquery-public-data.thelook_ecommerce` public dataset available in Google BigQuery.

## Dashboard
An interactive dashboard was created using Looker Studio to visualize the key findings. The dashboard provides insights into total revenue, top-performing products and customers, and realistic sales trends over time.

**https://lookerstudio.google.com/reporting/df03dc5a-ee7c-44d5-a88d-4681e44543b7**

## SQL Queries
The SQL script used for the entire analysis can be found in the `sql_scripts` folder. This file includes data exploration, joining multiple tables, and the final `CREATE VIEW` statement that cleans the data and serves as the source for the dashboard.

* **[`analysis_queries.sql`](sql_scripts/analysis_queries.sql)**
