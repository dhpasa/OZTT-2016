package com.org.oztt.formDto;

import java.math.BigDecimal;

public class PowderMilkInfo {

    private String powderBrand;
    
    private String powderSpec;
    
    private String number;
    
    private String powderPrice;
    
    private BigDecimal weight;
    
    private BigDecimal freeDeliveryParameter;

    public String getPowderBrand() {
        return powderBrand;
    }

    public void setPowderBrand(String powderBrand) {
        this.powderBrand = powderBrand;
    }

    public String getPowderSpec() {
        return powderSpec;
    }

    public void setPowderSpec(String powderSpec) {
        this.powderSpec = powderSpec;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getPowderPrice() {
        return powderPrice;
    }

    public void setPowderPrice(String powderPrice) {
        this.powderPrice = powderPrice;
    }

    public BigDecimal getWeight() {
        return weight;
    }

    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    public BigDecimal getFreeDeliveryParameter() {
        return freeDeliveryParameter;
    }

    public void setFreeDeliveryParameter(BigDecimal freeDeliveryParameter) {
        this.freeDeliveryParameter = freeDeliveryParameter;
    }
}
