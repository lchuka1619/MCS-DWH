
-- =====================================================
-- FACT: Employee Awards
-- =====================================================
CREATE TABLE dwh_hr.fact_employee_award (
    award_fact_key BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    employee_key BIGINT NOT NULL,
    company_key INT,
    award_type_key INT,
    
    award_date DATE,
    award_amount DECIMAL(18,2),
    award_currency NVARCHAR(3) DEFAULT 'MNT',
    
    awarding_organization NVARCHAR(300),
    award_reason NVARCHAR(500),
    award_notes NVARCHAR(MAX),
    order_number NVARCHAR(100),
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_award_id NVARCHAR(50),
    source_order_id NVARCHAR(50),
    source_employee_id NVARCHAR(50),
    
    source_created_date DATETIME2,
    source_updated_date DATETIME2,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT NOT NULL
);


-- Award indexes
CREATE INDEX IX_fact_employee_award_employee ON dwh_hr.fact_employee_award(employee_key);
CREATE INDEX IX_fact_employee_award_date ON dwh_hr.fact_employee_award(award_date);
CREATE INDEX IX_fact_employee_award_type ON dwh_hr.fact_employee_award(award_type_key);


-- =====================================================
-- SECTION 6: AWARD FACT TABLE FOREIGN KEYS
-- =====================================================

ALTER TABLE dwh_hr.fact_employee_award
ADD CONSTRAINT FK_fact_employee_award_employee 
    FOREIGN KEY (employee_key) REFERENCES dwh_hr.dim_employee(employee_key);

ALTER TABLE dwh_hr.fact_employee_award
ADD CONSTRAINT FK_fact_employee_award_company 
    FOREIGN KEY (company_key) REFERENCES dwh_hr.dim_company(company_key);

ALTER TABLE dwh_hr.fact_employee_award
ADD CONSTRAINT FK_fact_employee_award_award_type 
    FOREIGN KEY (award_type_key) REFERENCES dwh_hr.dim_award_type(award_type_key);