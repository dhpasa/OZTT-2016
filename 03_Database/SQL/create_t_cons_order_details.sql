DROP TABLE IF EXISTS `t_cons_order_details`;
CREATE TABLE `t_cons_order_details` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `orderNo` varchar(16) NOT NULL,
  `customerNo` varchar(16) NOT NULL,
  `goodsId` varchar(16) NOT NULL,
  `deliveryTime` varchar(10) DEFAULT NULL,
  `specifications` varchar(1000) DEFAULT NULL,
  `quantity` decimal(12, 0),
  `groupNo` varchar(16) DEFAULT NULL,
  `priceNo` varchar(16) DEFAULT NULL,
  `unitPrice` decimal(12, 2),
  `sumAmount` decimal(12, 2),
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
