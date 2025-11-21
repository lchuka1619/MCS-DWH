CREATE TABLE `dim_company` (
  `company_key` int NOT NULL AUTO_INCREMENT,
  `company_code` varchar(50) NOT NULL,
  `company_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `source_system_code` varchar(50) DEFAULT NULL,
  `source_created_date` datetime DEFAULT NULL,
  `source_updated_date` datetime DEFAULT NULL,
  `dw_created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dw_updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`company_key`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci