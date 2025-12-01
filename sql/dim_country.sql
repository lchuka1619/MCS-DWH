
-- =====================================================
-- DIMENSION: Country
-- =====================================================
CREATE TABLE dwh_hr.dim_country (
    country_key INT IDENTITY(1,1) PRIMARY KEY,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_country_id NVARCHAR(50),
    
    country_name NVARCHAR(200),
    country_code NVARCHAR(10),
    region NVARCHAR(100),
    
    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT
);
