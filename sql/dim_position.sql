CREATE TABLE dwh_hr.dim_position (
    position_key INT IDENTITY(1,1) PRIMARY KEY,

    source_system_code VARCHAR(50) NOT NULL,
    source_position_id VARCHAR(50) NOT NULL,
    company_key INT NOT NULL,

    position_code VARCHAR(50),
    position_name NVARCHAR(200) NOT NULL,
    position_category NVARCHAR(100), -- Удирдлага, Мэргэжилтэн, Ажилчин
    position_level VARCHAR(50),

    is_management BIT DEFAULT 0,
    is_active BIT DEFAULT 1,

    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT NOT NULL DEFAULT 1,

    dw_created_date DATETIME2 DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- Natural Key Unique Constraint
ALTER TABLE dwh_hr.dim_position
ADD CONSTRAINT uq_pos_natural_key 
UNIQUE (source_system_code, source_position_id, effective_start_date);
GO

-- Indexes
CREATE INDEX idx_company ON dwh_hr.dim_position (company_key);
CREATE INDEX idx_category ON dwh_hr.dim_position (position_category);
GO

-- drop table dbo.dim_company;
-- drop table dbo.dim_grade;
-- drop table dbo.dim_position;
-- drop table hr.dim_company;

-- DROP table dwh_hr.dim_position;

-- -- Grade Dimension
-- CREATE TABLE dim_grade (
--     grade_key INT AUTO_INCREMENT PRIMARY KEY,
--     source_system_code VARCHAR(50) NOT NULL,
--     source_grade_id VARCHAR(50) NOT NULL,
--     company_key INT NOT NULL,
--     grade_code VARCHAR(50),
--     grade_name VARCHAR(100),
--     grade_number INT, -- 1, 2, 3... 10
--     grade_description VARCHAR(500),
--     is_active TINYINT(1) DEFAULT 1,
    
--     dw_created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
--     dw_updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
--     UNIQUE KEY uq_grade_natural_key (source_system_code, source_grade_id),
--     INDEX idx_company (company_key)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -- Level Dimension (Дэв)
-- CREATE TABLE dim_level (
--     level_key INT AUTO_INCREMENT PRIMARY KEY,
--     source_system_code VARCHAR(50) NOT NULL,
--     source_level_id VARCHAR(50) NOT NULL,
--     company_key INT NOT NULL,
--     level_code VARCHAR(50),
--     level_name VARCHAR(100),
--     level_number INT, -- 0, 1, 2, 3...
--     level_description VARCHAR(500),
--     is_active TINYINT(1) DEFAULT 1,
    
--     dw_created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
--     dw_updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
--     UNIQUE KEY uq_level_natural_key (source_system_code, source_level_id),
--     INDEX idx_company (company_key)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -- Date Dimension (Time Dimension - Best Practice)
-- CREATE TABLE dim_date (
--     date_key INT PRIMARY KEY, -- YYYYMMDD format: 20250101
--     full_date DATE NOT NULL,
--     day_of_week INT, -- 1=Monday, 7=Sunday
--     day_name VARCHAR(20), -- Monday, Tuesday...
--     day_of_month INT,
--     day_of_year INT,
--     week_of_year INT,
--     month_number INT,
--     month_name VARCHAR(20),
--     month_abbr VARCHAR(3),
--     quarter_number INT,
--     quarter_name VARCHAR(2), -- Q1, Q2, Q3, Q4
--     year_number INT,
--     year_month INT, -- YYYYMM: 202501
--     year_quarter INT, -- YYYYQ: 20251
--     is_weekend TINYINT(1),
--     is_holiday TINYINT(1),
--     holiday_name VARCHAR(100),
--     fiscal_year INT,
--     fiscal_quarter INT,
--     fiscal_period INT,
    
--     INDEX idx_full_date (full_date),
--     INDEX idx_year_month (year_number, month_number),
--     INDEX idx_quarter (year_number, quarter_number)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;