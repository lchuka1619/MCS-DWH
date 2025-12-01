
-- =====================================================
-- DIMENSION: Training
-- =====================================================
CREATE TABLE dwh_hr.dim_training (
    training_key INT IDENTITY(1,1) PRIMARY KEY,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_training_id NVARCHAR(50),
    
    training_name NVARCHAR(500),
    training_code NVARCHAR(50),
    training_class NVARCHAR(200),      -- Сургалтын төрөл
    training_mode NVARCHAR(100),       -- Сургалтын хэлбэр
    standard_duration_hours INT,
    training_category NVARCHAR(200),   -- Сургалтын ангилал
    
    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT
);

-- =====================================================
-- DIMENSION: Training Provider
-- =====================================================
CREATE TABLE dwh_hr.dim_training_provider (
    training_provider_key INT IDENTITY(1,1) PRIMARY KEY,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_provider_id NVARCHAR(50),
    
    provider_name NVARCHAR(300),
    provider_code NVARCHAR(50),
    provider_type NVARCHAR(100),
    
    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT
);
