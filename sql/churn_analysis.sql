-- ========================================
-- CUSTOMER CHURN ANALYSIS (E-COMMERCE)
-- ========================================


-- =========================
-- DATABASE SETUP
-- =========================

CREATE DATABASE amex_project;
USE amex_project;


-- ====================
-- TABLE CREATION
-- ====================

CREATE TABLE customers (
    Credit_Score INT,
    City VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Customer_Since INT,
    Current_Account_Balance FLOAT,
    Num_of_products INT,
    UPI_Enabled VARCHAR(10),
    Estimated_Yearly_Income FLOAT,
    Customer_Status VARCHAR(10),
    Age_Group varchar(10)
);


-- ---------------
-- DATA PREVIEW
-- ---------------
SELECT * FROM customers LIMIT 10;


-- ==================
-- OVERALL METRICS
-- ==================

-- -----------------
-- Total Customers
-- -----------------

SELECT COUNT(*) AS total_customers
FROM customers;

-- --------------
-- Churn Rate
-- --------------

SELECT 
	ROUND(SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM customers;


-- ---------------------------
-- TOTAL CHURNED vs RETAINED
-- ---------------------------

SELECT 
	Customer_Status, 
	COUNT(*) AS total
FROM customers
GROUP BY Customer_Status;


-- -----------------
-- CHURN BY CITY
-- -----------------

SELECT 
	City, 
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS churned_customer,
	ROUND(SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM customers
GROUP BY City;


-- -----------------------
-- AVG BALANCE BY CHURN
-- ----------------------

SELECT 
	Customer_Status,
	ROUND(AVG(Current_Account_Balance),2) AS avg_account_balance
FROM customers
GROUP BY Customer_Status;


-- ----------------------------
-- CHURN BY NUMBER OF PRODUCTS
-- ----------------------------

SELECT 
	Num_of_products,
	COUNT(*) AS total_coustomer,
	SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS churned_customer,
	ROUND(SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM customers
GROUP BY Num_of_products;


-- -----------------------
-- CHURN BY UPI USAGE
-- -----------------------

SELECT 
	UPI_Enabled,
	COUNT(*) AS total_customer,
	SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS churned_customer
FROM customers
GROUP BY UPI_Enabled;


-- ------------------
-- AVG AGE BY CHURN
-- ------------------

SELECT 
	Customer_Status,
	ROUND(AVG(Age),2) AS avg_age
FROM customers
GROUP BY Customer_Status;


-- --------------------
-- AGE GROUP ANALYSIS
-- --------------------

SELECT 
	Age_group,
	COUNT(*) AS total,
SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS churned
FROM customers
GROUP BY 1;


-- -----------------------------------
-- TOP HIGH-INCOME CHURNED CUSTOMERS
-- -----------------------------------

SELECT *
FROM customers
WHERE Customer_Status = 'Churned'
ORDER BY Estimated_Yearly_Income DESC
LIMIT 10;


-- -----------------------
-- CREDIT SCORE IMPACT
-- -----------------------

SELECT 
CASE 
  WHEN Credit_Score < 400 THEN 'Low'
  WHEN Credit_Score BETWEEN 400 AND 600 THEN 'Medium'
  ELSE 'High'
END AS credit_category,
COUNT(*) AS total_customer,
SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS churned_customer
FROM customers
GROUP BY credit_category;


-- -----------------------------------
-- FINAL BUSINESS SUMMARY QUERY(KPI)
-- -----------------------------------

SELECT 
	COUNT(*) AS total_customers,
	SUM(CASE WHEN Customer_Status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(AVG(Age),1) AS avg_age,
	ROUND(AVG(Current_Account_Balance),0) AS avg_balance
FROM customers;