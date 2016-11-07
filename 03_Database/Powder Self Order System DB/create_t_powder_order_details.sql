DROP TABLE IF EXISTS `t_powder_order_details`;
CREATE TABLE `t_powder_order_details` (
  `Id` bigint(12) NOT NULL AUTO_INCREMENT,
  `powderId` varchar(12) NOT NULL,
  `quantity` decimal(12, 0),
  `unitPrice` decimal(12, 2),
  `powderBoxId` varchar(12) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
