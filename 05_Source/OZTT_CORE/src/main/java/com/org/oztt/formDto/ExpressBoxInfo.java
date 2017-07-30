package com.org.oztt.formDto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.org.oztt.entity.TExpressInfo;

public class ExpressBoxInfo {

    // 快递公司的信息
    private TExpressInfo tExpressInfo;
    
    // 快递公司装货物的重量
    private Double weight;
    
    // 需要支付快递公司的价格
    private BigDecimal totalPrice;
    
    // 当前快递公司的装箱信息
    private List<ProductBoxDto>  addedProductBoxes = new ArrayList<ProductBoxDto>();

    public TExpressInfo gettExpressInfo() {
        return tExpressInfo;
    }

    public void settExpressInfo(TExpressInfo tExpressInfo) {
        this.tExpressInfo = tExpressInfo;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<ProductBoxDto> getAddedProductBoxes() {
        return addedProductBoxes;
    }

    public void setAddedProductBoxes(List<ProductBoxDto> addedProductBoxes) {
        this.addedProductBoxes = addedProductBoxes;
    }
}
