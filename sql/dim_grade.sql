DROP TABLE IF EXISTS `dim_grade`;

CREATE TABLE `dim_grade` (
  `grade_key` INT NOT NULL AUTO_INCREMENT,
  `grade_id` INT NOT NULL,
  `code` VARCHAR(50),
  `grade_no` INT,
  `name` VARCHAR(255),
  -- `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `source_system_code` VARCHAR(50) DEFAULT NULL,
  `source_created_date` DATETIME DEFAULT NULL,
  `source_updated_date` DATETIME DEFAULT NULL,
  `dw_created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dw_updated_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`grade_key`),
  UNIQUE KEY `uq_grade_id` (`grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
