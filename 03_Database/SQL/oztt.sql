/*
Navicat MySQL Data Transfer

Source Server         : localMysql
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : oztt

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2016-03-06 21:33:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_address_info
-- ----------------------------
DROP TABLE IF EXISTS `t_address_info`;
CREATE TABLE `t_address_info` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT,
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

-- ----------------------------
-- Records of t_address_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_admin_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_basic_info`;
CREATE TABLE `t_admin_basic_info` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `adminNo` varchar(10) NOT NULL,
  `roleId` varchar(100) NOT NULL,
  `nickName` varchar(50) DEFAULT NULL,
  `headPic` varchar(200) DEFAULT NULL,
  `telNo` varchar(20) NOT NULL,
  `emailAddr` varchar(255) DEFAULT NULL,
  `wechatNo` varchar(50) DEFAULT NULL,
  `deleteFlg` char(1) NOT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin_basic_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_admin_login_his
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_login_his`;
CREATE TABLE `t_admin_login_his` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `adminNo` varchar(10) NOT NULL,
  `loginTimestamp` timestamp NULL DEFAULT NULL,
  `logoutTimestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin_login_his
-- ----------------------------

-- ----------------------------
-- Table structure for t_admin_login_info
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_login_info`;
CREATE TABLE `t_admin_login_info` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `adminNo` varchar(10) NOT NULL,
  `loginPass` varchar(255) NOT NULL,
  `salt` varchar(100) DEFAULT NULL,
  `loginStatus` char(1) DEFAULT NULL,
  `deleteFlg` char(1) NOT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin_login_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_cons_cart
-- ----------------------------
DROP TABLE IF EXISTS `t_cons_cart`;
CREATE TABLE `t_cons_cart` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `goodsId` varchar(16) NOT NULL,
  `customerNo` varchar(16) NOT NULL,
  `goodsSpecifications` varchar(1000) DEFAULT NULL,
  `quantity` decimal(12,0) DEFAULT NULL,
  `ifGroup` char(1) DEFAULT NULL,
  `groupNo` varchar(16) DEFAULT NULL,
  `priceNo` varchar(16) DEFAULT NULL,
  `purchaseCurrent` char(1) DEFAULT NULL,
  `addCartTimestamp` timestamp NULL DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cons_cart
-- ----------------------------

-- ----------------------------
-- Table structure for t_cons_invoice
-- ----------------------------
DROP TABLE IF EXISTS `t_cons_invoice`;
CREATE TABLE `t_cons_invoice` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `invoiceNo` varchar(16) NOT NULL,
  `customerNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cons_invoice
-- ----------------------------

-- ----------------------------
-- Table structure for t_cons_order
-- ----------------------------
DROP TABLE IF EXISTS `t_cons_order`;
CREATE TABLE `t_cons_order` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `orderNo` varchar(16) NOT NULL,
  `customerNo` varchar(16) NOT NULL,
  `orderAmount` decimal(12,2) DEFAULT NULL,
  `paymentMethod` varchar(6) DEFAULT NULL,
  `orderTimestamp` timestamp NULL DEFAULT NULL,
  `paymentTimestamp` timestamp NULL DEFAULT NULL,
  `handleFlg` varchar(6) DEFAULT NULL,
  `deliveryMethod` varchar(6) DEFAULT NULL,
  `addressId` bigint(18) DEFAULT NULL,
  `homeDeliveryTime` varchar(10) DEFAULT NULL,
  `accountNo` varchar(16) DEFAULT NULL,
  `deliveryCost` decimal(12,2) DEFAULT NULL,
  `transactionNo` varchar(16) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cons_order
-- ----------------------------

-- ----------------------------
-- Table structure for t_cons_order_details
-- ----------------------------
DROP TABLE IF EXISTS `t_cons_order_details`;
CREATE TABLE `t_cons_order_details` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `orderNo` varchar(16) NOT NULL,
  `customerNo` varchar(16) NOT NULL,
  `goodsId` varchar(16) NOT NULL,
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

-- ----------------------------
-- Records of t_cons_order_details
-- ----------------------------

-- ----------------------------
-- Table structure for t_cons_transaction
-- ----------------------------
DROP TABLE IF EXISTS `t_cons_transaction`;
CREATE TABLE `t_cons_transaction` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `transactionNo` varchar(16) NOT NULL,
  `customerNo` varchar(16) NOT NULL,
  `inOutFlg` char(1) NOT NULL,
  `accountNo` varchar(8) NOT NULL,
  `transactionMethod` varchar(6) DEFAULT NULL,
  `transactionType` varchar(6) DEFAULT NULL,
  `transactionObject` varchar(255) DEFAULT NULL,
  `transactionSerialNo` varchar(255) DEFAULT NULL,
  `transactionAmount` decimal(12,2) DEFAULT NULL,
  `transactionStatus` varchar(6) NOT NULL,
  `transactionTimestamp` timestamp NULL DEFAULT NULL,
  `transactionComments` varchar(500) DEFAULT NULL,
  `transactionBeforeAmount` decimal(12,2) DEFAULT NULL,
  `transactionAfterAmount` decimal(12,2) DEFAULT NULL,
  `transactionOperator` varchar(16) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cons_transaction
-- ----------------------------

-- ----------------------------
-- Table structure for t_customer_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_basic_info`;
CREATE TABLE `t_customer_basic_info` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `customerNo` varchar(16) NOT NULL,
  `cnSurname` varchar(20) DEFAULT NULL,
  `cnGivenname` varchar(20) DEFAULT NULL,
  `enFirstName` varchar(50) DEFAULT NULL,
  `enMiddleName` varchar(50) DEFAULT NULL,
  `enLastName` varchar(50) DEFAULT NULL,
  `idCardNo` varchar(50) DEFAULT NULL,
  `passportNo` varchar(50) DEFAULT NULL,
  `sex` varchar(6) DEFAULT NULL,
  `nickName` varchar(50) DEFAULT NULL,
  `birthday` varchar(8) DEFAULT NULL,
  `headPic` varchar(200) DEFAULT NULL,
  `marriage` varchar(6) DEFAULT NULL,
  `education` varchar(6) DEFAULT NULL,
  `occupation` varchar(6) DEFAULT NULL,
  `deleteFlg` char(1) NOT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_customer_basic_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_customer_login_his
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_login_his`;
CREATE TABLE `t_customer_login_his` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `customerNo` varchar(16) NOT NULL,
  `loginTimestamp` timestamp NULL DEFAULT NULL,
  `logoutTimestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_customer_login_his
-- ----------------------------

-- ----------------------------
-- Table structure for t_customer_login_info
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_login_info`;
CREATE TABLE `t_customer_login_info` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `customerNo` varchar(16) NOT NULL,
  `loginId` varchar(50) NOT NULL,
  `loginPass` varchar(255) NOT NULL,
  `salt` varchar(48) DEFAULT NULL,
  `loginStatus` char(1) DEFAULT NULL,
  `canLogin` char(1) DEFAULT NULL,
  `deleteFlg` char(1) NOT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_customer_login_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_customer_member_info
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_member_info`;
CREATE TABLE `t_customer_member_info` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `customerNo` varchar(16) NOT NULL,
  `memberCardNo` varchar(16) DEFAULT NULL,
  `points` int(8) DEFAULT NULL,
  `level` varchar(6) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_customer_member_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_customer_security_info
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_security_info`;
CREATE TABLE `t_customer_security_info` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `customerNo` varchar(16) NOT NULL,
  `telNo` varchar(20) NOT NULL,
  `emailAddr` varchar(255) DEFAULT NULL,
  `wechatNo` varchar(50) DEFAULT NULL,
  `wechatOpenId` varchar(100) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_customer_security_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_goods
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
  `ifTax` char(1),
  `goodsThumbnail` varchar(255) DEFAULT NULL,
  `goodsSmallPic` varchar(255) DEFAULT NULL,
  `goodsNormalPic` varchar(255) DEFAULT NULL,
  `onSaleFlg` char(1) DEFAULT NULL,
  `hotSaleFlg` char(1) DEFAULT NULL,
  `newSaleFlg` char(1) DEFAULT NULL,
  `costPrice` decimal(12,2) DEFAULT NULL,
  `sortOrder` int(8) DEFAULT NULL,
  `deleteFlg` char(1) NOT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO `t_goods` VALUES ('1', 'GD20160108000001', '2C0012', 'Blackmores', '', 'BM Conceive Well Gold', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('2', 'GD20160108000002', '2C0014', 'Blackmores', '', 'BM VE面霜', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('3', 'GD20160108000003', '2C0001', 'Blackmores', '', 'BM CoQ10辅酶', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('4', 'GD20160108000004', '2C0001', 'Blackmores', '', 'BM 三倍鱼油', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('5', 'GD20160108000005', '2C0012', 'Blackmores', '', 'BM 孕妇黄金素', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('6', 'GD20160108000006', '2C0005', 'Blackmores', '', 'BM 维骨力', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('7', 'GD20160108000007', '2C0006', 'Blackmores', '', 'BW 月见草', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('8', 'GD20160108000008', '2C0001', 'Blackmores', '', 'Blackmores 叶黄素护眼片加强版', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('9', 'GD20160108000009', '2C0001', 'Blackmores', '', 'Blackmores 更年期日夜舒缓片', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('10', 'GD20160108000010', '2C0009', 'Comvita', '', 'Comvita 儿童柠檬蜂蜜棒棒糖', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('11', 'GD20160108000011', '2C0009', 'Comvita', '', 'Comvita 蜂胶柠檬蜂蜜润喉糖', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('12', 'GD20160108000012', '2C0006', 'Femfresh', '', 'Femfresh 女性私处护理洗液', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('13', 'GD20160108000013', '2C0006', 'Healthycare', '', 'Healthycare葡萄籽', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('14', 'GD20160108000014', '2C0011', 'Life Space', '', 'Life Space婴儿益生菌粉', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('15', 'GD20160108000015', '2C0001', 'Lucas', '', 'Lucas木瓜膏', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('16', 'GD20160108000016', '2C0001', 'Medi Herb', '', 'Medi Herb', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('17', 'GD20160108000017', '2C0007', 'RedSeal', '', 'RedSeal去烟渍牙膏', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('18', 'GD20160108000018', '2C0006', 'Swisse', '', 'SW50岁以上女性营养片', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('19', 'GD20160108000019', '2C0002', 'Swisse', '', 'SW护肝片', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('20', 'GD20160108000020', '2C0002', 'Swisse', '', 'SW更年期平衡片', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('21', 'GD20160108000021', '2C0007', 'Swisse', '', 'SW男士复合营养片', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('22', 'GD20160108000022', '2C0001', 'Swisse', '', 'SW胶原蛋白液', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('23', 'GD20160108000023', '2C0001', 'Swisse', '', 'SW葡萄籽', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('24', 'GD20160108000024', '2C0001', 'Swisse', '', 'SW蔓越莓', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('25', 'GD20160108000025', '2C0001', 'Swisse', '', 'SW蜂胶', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('26', 'GD20160108000026', '2C0001', 'Swisse', '', 'Swisse CoQ10辅酶护心宝', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('27', 'GD20160108000027', '2C0001', 'Swisse', '', 'Swisse 大豆卵磷脂 1200mg', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('28', 'GD20160108000028', '2C0001', 'Swisse', '', 'Swisse 瑞思 钙片+维生素D', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('29', 'GD20160108000029', '2C0001', 'Thompson\'s', '', 'Thompson\'s Cholestrol Manager', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('30', 'GD20160108000030', '2C0001', 'Thompson\'s', '', 'Thompson\'s CoQ10', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('31', 'GD20160108000031', '2C0001', 'Thompson\'s', '', 'Thompson\'s Cod Liver Oil', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('32', 'GD20160108000032', '2C0001', 'Thompson\'s', '', 'Thompson\'s Memory Manager 60', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('33', 'GD20160108000033', '2C0001', 'Thompson\'s', '', 'Thompson\'s Salmon Oi', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('34', 'GD20160108000034', '2C0001', 'Thompson\'s', '', 'Thompson\'s 壮骨片', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('35', 'GD20160108000035', '2C0001', 'Thompson\'s', '', 'Thompson\'s 深海鱼油', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('36', 'GD20160108000036', '2C0001', 'Thompson\'s', '', 'Thopmson\'s 超级卵磷脂胶囊', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('37', 'GD20160108000037', '2C0014', 'Goat Soap', '', '羊奶皂-原味', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('38', 'GD20160108000038', '2C0014', 'Goat Soap', '', '羊奶皂-椰油', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('39', 'GD20160108000039', '2C0014', 'Goat Soap', '', '羊奶皂-燕麦', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods` VALUES ('40', 'GD20160108000040', '2C0014', 'Goat Soap', '', '羊奶皂-美卢卡蜂蜜', '', '这里是商品描述区域。', null, '', '1', 'pic_01.jpg', '', 'pic_01.jpg,pic_02.jpg,pic_03.jpg,pic_04.jpg', '1', '0', '0', '60.00', '10', '0', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');

-- ----------------------------
-- Table structure for t_goods_append_items
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_append_items`;
CREATE TABLE `t_goods_append_items` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `itemId` varchar(10) NOT NULL,
  `classId` varchar(10) NOT NULL,
  `displayName` varchar(50) DEFAULT NULL,
  `fieldName` varchar(50) DEFAULT NULL,
  `fieldType` varchar(6) DEFAULT NULL,
  `fieldLength` int(8) DEFAULT NULL,
  `inputType` varchar(6) DEFAULT NULL,
  `defaultValue` varchar(500) DEFAULT NULL,
  `isRequired` char(1) DEFAULT NULL,
  `sortOrder` int(8) DEFAULT NULL,
  `openFlg` char(1) NOT NULL,
  `buyUseFlg` char(1) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_append_items
-- ----------------------------

-- ----------------------------
-- Table structure for t_goods_classification
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_classification`;
CREATE TABLE `t_goods_classification` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `classId` varchar(10) NOT NULL,
  `className` varchar(50) DEFAULT NULL,
  `classNameEn` varchar(100) DEFAULT NULL,
  `sortOrder` int(8) DEFAULT NULL,
  `fatherClassId` varchar(10) NOT NULL,
  `openFlg` char(1) NOT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_classification
-- ----------------------------
INSERT INTO `t_goods_classification` VALUES ('1', '1C0001', '营养保健', null, '10', '0C0000', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('2', '1C0002', '母婴用品', null, '15', '0C0000', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('3', '1C0003', '美容护肤', null, '20', '0C0000', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('4', '1C0004', '进口食品', null, '25', '0C0000', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('5', '1C0005', '酒水茶饮', null, '30', '0C0000', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('6', '1C0006', '居家日用', null, '35', '0C0000', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('7', '2C0001', '调节免疫', null, '10', '1C0001', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('8', '2C0002', '调节三高', null, '15', '1C0001', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('9', '2C0003', '维生素钙', null, '20', '1C0001', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('10', '2C0004', '肝肾养护', null, '25', '1C0001', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('11', '2C0005', '骨骼健康', null, '30', '1C0001', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('12', '2C0006', '呵护女性', null, '35', '1C0001', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('13', '2C0007', '男性健康', null, '40', '1C0001', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('14', '2C0008', '宝宝奶粉', null, '10', '1C0002', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('15', '2C0009', '宝宝健康', null, '15', '1C0002', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('16', '2C0010', '宝宝辅食', null, '20', '1C0002', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('17', '2C0011', '宝宝护理', null, '25', '1C0002', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('18', '2C0012', '妈妈备孕', null, '30', '1C0002', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('19', '2C0013', '绵羊油', null, '10', '1C0003', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('20', '2C0014', '护肤', null, '15', '1C0003', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('21', '2C0015', '精油', null, '20', '1C0003', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('22', '2C0016', '化妆品', null, '25', '1C0003', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('23', '2C0017', '饼干糕点', null, '10', '1C0004', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('24', '2C0018', '乳制品', null, '15', '1C0004', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('25', '2C0019', '糖果/巧克力', null, '20', '1C0004', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('26', '2C0020', '休闲食品', null, '25', '1C0004', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('27', '2C0021', '红酒', null, '10', '1C0005', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('28', '2C0022', '咖啡', null, '15', '1C0005', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('29', '2C0023', 'UGG', null, '10', '1C0006', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('30', '2C0024', '羊毛制品', null, '15', '1C0006', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_classification` VALUES ('31', '2C0025', '日常用品', null, '20', '1C0006', '0', '2016-02-01 00:00:00', 'oztt', '2016-02-01 00:00:00', 'oztt', 'manual');

-- ----------------------------
-- Table structure for t_goods_group
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_group`;
CREATE TABLE `t_goods_group` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `groupNo` varchar(16) NOT NULL,
  `goodsId` varchar(16) NOT NULL,
  `groupPrice` decimal(12,2) NOT NULL,
  `groupMaxQuantity` decimal(12,0) DEFAULT NULL,
  `groupCurrentQuantity` decimal(12,0) DEFAULT NULL,
  `groupComments` varchar(500) DEFAULT NULL,
  `groupDesc` varchar(255) DEFAULT NULL,
  `comsumerReminder` varchar(255) DEFAULT NULL,
  `shopperRules` varchar(255) DEFAULT NULL,
  `openFlg` char(1) NOT NULL,
  `validPeriodStart` timestamp NULL DEFAULT NULL,
  `validPeriodEnd` timestamp NULL DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_group
-- ----------------------------
INSERT INTO `t_goods_group` VALUES ('1', 'GP20160108000001', 'GD20160108000001', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('2', 'GP20160108000002', 'GD20160108000002', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('3', 'GP20160108000003', 'GD20160108000003', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('4', 'GP20160108000004', 'GD20160108000004', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('5', 'GP20160108000005', 'GD20160108000005', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('6', 'GP20160108000006', 'GD20160108000006', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('7', 'GP20160108000007', 'GD20160108000007', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('8', 'GP20160108000008', 'GD20160108000008', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('9', 'GP20160108000009', 'GD20160108000009', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('10', 'GP20160108000010', 'GD20160108000010', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('11', 'GP20160108000011', 'GD20160108000011', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('12', 'GP20160108000012', 'GD20160108000012', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('13', 'GP20160108000013', 'GD20160108000013', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('14', 'GP20160108000014', 'GD20160108000014', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('15', 'GP20160108000015', 'GD20160108000015', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('16', 'GP20160108000016', 'GD20160108000016', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('17', 'GP20160108000017', 'GD20160108000017', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('18', 'GP20160108000018', 'GD20160108000018', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('19', 'GP20160108000019', 'GD20160108000019', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('20', 'GP20160108000020', 'GD20160108000020', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('21', 'GP20160108000021', 'GD20160108000021', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('22', 'GP20160108000022', 'GD20160108000022', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('23', 'GP20160108000023', 'GD20160108000023', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('24', 'GP20160108000024', 'GD20160108000024', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('25', 'GP20160108000025', 'GD20160108000025', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('26', 'GP20160108000026', 'GD20160108000026', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('27', 'GP20160108000027', 'GD20160108000027', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('28', 'GP20160108000028', 'GD20160108000028', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('29', 'GP20160108000029', 'GD20160108000029', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('30', 'GP20160108000030', 'GD20160108000030', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('31', 'GP20160108000031', 'GD20160108000031', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('32', 'GP20160108000032', 'GD20160108000032', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('33', 'GP20160108000033', 'GD20160108000033', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('34', 'GP20160108000034', 'GD20160108000034', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('35', 'GP20160108000035', 'GD20160108000035', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('36', 'GP20160108000036', 'GD20160108000036', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('37', 'GP20160108000037', 'GD20160108000037', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('38', 'GP20160108000038', 'GD20160108000038', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('39', 'GP20160108000039', 'GD20160108000039', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');
INSERT INTO `t_goods_group` VALUES ('40', 'GP20160108000040', 'GD20160108000040', '80.00', '100', '20', '欢迎来到OZTuanTuan！', 'desc.html', 'reminder.html', 'rules.html', '0', '2016-01-01 00:00:00', '2020-01-01 00:00:00', '2016-01-08 00:00:00', 'oztt', '2016-01-08 00:00:00', 'oztt', 'manual');

-- ----------------------------
-- Table structure for t_goods_price
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_price`;
CREATE TABLE `t_goods_price` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `priceNo` varchar(16) NOT NULL,
  `goodsId` varchar(16) NOT NULL,
  `goodsClassId` varchar(255) NOT NULL,
  `goodsClassValue` decimal(12,2) DEFAULT NULL,
  `openFlg` char(1) NOT NULL,
  `validPeriodStart` timestamp NULL DEFAULT NULL,
  `validPeriodEnd` timestamp NULL DEFAULT NULL,
  `defaultFlg` char(1) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_price
-- ----------------------------
INSERT INTO `t_goods_price` VALUES ('1', 'PR20160108000001', 'GD20160108000001', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('2', 'PR20160108000002', 'GD20160108000002', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('3', 'PR20160108000003', 'GD20160108000003', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('4', 'PR20160108000004', 'GD20160108000004', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('5', 'PR20160108000005', 'GD20160108000005', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('6', 'PR20160108000006', 'GD20160108000006', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('7', 'PR20160108000007', 'GD20160108000007', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('8', 'PR20160108000008', 'GD20160108000008', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('9', 'PR20160108000009', 'GD20160108000009', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('10', 'PR20160108000010', 'GD20160108000010', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('11', 'PR20160108000011', 'GD20160108000011', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('12', 'PR20160108000012', 'GD20160108000012', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('13', 'PR20160108000013', 'GD20160108000013', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('14', 'PR20160108000014', 'GD20160108000014', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('15', 'PR20160108000015', 'GD20160108000015', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('16', 'PR20160108000016', 'GD20160108000016', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('17', 'PR20160108000017', 'GD20160108000017', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('18', 'PR20160108000018', 'GD20160108000018', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('19', 'PR20160108000019', 'GD20160108000019', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('20', 'PR20160108000020', 'GD20160108000020', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('21', 'PR20160108000021', 'GD20160108000021', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('22', 'PR20160108000022', 'GD20160108000022', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('23', 'PR20160108000023', 'GD20160108000023', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('24', 'PR20160108000024', 'GD20160108000024', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('25', 'PR20160108000025', 'GD20160108000025', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('26', 'PR20160108000026', 'GD20160108000026', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('27', 'PR20160108000027', 'GD20160108000027', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('28', 'PR20160108000028', 'GD20160108000028', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('29', 'PR20160108000029', 'GD20160108000029', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('30', 'PR20160108000030', 'GD20160108000030', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('31', 'PR20160108000031', 'GD20160108000031', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('32', 'PR20160108000032', 'GD20160108000032', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('33', 'PR20160108000033', 'GD20160108000033', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('34', 'PR20160108000034', 'GD20160108000034', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('35', 'PR20160108000035', 'GD20160108000035', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('36', 'PR20160108000036', 'GD20160108000036', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('37', 'PR20160108000037', 'GD20160108000037', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('38', 'PR20160108000038', 'GD20160108000038', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('39', 'PR20160108000039', 'GD20160108000039', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');
INSERT INTO `t_goods_price` VALUES ('40', 'PR20160108000040', 'GD20160108000040', '0', '100.00', '0', '2016-01-08 00:00:00', '2016-01-08 00:00:00', '1');

-- ----------------------------
-- Table structure for t_goods_property
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_property`;
CREATE TABLE `t_goods_property` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `goodsId` varchar(16) NOT NULL,
  `goodsClassId` varchar(10) NOT NULL,
  `goodsClassValue` varchar(500) DEFAULT NULL,
  `openFlg` char(1) NOT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_property
-- ----------------------------

-- ----------------------------
-- Table structure for t_goods_storage
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_storage`;
CREATE TABLE `t_goods_storage` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `goodsId` varchar(16) NOT NULL,
  `checkinBatch` varchar(20) NOT NULL,
  `checkinQuantity` decimal(12,0) DEFAULT NULL,
  `currentQuantity` decimal(12,0) DEFAULT NULL,
  `checkinPrice` decimal(12,2) DEFAULT NULL,
  `checkinTimestamp` timestamp NULL DEFAULT NULL,
  `checkinPerson` varchar(10) DEFAULT NULL,
  `checkinFlg` char(1) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_storage
-- ----------------------------

-- ----------------------------
-- Table structure for t_no_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_no_customer`;
CREATE TABLE `t_no_customer` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `date` varchar(8) NOT NULL,
  `maxNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_no_customer
-- ----------------------------

-- ----------------------------
-- Table structure for t_no_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_no_goods`;
CREATE TABLE `t_no_goods` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `date` varchar(8) NOT NULL,
  `maxNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_no_goods
-- ----------------------------

-- ----------------------------
-- Table structure for t_no_group
-- ----------------------------
DROP TABLE IF EXISTS `t_no_group`;
CREATE TABLE `t_no_group` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `date` varchar(8) NOT NULL,
  `maxNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_no_group
-- ----------------------------

-- ----------------------------
-- Table structure for t_no_invoice
-- ----------------------------
DROP TABLE IF EXISTS `t_no_invoice`;
CREATE TABLE `t_no_invoice` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `date` varchar(8) NOT NULL,
  `maxNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_no_invoice
-- ----------------------------

-- ----------------------------
-- Table structure for t_no_order
-- ----------------------------
DROP TABLE IF EXISTS `t_no_order`;
CREATE TABLE `t_no_order` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `date` varchar(8) NOT NULL,
  `maxNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_no_order
-- ----------------------------

-- ----------------------------
-- Table structure for t_no_price
-- ----------------------------
DROP TABLE IF EXISTS `t_no_price`;
CREATE TABLE `t_no_price` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `date` varchar(8) NOT NULL,
  `maxNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_no_price
-- ----------------------------

-- ----------------------------
-- Table structure for t_no_transaction
-- ----------------------------
DROP TABLE IF EXISTS `t_no_transaction`;
CREATE TABLE `t_no_transaction` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `date` varchar(8) NOT NULL,
  `maxNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_no_transaction
-- ----------------------------

-- ----------------------------
-- Table structure for t_suburb_deliver_fee
-- ----------------------------
DROP TABLE IF EXISTS `t_suburb_deliver_fee`;
CREATE TABLE `t_suburb_deliver_fee` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `suburb` varchar(100) NOT NULL,
  `deliverFee` decimal(12,2) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_suburb_deliver_fee
-- ----------------------------
INSERT INTO `t_suburb_deliver_fee` VALUES ('1', 'Algester', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('2', 'Annerley', '8.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('3', 'Acacia Ridge', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('4', 'Auchenflower', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('5', 'Ascot', '18.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('6', 'Archerfield', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('7', 'Browns Plains', '9.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('8', 'Bowen Hills', '14.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('9', 'Bridgeman Downs', '22.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('10', 'Bardon', '15.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('11', 'Bulimba', '15.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('12', 'Coopers Plains', '3.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('13', 'Calamvale', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('14', 'Carindale', '10.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('15', 'Carina', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('16', 'City', '9.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('17', 'Coorparoo', '9.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('18', 'Camp Hill', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('19', 'Cannon Hill', '12.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('20', 'Chermside', '18.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('21', 'Chermside West', '18.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('22', 'Carseldine', '22.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('23', 'Drewvale', '8.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('24', 'Doolandella', '10.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('25', 'Daisy Hill', '14.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('26', 'Eight Mile Plains', '5.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('27', 'East Brisbane', '10.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('28', 'Fortitude Vally', '10.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('29', 'Forest Lake', '12.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('30', 'Greenslopes', '8.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('31', 'Herston', '12.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('32', 'Highgate Hill', '10.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('33', 'Hamilton', '15.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('34', 'Holland Park', '8.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('35', 'Holland Park West', '7.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('36', 'Hawthorne', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('37', 'Indooroopilly', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('38', 'Jimbooba', '16.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('39', 'Jindalee', '15.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('40', 'Lutwyche', '15.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('41', 'Kuraby', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('42', 'Kelvin Grove', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('43', 'Kangaroo Point', '9.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('44', 'Macgregor', '4.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('45', 'Mt Gravatt', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('46', 'Moorooka', '8.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('47', 'Mt Gravatt East', '7.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('48', 'Morningside', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('49', 'Milton', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('50', 'Mansfield', '7.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('51', 'Mitchelton', '15.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('52', 'Norman Park', '15.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('53', 'Newmarket', '13.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('54', 'Nundah', '20.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('55', 'New Farm', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('56', 'Oxley', '8.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('57', 'Parkinson', '7.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('58', 'Paddington', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('59', 'Robertson', '3.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('60', 'Runcorn', '5.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('61', 'Rochedale', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('62', 'Rochedale South', '7.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('63', 'Rocklea', '7.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('64', 'Red Hill', '12.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('65', 'Salisbury', '3.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('66', 'Sunnybank', '4.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('67', 'Sunnybank Hills', '5.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('68', 'Streetton', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('69', 'St Lucia', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('70', 'South Bank', '9.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('71', 'South Brisbane', '9.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('72', 'Spring Hill', '10.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('73', 'Stafford', '18.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('74', 'Slacks Creek', '12.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('75', 'Taringa', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('76', 'Toowong', '10.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('77', 'Tarragindi', '7.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('78', 'Teneriffe', '11.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('79', 'Underwood', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('80', 'Upper Mt Gravatt', '4.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('81', 'Virginia', '20.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('82', 'Windsor', '13.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('83', 'Woolongabba', '9.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('84', 'Wishart', '6.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('85', 'West End', '9.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('86', 'Woodridge', '8.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('87', 'Wooloowin', '20.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('88', 'Wavell Heights', '18.00');
INSERT INTO `t_suburb_deliver_fee` VALUES ('89', 'Yeronga', '9.00');

-- ----------------------------
-- Table structure for t_sys_account
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_account`;
CREATE TABLE `t_sys_account` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `accountNo` varchar(8) NOT NULL,
  `accountType` varchar(6) DEFAULT NULL,
  `accountBalance` decimal(12,2) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_account
-- ----------------------------

-- ----------------------------
-- Table structure for t_sys_code
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_code`;
CREATE TABLE `t_sys_code` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `codeId` varchar(6) NOT NULL,
  `codeDetailId` varchar(6) NOT NULL,
  `codeName` varchar(100) NOT NULL,
  `codeDetailName` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_code
-- ----------------------------
INSERT INTO `t_sys_code` VALUES ('1', 'COM001', '1', '性别', '男');
INSERT INTO `t_sys_code` VALUES ('2', 'COM001', '2', '性别', '女');
INSERT INTO `t_sys_code` VALUES ('3', 'COM001', '9', '性别', '保密');
INSERT INTO `t_sys_code` VALUES ('4', 'COM002', '0', '婚姻状况', '未婚');
INSERT INTO `t_sys_code` VALUES ('5', 'COM002', '1', '婚姻状况', '已婚');
INSERT INTO `t_sys_code` VALUES ('6', 'COM002', '9', '婚姻状况', '保密');
INSERT INTO `t_sys_code` VALUES ('7', 'COM003', '10', '教育程度', '初中');
INSERT INTO `t_sys_code` VALUES ('8', 'COM003', '20', '教育程度', '高中');
INSERT INTO `t_sys_code` VALUES ('9', 'COM003', '30', '教育程度', '中专');
INSERT INTO `t_sys_code` VALUES ('10', 'COM003', '40', '教育程度', '大专');
INSERT INTO `t_sys_code` VALUES ('11', 'COM003', '50', '教育程度', '本科');
INSERT INTO `t_sys_code` VALUES ('12', 'COM003', '60', '教育程度', '硕士');
INSERT INTO `t_sys_code` VALUES ('13', 'COM003', '70', '教育程度', '博士');
INSERT INTO `t_sys_code` VALUES ('14', 'COM003', '80', '教育程度', '其他');
INSERT INTO `t_sys_code` VALUES ('15', 'COM004', '0', '订单状态', '未付款');
INSERT INTO `t_sys_code` VALUES ('16', 'COM004', '1', '订单状态', '已付款');
INSERT INTO `t_sys_code` VALUES ('17', 'COM004', '2', '订单状态', '处理中');
INSERT INTO `t_sys_code` VALUES ('18', 'COM004', '3', '订单状态', '处理完毕');
INSERT INTO `t_sys_code` VALUES ('19', 'COM004', '9', '订单状态', '删除');
INSERT INTO `t_sys_code` VALUES ('20', 'COM005', '1', '付款方式', 'Credit Card');
INSERT INTO `t_sys_code` VALUES ('21', 'COM005', '2', '付款方式', 'Paypal');
INSERT INTO `t_sys_code` VALUES ('22', 'COM005', '3', '付款方式', '支付宝');
INSERT INTO `t_sys_code` VALUES ('23', 'COM005', '4', '付款方式', '微信支付');
INSERT INTO `t_sys_code` VALUES ('24', 'COM006', '1', '交易类型', '订单支付');
INSERT INTO `t_sys_code` VALUES ('25', 'COM006', '2', '交易类型', '手续费收取');
INSERT INTO `t_sys_code` VALUES ('26', 'COM007', '0', '交易状态', '处理中');
INSERT INTO `t_sys_code` VALUES ('27', 'COM007', '1', '交易状态', '处理成功');
INSERT INTO `t_sys_code` VALUES ('28', 'COM007', '9', '交易状态', '处理失败');
INSERT INTO `t_sys_code` VALUES ('29', 'COM008', '1', '运送方式', '来店自提');
INSERT INTO `t_sys_code` VALUES ('30', 'COM008', '2', '运送方式', '普通快递');
INSERT INTO `t_sys_code` VALUES ('31', 'COM008', '3', '运送方式', '货到付款');
INSERT INTO `t_sys_code` VALUES ('32', 'COM009', '01', '送货上门时间段', '8:00～～10:00');
INSERT INTO `t_sys_code` VALUES ('33', 'COM009', '02', '送货上门时间段', '10:00～～12:00');
INSERT INTO `t_sys_code` VALUES ('34', 'COM009', '03', '送货上门时间段', '12:00～～14:00');
INSERT INTO `t_sys_code` VALUES ('35', 'COM009', '04', '送货上门时间段', '14:00～～16:00');
INSERT INTO `t_sys_code` VALUES ('36', 'COM009', '05', '送货上门时间段', '16:00～～18:00');

-- ----------------------------
-- Table structure for t_sys_module
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_module`;
CREATE TABLE `t_sys_module` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `moduleNo` varchar(8) NOT NULL,
  `fatherModuleNo` varchar(8) DEFAULT NULL,
  `moduleName` varchar(50) NOT NULL,
  `moduleDesc` varchar(100) DEFAULT NULL,
  `openFlg` char(1) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_module
-- ----------------------------

-- ----------------------------
-- Table structure for t_sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_resource`;
CREATE TABLE `t_sys_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resourceName` varchar(100) NOT NULL,
  `resourceType` varchar(50) DEFAULT NULL,
  `resourceUrl` varchar(500) DEFAULT NULL,
  `parentResourceId` bigint(20) DEFAULT NULL,
  `parentResourceIds` varchar(200) DEFAULT NULL,
  `resourcePermission` varchar(100) DEFAULT NULL,
  `resourceAvailable` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_resource
-- ----------------------------

-- ----------------------------
-- Table structure for t_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE `t_sys_role` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(50) NOT NULL,
  `roleDesc` varchar(100) DEFAULT NULL,
  `resourceIds` varchar(1000) DEFAULT NULL,
  `openFlg` char(1) DEFAULT NULL,
  `addTimestamp` timestamp NULL DEFAULT NULL,
  `addUserKey` varchar(40) DEFAULT NULL,
  `updTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updUserKey` varchar(40) DEFAULT NULL,
  `updPgmId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_role
-- ----------------------------

-- ----------------------------
-- Table structure for t_sys_validate_message
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_validate_message`;
CREATE TABLE `t_sys_validate_message` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT,
  `telNumber` varchar(20) DEFAULT NULL,
  `validateCode` varchar(10) DEFAULT NULL,
  `createTimestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_validate_message
-- ----------------------------

-- ----------------------------
-- Table structure for t_no_announcement
-- ----------------------------
DROP TABLE IF EXISTS `t_no_announcement`;
CREATE TABLE `t_no_announcement` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `date` varchar(8) NOT NULL,
  `maxNo` varchar(16) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_no_announcement
-- ----------------------------

-- ----------------------------
-- Table structure for t_sys_announcement
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_announcement`;
CREATE TABLE `t_sys_announcement` (
  `no` bigint(12) NOT NULL AUTO_INCREMENT,
  `announceNo` varchar(16) NOT NULL,
  `announceTitle` varchar(255) NOT NULL,
  `announceContent` varchar(1000) NOT NULL,
  `releaseTime` timestamp NULL DEFAULT NULL,
  `ifRevoke` char(1),
  `revokeTime` timestamp NULL DEFAULT NULL,
  `ifDelete` char(1),
  `deleteTime` timestamp NULL DEFAULT NULL,
  `priority` char(1),
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sys_announcement
-- ----------------------------
