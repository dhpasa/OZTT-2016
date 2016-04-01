DROP TABLE IF EXISTS `t_address_info`;
CREATE TABLE `t_address_info` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT,
  `flg` char(1) NOT NULL,
  `customerNo` varchar(16) NOT NULL,
  `deliveryMethod` varchar(6) NOT NULL,
  `countryCode` varchar(20) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `suburb` varchar(50) DEFAULT NULL,
  `addressDetails` varchar(200) DEFAULT NULL,
  `postCode` varchar(20) DEFAULT NULL,
  `receiver` varchar(50) DEFAULT NULL,
  `contactTel` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
