DROP TABLE IF EXISTS `t_goods_price`;
CREATE TABLE `t_goods_price` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `priceNo` varchar(16) NOT NULL,
  `goodsId` varchar(16) NOT NULL,
  `pricePolicy` varchar(255) NOT NULL,
  `priceValue` decimal(12, 2),
  `openFlg` char(1) NOT NULL,
  `validPeriodStart` timestamp NULL DEFAULT NULL,
  `validPeriodEnd` timestamp NULL DEFAULT NULL,
  `defaultFlg` char(1),
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
