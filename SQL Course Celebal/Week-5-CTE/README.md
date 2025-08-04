# 📚 Week 5 - Common Table Expressions (CTE)

Welcome to *Week 5* of the SQL Internship at *Celebal Technologies*!  
This week focuses on mastering *Common Table Expressions (CTEs)* — a powerful SQL feature for writing modular and readable queries, especially useful in handling complex business logic and hierarchical data structures.

---

## 🧠 Topics Covered

- Common Table Expressions (CTE) – Part 1 & Part 2  
- Updatable Common Table Expressions  
- Recursive CTE

---

## 🧪 Execution Environment

All tasks and the final assignment were executed using:

- *Microsoft SQL Server Management Studio (SSMS)*  
- *MySQL Workbench* (used for syntax reference where applicable)

---

## 📝 Assignment - Subject Change Request Problem

### 🎯 Problem Statement

The college needs to maintain a *complete history of open elective subject changes* made by students over time.  
When a student requests a subject change, the current active subject must be invalidated, and the newly requested subject must be added and marked as active — *without deleting any historical records*.

---

### 📌 Tables Used

1. *SubjectAllotments*
   - StudentId (varchar)  
   - SubjectId (varchar)  
   - Is_valid (bit) — 1 for currently active, 0 for inactive/allotted in past  

2. *SubjectRequest*
   - StudentId (varchar)  
   - SubjectId (varchar) — newly requested subject

---

### 🔁 Business Rules Implemented

- If the student already has the requested subject active → *No changes*.
- If the requested subject is *different from the current active one* →  
  → Set existing active record's Is_valid = 0  
  → Insert new record with Is_valid = 1
- If the student is **not found in SubjectAllotments** → Insert the new record with Is_valid = 1

--- 

### 🛠 Stored Procedure: HandleSubjectRequests

A *cursor-based stored procedure* named HandleSubjectRequests was created to process each row in SubjectRequest table. It performs the following:

- Fetches each student's request.
- Compares it with their current active subject in SubjectAllotments.
- Updates the old subject as invalid if necessary.
- Inserts the new subject as valid.

---
✅ The solution is fully tested, logically optimized, and built using clean SQL practices.  
The approach ensures *data consistency, traceability, and student history tracking* — aligned with real-world systems.

---
