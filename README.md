# E-Commerce Sales Analysis using SQL

## Overview
Analyzed 500,000+ transactions from a UK-based online retailer using SQL to uncover revenue trends, top products, customer purchase patterns, and query performance bottlenecks at scale.

## Dataset
Online Retail Dataset (UCI Machine Learning Repository), sourced via Kaggle.

## Key Findings
- The United Kingdom generated the highest revenue by a large margin, followed by the Netherlands and Ireland.
- The Regency Cakestand 3 Tier was the top-selling physical product by revenue.
- Revenue showed clear monthly variation, with identifiable peak and low periods across the year.
- A significant portion of customers placed repeat orders, indicating strong customer retention.
- Average order value (AOV) across all transactions was approximately £376.

## Query Performance Optimization
Ran `EXPLAIN QUERY PLAN` on the customer- and invoice-level grouping queries and found they were performing full table scans on the 500K+ row dataset. Added indexes on the `CustomerID` and `InvoiceNo` columns to address this.

**Results:**

| Query | Before (no index) | After (indexed) | Improvement |
|---|---|---|---|
| Repeat customer analysis (`GROUP BY CustomerID`) | 159ms | 108ms | ~32% faster |
| Average order value (`GROUP BY InvoiceNo`) | 199ms | 70ms | ~65% faster |

`EXPLAIN QUERY PLAN` confirmed the shift from a full table scan (`SCAN TABLE sales`) to an indexed lookup (`SEARCH TABLE sales USING INDEX ...`) after indexing.

## Tools Used
SQL (SQLite), DB Browser for SQLite

## Queries
All queries are available in `analysis.sql`, covering:
- Revenue by country
- Top products by revenue
- Monthly revenue trends
- Repeat customer analysis
- Average order value
- Query plan inspection and indexing (performance optimization)
