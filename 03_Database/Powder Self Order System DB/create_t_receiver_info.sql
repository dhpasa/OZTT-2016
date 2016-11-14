DROP TABLE IF EXISTS `t_receiver_info`;
CREATE TABLE `t_receiver_info` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `receiverName` varchar(20) NOT NULL,
  `receiverTel` varchar(16) NOT NULL,
  `receiverAddr` varchar(12) NOT NULL,
  `receiverIdCardNo` varchar(255) DEFAULT NULL,
  `receiverIdCardPhotoUrls` varchar(500) DEFAULT NULL,
  `customerId` varchar(12) NOT NULL,
  `deleteFlg` char(1),
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
