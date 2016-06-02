DROP TABLE IF EXISTS `t_tab_info`;
CREATE TABLE `t_tab_info` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `tabName` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
