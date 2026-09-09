-- E-Commerce Sales Analysis using SQL
-- Dataset: Online Retail Dataset (UCI) - 500K+ transactions from a UK-based online retailer

-- 1. Total revenue by country
SELECT Country, SUM(Quantity * UnitPrice) AS Revenue
FROM sales GROUP BY Country ORDER BY Revenue DESC;

-- 2. Top 10 products by revenue
SELECT Description, SUM(Quantity * UnitPrice) AS Revenue
FROM sales GROUP BY Description ORDER BY Revenue DESC LIMIT 10;

-- 3. Monthly revenue trend
SELECT strftime('%Y-%m', InvoiceDate) AS Month, SUM(Quantity * UnitPrice) AS Revenue
FROM sales GROUP BY Month ORDER BY Month;

-- 4. Repeat customers (ordered more than once)
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Orders
FROM sales GROUP BY CustomerID HAVING Orders > 1 ORDER BY Orders DESC;

-- 5. Average order value
SELECT AVG(OrderTotal) AS AvgOrderValue FROM (
  SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS OrderTotal
  FROM sales GROUP BY InvoiceNo
) AS orders;

-- 6. Query performance optimization
-- Checked query plan before indexing (showed full table scan on 'sales')
.timer on
EXPLAIN QUERY PLAN
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Orders
FROM sales GROUP BY CustomerID HAVING Orders > 1 ORDER BY Orders DESC;

EXPLAIN QUERY PLAN
SELECT AVG(OrderTotal) AS AvgOrderValue FROM (
  SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS OrderTotal
  FROM sales GROUP BY InvoiceNo
) AS orders;

-- Ran and timed both queries before indexing
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Orders
FROM sales GROUP BY CustomerID HAVING Orders > 1 ORDER BY Orders DESC;

SELECT AVG(OrderTotal) AS AvgOrderValue FROM (
  SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS OrderTotal
  FROM sales GROUP BY InvoiceNo
) AS orders;

-- Added indexes on grouping columns
CREATE INDEX idx_customerid ON sales(CustomerID);
CREATE INDEX idx_invoiceno ON sales(InvoiceNo);

-- Checked query plan after indexing (should now show index search instead of scan)
EXPLAIN QUERY PLAN
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Orders
FROM sales GROUP BY CustomerID HAVING Orders > 1 ORDER BY Orders DESC;

EXPLAIN QUERY PLAN
SELECT AVG(OrderTotal) AS AvgOrderValue FROM (
  SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS OrderTotal
  FROM sales GROUP BY InvoiceNo
) AS orders;

-- Ran and timed both queries after indexing
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Orders
FROM sales GROUP BY CustomerID HAVING Orders > 1 ORDER BY Orders DESC;

SELECT AVG(OrderTotal) AS AvgOrderValue FROM (
  SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS OrderTotal
  FROM sales GROUP BY InvoiceNo
) AS orders;
