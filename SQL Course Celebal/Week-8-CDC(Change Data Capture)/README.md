# ⭐ Week 8 - CDC (Change Data Capture), SCD & OLAP Operations

Welcome to **Week 8** of the SQL Internship at **Celebal Technologies**!  
This week dives into **Change Data Capture (CDC)**, advanced **Slowly Changing Dimension (SCD)** handling, and powerful **OLAP operations** using SQL Server.

---

## 🧠 Topics Covered

- 🔄 **CDC (Change Data Capture)**  
  Learn how to track changes (inserts, updates, deletes) in SQL Server tables efficiently using CDC — a vital technique in ETL pipelines.

- 🌀 **SCD (Slowly Changing Dimensions)**  
  Deepen your understanding of handling historical data changes over time using advanced dimension tracking.

- 🔁 **SCD Type 2**  
  Implement full history tracking by adding a new row on every update, maintaining a timeline of changes.

- ⚙️ **Dynamic SQL**  
  Explore how to generate and execute SQL code dynamically to handle flexible, runtime-driven operations.

- 📊 **OLAP Operations in SQL Server**  
  Understand multidimensional analysis with:
  - **Grouping Sets**
  - **ROLLUP**
  - **CUBE**

These are essential for data summarization, drilldowns, and advanced reporting.

---

## 🧪 Assignment - Level D Task

### 📌 Task:
Write a **stored procedure** that takes a date (e.g., `'2020-07-14'`) and **populates a Time Dimension table** with detailed calendar and fiscal attributes for all dates in that year. The procedure must use **only one `INSERT` statement** and should not use multiple insert operations.

### 📁 Folder: `Week-8-CDC/`
### 📄 Assignment File: `CDC Task.sql`
---
### 🏗️ Attributes to Include:
- `SKDate`, `KeyDate`, `CalendarDay`, `CalendarMonth`, `CalendarQuarter`, `CalendarYear`
- `DayNameLong`, `DayNameShort`, `DayNumberOfWeek`, `DayNumberOfYear`, `DaySuffix`
- `FiscalWeek`, `FiscalPeriod`, `FiscalQuarter`, `FiscalYear`, `FiscalYearPeriod`

---

## 🎯 Learning Outcomes

- Enable **real-time change tracking** using CDC for reliable ETL processing.
- Apply **Slowly Changing Dimension** logic to manage evolving records in a data warehouse.
- Use **Dynamic SQL** for flexible, automated query generation.
- Implement **OLAP operations** such as `GROUPING SETS`, `ROLLUP`, and `CUBE` for multi-level data summarization.
- Build **robust and scalable stored procedures** for time-based data modeling.

---

🚀 Keep building these essential data engineering skills — they're critical for designing efficient, real-world business intelligence systems!
