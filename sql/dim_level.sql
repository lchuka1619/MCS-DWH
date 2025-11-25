
CREATE TABLE dwh_hr.dim_level (
    level_key INT IDENTITY(1,1) PRIMARY KEY,
    level_id INT NOT NULL,

    level_code NVARCHAR(50),
    level_name NVARCHAR(255),

    source_system_code NVARCHAR(50),
    source_created_date DATETIME2,
    source_updated_date DATETIME2,

    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

-- Unique constraint
ALTER TABLE dwh_hr.dim_level
ADD CONSTRAINT uq_level_id UNIQUE (level_id);
GO

drop table dwh_hr.dim_level