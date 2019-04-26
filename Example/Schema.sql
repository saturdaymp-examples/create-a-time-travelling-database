
CREATE DATABASE TemporalDemo
GO

USE TemporalDemo
GO

CREATE TABLE Customers
(
  Id        INT  NOT NULL IDENTITY PRIMARY KEY,
  RecordId  INT  NULL,
  StartDate DATE NOT NULL,
  EndDate   DATE NOT NULL,
  Name      VARCHAR(100)
)
GO

CREATE TRIGGER TR_Customers_OverlappingSegments ON Customers FOR UPDATE, INSERT AS
  IF EXISTS(
      SELECT *
      FROM Customers t
      INNER JOIN inserted i On i.RecordId = t.RecordId
        AND t.Id <> i.Id
        AND t.StartDate <= i.EndDate
        AND t.EndDate >= i.StartDate
    )
    BEGIN
      RAISERROR ('Tried to insert overlapping segments in Customers table.', 16, 1);
      ROLLBACK;
    END
GO

CREATE TRIGGER TR_Customers_UpdateRecordId ON Customers FOR INSERT AS
  UPDATE Customers
  SET RecordId = Id
  WHERE RecordId IS NULL
  AND ID IN (
    SELECT ID
    FROM inserted
  )
GO

CREATE TRIGGER TR_Customers_Addresses_ForeignKey_D ON Customers FOR DELETE AS
  IF NOT EXISTS(
    SELECT *
    FROM Customers
    Where RecordId IN (
      SELECT CustomerRecId
      FROM Addresses
      INNER JOIN deleted On deleted.RecordId = CustomerRecId
      )
    )
    BEGIN
      RAISERROR ('Tried to deleted Customers record that is referenced by Addresses forgien key.', 16, 1);
      ROLLBACK;
    END
GO


CREATE TABLE Addresses
(
  Id            INT  NOT NULL IDENTITY PRIMARY KEY,
  RecordId      INT  NULL,
  StartDate     DATE NOT NULL,
  EndDate       DATE NOT NULL,
  CustomerRecId INT  NOT NULL,
  Address       VARCHAR(200)
)
GO

CREATE TRIGGER TR_Addresses_OverlappingSegments ON Addresses FOR UPDATE, INSERT AS
  IF EXISTS(
      SELECT *
      FROM Addresses t
      INNER JOIN inserted i On i.RecordId = t.RecordId
        AND t.Id <> i.Id
        AND t.StartDate <= i.EndDate
        AND t.EndDate >= i.StartDate
    )
    BEGIN
      RAISERROR ('Tried to insert overlapping segments in Addresses table.', 16, 1);
      ROLLBACK;
    END
GO

CREATE TRIGGER TR_Addresses_UpdateRecordId ON Addresses FOR INSERT AS
  UPDATE Addresses
  SET RecordId = Id
  WHERE RecordId IS NULL
  AND ID IN (
    SELECT ID
    FROM inserted
  )
GO

CREATE TRIGGER TR_Addresses_Customers_ForeignKey_IU ON Addresses FOR INSERT, UPDATE AS
  IF NOT EXISTS(
    SELECT *
    FROM Customers
    Where RecordId IN (
      SELECT CustomerRecId
      FROM inserted
      )
    )
    BEGIN
      RAISERROR ('Tried to insert/update Addresses record that had a invalid forgien key to the Customers table.', 16, 1);
      ROLLBACK;
    END
GO
