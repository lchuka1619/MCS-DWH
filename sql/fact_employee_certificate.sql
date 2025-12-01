
-- =====================================================
-- FACT: Employee Certificates
-- =====================================================
CREATE TABLE dwh_hr.fact_employee_certificate (
    certificate_fact_key BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    employee_key BIGINT NOT NULL,
    certificate_key INT NOT NULL,
    certificate_type_key INT,
    
    certificate_number NVARCHAR(100),
    issue_date DATE,
    expiry_date DATE,
    
    notes NVARCHAR(MAX),
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_employee_certificate_id NVARCHAR(50),
    source_employee_id NVARCHAR(50),
    
    is_active BIT DEFAULT 1,
    is_expired BIT DEFAULT 0,
    
    source_created_date DATETIME2,
    source_updated_date DATETIME2,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT NOT NULL
);



-- Certificate indexes
CREATE INDEX IX_fact_employee_certificate_employee ON dwh_hr.fact_employee_certificate(employee_key);
CREATE INDEX IX_fact_employee_certificate_certificate ON dwh_hr.fact_employee_certificate(certificate_key);
CREATE INDEX IX_fact_employee_certificate_dates ON dwh_hr.fact_employee_certificate(issue_date, expiry_date);


-- =====================================================
-- SECTION 7: CERTIFICATE FACT TABLE FOREIGN KEYS
-- =====================================================

ALTER TABLE dwh_hr.fact_employee_certificate
ADD CONSTRAINT FK_fact_employee_certificate_employee 
    FOREIGN KEY (employee_key) REFERENCES dwh_hr.dim_employee(employee_key);

ALTER TABLE dwh_hr.fact_employee_certificate
ADD CONSTRAINT FK_fact_employee_certificate_certificate 
    FOREIGN KEY (certificate_key) REFERENCES dwh_hr.dim_certificate(certificate_key);

ALTER TABLE dwh_hr.fact_employee_certificate
ADD CONSTRAINT FK_fact_employee_certificate_certificate_type 
    FOREIGN KEY (certificate_type_key) REFERENCES dwh_hr.dim_certificate_type(certificate_type_key);