 --Task 17: Create a User, Create a Login, and Grant db_owner Role

-- Step 1: Create Login at the Server Level
CREATE LOGIN UserKrishnaLogin
WITH PASSWORD = 'Krishna@8318';  

-- Step 2: Use your target database or create one
CREATE DATABASE KrishnaDB;
USE KrishnaDB;

-- Step 3: Create a database user for the login in the selected DB
CREATE USER UserKrishna FOR LOGIN UserKrishnaLogin;

-- Step 4: Grant db_owner permission to the user in this database
EXEC sp_addrolemember 'db_owner', 'UserKrishna';


-- List all users in current DB
SELECT name, type_desc FROM sys.database_principals;

-- List members of db_owner
EXEC sp_helprolemember 'db_owner';
