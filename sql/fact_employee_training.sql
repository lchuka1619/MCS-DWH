
-- =====================================================
-- FACT: Employee Training
-- =====================================================
CREATE TABLE dwh_hr.fact_employee_training (
    training_fact_key BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    employee_key BIGINT NOT NULL,
    training_key INT,
    training_provider_key INT,
    
    training_begin_date DATE,
    training_end_date DATE,
    
    required_hours INT,
    completed_hours INT,
    total_expense DECIMAL(18,2),
    expense_currency NVARCHAR(3) DEFAULT 'MNT',
    evaluation_score DECIMAL(5,2),
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_training_instance_id NVARCHAR(50),
    source_employee_training_id NVARCHAR(50),
    source_employee_id NVARCHAR(50),
    
    training_status NVARCHAR(50),      -- Completed, In Progress, Cancelled
    completion_rate DECIMAL(5,2),
    
    source_created_date DATETIME2,
    source_updated_date DATETIME2,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT NOT NULL
);


-- =====================================================
-- SECTION 3: TRAINING FACT TABLE FOREIGN KEYS
-- =====================================================

ALTER TABLE dwh_hr.fact_employee_training
ADD CONSTRAINT FK_fact_employee_training_employee 
    FOREIGN KEY (employee_key) REFERENCES dwh_hr.dim_employee(employee_key);

ALTER TABLE dwh_hr.fact_employee_training
ADD CONSTRAINT FK_fact_employee_training_training 
    FOREIGN KEY (training_key) REFERENCES dwh_hr.dim_training(training_key);

ALTER TABLE dwh_hr.fact_employee_training
ADD CONSTRAINT FK_fact_employee_training_provider 
    FOREIGN KEY (training_provider_key) REFERENCES dwh_hr.dim_training_provider(training_provider_key);

ALTER TABLE dwh_hr.fact_employee_training
ADD training_begin_date_key INT,
    training_end_date_key INT;