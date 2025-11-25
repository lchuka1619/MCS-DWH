-- -- Core Employee Dimension Table (MySQL Syntax)
-- CREATE TABLE dim_employee (
--     -- Surrogate Key
--     employee_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    
--     -- Business Keys
--     source_system_code VARCHAR(50) NOT NULL,
--     source_employee_id VARCHAR(50) NOT NULL,
--     company_id INT,
--     employee_code VARCHAR(50),
--     registration_number VARCHAR(20), -- Регистрийн дугаар
    
--     -- Personal Information
--     family_name VARCHAR(100), -- Овог
--     last_name VARCHAR(100),   -- Эцэг/эхийн нэр
--     first_name VARCHAR(100), -- Нэр
--     gender VARCHAR(20), -- Эр/Эм
--     birth_date DATE,
--     nationality_id INT,
    
--     -- -- Employment Information
--     -- company_name VARCHAR(200) NOT NULL,
--     -- department_name VARCHAR(200),
--     -- position_title VARCHAR(200),
--     -- grade_level VARCHAR(20),
--     employment_status VARCHAR(50),
--     -- hire_date DATE,
--     -- termination_date DATE,
--     -- status_date DATE,
    
--     -- -- Contact Information
--     -- mobile_phone VARCHAR(50),
--     -- work_phone VARCHAR(50),
--     -- email VARCHAR(100),
--     -- email2 VARCHAR(100),
    
--     -- -- Address Information
--     -- country_id INT,
--     -- division_id INT,
--     -- district_id INT,
--     -- address_line1 VARCHAR(500),
    
--     -- Data Warehouse Management (SCD Type 2)
--     effective_start_date DATETIME DEFAULT CURRENT_TIMESTAMP,
--     effective_end_date DATETIME DEFAULT '9999-12-31 23:59:59',
--     is_current_record TINYINT(1) DEFAULT 1,
    
--     -- Source Tracking
--     source_created_date DATETIME,
--     source_updated_date DATETIME,
--     -- source_created_by VARCHAR(100),
--     -- source_updated_by VARCHAR(100),
    
--     -- ETL Metadata
--     dw_created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     dw_updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     etl_batch_id BIGINT,
    
--     -- Constraints
--     CONSTRAINT uq_employee_natural_key UNIQUE (
--         source_system_code, 
--         source_employee_id, 
--         effective_start_date
--     ),
    
--     INDEX idx_employee_company (company_id, is_current_record),
--     INDEX idx_employee_regno (registration_number),
--     INDEX idx_employee_status (employment_status, is_current_record),
--     INDEX idx_employee_effective_dates (effective_start_date, effective_end_date, is_current_record)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE dwh_hr.dim_employee (
    employee_key BIGINT IDENTITY(1,1) PRIMARY KEY,

    source_system_code NVARCHAR(50) NOT NULL,
    source_employee_id NVARCHAR(500),
    company_key INT,
    employee_code NVARCHAR(50),
    registration_number NVARCHAR(20), -- Регистрийн дугаар
    family_name NVARCHAR(100),         -- Овог
    last_name NVARCHAR(100),           -- Эцэг/эхийн нэр
    first_name NVARCHAR(100),          -- Нэр
    gender NVARCHAR(20),               -- Эр/Эм
    birth_date DATE,
    nationality_id INT,
    employment_status NVARCHAR(50),

    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,

    source_created_date DATETIME2,
    source_updated_date DATETIME2,
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    etl_batch_id BIGINT
);
GO

-- Natural Key Unique Constraint
ALTER TABLE dwh_hr.dim_employee
ADD CONSTRAINT uq_employee_natural_key 
UNIQUE (source_system_code, source_employee_id, effective_start_date);
GO

-- Indexes
CREATE INDEX idx_employee_company 
    ON dwh_hr.dim_employee (company_key, is_current_record);

CREATE INDEX idx_employee_regno 
    ON dwh_hr.dim_employee (registration_number);

CREATE INDEX idx_employee_status 
    ON dwh_hr.dim_employee (employment_status, is_current_record);

CREATE INDEX idx_employee_effective_dates 
    ON dwh_hr.dim_employee (effective_start_date, effective_end_date, is_current_record);
GO

select * from dwh_hr.dim_employee where source_employee_id = '18096'
-- drop table dwh_hr.dim_employee


select h.EMPID, e.source_employee_id from 

HRMS_PROD.TBLEMPEMPLHIST h 
, dwh_hr.dim_employee e
where str(h.EMPID) = str(e.source_employee_id)

select * from dwh_hr.dim_employee where source_employee_id = 6751