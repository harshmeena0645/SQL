<h1 align="center">📊 Celebal SQL Internship Tasks - Summer 2025 </h1>

Welcome to the official repository for my SQL tasks completed during the **Celebal Technologies Summer Internship 2025**. This repository is structured week-wise as per the course modules provided on the Celebal Internship Portal.

---

## 📅 Internship Details

- **🏢 Company:** Celebal Technologies  
- **👨‍💻 Role:** SQL Intern  
- **📆 Duration:** June 2, 2025 – August 3, 2025  

---

## 🗂 Weekly Breakdown

### 🔹 Week 1 - DDL & Basic SQL Operations
Tasks focused on foundational SQL concepts like:

- Creating, Altering, Dropping Databases and Tables  
- SQL Constraints (Primary, Foreign, Default, Check, etc.)  
- Data Types in SQL Server  
- SQL Commands: `INSERT`, `UPDATE`, `DELETE`  
- `SELECT` Statements  
- Joins and Advanced Joins  
- Aggregation and Set Operations  
- Relationship Modeling and Referential Integrity  

📁 **Folder:** `Week-1-DDL/`  
📄 **Assignment:** `Level A Task Solutions`

---

### 🔹 Week 2 - Built-In Functions, Procedures, Views & Triggers

This week focuses on advanced SQL concepts using the **AdventureWorks2022** database, including built-in functions, user-defined functions, stored procedures, views, and triggers.

#### 📚 Key Topics:

- Built-in String, DateTime, Math, Cast/Convert Functions  
- User Defined Functions (UDFs)  
- Views (Standard, Updatable, Indexed, with Limitations)  
- Stored Procedures for Insert, Update, Delete, Fetch Operations  
- Triggers for Referential Integrity and Inventory Management  

📁 **Folder:** `Week-2-BuiltIn-Functions/`  
📄 **Assignment:** `Level B Task Solutions`

---

### 🔹 Week 3 - Indexes, Stored Procedures & Subqueries

This week dives into **performance optimization** and **modular SQL programming** through indexes, stored procedures, and subqueries.

#### 📚 Key Topics:

- Temporary Tables  
- Indexes (Part 1 & 2)  
- Unique vs Non-Unique Indexes  
- Pros and Cons of Indexes  
- Stored Procedures  
- Stored Procedures with Output Parameters (Part 1 & 2)  
- Advantages of Stored Procedures  
- Subqueries & Correlated Subqueries  
- Performance Comparison: Subquery vs Join  

📁 **Folder:** `Week-3-Indexes/`  
📄 **Assignment:** `Level C Task Solutions`

---
### 🔹 Week 4 - Triggers & Student Allotment Logic

This week focuses on **DML triggers** and their practical use cases, including conditional logic during `INSERT`, `UPDATE`, and `DELETE` operations. The week concludes with a subject allotment assignment based on GPA and preference order.

#### 📚 Key Topics:

- DML Triggers  
- AFTER UPDATE Trigger  
- INSTEAD OF INSERT Trigger  
- INSTEAD OF UPDATE Trigger  
- INSTEAD OF DELETE Trigger  

📁 **Folder:** `Week-4-Triggers/`  
📄 **Assignment:** `Student Allotment SQL Problem`  

---

### 🔹 Week 5 - Common Table Expressions (CTE)

This week covers **Common Table Expressions (CTE)** and their use in modular query writing. Topics include recursive CTEs, updatable CTEs, and using them in practical scenarios. The assignment implements a subject change request tracker using stored procedures.

#### 📚 Key Topics:

- Common Table Expressions (CTE) – Part 1 & 2  
- Updatable CTEs  
- Recursive CTE  

📁 **Folder:** `Week-5-CTE/`  
📄 **Assignment:** `Subject Change Request Problem`  

---

### 🔹 Week 6 - Pivot, Error Handling, Transactions & LeetCode Problems

This week introduces **data reshaping**, **robust error handling**, and **transaction management** in SQL Server. It also includes **LeetCode-style SQL problems** that help apply concepts in real-world scenarios.

#### 📚 Key Topics:

- `PIVOT` – Transform rows into columns  
- `UNPIVOT` – Transform columns back into rows  
- Error Handling using `TRY...CATCH` blocks  
  - Error Handling – Part 1: Handling syntax/logical errors  
  - Error Handling – Part 2: Custom error messages, nested try-catch  
- Transactions & ACID Properties  
- `MERGE` Statement – Conditional `INSERT`, `UPDATE`, or `DELETE`  
- **Window Functions**:  
  - `ROW_NUMBER()`  
  - `RANK()`  
  - `DENSE_RANK()`  
  - `NTILE()`  
- LeetCode SQL Problems (Performance-focused)

📁 **Folder:** `Week-6-Pivot/`  
📄 **Assignment:** `Perform  Leetcode Questions`

---

### 🔹 Week 7 - Slowly Changing Dimensions (SCD) – Types 0, 1, 2, 3, 4, 6

This week dives deep into **Slowly Changing Dimensions (SCD)** — a critical concept in **Data Warehousing and ETL** processes. Each SCD type handles historical changes in dimension tables differently. The assignment includes implementation of stored procedures for each SCD type using **SQL Server**.

#### 📚 Key Topics

- **SCD Type 0**: Fixed dimensions (no changes allowed)
- **SCD Type 1**: Overwrite old data (no history maintained)
- **SCD Type 2**: Historical tracking via versioning or effective dates
- **SCD Type 3**: Limited history with previous and current column versions
- **SCD Type 4**: History stored in a separate historical table
- **SCD Type 6**: Hybrid approach (Types 1 + 2 + 3)

Each SCD type is implemented through a **dedicated stored procedure** to handle `INSERT` and `UPDATE` operations based on the logic of that dimension type.


📁 **Folder:** `Week-7-Star and Snowflake Schema/`  
📄 **Assignment:** `Create Stored Procedures for SCD Types`

---
### 🔹 Week 8 – CDC, SCD Type 2, Dynamic SQL & OLAP Operations

This week focuses on **Change Tracking**, **historical dimension handling**, **dynamic SQL generation**, and **OLAP-style aggregations** in SQL Server. These concepts are widely used in real-world **ETL pipelines**, **reporting systems**, and **data marts**.

#### 📚 Key Topics

- **CDC (Change Data Capture)**:  
  Track and log changes (INSERTs, UPDATEs, DELETEs) to source tables for incremental ETL processing.

- **SCD Type 2**:  
  Maintain a full history of changes by inserting new rows on update, using `start_date`, `end_date`, and `is_current` flags or versioning columns.

- **Dynamic SQL**:  
  Learn how to generate flexible queries at runtime using `EXEC` or `sp_executesql`.

- **OLAP Features in SQL Server**:  
  Use advanced SQL grouping techniques for data summarization:
  - `GROUPING SETS`
  - `ROLLUP`
  - `CUBE`

These operations allow **multi-level aggregations** without multiple `GROUP BY` statements, optimizing performance for analytics.

---

📁 **Folder:** `Week-8-CDC/`  
📄 **Assignment:** `PopulateTimeDimension.sql` – Write a stored procedure to populate a Time Dimension table for all dates of a year based on one input date, using a single `INSERT` and recursive CTE.

---


## 🚀 How to Use

1. Clone this repository or download it as a ZIP.  
2. Open `.sql` files using SQL Server Management Studio (SSMS) or Mysql WorkBench 8.0
3. Execute the queries on the **Adventure works2022** database.  
4. Files are named and commented for clarity.

---

## 👤 Author

**Krishna Shelar**  
💼 SQL Intern @ Celebal Technologies  
🔗 [LinkedIn](https://www.linkedin.com/in/krishna-shelar-75294a255/)  

---

> 📌 _This repository will be updated weekly with new assignments and tasks._
