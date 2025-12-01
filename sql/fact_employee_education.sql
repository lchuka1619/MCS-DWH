
-- =====================================================
-- FACT: Employee Education
-- =====================================================
CREATE TABLE dwh_hr.fact_employee_education (
    education_fact_key BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    employee_key BIGINT NOT NULL,
    education_level_key INT,
    university_key INT,
    profession_key INT,
    country_key INT,
    
    from_date DATE,
    to_date DATE,
    gpa DECIMAL(5,2),
    certificate_number NVARCHAR(100),
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_education_id NVARCHAR(50),
    source_employee_id NVARCHAR(50),
    
    is_highest_education BIT DEFAULT 0,
    education_duration_months INT,
    
    source_created_date DATETIME2,
    source_updated_date DATETIME2,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT NOT NULL
);
