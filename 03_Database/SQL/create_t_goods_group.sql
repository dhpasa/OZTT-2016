DROP TABLE IF EXISTS `t_goods_group`;
CREATE TABLE `t_goods_group` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `groupNo` varchar(16) NOT NULL,
  `goodsId` varchar(16) NOT NULL,
  `topPageUp` char(1) DEFAULT NULL,
  `groupPrice` decimal(12, 2) NOT NULL,
  `groupMaxQuantity` decimal(12, 0),
  `groupCurrentQuantity` decimal(12, 0),
  `groupComments` varchar(500) DEFAULT NULL,
  `groupDesc` varchar(255) DEFAULT NULL,
  `comsumerReminder` varchar(255) DEFAULT NULL,
  `shopperRules` varchar(255) DEFAULT NULL,
  `openFlg` char(1) NOT NULL,
  `validPeriodStart` timestamp NULL DEFAULT NULL,
  `validPeriodEnd` timestamp NULL DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
