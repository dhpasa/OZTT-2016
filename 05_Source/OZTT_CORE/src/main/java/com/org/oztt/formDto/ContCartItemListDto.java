package com.org.oztt.formDto;

import java.util.List;

/**
 * 商品购物车
 * 
 * @author linliuan
 */
public class ContCartItemListDto {

    private String queryDay;
    
    private List<ContCartItemDto> itemList;

    public String getQueryDay() {
        return queryDay;
    }

    public void setQueryDay(String queryDay) {
        this.queryDay = queryDay;
    }

    public List<ContCartItemDto> getItemList() {
        return itemList;
    }

    public void setItemList(List<ContCartItemDto> itemList) {
        this.itemList = itemList;
    }

    
}
