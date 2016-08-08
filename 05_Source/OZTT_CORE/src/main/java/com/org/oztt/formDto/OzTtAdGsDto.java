package com.org.oztt.formDto;

/**
 * 产品维度
 *
 * @author x-wang
 */
public class OzTtAdGsDto {

    private String goodsName;

    private String dateFrom;

    private String dateTo;

    private String handleFlg;

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
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

	public String getHandleFlg() {
		return handleFlg;
	}

	public void setHandleFlg(String handleFlg) {
		this.handleFlg = handleFlg;
	}

}
