package com.org.oztt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class TGoodsPrice implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long no;

    private String priceno;

    private String goodsid;

    private String pricepolicy;

    private BigDecimal pricevalue;

    private String openflg;

    private Date validperiodstart;

    private Date validperiodend;

    private String defaultflg;

    public Long getNo() {
        return no;
    }

    public void setNo(Long no) {
        this.no = no;
    }

    public String getPriceno() {
        return priceno;
    }

    public void setPriceno(String priceno) {
        this.priceno = priceno;
    }

    public String getGoodsid() {
        return goodsid;
    }

    public void setGoodsid(String goodsid) {
        this.goodsid = goodsid;
    }

    public String getPricepolicy() {
        return pricepolicy;
    }

    public void setPricepolicy(String pricepolicy) {
        this.pricepolicy = pricepolicy;
    }

    public BigDecimal getPricevalue() {
        return pricevalue;
    }

    public void setPricevalue(BigDecimal pricevalue) {
        this.pricevalue = pricevalue;
    }

    public String getOpenflg() {
        return openflg;
    }

    public void setOpenflg(String openflg) {
        this.openflg = openflg;
    }

    public Date getValidperiodstart() {
        return validperiodstart;
    }

    public void setValidperiodstart(Date validperiodstart) {
        this.validperiodstart = validperiodstart;
    }

    public Date getValidperiodend() {
        return validperiodend;
    }

    public void setValidperiodend(Date validperiodend) {
        this.validperiodend = validperiodend;
    }

    public String getDefaultflg() {
        return defaultflg;
    }

    public void setDefaultflg(String defaultflg) {
        this.defaultflg = defaultflg;
    }
}