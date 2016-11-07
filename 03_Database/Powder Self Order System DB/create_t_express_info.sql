DROP TABLE IF EXISTS `t_express_info`;
CREATE TABLE `t_express_info` (
  `Id` bigint(12) NOT NULL AUTO_INCREMENT,
  `expressName` varchar(50) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `priceCoefficient` decimal(12, 2),
  `deleteFlg` char(1),
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
