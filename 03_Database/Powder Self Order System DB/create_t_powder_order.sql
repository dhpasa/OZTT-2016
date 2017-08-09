DROP TABLE IF EXISTS `t_powder_order`;
CREATE TABLE `t_powder_order` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `ordreNo` varchar(16) NOT NULL,
  `orderDate` varchar(8) NOT NULL,
  `customerId` varchar(12) DEFAULT NULL,
  `sumAmount` decimal(12, 2),
  `paymentMethod` char(1),
  `paymentStatus` char(1),
  `paymentDate` varchar(8) DEFAULT NULL,
  `status` char(1),
  `remarks` varchar(500) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
