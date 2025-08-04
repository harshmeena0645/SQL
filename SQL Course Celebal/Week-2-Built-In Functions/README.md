# 📚 Week 2 - Built-In Functions, Stored Procedures, Views, and Triggers

Welcome to **Week 2** of the SQL Internship at Celebal Technologies!  
This week covers advanced SQL features such as built-in functions, user-defined functions, stored procedures, views, and triggers using the **AdventureWorks2022** database.

---

## 🧠 Topics Covered

- Built-in String Functions  
- DateTime Functions  
- Cast and Convert Functions  
- Mathematical Functions 
- User Defined Functions (UDF) – Scalar Functions  
- Views in SQL Server  
- Updatable Views  
- Indexed Views  
- View Limitations  
- Stored Procedures  
- Triggers  

---

## 📝 Assignment - Level B Task

Tasks are to be implemented using the **AdventureWorks2022** database. The assignment consists of Stored Procedures, Functions, Views, and Triggers.

---

### 🔁 Stored Procedures

1. **InsertOrderDetails**  
   - Inserts order details with parameters: OrderID, ProductID, UnitPrice, Quantity, and Discount  
   - UnitPrice and Discount are optional (defaulted if not passed)  
   - Updates inventory accordingly  
   - Aborts if insufficient stock  
   - Notifies if stock drops below reorder level  

2. **UpdateOrderDetails**  
   - Updates Order Details values  
   - Parameters except OrderID and ProductID are optional  
   - Uses `ISNULL()` to retain original values if NULL is passed  
   - Adjusts stock accordingly  

3. **GetOrderDetails**  
   - Input: OrderID  
   - Fetches order details  
   - Prints message if OrderID not found:  
     `The OrderID XXXX does not exist.`  
   - Returns 1 if not found  

4. **DeleteOrderDetails**  
   - Input: OrderID and ProductID  
   - Validates parameters  
   - Deletes entry if valid  
   - Returns -1 and prints an error message if invalid  

---

### 🧮 Functions

1. Function to return `MM/DD/YYYY` format from a `datetime` input  
2. Function to return `YYYYMMDD` format from a `datetime` input  
> 💡 Use reference: [SQL Server Date Formats](http://www.sql-server-helper.com/tips/date-formats.aspx)

---

### 👁️ Views

1. **vwCustomerOrders**  
   - Displays: CompanyName, OrderID, OrderDate, ProductID, ProductName, Quantity, UnitPrice, Total = Quantity × UnitPrice  

2. **vwCustomerOrders (Filtered)**  
   - Same as above, but shows only **yesterday's orders**  

3. **MyProducts**  
   - Shows: ProductID, ProductName, QuantityPerUnit, UnitPrice  
   - Joins `Suppliers` for CompanyName and `Categories` for CategoryName  
   - Only non-discontinued products  

---

### 🧨 Triggers

1. **Instead Of DELETE Trigger** (on Orders Table)  
   - Deletes OrderDetails before deleting an Order  

2. **BEFORE INSERT Trigger** (on OrderDetails Table)  
   - Checks for sufficient stock  
   - Rejects insert with a message if stock is insufficient  
   - Reduces stock if sufficient  

---

✅ Make sure to test all procedures, functions, and triggers using the **AdventureWorks2022** database.
