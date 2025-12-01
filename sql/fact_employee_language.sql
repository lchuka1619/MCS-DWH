

-- =====================================================
-- FACT: Employee Language Skills
-- =====================================================
CREATE TABLE dwh_hr.fact_employee_language (
    language_fact_key BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    employee_key BIGINT NOT NULL,
    language_key INT NOT NULL,
    
    listening_level NVARCHAR(50),
    speaking_level NVARCHAR(50),
    reading_level NVARCHAR(50),
    writing_level NVARCHAR(50),
    
    test_name NVARCHAR(100),           -- IELTS, JLPT, etc.
    test_score DECIMAL(5,2),
    test_date DATE,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_language_skill_id NVARCHAR(50),
    source_employee_id NVARCHAR(50),
    
    overall_proficiency_level NVARCHAR(50),  -- Calculated from 4 skills
    
    source_created_date DATETIME2,
    source_updated_date DATETIME2,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT NOT NULL
);

-- Language indexes
CREATE INDEX IX_fact_employee_language_employee ON dwh_hr.fact_employee_language(employee_key);
CREATE INDEX IX_fact_employee_language_language ON dwh_hr.fact_employee_language(language_key);



-- =====================================================
-- SECTION 4: LANGUAGE FACT TABLE FOREIGN KEYS
-- =====================================================

ALTER TABLE dwh_hr.fact_employee_language
ADD CONSTRAINT FK_fact_employee_language_employee 
    FOREIGN KEY (employee_key) REFERENCES dwh_hr.dim_employee(employee_key);

ALTER TABLE dwh_hr.fact_employee_language
ADD CONSTRAINT FK_fact_employee_language_language 
    FOREIGN KEY (language_key) REFERENCES dwh_hr.dim_language(language_key);