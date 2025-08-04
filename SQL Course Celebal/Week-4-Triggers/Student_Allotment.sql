-- Task : Student Allotment SQL Problem

CREATE DATABASE SubjectAllotmentDB;
GO

USE SubjectAllotmentDB;
GO

-- 1. StudentDetails
CREATE TABLE StudentDetails (
    StudentId VARCHAR(20) PRIMARY KEY,
    StudentName VARCHAR(100),
    GPA DECIMAL(3,1),
    Branch VARCHAR(50),
    Section CHAR(1)
);

-- 2. SubjectDetails
CREATE TABLE SubjectDetails (
    SubjectId VARCHAR(20) PRIMARY KEY,
    SubjectName VARCHAR(100),
    MaxSeats INT,
    RemainingSeats INT
);

-- 3. StudentPreference
CREATE TABLE StudentPreference (
    StudentId VARCHAR(20),
    SubjectId VARCHAR(20),
    Preference INT CHECK (Preference BETWEEN 1 AND 5),
    PRIMARY KEY (StudentId, Preference),
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId),
    FOREIGN KEY (SubjectId) REFERENCES SubjectDetails(SubjectId)
);

-- 4. Allotments
CREATE TABLE Allotments (
    SubjectId VARCHAR(20),
    StudentId VARCHAR(20),
    FOREIGN KEY (SubjectId) REFERENCES SubjectDetails(SubjectId),
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId)
);

-- 5. UnallottedStudents
CREATE TABLE UnallottedStudents (
    StudentId VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId)
);



INSERT INTO StudentDetails VALUES 
('159103036', 'Mohit Agarwal', 8.9, 'CCE', 'A'),
('159103037', 'Rohit Agarwal', 5.2, 'CCE', 'A'),
('159103038', 'Shohit Garg', 7.1, 'CCE', 'B'),
('159103039', 'Mrinal Malhotra', 7.9, 'CCE', 'A'),
('159103040', 'Mehreet Singh', 5.6, 'CCE', 'A'),
('159103041', 'Arjun Tehlan', 9.2, 'CCE', 'B');


INSERT INTO SubjectDetails VALUES 
('PO1491', 'Basics of Political Science', 60, 2),
('PO1492', 'Basics of Accounting', 120, 119),
('PO1493', 'Basics of Financial Markets', 90, 90),
('PO1494', 'Eco philosophy', 60, 50),
('PO1495', 'Automotive Trends', 60, 60);


INSERT INTO StudentPreference VALUES
('159103036', 'PO1491', 1),
('159103036', 'PO1492', 2),
('159103036', 'PO1493', 3),
('159103036', 'PO1494', 4),
('159103036', 'PO1495', 5);



DROP PROCEDURE IF EXISTS AllocateSubjects;
GO

CREATE PROCEDURE AllocateSubjects
AS
BEGIN
    DECLARE @StudentId VARCHAR(20),
            @GPA DECIMAL(3,1),
            @SubjectId VARCHAR(20),
            @RemainingSeats INT,
            @Preference INT,
            @Allocated BIT;

    DECLARE student_cursor CURSOR FOR
    SELECT StudentId, GPA FROM StudentDetails ORDER BY GPA DESC;

    OPEN student_cursor;
    FETCH NEXT FROM student_cursor INTO @StudentId, @GPA;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Preference = 1;
        SET @Allocated = 0;

        WHILE @Preference <= 5 AND @Allocated = 0
        BEGIN
            SELECT @SubjectId = SubjectId
            FROM StudentPreference
            WHERE StudentId = @StudentId AND Preference = @Preference;

            IF @SubjectId IS NOT NULL
            BEGIN
                SELECT @RemainingSeats = RemainingSeats
                FROM SubjectDetails
                WHERE SubjectId = @SubjectId;

                IF @RemainingSeats > 0
                BEGIN
                    INSERT INTO Allotments (SubjectId, StudentId)
                    VALUES (@SubjectId, @StudentId);

                    UPDATE SubjectDetails
                    SET RemainingSeats = RemainingSeats - 1
                    WHERE SubjectId = @SubjectId;

                    SET @Allocated = 1;
                END
            END

            SET @Preference = @Preference + 1;
        END

       IF @Allocated = 0
BEGIN
    IF NOT EXISTS (SELECT 1 FROM UnallottedStudents WHERE StudentId = @StudentId)
    BEGIN
        INSERT INTO UnallottedStudents (StudentId)
        VALUES (@StudentId);
    END
END


        FETCH NEXT FROM student_cursor INTO @StudentId, @GPA;
    END

    CLOSE student_cursor;
    DEALLOCATE student_cursor;
END;
GO


-- Execute the Procedure
EXEC AllocateSubjects;


-- Check Results

-- Check alloted students
SELECT * FROM Allotments;

-- Check unallotted students
SELECT * FROM UnallottedStudents;

-- Check remaining seats in subjects
SELECT * FROM SubjectDetails;
