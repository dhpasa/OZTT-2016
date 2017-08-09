DROP TABLE IF EXISTS `t_powder_box`;
CREATE TABLE `t_powder_box` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `elecExpressNo` varchar(20) NOT NULL,
  `expressDate` varchar(8) NOT NULL,
  `deliverId` varchar(12) DEFAULT NULL,
  `senderId` varchar(12) DEFAULT NULL,
  `receiverId` varchar(12) DEFAULT NULL,
  `ifRemarks` char(1),
  `remarks` varchar(100) DEFAULT NULL,
  `ifMsg` char(1),
  `additionalCost` decimal(12, 2),
  `sumAmount` decimal(12, 2),
  `expressPhotoUrl` varchar(255) DEFAULT NULL,
  `boxPhotoUrls` varchar(500) DEFAULT NULL,
  `orderId` varchar(12) DEFAULT NULL,
  `handleStatus` char(1),
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
