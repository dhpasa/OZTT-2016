ALTER TABLE `oztt`.`t_express_info` ADD COLUMN `babyOriginalBoxFlg` CHAR(1) NULL DEFAULT NULL;
ALTER TABLE `oztt`.`t_express_info` ADD COLUMN `instantOriginalBoxFlg` CHAR(1) NULL DEFAULT NULL;

ALTER TABLE `oztt`.`t_powder_info` ADD COLUMN `freeDeliveryParameter2` DECIMAL(12,2) NULL DEFAULT 0.00;
