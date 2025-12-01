-- View 1: Current Employee Profile
CREATE VIEW dwh_hr.vw_current_employee_profile AS
SELECT 
    e.employee_key,
    e.employee_code,
    e.first_name,
    e.last_name,
    e.gender,
    e.birth_date,
    DATEDIFF(YEAR, e.birth_date, GETDATE()) AS age,
    
    c.company_name,
    d.department_name,
    p.position_name,
    g.grade_name,
    l.level_name,
    
    h.begin_date AS current_position_start_date,
    h.base_wage AS current_salary,
    h.is_current_position
    
FROM dwh_hr.dim_employee e
JOIN dwh_hr.fact_employee_history h ON e.employee_key = h.employee_key
LEFT JOIN dwh_hr.dim_company c ON h.company_key = c.company_key
LEFT JOIN dwh_hr.dim_department d ON h.department_key = d.department_key
LEFT JOIN dwh_hr.dim_position p ON h.position_key = p.position_key
LEFT JOIN dwh_hr.dim_grade g ON h.grade_key = g.grade_key
LEFT JOIN dwh_hr.dim_level l ON h.level_key = l.level_key
WHERE h.is_current_position = 1
  AND e.is_current_record = 1;

-- View 2: Training Summary
CREATE VIEW dwh_hr.vw_training_summary AS
SELECT 
    e.employee_key,
    e.first_name + ' ' + e.last_name AS employee_name,
    t.training_name,
    tp.provider_name,
    ft.training_begin_date,
    ft.training_end_date,
    ft.required_hours,
    ft.completed_hours,
    ft.completion_rate,
    ft.total_expense,
    ft.evaluation_score,
    ft.training_status
FROM dwh_hr.fact_employee_training ft
JOIN dwh_hr.dim_employee e ON ft.employee_key = e.employee_key
JOIN dwh_hr.dim_training t ON ft.training_key = t.training_key
LEFT JOIN dwh_hr.dim_training_provider tp ON ft.training_provider_key = tp.training_provider_key
WHERE e.is_current_record = 1;