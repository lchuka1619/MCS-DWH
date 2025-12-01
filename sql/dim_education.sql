-- =====================================================
-- DIMENSION: Education Level
-- =====================================================
CREATE TABLE dwh_hr.dim_education_level (
    
    education_level_key INT IDENTITY(1,1) PRIMARY KEY,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_education_level_id NVARCHAR(50),
    
    education_level_name NVARCHAR(200),
    education_level_code NVARCHAR(50),
    education_level_order INT,
    
    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT
);


-- =====================================================
-- SECTION 2: EDUCATION FACT TABLE FOREIGN KEYS
-- =====================================================

ALTER TABLE dwh_hr.fact_employee_education
ADD CONSTRAINT FK_fact_employee_education_employee 
    FOREIGN KEY (employee_key) REFERENCES dwh_hr.dim_employee(employee_key);

ALTER TABLE dwh_hr.fact_employee_education
ADD CONSTRAINT FK_fact_employee_education_education_level 
    FOREIGN KEY (education_level_key) REFERENCES dwh_hr.dim_education_level(education_level_key);

ALTER TABLE dwh_hr.fact_employee_education
ADD CONSTRAINT FK_fact_employee_education_university 
    FOREIGN KEY (university_key) REFERENCES dwh_hr.dim_university(university_key);

ALTER TABLE dwh_hr.fact_employee_education
ADD CONSTRAINT FK_fact_employee_education_profession 
    FOREIGN KEY (profession_key) REFERENCES dwh_hr.dim_profession(profession_key);

ALTER TABLE dwh_hr.fact_employee_education
ADD CONSTRAINT FK_fact_employee_education_country 
    FOREIGN KEY (country_key) REFERENCES dwh_hr.dim_country(country_key);