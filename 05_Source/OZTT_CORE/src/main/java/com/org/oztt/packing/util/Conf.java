package com.org.oztt.packing.util;

public enum Conf {
    TIME_GAP("", 10000), 
    UPLOAD_TIME_GAP("", 1000), 
    TOTAL_WEIGHT("", 0), 
    TOTAL_SCORE("", 0), 
    BOX_MARGIN("", 90), 
    ITEM_COUNT("", 10), 
    TOTAL_ITEM_COUNT("", 12), 
    DEFUALT_PRODUCT_EXPRESS_ID("", 2), 
    SYNCHRONIZE("", 0);

    private String strValue;

    private Long   lValue;

    private Conf(String strValue, long lValue)
    {
        this.strValue = strValue;
        this.lValue = lValue;
    }

    public String getStrValue() {
        return this.strValue;
    }

    public long getLongValue() {
        return this.lValue;
    }

    public void setLongValue(long value) {
        this.lValue = value;
    }

}
