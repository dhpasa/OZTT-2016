DROP TABLE IF EXISTS `t_sys_config`;
CREATE TABLE `t_sys_config` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `goodsSearchKey1` int(8),
  `goodsSearchValue1` varchar(255),
  `goodsSearchKey2` int(8),
  `goodsSearchValue2` varchar(255),
  `goodsSearchKey3` int(8),
  `goodsSearchValue3` varchar(255),
  `discountRate` decimal(12, 2) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
