DROP TABLE IF EXISTS `t_cons_order`;
CREATE TABLE `t_cons_order` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `orderNo` varchar(16) NOT NULL,
  `customerNo` varchar(16) NOT NULL,
  `orderAmount` decimal(12, 2),
  `paymentMethod` varchar(6) DEFAULT NULL,
  `orderTimestamp` timestamp NULL DEFAULT NULL,
  `paymentTimestamp` timestamp NULL DEFAULT NULL,
  `handleFlg` varchar(6) DEFAULT NULL,
  `deliveryMethod` varchar(6) DEFAULT NULL,
  `addressId` bigint(18),
  `homeDeliveryTime` varchar(10) DEFAULT NULL,
  `invoiceFlg` char(1) DEFAULT NULL,
  `invoiceNo` varchar(16) DEFAULT NULL,
  `deliveryCost` decimal(12, 2),
  `transactionNo` varchar(16) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
