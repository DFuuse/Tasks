CREATE TABLE Candidate(
    ID INT IDENTITY PRIMARY KEY,
    Qualification VARCHAR(100),
    Experience VARCHAR(50),
    Name VARCHAR(100),
    ContactNo VARCHAR(15),
    Email VARCHAR(100),
    CTC DECIMAL(10,2),
    ECTC DECIMAL(10,2),
    NoticePeriod VARCHAR(50),
    AttachmentPath VARCHAR(255),
);

create PROCEDURE ICandidate
    @Qualification VARCHAR(100),
    @Experience VARCHAR(50),
    @Name VARCHAR(100),
    @ContactNo VARCHAR(15),
    @Email VARCHAR(100),
    @CTC DECIMAL(10,2) = null,
    @ECTC DECIMAL(10,2) = null,
    @NoticePeriod VARCHAR(50) = null,
    @AttachmentPath VARCHAR(255)
AS
BEGIN
    INSERT INTO Candidate
    (
        Qualification,
        Experience,
        Name,
        ContactNo,
        Email,
        CTC,
        ECTC,
        NoticePeriod,
        AttachmentPath
    )
    VALUES
    (
        @Qualification,
        @Experience,
        @Name,
        @ContactNo,
        @Email,
        @CTC,
        @ECTC,
        @NoticePeriod,
        @AttachmentPath
    );
END;

Select * from Candidate;

CREATE TABLE Schedule
(
    sid INT IDENTITY PRIMARY KEY,
    Dayy VARCHAR(100),
    Slot VARCHAR(100),
    Email VARCHAR(100)
);
Select * from Schedule;