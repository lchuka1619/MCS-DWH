

-- =====================================================
-- DIMENSION: Certificate Type
-- =====================================================
CREATE TABLE dwh_hr.dim_certificate_type (
    certificate_type_key INT IDENTITY(1,1) PRIMARY KEY,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_certificate_type_id NVARCHAR(50),
    
    certificate_type_name NVARCHAR(200),
    certificate_type_code NVARCHAR(50),
    certificate_category NVARCHAR(100),
    
    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT
);

-- =====================================================
-- DIMENSION: Certificate
-- =====================================================
CREATE TABLE dwh_hr.dim_certificate (
    certificate_key INT IDENTITY(1,1) PRIMARY KEY,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_certificate_id NVARCHAR(50),
    certificate_type_key INT,
    
    certificate_name NVARCHAR(300),
    certificate_code NVARCHAR(50),
    
    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT
);


-- =====================================================
-- SECTION 9: DIMENSION TABLE FOREIGN KEYS
-- =====================================================



-- dim_certificate to dim_certificate_type
ALTER TABLE dwh_hr.dim_certificate
ADD CONSTRAINT FK_dim_certificate_certificate_type 
    FOREIGN KEY (certificate_type_key) REFERENCES dwh_hr.dim_certificate_type(certificate_type_key);