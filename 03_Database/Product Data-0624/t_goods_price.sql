/*
Navicat MySQL Data Transfer

Source Server         : localMysql
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : oztt

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2016-06-22 16:27:51
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_goods_price`
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_price`;
CREATE TABLE `t_goods_price` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `priceNo` varchar(16) NOT NULL,
  `goodsId` varchar(16) NOT NULL,
  `pricePolicy` varchar(255) NOT NULL,
  `priceValue` decimal(12,2) DEFAULT NULL,
  `openFlg` char(1) NOT NULL,
  `validPeriodStart` timestamp NULL DEFAULT NULL,
  `validPeriodEnd` timestamp NULL DEFAULT NULL,
  `defaultFlg` char(1) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_price
-- ----------------------------
