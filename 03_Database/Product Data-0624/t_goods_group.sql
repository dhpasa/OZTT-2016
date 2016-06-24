/*
Navicat MySQL Data Transfer

Source Server         : localMysql
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : oztt

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2016-06-22 16:27:44
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_goods_group`
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_group`;
CREATE TABLE `t_goods_group` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `groupNo` varchar(16) NOT NULL,
  `goodsId` varchar(16) NOT NULL,
  `topPageUp` char(1) DEFAULT NULL,
  `preFlg` char(1) DEFAULT NULL,
  `inStockFlg` char(1) DEFAULT NULL,
  `hotFlg` char(1) DEFAULT NULL,
  `groupPrice` decimal(12,2) NOT NULL,
  `groupMaxQuantity` decimal(12,0) DEFAULT NULL,
  `groupCurrentQuantity` decimal(12,0) DEFAULT NULL,
  `groupQuantityLimit` decimal(12,0) DEFAULT NULL,
  `groupComments` varchar(500) DEFAULT NULL,
  `groupDesc` text,
  `comsumerReminder` text,
  `shopperRules` text,
  `openFlg` char(1) NOT NULL,
  `validPeriodStart` timestamp NULL DEFAULT NULL,
  `validPeriodEnd` timestamp NULL DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_group
-- ----------------------------
