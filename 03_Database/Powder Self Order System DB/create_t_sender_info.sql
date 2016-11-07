DROP TABLE IF EXISTS `t_sender_info`;
CREATE TABLE `t_sender_info` (
  `Id` bigint(12) NOT NULL AUTO_INCREMENT,
  `senderName` varchar(20) NOT NULL,
  `senderTel` varchar(16) NOT NULL,
  `customerId` varchar(12) NOT NULL,
  `deleteFlg` char(1),
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
