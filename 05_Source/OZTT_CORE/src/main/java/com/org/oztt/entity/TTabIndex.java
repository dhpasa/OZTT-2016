package com.org.oztt.entity;

import java.io.Serializable;

public class TTabIndex implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = -8966374513462208926L;

    private String tabid;

    private String goodsid;

    public String getTabid() {
        return tabid;
    }

    public void setTabid(String tabid) {
        this.tabid = tabid;
    }

    public String getGoodsid() {
        return goodsid;
    }

    public void setGoodsid(String goodsid) {
        this.goodsid = goodsid;
    }
}