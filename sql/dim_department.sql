-- -- Department Dimension
-- CREATE TABLE dim_department (
--     department_key INT AUTO_INCREMENT PRIMARY KEY,
    
--     source_system_code VARCHAR(50) NOT NULL,
--     source_department_id VARCHAR(50) NOT NULL,
--     company_key INT NOT NULL,
--     source_company_id VARCHAR(50) NOT NULL,
    
--     department_code VARCHAR(100),
--     department_name VARCHAR(200) NOT NULL,
--     department_type_id INT,
    
--     parent_department_key INT,
--     source_parent_id VARCHAR(50),
--     is_top_level TINYINT(1) DEFAULT 0,
    
--     department_path VARCHAR(1000),
--     department_path_ids VARCHAR(500),
--     department_level INT,
    
--     hierarchy_level1_dept_key INT,
--     hierarchy_level1_dept_name VARCHAR(200),
--     hierarchy_level1_dept_code VARCHAR(100),
    
--     hierarchy_level2_dept_key INT,
--     hierarchy_level2_dept_name VARCHAR(200),
--     hierarchy_level2_dept_code VARCHAR(100),
    
--     hierarchy_level3_dept_key INT,
--     hierarchy_level3_dept_name VARCHAR(200),
--     hierarchy_level3_dept_code VARCHAR(100),
    
--     hierarchy_level4_dept_key INT,
--     hierarchy_level4_dept_name VARCHAR(200),
--     hierarchy_level4_dept_code VARCHAR(100),
    
--     full_path_text TEXT,
    
--     is_active TINYINT(1) DEFAULT 1,
--     is_leaf_node TINYINT(1) DEFAULT 0,
--     child_count INT DEFAULT 0,
    
--     effective_start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     effective_end_date DATETIME NOT NULL DEFAULT '9999-12-31 23:59:59',
--     is_current_record TINYINT(1) NOT NULL DEFAULT 1,
    
--     source_created_date DATETIME,
--     source_updated_date DATETIME,
    
--     dw_created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     dw_updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     etl_batch_id BIGINT NOT NULL,
    
--     CONSTRAINT uq_dept_natural_key UNIQUE (
--         source_system_code,
--         source_department_id,
--         effective_start_date
--     ),
--     INDEX idx_company_active (company_key, is_active, is_current_record),
--     INDEX idx_parent (parent_department_key),
--     INDEX idx_dept_code (department_code, is_current_record),
--     INDEX idx_path_ids (department_path_ids(100)),
--     INDEX idx_dept_level (department_level, is_current_record),
--     INDEX idx_top_level (is_top_level, is_current_record),
--     INDEX idx_source_lookup (source_system_code, source_department_id, is_current_record)
-- )
-- --  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE dim_department (
    department_key INT AUTO_INCREMENT PRIMARY KEY,
    source_system_code VARCHAR(50) NOT NULL,
    source_department_id VARCHAR(50) NOT NULL,
    company_key INT NOT NULL,
    department_code VARCHAR(50),
    department_name VARCHAR(200) NOT NULL,
    -- parent_department_key INT,
    parent_department_key INT,
    department_level VARCHAR(50),
    is_active TINYINT(1) DEFAULT 1,
    
    effective_start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    effective_end_date DATETIME NOT NULL DEFAULT '9999-12-31 23:59:59',
    is_current_record TINYINT(1) NOT NULL DEFAULT 1,
    
    dw_created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    dw_updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    UNIQUE KEY uq_dept_natural_key (source_system_code, source_department_id, effective_start_date),
    INDEX idx_company (company_key),
    INDEX idx_parent (parent_department_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;