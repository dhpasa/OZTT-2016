package com.org.oztt.entity;

import java.io.Serializable;
import java.util.Date;

public class TProduct implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *  
     */
    private Long id;

    /**
     *  
     */
    private String code;

    /**
     *  
     */
    private String scanCode;

    /**
     *  
     */
    private String name;

    /**
     *  
     */
    private Double cost;

    /**
     *  
     */
    private Double price;

    /**
     *  
     */
    private Double priceEx;

    /**
     *  
     */
    private String material;

    /**
     *  
     */
    private String deliveryType;

    /**
     *  
     */
    private String productType;

    /**
     *  
     */
    private Double quantity;

    /**
     *  
     */
    private Double weight;

    /**
     *  
     */
    private String size;

    /**
     *  
     */
    private String picUrl;

    /**
     *  
     */
    private String description;

    /**
     *  
     */
    private String ifGst;

    /**
     *  
     */
    private String ifInvoice;

    /**
     *  
     */
    private String ifDelete;

    /**
     *  
     */
    private String groupStatus;

    /**
     *  
     */
    private String remarks;

    /**
     *  
     */
    private Date bestBeforeDate;

    /**
     *  
     */
    private Date addTimestamp;

    /**
     *  
     */
    private String addUserKey;

    /**
     *  
     */
    private Date updTimestamp;

    /**
     *  
     */
    private String updUserKey;

    /**
     *  
     */
    private String updPgmId;

    /**
     *  
     */
    private String brand;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getScanCode() {
        return scanCode;
    }

    public void setScanCode(String scanCode) {
        this.scanCode = scanCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getPriceEx() {
        return priceEx;
    }

    public void setPriceEx(Double priceEx) {
        this.priceEx = priceEx;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIfGst() {
        return ifGst;
    }

    public void setIfGst(String ifGst) {
        this.ifGst = ifGst;
    }

    public String getIfInvoice() {
        return ifInvoice;
    }

    public void setIfInvoice(String ifInvoice) {
        this.ifInvoice = ifInvoice;
    }

    public String getIfDelete() {
        return ifDelete;
    }

    public void setIfDelete(String ifDelete) {
        this.ifDelete = ifDelete;
    }

    public String getGroupStatus() {
        return groupStatus;
    }

    public void setGroupStatus(String groupStatus) {
        this.groupStatus = groupStatus;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Date getBestBeforeDate() {
        return bestBeforeDate;
    }

    public void setBestBeforeDate(Date bestBeforeDate) {
        this.bestBeforeDate = bestBeforeDate;
    }

    public Date getAddTimestamp() {
        return addTimestamp;
    }

    public void setAddTimestamp(Date addTimestamp) {
        this.addTimestamp = addTimestamp;
    }

    public String getAddUserKey() {
        return addUserKey;
    }

    public void setAddUserKey(String addUserKey) {
        this.addUserKey = addUserKey;
    }

    public Date getUpdTimestamp() {
        return updTimestamp;
    }

    public void setUpdTimestamp(Date updTimestamp) {
        this.updTimestamp = updTimestamp;
    }

    public String getUpdUserKey() {
        return updUserKey;
    }

    public void setUpdUserKey(String updUserKey) {
        this.updUserKey = updUserKey;
    }

    public String getUpdPgmId() {
        return updPgmId;
    }

    public void setUpdPgmId(String updPgmId) {
        this.updPgmId = updPgmId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }
}