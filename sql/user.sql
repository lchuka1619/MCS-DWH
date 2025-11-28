USE master;
GO
CREATE LOGIN shijirbum WITH PASSWORD = 'StrongP@ssw0rd!';
GO

CREATE USER shijirbum FOR LOGIN shijirbum;


-- base access
ALTER ROLE db_datareader ADD MEMBER shijirbum;
ALTER ROLE db_datawriter ADD MEMBER shijirbum;

-- controlled DDL
GRANT ALTER, CONTROL, REFERENCES ON SCHEMA::dwh_hr TO shijirbum;
GRANT CREATE TABLE TO shijirbum;
GRANT CREATE VIEW TO shijirbum;
GRANT CREATE PROCEDURE TO shijirbum;
-- GRANT CREATE INDEX TO shijirbum;

