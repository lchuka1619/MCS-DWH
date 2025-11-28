CREATE TABLE dwh_hr.dim_company (
    company_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    company_code VARCHAR(50) NOT NULL,
    company_name NVARCHAR(200) NOT NULL,  -- NVARCHAR for Unicode support
    is_active BIT NOT NULL DEFAULT 1,
    source_system_code VARCHAR(50) NULL,
    source_created_date DATETIME NULL,
    source_updated_date DATETIME NULL,
    dw_created_date DATETIME NOT NULL DEFAULT GETDATE(),
    dw_updated_date DATETIME NOT NULL DEFAULT GETDATE()
);

-- create schema dwh_hr;
-- select * from dwh_hr.dim_company
-- delete from dwh_hr.dim_company where company_code='MCSPOWER';


-- select * from HRMS_PROD.SILEVEL
-- select * from HRMS_PROD.TBLCOMPANY
-- delete from HRMS_PROD.TBLCOMPANY where COMPANYID='MCSPOWER';

-- delete from HRMS_PROD.TBLCOMPANY 

-- ALTER TABLE HRMS_PROD.TBLCOMPANY
-- ALTER COLUMN COMPANYID NVARCHAR(10) NOT NULL;
-- GO

-- ALTER TABLE HRMS_PROD.TBLCOMPANY
-- ADD CONSTRAINT PK_TBLCOMPANY PRIMARY KEY (COMPANYID);
-- GO


-- -- Create user for ADF managed identity
-- CREATE USER [mcsh-data-factory] FROM EXTERNAL PROVIDER;

-- -- Grant read/write roles
-- ALTER ROLE db_datareader ADD MEMBER [mcsh-data-factory];
-- ALTER ROLE db_datawriter ADD MEMBER [mcsh-data-factory];

-- -- Connect as Azure AD admin
-- ALTER ROLE db_ddladmin ADD MEMBER [mcsh-data-factory];
-- -- or
-- ALTER ROLE db_owner ADD MEMBER [mcsh-data-factory];  -- full control


