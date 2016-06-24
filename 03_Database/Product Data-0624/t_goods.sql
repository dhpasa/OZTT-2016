/*
Navicat MySQL Data Transfer

Source Server         : localMysql
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : oztt

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2016-06-22 16:27:39
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_goods`
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `goodsId` varchar(16) NOT NULL,
  `classId` varchar(10) NOT NULL,
  `goodsBrand` varchar(50) NOT NULL,
  `goodsBrandEn` varchar(100) NOT NULL,
  `goodsName` varchar(100) NOT NULL,
  `goodsNameEn` varchar(200) NOT NULL,
  `goodsDesc` varchar(200) DEFAULT NULL,
  `goodsDescEn` varchar(400) DEFAULT NULL,
  `goodsComments` varchar(500) DEFAULT NULL,
  `ifTax` char(1) DEFAULT NULL,
  `goodsThumbnail` varchar(255) DEFAULT NULL,
  `goodsSmallPic` varchar(255) DEFAULT NULL,
  `goodsNormalPic` varchar(255) DEFAULT NULL,
  `onSaleFlg` char(1) DEFAULT NULL,
  `hotSaleFlg` char(1) DEFAULT NULL,
  `newSaleFlg` char(1) DEFAULT NULL,
  `costPrice` decimal(12,2) DEFAULT NULL,
  `sortOrder` int(8) DEFAULT NULL,
  `tabs` varchar(255) DEFAULT NULL,
  `deleteFlg` char(1) NOT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
