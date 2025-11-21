DROP TABLE IF EXISTS `dim_level`;

CREATE TABLE `dim_level` (
  `level_key` int NOT NULL AUTO_INCREMENT,
  `level_id` int NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
--   `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `source_system_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source_created_date` datetime DEFAULT NULL,
  `source_updated_date` datetime DEFAULT NULL,
  `dw_created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dw_updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`level_key`),
  UNIQUE KEY `uq_level_id` (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
