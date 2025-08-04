# ⭐ Week 7 - Star & Snowflake Schema, Normalization, SCD Types

Welcome to **Week 7** of the SQL Internship at **Celebal Technologies**!  
This week emphasizes mastering **Data Warehouse modeling**, understanding **normalization vs denormalization**, and implementing **Slowly Changing Dimensions (SCD)** using robust SQL stored procedures.

---

## 🧠 Topics Covered

- 📊 **Star and Snowflake Schema**  
  Learn the fundamental structures used in dimensional modeling and how they optimize reporting and analytics.

- 🧱 **Normalization**  
  Understand the importance of removing data redundancy and achieving higher normal forms (1NF to 3NF).

- ⚠️ **Error Handling with TRY...CATCH**  
  Revisit structured error handling techniques to build reliable and fail-safe SQL scripts.

---

## 🧪 Assignment - Implement SCD Types

This week's practical assignment focuses on implementing various **Slowly Changing Dimension (SCD)** techniques — a critical component in data warehousing to manage historical data efficiently.

---

📁 **Folder:** `Week-7-Star and Snowflake Schema/`  
📄 **Assignment File:** `SCD_Types.sql`

### 🛠️ Tasks

Create SQL stored procedures for the following SCD types:

- 🔹 **SCD Type 0** – Retain original data (No updates allowed)  
- 🔹 **SCD Type 1** – Overwrite old data with new values  
- 🔹 **SCD Type 2** – Maintain full history by inserting a new row  
- 🔹 **SCD Type 3** – Track limited history using additional columns  
- 🔹 **SCD Type 4** – Archive historical changes in a separate table  
- 🔹 **SCD Type 6** – Hybrid approach combining Types 1, 2, and 3  

---

## 🎯 Learning Outcomes

- Design and differentiate between Star and Snowflake schemas  
- Apply normalization principles to optimize relational databases  
- Understand and implement various SCD strategies for data versioning  
- Develop modular and reusable stored procedures in SQL  
- Improve code reliability using TRY...CATCH error handling

---

🚀 Keep practicing and applying these techniques — they form the backbone of effective data warehousing and business intelligence solutions!
