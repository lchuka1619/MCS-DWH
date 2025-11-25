CREATE TABLE dwh_hr.dim_department (
    department_key INT IDENTITY(1,1) PRIMARY KEY,

    source_system_code NVARCHAR(50) NOT NULL,
    source_department_id NVARCHAR(50) NOT NULL,
    company_key INT NOT NULL,

    department_code NVARCHAR(50),
    department_name NVARCHAR(200) NOT NULL,

    parent_department_key INT,
    department_level NVARCHAR(50),

    is_active BIT DEFAULT 1,

    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT NOT NULL DEFAULT 1,

    dw_created_date DATETIME2 DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- Natural Key Unique Constraint
ALTER TABLE dwh_hr.dim_department
ADD CONSTRAINT uq_dept_natural_key
UNIQUE (source_system_code, source_department_id, effective_start_date);
GO

-- Indexes
CREATE INDEX idx_company ON dwh_hr.dim_department (company_key);
-- CREATE INDEX idx_parent ON dwh_hr.dim_department (parent_department_key);
GO


-- drop table dwh_hr.dim_department