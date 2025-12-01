CREATE TABLE dwh_hr.dim_date (
    date_key INT PRIMARY KEY,  -- Format: YYYYMMDD (e.g., 20250101)
    full_date DATE NOT NULL,
    
    -- Year attributes
    year INT,
    year_name NVARCHAR(10),  -- '2025'
    
    -- Quarter attributes
    quarter INT,  -- 1-4
    quarter_name NVARCHAR(10),  -- 'Q1 2025'
    
    -- Month attributes
    month_number INT,  -- 1-12
    month_name NVARCHAR(20),  -- 'January'
    month_name_short NVARCHAR(3),  -- 'Jan'
    month_year NVARCHAR(20),  -- 'January 2025'
    
    -- Week attributes
    week_of_year INT,
    week_of_month INT,
    
    -- Day attributes
    day_of_month INT,
    day_of_week INT,  -- 1-7 (Monday=1)
    day_name NVARCHAR(20),  -- 'Monday'
    day_name_short NVARCHAR(3),  -- 'Mon'
    
    -- Special flags
    is_weekend BIT,
    is_holiday BIT,
    holiday_name NVARCHAR(100),
    
    -- Fiscal calendar (if different from calendar year)
    fiscal_year INT,
    fiscal_quarter INT,
    fiscal_month INT,
    
    -- Mongolian calendar support
    lunar_month INT,
    is_tsagaan_sar BIT,  -- Mongolian New Year
    is_naadam BIT,
    
    -- Work day tracking
    is_working_day BIT,
    
    etl_batch_id BIGINT
);

-- Create indexes
CREATE INDEX IX_dim_date_full_date ON dwh_hr.dim_date(full_date);
CREATE INDEX IX_dim_date_year_month ON dwh_hr.dim_date(year, month_number);
CREATE INDEX IX_dim_date_fiscal ON dwh_hr.dim_date(fiscal_year, fiscal_quarter);