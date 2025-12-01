
-- =====================================================
-- DIMENSION: Language
-- =====================================================
CREATE TABLE dwh_hr.dim_language (
    language_key INT IDENTITY(1,1) PRIMARY KEY,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_language_id NVARCHAR(50),
    
    language_name NVARCHAR(100),
    language_code NVARCHAR(10),
    
    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT
);
