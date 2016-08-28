package com.org.oztt.formDto;

import org.springframework.util.StringUtils;

/**
 * 商品团购
 * 
 * @author linliuan
 */
public class OzTtAdGcDto {

    private String goodsName;

    private String goodsClassId;

    private String goodsId;

    private String dateFrom;

    private String dateTo;

    private String isOpenFlag;

    private String isTopUp;

    private String isPre;

    private String isInStock;

    private String isHot;
    
    private String isDiamond;
    
    private String isEn;

    private String openFlg;

    public String getOpenFlg() {
        return openFlg;
    }

    public void setOpenFlg(String openFlg) {
        this.openFlg = openFlg;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsClassId() {
        return goodsClassId;
    }

    public void setGoodsClassId(String goodsClassId) {
        this.goodsClassId = goodsClassId;
    }

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public String getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(String dateFrom) {
        this.dateFrom = dateFrom;
    }

    public String getDateTo() {
        return dateTo;
    }

    public void setDateTo(String dateTo) {
        this.dateTo = dateTo;
    }

    public String getIsOpenFlag() {
        return isOpenFlag;
    }

    public void setIsOpenFlag(String isOpenFlag) {
        this.isOpenFlag = isOpenFlag;
    }

    public String getIsTopUp() {
        return StringUtils.isEmpty(isTopUp) ? "" : isTopUp;
    }

    public void setIsTopUp(String isTopUp) {
        this.isTopUp = isTopUp;
    }

    public String getIsPre() {
        return StringUtils.isEmpty(isPre) ? "" : isPre;
    }

    public void setIsPre(String isPre) {
        this.isPre = isPre;
    }

    public String getIsInStock() {
        return StringUtils.isEmpty(isInStock) ? "" : isInStock;
    }

    public void setIsInStock(String isInStock) {
        this.isInStock = isInStock;
    }

    public String getIsHot() {
        return StringUtils.isEmpty(isHot) ? "" : isHot;
    }

    public void setIsHot(String isHot) {
        this.isHot = isHot;
    }

	public String getIsDiamond() {
		return StringUtils.isEmpty(isDiamond) ? "" : isDiamond;
	}

	public void setIsDiamond(String isDiamond) {
		this.isDiamond = isDiamond;
	}

	public String getIsEn() {
		return StringUtils.isEmpty(isEn) ? "" : isEn;
	}

	public void setIsEn(String isEn) {
		this.isEn = isEn;
	}

}
