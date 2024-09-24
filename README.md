# Retail Sales Analysis SQL Script

This repository contains SQL scripts designed to analyze and clean retail sales data. The queries include operations for data exploration, identifying missing values, and generating insights such as the highest monthly sales for each year.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Example Query: Top Sales Month by Year](#example-query-top-sales-month-by-year)
- [Data Cleaning](#data-cleaning)
- [Data Exploration](#data-exploration)
- [Analysis Queries](#analysis-queries)
- [Contributing](#contributing)
- [License](#license)

## Overview
The SQL script interacts with a table named `sql - retail sales analysis_utf`, which resides in the `retailsalesanalysis` schema. The primary purpose of this script is to clean and analyze retail sales data, focusing on metrics such as transaction ID, sales date, time, quantity, and total sales.

## Features
- **Data Preview**: Initial queries to quickly view data from the retail sales table.
- **Data Cleaning**: Identifies missing values in critical columns.
- **Sales Analysis**: Aggregates and ranks data to determine trends, such as top-performing months.
- **Average Sales Reporting**: Calculates average sales by year and month.

## Prerequisites
- A SQL-compatible database like MySQL 8.0+ (due to the use of window functions like `RANK()`).
- SQL client (e.g., MySQL Workbench, DBeaver, or any other SQL editor).

## Installation
To get started with the project, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/retail-sales-analysis.git
    ```
2. Load the provided SQL script (`Retail_Sales_Analysis.sql`) into your SQL client.

## Usage
Ensure you have the relevant retail sales data in the table: `retailsalesanalysis.sql - retail sales analysis_utf`. Run the queries in the provided script to:
- Clean your dataset.
- Analyze the sales trends.
- Generate reports such as top sales months by year.

## Example Query: Top Sales Month by Year
This query identifies the month with the highest average sales for each year:

```sql
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS sales_rank
    FROM retailsalesanalysis.`sql - retail sales analysis_utf`
    GROUP BY year, month
) AS t1
WHERE sales_rank = 1;
```

## Data Cleaning
The script includes several queries for identifying missing or invalid data in key columns, ensuring that your analysis is based on a clean dataset.

```sql
SELECT * 
FROM retail_sales_analysis_utf
WHERE 
    transaction_id IS NULL 
    OR sale_date IS NULL 
    OR sale_time IS NULL 
    OR gender IS NULL 
    OR category IS NULL 
    OR quantity IS NULL 
    OR cogs IS NULL 
    OR total_sale IS NULL;
```

## Data Exploration
The exploration phase includes queries to summarize and understand the data. For example, you can calculate the total number of sales:

```sql
SELECT COUNT(*) AS total_sales 
FROM retail_sales_analysis_utf;
```

## Analysis Queries
You will also find advanced queries that involve sales trends, ranking sales by month, and calculating average monthly sales.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or suggestions.

1. Fork the repository.
2. Create your feature branch: `git checkout -b feature/my-feature`.
3. Commit your changes: `git commit -m 'Add my feature'`.
4. Push to the branch: `git push origin feature/my-feature`.
5. Open a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.
   
