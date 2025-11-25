CREATE TABLE dwh_hr.dim_grade (
    grade_key INT IDENTITY(1,1) NOT NULL,
    grade_id INT NOT NULL,
    code NVARCHAR(50),
    grade_no INT,
    name NVARCHAR(255),
    is_active BIT NOT NULL DEFAULT 1,
    source_system_code NVARCHAR(50) NULL,
    source_created_date DATETIME NULL,
    source_updated_date DATETIME NULL,
    dw_created_date DATETIME NOT NULL DEFAULT (SYSDATETIME()),
    dw_updated_date DATETIME NOT NULL DEFAULT (SYSDATETIME()),
    
    CONSTRAINT PK_dim_grade PRIMARY KEY (grade_key),
    CONSTRAINT UQ_dim_grade_grade_id UNIQUE (grade_id)
);
GO

-- Auto-update dw_updated_date on update (SQL Server requires trigger)
CREATE TRIGGER trg_dim_grade_dw_updated_date
ON dwh_hr.dim_grade
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE d
    SET dw_updated_date = SYSDATETIME()
    FROM dwh_hr.dim_grade d
    INNER JOIN inserted i ON d.grade_key = i.grade_key;
END;
GO

ALTER TABLE dwh_hr.dim_grade
ADD CONSTRAINT uq_grade UNIQUE(grade_id);