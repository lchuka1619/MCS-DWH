
CREATE TABLE dwh_hr.fact_employee_history (
    history_fact_key BIGINT IDENTITY(1,1) PRIMARY KEY,

    employee_key BIGINT, -- uncomment when FK ready
    company_key INT,
    department_key INT,
    position_key INT,
    grade_key INT,
    level_key INT,

    begin_date DATE NULL,
    end_date DATE,

    source_system_code NVARCHAR(50) NOT NULL,
    source_history_id NVARCHAR(50),
    source_employee_id NVARCHAR(50)  NULL,
    source_order_id NVARCHAR(50),

    order_type NVARCHAR(50),
    order_number NVARCHAR(100),
    level_number INT,

    base_wage DECIMAL(18,2),
    base_wage_currency NVARCHAR(3) DEFAULT 'MNT',

    insurance_type_id INT,
    labour_condition NVARCHAR(100),

    is_current_position BIT DEFAULT 0,
    is_active_employment BIT DEFAULT 1,

    source_created_date DATETIME2,
    source_updated_date DATETIME2,

    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    etl_batch_id BIGINT NOT NULL
);
GO
ALTER TABLE dwh_hr.fact_employee_history
ADD CONSTRAINT fk_fact_dim_employee
FOREIGN KEY (employee_key)
REFERENCES dwh_hr.dim_employee(employee_key);

ALTER TABLE dwh_hr.fact_employee_history
ADD CONSTRAINT fk_fact_dim_company
FOREIGN KEY (company_key)
REFERENCES dwh_hr.dim_company (company_key);


ALTER TABLE dwh_hr.fact_employee_history
ADD CONSTRAINT fk_fact_dim_department
FOREIGN KEY (department_key)
REFERENCES dwh_hr.dim_department (department_key);

ALTER TABLE dwh_hr.fact_employee_history
ADD CONSTRAINT fk_fact_dim_position
FOREIGN KEY (position_key)
REFERENCES dwh_hr.dim_position (position_key);

ALTER TABLE dwh_hr.fact_employee_history
ADD CONSTRAINT fk_fact_dim_grade
FOREIGN KEY (grade_key)
REFERENCES dwh_hr.dim_grade (grade_key);

ALTER TABLE dwh_hr.fact_employee_history
ADD CONSTRAINT fk_fact_dim_level
FOREIGN KEY (level_key)
REFERENCES dwh_hr.dim_level (level_key);

-- Add date foreign keys to fact tables
ALTER TABLE dwh_hr.fact_employee_history 
ADD begin_date_key INT,
    end_date_key INT;



-- Add foreign key constraints
ALTER TABLE dwh_hr.fact_employee_history
ADD CONSTRAINT FK_fact_employee_history_begin_date 
    FOREIGN KEY (begin_date_key) REFERENCES dwh_hr.dim_date(date_key);


CREATE INDEX idx_fact_emp_employee_key ON dwh_hr.fact_employee_history(employee_key);
CREATE INDEX idx_fact_emp_company_key ON dwh_hr.fact_employee_history(company_key);
CREATE INDEX idx_fact_emp_department_key ON dwh_hr.fact_employee_history(department_key);
CREATE INDEX idx_fact_emp_position_key ON dwh_hr.fact_employee_history(position_key);
CREATE INDEX idx_fact_emp_level_key ON dwh_hr.fact_employee_history(level_key);


select * from dwh_hr.fact_employee_history where company_key is null



-- drop table dwh_hr.fact_employee_history

-- alter table employee_key

-- select * from HRMS_PROD.TBLEMPEMPLHIST where BEGINDATE is NULL
