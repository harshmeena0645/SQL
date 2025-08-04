# 📚 Week 4 - Triggers

Welcome to **Week 4** of the SQL Internship at **Celebal Technologies**!  
This week focuses on implementing **DML triggers** to enforce logic during data changes (INSERT, UPDATE, DELETE). You will also explore **instead-of triggers** that allow conditional control before an operation executes on a table or view.

---

## 🧠 Topics Covered

- DML Triggers  
- AFTER UPDATE Trigger  
- INSTEAD OF INSERT Trigger  
- INSTEAD OF UPDATE Trigger  
- INSTEAD OF DELETE Trigger

---

## 🧪 Execution Environment

All tasks were implemented and tested using:

- **Microsoft SQL Server Management Studio (SSMS)**  
- **MySQL Workbench** *(for basic syntax validation, where applicable)*

---

## 📝 Assignment - Student Allotment SQL Problem

### 🎯 Problem Statement

The college needs to automate the **subject allotment process** for open electives.  
Each student fills **5 subject preferences** (ranked from 1 to 5). Subjects are to be allotted **based on GPA**, with students having **higher GPA getting higher priority**. Each subject has a **limited number of seats**.

---

### 📌 Tables Used

1. **StudentPreference**  
   Stores the 5 preferences of each student.  
   - `StudentId`  
   - `SubjectId`  
   - `Preference` *(1 to 5)*  

2. **SubjectDetails**  
   Contains metadata and seat availability for each subject.  
   - `SubjectId`  
   - `SubjectName`  
   - `MaxSeats`  
   - `RemainingSeats`  

3. **StudentDetails**  
   Information about each student along with GPA.  
   - `StudentId`  
   - `StudentName`  
   - `GPA`  
   - `Branch`  
   - `Section`

4. **Allotments**  
   Final subject-to-student mapping table.  
   - `SubjectId`  
   - `StudentId`

5. **UnallottedStudents**  
   Stores students who couldn’t be allotted any subject due to full capacity.  
   - `StudentId`

---

### 🔁 Business Logic

- Sort students **in descending order of GPA**.
- For each student, go through their preferences from 1 to 5:
  - If a subject has **remaining seats**, allot it and reduce seat count.
  - If all 5 preferences are full, mark the student as **unallotted**.
- No student can select the **same subject twice**.
- The system must retain this **allocation history**.

---

### 🛠 Stored Procedure: `AllotSubjectsBasedOnGPA`

A stored procedure was developed to:

- Fetch and sort students based on GPA.
- Traverse each student’s preferences in order.
- Allocate subject if seats are available.
- Insert into `Allotments` or `UnallottedStudents` based on availability.

---
✅ The implementation ensures fair allotment based on academic performance (GPA), manages seat limits, and handles edge cases where all preferences are full.  
The logic is scalable, modular, and can be scheduled or triggered post-form submission.
