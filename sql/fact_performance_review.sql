
-- =====================================================
-- FACT: Performance Reviews (PST Score)
-- =====================================================
CREATE TABLE dwh_hr.fact_performance_review (
    performance_review_key BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    employee_key BIGINT NOT NULL,
    company_key INT,
    department_key INT,
    position_key INT,
    
    review_date DATE NOT NULL,
    review_period_start DATE,
    review_period_end DATE,
    
    review_type NVARCHAR(100),         -- Periodic, Annual, Probation, etc.
    review_score DECIMAL(5,2),
    rating NVARCHAR(50),               -- Excellent, Good, Satisfactory, etc.
    
    feedback_text NVARCHAR(MAX),
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_review_id NVARCHAR(50),
    source_employee_id NVARCHAR(50),
    
    reviewer_employee_key BIGINT,
    
    source_created_date DATETIME2,
    source_updated_date DATETIME2,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT NOT NULL
);


-- Performance review indexes
CREATE INDEX IX_fact_performance_review_employee ON dwh_hr.fact_performance_review(employee_key);
CREATE INDEX IX_fact_performance_review_date ON dwh_hr.fact_performance_review(review_date);


-- =====================================================
-- SECTION 8: PERFORMANCE REVIEW FACT TABLE FOREIGN KEYS
-- =====================================================

ALTER TABLE dwh_hr.fact_performance_review
ADD CONSTRAINT FK_fact_performance_review_employee 
    FOREIGN KEY (employee_key) REFERENCES dwh_hr.dim_employee(employee_key);

ALTER TABLE dwh_hr.fact_performance_review
ADD CONSTRAINT FK_fact_performance_review_company 
    FOREIGN KEY (company_key) REFERENCES dwh_hr.dim_company(company_key);

ALTER TABLE dwh_hr.fact_performance_review
ADD CONSTRAINT FK_fact_performance_review_department 
    FOREIGN KEY (department_key) REFERENCES dwh_hr.dim_department(department_key);

ALTER TABLE dwh_hr.fact_performance_review
ADD CONSTRAINT FK_fact_performance_review_position 
    FOREIGN KEY (position_key) REFERENCES dwh_hr.dim_position(position_key);

ALTER TABLE dwh_hr.fact_performance_review
ADD CONSTRAINT FK_fact_performance_review_reviewer 
    FOREIGN KEY (reviewer_employee_key) REFERENCES dwh_hr.dim_employee(employee_key);

    

-- =====================================================
-- COMMENTS
-- =====================================================
-- These tables follow the same design patterns as your existing tables:
-- 1. SCD Type 2 for dimensions (effective dates, is_current_record)
-- 2. Consistent naming conventions (_key for surrogate keys)
-- 3. Source system tracking (source_system_code, source_*_id)
-- 4. Audit columns (dw_created_date, dw_updated_date, etl_batch_id)
-- 5. Proper indexing on foreign keys and date columns
-- 6. Support for both Mongolian and English field names where relevant