package com.org.oztt.formDto;

public class OzTtAdOdListDto {

    private String goodsId;

    private String goodsName;

    private String goodsPic;

    private String goodsQuantity;

    private String goodsPrice;

    private String goodsProperties;

    private String goodsTotalAmount;
    
    private String detailNo;
    
    private String goodsGroupId;
    
    private String deliveryTime;
    
    private String detailStatus;
    
    public String getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(String deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

	public String getGoodsGroupId() {
		return goodsGroupId;
	}

	public void setGoodsGroupId(String goodsGroupId) {
		this.goodsGroupId = goodsGroupId;
	}

	public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsPic() {
        return goodsPic;
    }

    public void setGoodsPic(String goodsPic) {
        this.goodsPic = goodsPic;
    }

    public String getGoodsQuantity() {
        return goodsQuantity;
    }

    public void setGoodsQuantity(String goodsQuantity) {
        this.goodsQuantity = goodsQuantity;
    }

    public String getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(String goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public String getGoodsProperties() {
        return goodsProperties;
    }

    public void setGoodsProperties(String goodsProperties) {
        this.goodsProperties = goodsProperties;
    }

    public String getGoodsTotalAmount() {
        return goodsTotalAmount;
    }

    public void setGoodsTotalAmount(String goodsTotalAmount) {
        this.goodsTotalAmount = goodsTotalAmount;
    }

    public String getDetailNo() {
        return detailNo;
    }

    public void setDetailNo(String detailNo) {
        this.detailNo = detailNo;
    }

	public String getDetailStatus() {
		return detailStatus;
	}

	public void setDetailStatus(String detailStatus) {
		this.detailStatus = detailStatus;
	}
}
