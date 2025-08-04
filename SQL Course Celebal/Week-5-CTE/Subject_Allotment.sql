-- Task : Subject Allotment Request Handling and History Tracking Using Stored Procedure

-- Create a new database
CREATE DATABASE SubjectAllotmentDB;


-- use database
USE SubjectAllotmentDB;

-- Create SubjectAllotments table
CREATE TABLE SubjectAllotments (
    StudentId VARCHAR(50),
    SubjectId VARCHAR(50),
    Is_valid BIT
);

-- Create SubjectRequest table
CREATE TABLE SubjectRequest (
    StudentId VARCHAR(50),
    SubjectId VARCHAR(50)
);


-- Insert sample data into SubjectAllotments (1 active, others inactive)
INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
VALUES
('159103036', 'P01491', 1),  -- Active
('159103036', 'P01492', 0),
('159103036', 'P01493', 0),
('159103036', 'P01494', 0),
('159103036', 'P01495', 0);


-- Insert request for new subject
INSERT INTO SubjectRequest (StudentId, SubjectId)
VALUES
('159103036', 'P01496');  -- New requested subject


-- Create stored procedure to process requests
CREATE PROCEDURE HandleSubjectRequests
AS
BEGIN
    SET NOCOUNT ON;

	-- Declare variables to hold values from SubjectRequest
    DECLARE @StudentId VARCHAR(50);
    DECLARE @RequestedSubjectId VARCHAR(50);
    DECLARE @CurrentSubjectId VARCHAR(50);

	-- Cursor to iterate through all requests
    DECLARE request_cursor CURSOR FOR
    SELECT StudentId, SubjectId FROM SubjectRequest;

    OPEN request_cursor;
    FETCH NEXT FROM request_cursor INTO @StudentId, @RequestedSubjectId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Check if the student exists in SubjectAllotments
        IF EXISTS (SELECT 1 FROM SubjectAllotments WHERE StudentId = @StudentId)
        BEGIN
            -- Get current active subject
            SELECT @CurrentSubjectId = SubjectId
            FROM SubjectAllotments
            WHERE StudentId = @StudentId AND Is_valid = 1;

            -- If requested subject is different from current active subject
            IF @CurrentSubjectId <> @RequestedSubjectId
            BEGIN
                -- Invalidate current subject
                UPDATE SubjectAllotments
                SET Is_valid = 0
                WHERE StudentId = @StudentId AND Is_valid = 1;

                -- Insert new subject as valid
                INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
                VALUES (@StudentId, @RequestedSubjectId, 1);
            END
            -- If same subject is requested, do nothing
        END
        ELSE
        BEGIN
            -- Student not found in SubjectAllotments, insert directly
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
            VALUES (@StudentId, @RequestedSubjectId, 1);
        END

        FETCH NEXT FROM request_cursor INTO @StudentId, @RequestedSubjectId;
    END

    CLOSE request_cursor;
    DEALLOCATE request_cursor;
END;


--  Execute the procedure to process subject changes
EXEC HandleSubjectRequests;

--  View updated allotments for the student
SELECT * FROM SubjectAllotments
WHERE StudentId = '159103036';
