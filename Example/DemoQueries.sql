--
-- Clean up the table.
--
DELETE
FROM Customers;
GO

--
-- First record inserted, does not need record ID as it will
-- be set to the ID.
--
INSERT INTO Customers (StartDate, EndDate, Name)
VALUES ('2000-01-01', '2000-12-31', 'Chronos')

SELECT *
FROM Customers;

DECLARE @recId INT
SELECT @recId = SCOPE_IDENTITY()

--
-- All of the below are overlapping segments and shouldn't
-- be inserted.
--
BEGIN TRY
  INSERT INTO Customers (RecordId, StartDate, EndDate, Name)
  VALUES (@recId, '1999-06-01', '2000-06-30', 'Overlap Start')
END TRY
BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
  INSERT INTO Customers (RecordId, StartDate, EndDate, Name)
  VALUES (@recId, '2000-03-01', '2000-10-31', 'Overlap Inside')
END TRY
BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
  INSERT INTO Customers (RecordId, StartDate, EndDate, Name)
  VALUES (@recId, '2000-06-01', '2001-06-30', 'Overlap End')
END TRY
BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
  INSERT INTO Customers (RecordId, StartDate, EndDate, Name)
  VALUES (@recId, '1999-06-01', '2001-06-30', 'Overlap Outside')
END TRY
BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH

--
-- Segments before and after the above record can be inserted.
--
INSERT INTO Customers (RecordId, StartDate, EndDate, Name)
VALUES (@recId, '1999-01-01', '1999-12-31', 'Before')

INSERT INTO Customers (RecordId, StartDate, EndDate, Name)
VALUES (@recId, '2001-01-01', '2001-12-31', 'After')

--
-- See what the table contains.
--
SELECT *
FROM Customers;



--
-- Add an address.
--
INSERT INTO Addresses (StartDate, EndDate, CustomerRecId, Address)
VALUES ('2000-01-01', '2000-12-31', #, '1234-12 Street')

--
-- Try to add an address with an invalid Customers foreign key.
--
INSERT INTO Addresses (StartDate, EndDate, CustomerRecId, Address)
VALUES ('2000-01-01', '2000-12-31', #, '1234-12 Street')

--
-- Show what is in the table.
--
Select *
FROM Addresses

--
-- Try to delete Customers segments.  All but the last
-- should be deleted.
--
DELETE FROM Customers WHERE ID = 41
DELETE FROM Customers WHERE ID = 46
DELETE FROM Customers WHERE ID = 47