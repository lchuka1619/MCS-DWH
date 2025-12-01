
-- =====================================================
-- FACT: Employee Family Members
-- =====================================================
CREATE TABLE dwh_hr.fact_employee_family (
    family_fact_key BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    employee_key BIGINT NOT NULL,
    relationship_type_key INT NOT NULL,
    profession_key INT,
    
    family_last_name NVARCHAR(100),
    family_first_name NVARCHAR(100),
    family_registration_number NVARCHAR(20),
    birth_date DATE,
    
    organization_name NVARCHAR(300),
    job_title NVARCHAR(200),
    phone_number NVARCHAR(50),
    notes NVARCHAR(MAX),
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_family_id NVARCHAR(50),
    source_employee_id NVARCHAR(50),
    
    is_dependent BIT DEFAULT 0,
    is_emergency_contact BIT DEFAULT 0,
    
    source_created_date DATETIME2,
    source_updated_date DATETIME2,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT NOT NULL
);

-- Family indexes
CREATE INDEX IX_fact_employee_family_employee ON dwh_hr.fact_employee_family(employee_key);
CREATE INDEX IX_fact_employee_family_relationship ON dwh_hr.fact_employee_family(relationship_type_key);



-- =====================================================
-- SECTION 5: FAMILY FACT TABLE FOREIGN KEYS
-- =====================================================

ALTER TABLE dwh_hr.fact_employee_family
ADD CONSTRAINT FK_fact_employee_family_employee 
    FOREIGN KEY (employee_key) REFERENCES dwh_hr.dim_employee(employee_key);

ALTER TABLE dwh_hr.fact_employee_family
ADD CONSTRAINT FK_fact_employee_family_relationship 
    FOREIGN KEY (relationship_type_key) REFERENCES dwh_hr.dim_relationship_type(relationship_type_key);

ALTER TABLE dwh_hr.fact_employee_family
ADD CONSTRAINT FK_fact_employee_family_profession 
    FOREIGN KEY (profession_key) REFERENCES dwh_hr.dim_profession(profession_key);