-- Position Dimension
CREATE TABLE dim_position (
    position_key INT AUTO_INCREMENT PRIMARY KEY,
    source_system_code VARCHAR(50) NOT NULL,
    source_position_id VARCHAR(50) NOT NULL,
    company_key INT NOT NULL,
    position_code VARCHAR(50),
    position_name VARCHAR(200) NOT NULL,
    position_category VARCHAR(100), -- Удирдлага, Мэргэжилтэн, Ажилчин
    position_level VARCHAR(50),
    is_management INT(1) DEFAULT 0,
    is_active INT(1) DEFAULT 1,
    
    effective_start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    effective_end_date DATETIME NOT NULL DEFAULT '9999-12-31 23:59:59',
    is_current_record INT(1) NOT NULL DEFAULT 1,
    
    dw_created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    dw_updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    UNIQUE KEY uq_pos_natural_key (source_system_code, source_position_id, effective_start_date),
    INDEX idx_company (company_key),
    INDEX idx_category (position_category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




-- Grade Dimension
CREATE TABLE dim_grade (
    grade_key INT AUTO_INCREMENT PRIMARY KEY,
    source_system_code VARCHAR(50) NOT NULL,
    source_grade_id VARCHAR(50) NOT NULL,
    company_key INT NOT NULL,
    grade_code VARCHAR(50),
    grade_name VARCHAR(100),
    grade_number INT, -- 1, 2, 3... 10
    grade_description VARCHAR(500),
    is_active TINYINT(1) DEFAULT 1,
    
    dw_created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    dw_updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    UNIQUE KEY uq_grade_natural_key (source_system_code, source_grade_id),
    INDEX idx_company (company_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Level Dimension (Дэв)
CREATE TABLE dim_level (
    level_key INT AUTO_INCREMENT PRIMARY KEY,
    source_system_code VARCHAR(50) NOT NULL,
    source_level_id VARCHAR(50) NOT NULL,
    company_key INT NOT NULL,
    level_code VARCHAR(50),
    level_name VARCHAR(100),
    level_number INT, -- 0, 1, 2, 3...
    level_description VARCHAR(500),
    is_active TINYINT(1) DEFAULT 1,
    
    dw_created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    dw_updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    UNIQUE KEY uq_level_natural_key (source_system_code, source_level_id),
    INDEX idx_company (company_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Date Dimension (Time Dimension - Best Practice)
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY, -- YYYYMMDD format: 20250101
    full_date DATE NOT NULL,
    day_of_week INT, -- 1=Monday, 7=Sunday
    day_name VARCHAR(20), -- Monday, Tuesday...
    day_of_month INT,
    day_of_year INT,
    week_of_year INT,
    month_number INT,
    month_name VARCHAR(20),
    month_abbr VARCHAR(3),
    quarter_number INT,
    quarter_name VARCHAR(2), -- Q1, Q2, Q3, Q4
    year_number INT,
    year_month INT, -- YYYYMM: 202501
    year_quarter INT, -- YYYYQ: 20251
    is_weekend TINYINT(1),
    is_holiday TINYINT(1),
    holiday_name VARCHAR(100),
    fiscal_year INT,
    fiscal_quarter INT,
    fiscal_period INT,
    
    INDEX idx_full_date (full_date),
    INDEX idx_year_month (year_number, month_number),
    INDEX idx_quarter (year_number, quarter_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;