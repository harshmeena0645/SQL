
# 📚 Week 3 - Indexes, Temporary Tables, Stored Procedures & Subqueries

Welcome to **Week 3** of the SQL Internship at Celebal Technologies!  
This week focuses on **SQL performance tuning**, **modular programming**, and **query optimization** using advanced techniques such as indexes, temporary tables, stored procedures with output parameters, and subqueries.

---

## 🧠 Topics Covered

- Temporary Tables  
- Indexes – Part 1 & Part 2  
- Unique & Non-Unique Indexes  
- Pros and Cons of Indexes  
- Stored Procedures  
- Stored Procedures with Output Parameters (Parts 1 & 2)  
- Advantages of Stored Procedures  
- Subqueries  
- Correlated Subqueries  
- Performance Analysis: Subquery vs Join  

---

## 🧪 Execution Environment

I have executed all **20 Level C tasks** using the following tools:

- **MySQL Workbench 8.0**  
- **Microsoft SQL Server Management Studio (SSMS)**

The tasks were tested across both environments to ensure correctness and performance consistency.

---

## 📝 Assignment - Level C Task

---

### 📁 Temporary Tables

- Created temporary tables for intermediate data processing and testing logic.  
- Used both `#TemporaryTable` and `##GlobalTempTable` formats to demonstrate scope and session behavior.

---

### 📌 Indexes

1. **Create and Analyze Indexes**  
   - Designed Clustered, Non-Clustered, Unique, and Composite indexes.  
   - Verified performance improvements using query plans and system views.

2. **Performance Observation**  
   - Used `SET STATISTICS TIME` and `IO` (SQL Server) and `EXPLAIN` (MySQL) to measure query execution performance.

3. **Evaluate Trade-offs**  
   - Documented benefits (e.g., faster reads) and drawbacks (e.g., slower writes) of indexing under different scenarios.

---

### 🛠️ Stored Procedures with Output Parameters

1. **Single Output Parameter**  
   - Implemented procedures that return computed results using an `OUTPUT` parameter.

2. **Multiple Output Parameters**  
   - Created procedures that return multiple values such as counts, totals, and averages.

3. **Advantages**  
   - Highlighted modularization, improved performance, security, and reuse as key advantages.

---

### 🔍 Subqueries

1. **Basic Subqueries**  
   - Demonstrated subqueries in `SELECT`, `FROM`, and `WHERE` clauses for filtering and derived calculations.

2. **Correlated Subqueries**  
   - Used correlated subqueries to return row-dependent values (e.g., highest-paid employee per department).

3. **Performance Comparison**  
   - Compared subqueries and joins using execution plans to determine the most efficient solution in different contexts.

---

✅ All SQL scripts are well-tested, commented, and optimized for clarity and performance. Each solution includes rationale behind indexing strategy, subquery usage, and procedure design.

