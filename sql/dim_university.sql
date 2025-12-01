
-- =====================================================
-- DIMENSION: University
-- =====================================================
CREATE TABLE dwh_hr.dim_university (
    university_key INT IDENTITY(1,1) PRIMARY KEY,
    
    source_system_code NVARCHAR(50) NOT NULL,
    source_university_id NVARCHAR(50),
    
    university_name NVARCHAR(300),
    university_code NVARCHAR(50),
    country_key INT,
    
    effective_start_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    effective_end_date DATETIME2 NOT NULL DEFAULT ('9999-12-31T23:59:59'),
    is_current_record BIT DEFAULT 1,
    
    dw_created_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    dw_updated_date DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    
    etl_batch_id BIGINT
);


-- dim_university to dim_country
ALTER TABLE dwh_hr.dim_university
ADD CONSTRAINT FK_dim_university_country 
    FOREIGN KEY (country_key) REFERENCES dwh_hr.dim_country(country_key);