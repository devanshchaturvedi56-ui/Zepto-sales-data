# 🛒 Zepto SQL Data Analysis Project

## 📌 Project Overview

This project is based on a Zepto product dataset. The main purpose of this project is to clean the raw data, perform exploratory data analysis, and answer useful business questions using **MySQL**.

The project covers SQL concepts such as:

* Database and table handling
* Data cleaning
* NULL value checking
* Duplicate identification
* Data transformation
* Aggregate functions
* GROUP BY
* HAVING
* ORDER BY
* DISTINCT
* WHERE
* LIMIT
* Business analysis using SQL

---

# 🗂️ Dataset

The dataset contains information about Zepto products such as:

* Product Name
* Category
* MRP
* Discount Percentage
* Available Quantity
* Discounted Selling Price
* Weight in Grams
* Stock Availability
* Quantity

The original dataset was imported into MySQL and then cleaned before performing the analysis.

---

# 🛠️ Tools & Technologies

* **MySQL**
* **SQL**
* **Excel** – Used for dataset handling/import
* **GitHub** – Used for project documentation

---

# 🔄 Project Workflow

The project was completed in the following steps:

1. Import the dataset into MySQL
2. Rename the table
3. Add a unique SKU ID
4. Check the total number of rows
5. Identify NULL values
6. Check product categories
7. Analyze stock availability
8. Identify duplicate products
9. Find products with zero prices
10. Remove invalid records
11. Convert prices from paise to rupees
12. Perform business analysis using SQL

---

# 🧹 Data Cleaning

## 1. Rename Table

```sql
RENAME TABLE `copy of zepto_v1` TO zepto_v1;
```

## 2. Add SKU ID

```sql
ALTER TABLE zepto_v1
ADD COLUMN sku_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL;
```

## 3. Count Total Rows

```sql
SELECT COUNT(*) AS total_rows
FROM zepto_v1;
```

## 4. Check NULL Values

```sql
SELECT *
FROM zepto_v1
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR availableQuantity IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;
```

## 5. Check Product Categories

```sql
SELECT DISTINCT category
FROM zepto_v1
ORDER BY category;
```

## 6. Stock Availability Analysis

```sql
SELECT 
    outOfStock,
    COUNT(*) AS total_products
FROM zepto_v1
GROUP BY outOfStock;
```

## 7. Find Duplicate Product Names

```sql
SELECT 
    name,
    COUNT(sku_id) AS number_of_skus
FROM zepto_v1
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY number_of_skus DESC;
```

---

# 🧽 Data Cleaning & Transformation

## Find Products With Zero Price

```sql
SELECT *
FROM zepto_v1
WHERE mrp = 0
   OR discountedSellingPrice = 0;
```

## Remove Products With Zero MRP

```sql
DELETE FROM zepto_v1
WHERE mrp = 0;
```

## Convert Paise Into Rupees

The price values in the original dataset were stored in paise.

Therefore, the values were divided by 100 to convert them into rupees.

```sql
UPDATE zepto_v1
SET 
    mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;
```

---

# 📊 Business Analysis

## Q1. Top 10 Products With Highest Discount Percentage

```sql
SELECT 
    name,
    mrp,
    discountPercent
FROM zepto_v1
ORDER BY discountPercent DESC
LIMIT 10;
```

### Purpose

This query identifies the products offering the highest discount percentages.

---

## Q2. Product With Highest MRP That Is Out of Stock

```sql
SELECT 
    name,
    mrp,
    outOfStock
FROM zepto_v1
WHERE outOfStock = 'true'
ORDER BY mrp DESC
LIMIT 1;
```

### Purpose

This helps identify the highest-priced product that is currently out of stock.

---

## Q3. Estimated Revenue by Category

```sql
SELECT 
    category,
    SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v1
GROUP BY category
ORDER BY total_revenue DESC;
```

### Purpose

This estimates the potential revenue associated with each product category based on discounted selling price and available quantity.

> Note: This is an estimated revenue calculation, not actual historical sales revenue.

---

## Q4. Products With MRP Greater Than ₹500 and Discount Less Than 10%

```sql
SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM zepto_v1
WHERE mrp > 500
  AND discountPercent < 10;
```

### Purpose

This identifies relatively expensive products that have a low discount percentage.

---

## Q5. Top 5 Categories With Highest Average Discount

```sql
SELECT 
    category,
    ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto_v1
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
```

### Purpose

This identifies the five categories with the highest average discount percentage.

---

## Q6. Price Per Gram for Products Above 100g

```sql
SELECT DISTINCT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND(
        discountedSellingPrice / NULLIF(weightInGms, 0),
        2
    ) AS price_per_gram
FROM zepto_v1
WHERE weightInGms > 100
ORDER BY price_per_gram ASC;
```

### Purpose

This calculates the price per gram and helps compare product value based on weight.

---

# 🧠 SQL Concepts Used

The following SQL concepts were used in this project:

### DDL

* `ALTER TABLE`
* `RENAME TABLE`
* `ADD COLUMN`

### DML

* `UPDATE`
* `DELETE`

### Data Retrieval

* `SELECT`
* `DISTINCT`
* `WHERE`

### Aggregation

* `COUNT()`
* `SUM()`
* `AVG()`
* `ROUND()`

### Filtering & Sorting

* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `LIMIT`

### SQL Operators

* `AND`
* `OR`
* `>`
* `<`
* `=`

### Other Concepts

* Primary Key
* Auto Increment
* NULL handling
* Data cleaning
* Data transformation
* Duplicate detection

---

# 📈 Key Analysis Areas

This project focuses on answering practical business questions such as:

* Which products have the highest discounts?
* Which expensive products are out of stock?
* Which categories have the highest estimated revenue?
* Which products have high MRP but low discounts?
* Which categories provide the highest average discounts?
* Which products offer a lower price per gram?
* Which products appear multiple times in the dataset?
* How many products are currently out of stock?

---

# 📁 Project Structure

```text
Zepto-SQL-Data-Analysis/
│
├── README.md
│
├── Dataset/
│   └── zepto_v1.xlsx
│
└── SQL/
    └── zepto_analysis.sql
```

---

# 🚀 Future Improvements

The project can be extended by adding:

* More advanced SQL queries
* Window functions
* CTEs
* Subqueries
* Product ranking
* Category-wise price analysis
* Discount vs price analysis
* Stock availability analysis
* Power BI dashboard
* Interactive business dashboard
* Additional KPIs

---

# 🎯 Learning Outcome

Through this project, I practiced using SQL for real-world data analysis and learned how to:

* Import and clean raw datasets
* Identify data quality issues
* Transform data into a usable format
* Analyze products and categories
* Use aggregate functions
* Write business-oriented SQL queries
* Extract useful insights from structured data

---

# 👨‍💻 Author

**Dev Chaturvedi**

Aspiring Data Analyst

### Skills

* Excel
* SQL
* Power BI
* Python
* Data Analysis

---

# ⭐ Project Summary

This Zepto SQL Data Analysis project demonstrates how SQL can be used to transform raw e-commerce product data into meaningful business analysis.

The project covers the complete basic workflow from **data cleaning to business-oriented SQL analysis** and can be further enhanced with Power BI for interactive visualization.
