
-- =====================================================
-- SECTION 11: UNIQUE CONSTRAINTS
-- =====================================================

-- Ensure no duplicate source records in dimensions
ALTER TABLE dwh_hr.dim_employee
ADD CONSTRAINT UQ_dim_employee_source 
    UNIQUE (source_system_code, source_employee_id, effective_start_date);

ALTER TABLE dwh_hr.dim_company
ADD CONSTRAINT UQ_dim_company_source 
    UNIQUE (source_system_code, source_company_id, effective_start_date);

ALTER TABLE dwh_hr.dim_department
ADD CONSTRAINT UQ_dim_department_source 
    UNIQUE (source_system_code, source_department_id, effective_start_date);

ALTER TABLE dwh_hr.dim_position
ADD CONSTRAINT UQ_dim_position_source 
    UNIQUE (source_system_code, source_position_id, effective_start_date);

ALTER TABLE dwh_hr.dim_education_level
ADD CONSTRAINT UQ_dim_education_level_source 
    UNIQUE (source_system_code, source_education_level_id, effective_start_date);

ALTER TABLE dwh_hr.dim_university
ADD CONSTRAINT UQ_dim_university_source 
    UNIQUE (source_system_code, source_university_id, effective_start_date);

ALTER TABLE dwh_hr.dim_profession
ADD CONSTRAINT UQ_dim_profession_source 
    UNIQUE (source_system_code, source_profession_id, effective_start_date);

ALTER TABLE dwh_hr.dim_country
ADD CONSTRAINT UQ_dim_country_source 
    UNIQUE (source_system_code, source_country_id, effective_start_date);

ALTER TABLE dwh_hr.dim_training
ADD CONSTRAINT UQ_dim_training_source 
    UNIQUE (source_system_code, source_training_id, effective_start_date);

ALTER TABLE dwh_hr.dim_training_provider
ADD CONSTRAINT UQ_dim_training_provider_source 
    UNIQUE (source_system_code, source_provider_id, effective_start_date);

ALTER TABLE dwh_hr.dim_language
ADD CONSTRAINT UQ_dim_language_source 
    UNIQUE (source_system_code, source_language_id, effective_start_date);

ALTER TABLE dwh_hr.dim_relationship_type
ADD CONSTRAINT UQ_dim_relationship_type_source 
    UNIQUE (source_system_code, source_relationship_id, effective_start_date);

ALTER TABLE dwh_hr.dim_award_type
ADD CONSTRAINT UQ_dim_award_type_source 
    UNIQUE (source_system_code, source_award_type_id, effective_start_date);

ALTER TABLE dwh_hr.dim_certificate_type
ADD CONSTRAINT UQ_dim_certificate_type_source 
    UNIQUE (source_system_code, source_certificate_type_id, effective_start_date);

ALTER TABLE dwh_hr.dim_certificate
ADD CONSTRAINT UQ_dim_certificate_source 
    UNIQUE (source_system_code, source_certificate_id, effective_start_date);

-- Ensure only one current record per source entity
CREATE UNIQUE INDEX UQ_dim_employee_current 
    ON dwh_hr.dim_employee(source_system_code, source_employee_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_company_current 
    ON dwh_hr.dim_company(source_system_code, source_company_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_department_current 
    ON dwh_hr.dim_department(source_system_code, source_department_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_position_current 
    ON dwh_hr.dim_position(source_system_code, source_position_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_education_level_current 
    ON dwh_hr.dim_education_level(source_system_code, source_education_level_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_university_current 
    ON dwh_hr.dim_university(source_system_code, source_university_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_profession_current 
    ON dwh_hr.dim_profession(source_system_code, source_profession_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_country_current 
    ON dwh_hr.dim_country(source_system_code, source_country_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_training_current 
    ON dwh_hr.dim_training(source_system_code, source_training_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_training_provider_current 
    ON dwh_hr.dim_training_provider(source_system_code, source_provider_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_language_current 
    ON dwh_hr.dim_language(source_system_code, source_language_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_relationship_type_current 
    ON dwh_hr.dim_relationship_type(source_system_code, source_relationship_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_award_type_current 
    ON dwh_hr.dim_award_type(source_system_code, source_award_type_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_certificate_type_current 
    ON dwh_hr.dim_certificate_type(source_system_code, source_certificate_type_id)
    WHERE is_current_record = 1;

CREATE UNIQUE INDEX UQ_dim_certificate_current 
    ON dwh_hr.dim_certificate(source_system_code, source_certificate_id)
    WHERE is_current_record = 1;

-- =====================================================
-- SECTION 12: DEFAULT CONSTRAINTS
-- =====================================================

-- Set default values for common columns if not already set during table creation
-- (Most defaults should already be set in CREATE TABLE statements)

-- Ensure currency defaults
ALTER TABLE dwh_hr.fact_employee_history
ADD CONSTRAINT DF_fact_employee_history_currency 
    DEFAULT 'MNT' FOR base_wage_currency;

ALTER TABLE dwh_hr.fact_employee_training
ADD CONSTRAINT DF_fact_employee_training_currency 
    DEFAULT 'MNT' FOR expense_currency;

ALTER TABLE dwh_hr.fact_employee_award
ADD CONSTRAINT DF_fact_employee_award_currency 
    DEFAULT 'MNT' FOR award_currency;



-- =====================================================
-- SECTION 13: VERIFICATION QUERIES
-- =====================================================

-- Run these queries to verify all constraints are created successfully

-- View all foreign keys
SELECT 
    fk.name AS foreign_key_name,
    OBJECT_NAME(fk.parent_object_id) AS table_name,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS column_name,
    OBJECT_NAME(fk.referenced_object_id) AS referenced_table,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS referenced_column
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
WHERE OBJECT_SCHEMA_NAME(fk.parent_object_id) = 'dwh_hr'
ORDER BY table_name, foreign_key_name;

-- View all check constraints
SELECT 
    cc.name AS check_constraint_name,
    OBJECT_NAME(cc.parent_object_id) AS table_name,
    cc.definition
FROM sys.check_constraints cc
WHERE OBJECT_SCHEMA_NAME(cc.parent_object_id) = 'dwh_hr'
ORDER BY table_name, check_constraint_name;

-- View all unique constraints
SELECT 
    i.name AS unique_constraint_name,
    OBJECT_NAME(i.object_id) AS table_name,
    STRING_AGG(c.name, ', ') AS columns
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE i.is_unique = 1 
  AND i.is_primary_key = 0
  AND OBJECT_SCHEMA_NAME(i.object_id) = 'dwh_hr'
GROUP BY i.name, i.object_id
ORDER BY table_name, unique_constraint_name;

-- Count constraints by type
SELECT 
    'Foreign Keys' AS constraint_type,
    COUNT(*) AS count
FROM sys.foreign_keys
WHERE OBJECT_SCHEMA_NAME(parent_object_id) = 'dwh_hr'
UNION ALL
SELECT 
    'Check Constraints' AS constraint_type,
    COUNT(*) AS count
FROM sys.check_constraints
WHERE OBJECT_SCHEMA_NAME(parent_object_id) = 'dwh_hr'
UNION ALL
SELECT 
    'Unique Constraints' AS constraint_type,
    COUNT(*) AS count
FROM sys.indexes
WHERE is_unique = 1 
  AND is_primary_key = 0
  AND OBJECT_SCHEMA_NAME(object_id) = 'dwh_hr';

-- =====================================================
-- SECTION 14: TROUBLESHOOTING - DROP CONSTRAINTS
-- =====================================================
-- Use these ONLY if you need to recreate constraints
-- CAUTION: This will remove referential integrity!

/*
-- Drop all foreign keys in dwh_hr schema
DECLARE @SQL NVARCHAR(MAX) = '';
SELECT @SQL += 'ALTER TABLE dwh_hr.' + OBJECT_NAME(fk.parent_object_id) + 
               ' DROP CONSTRAINT ' + fk.name + ';' + CHAR(13)
FROM sys.foreign_keys fk
WHERE OBJECT_SCHEMA_NAME(fk.parent_object_id) = 'dwh_hr';
EXEC sp_executesql @SQL;

-- Drop all check constraints in dwh_hr schema
SET @SQL = '';
SELECT @SQL += 'ALTER TABLE dwh_hr.' + OBJECT_NAME(cc.parent_object_id) + 
               ' DROP CONSTRAINT ' + cc.name + ';' + CHAR(13)
FROM sys.check_constraints cc
WHERE OBJECT_SCHEMA_NAME(cc.parent_object_id) = 'dwh_hr';
EXEC sp_executesql @SQL;

-- Drop all unique constraints in dwh_hr schema
SET @SQL = '';
SELECT @SQL += 'DROP INDEX ' + i.name + ' ON dwh_hr.' + OBJECT_NAME(i.object_id) + ';' + CHAR(13)
FROM sys.indexes i
WHERE i.is_unique = 1 
  AND i.is_primary_key = 0
  AND OBJECT_SCHEMA_NAME(i.object_id) = 'dwh_hr';
EXEC sp_executesql @SQL;
*/

-- =====================================================
-- NOTES:
-- =====================================================
-- 1. Execute these constraints AFTER all tables are created
-- 2. Ensure parent tables (dimensions) have data before inserting into child tables (facts)
-- 3. Foreign keys will prevent orphaned records in fact tables
-- 4. Check constraints enforce business rules at database level
-- 5. Unique constraints prevent duplicate dimension records
-- 6. Filtered unique indexes enforce "only one current record" rule for SCD Type 2
-- 7. Power BI will auto-detect relationships based on foreign keys
-- 8. These constraints may slow down bulk inserts - consider disabling during ETL and re-enabling after
-- =====================================================