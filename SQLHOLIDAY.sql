
CREATE TABLE Holiday (
    hID INT IDENTITY(1,1) PRIMARY KEY,
    mID INT NOT NULL,   
    HolidayTitle VARCHAR(100),
    Date DATE,
    Status VARCHAR(50),

    FOREIGN KEY (mID) REFERENCES MasterEvent(mID)
);



CREATE TABLE MasterEvent (
    mID INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(100) UNIQUE NOT NULL,
    Color VARCHAR(50),
    Status VARCHAR(50)
);


Create PROCEDURE CRUDMasterEvent
(
    @Choice     VARCHAR(10),   
    @mID        INT = NULL,
    @EventName  VARCHAR(100) = NULL,
    @Color      VARCHAR(50) = NULL,
    @Status     VARCHAR(50) = NULL
)
AS
BEGIN

    IF @Choice = 'INSERT'
    BEGIN
        INSERT INTO MasterEvent (EventName, Color, Status)
        VALUES (@EventName, @Color, @Status);
    END

    ELSE IF @Choice = 'SELECT'
    BEGIN
        SELECT * FROM MasterEvent;
    END

    ELSE IF @Choice = 'SELECTBYID'
    BEGIN
        SELECT * FROM MasterEvent WHERE mID = @mID;
    END

 
    ELSE IF @Choice = 'UPDATE'
    BEGIN
        UPDATE MasterEvent
        SET EventName = @EventName,
            Color = @Color,
            Status = @Status
        WHERE mID = @mID;
    END


    ELSE IF @Choice = 'DELETE'
    BEGIN
        DELETE FROM MasterEvent WHERE mID = @mID;
    END

END

SELECT name 
FROM sys.procedures 
WHERE name = 'CRUDMasterEvent';



ALTER PROCEDURE CRUDHoliday
(
    @Choice        VARCHAR(15),
    @hID           INT = NULL,
    @mID           INT = NULL,
    @HolidayTitle  VARCHAR(200) = NULL,
    @Date          DATE = NULL,
    @Status        VARCHAR(50) = NULL
)
AS
BEGIN

    IF @Choice = 'INSERT'
    BEGIN
        INSERT INTO Holiday (mID, HolidayTitle, Date, Status)
        VALUES (@mID, @HolidayTitle, @Date, @Status);
    END

    
    ELSE IF @Choice = 'SELECT'
    BEGIN
        SELECT 
            h.hID,
            m.EventName AS EventType,
            h.HolidayTitle,
            h.Date,
            h.Status
        FROM Holiday h
        INNER JOIN MasterEvent m ON h.mID = m.mID;
    END

  
    ELSE IF @Choice = 'SELECTBYID'
    BEGIN
        SELECT * FROM Holiday WHERE hID = @hID;
    END

    
    ELSE IF @Choice = 'UPDATE'
    BEGIN
        UPDATE Holiday
        SET 
            mID = @mID,
            HolidayTitle = @HolidayTitle,
            Date = @Date,
            Status = @Status
        WHERE hID = @hID;
    END

  
    ELSE IF @Choice = 'DELETE'
    BEGIN
        DELETE FROM Holiday WHERE hID = @hID;
    END

END