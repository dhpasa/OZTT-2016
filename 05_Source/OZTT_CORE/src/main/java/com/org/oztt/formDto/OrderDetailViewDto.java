package com.org.oztt.formDto;

import java.util.ArrayList;
import java.util.List;

public class OrderDetailViewDto {
    
    private String orderNo;
    
    private String orderDate;
    
    private String orderDesc;
    
    private String orderStatus;
    
    private List<OrderDetailViewProductDto> productList = new ArrayList<OrderDetailViewProductDto>();
    
    private String yunfeicha;
    
    private String productAmountSum;
    
    private String yunfei;
    
    private String orderAmountSum;
    
    private String powderOrProductFlg; // 1 是奶粉 2 是产品
    
    private List<OrderDetailViewBoxDto> boxList = new ArrayList<OrderDetailViewBoxDto>();
    

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderDesc() {
        return orderDesc;
    }

    public void setOrderDesc(String orderDesc) {
        this.orderDesc = orderDesc;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<OrderDetailViewProductDto> getProductList() {
        return productList;
    }

    public void setProductList(List<OrderDetailViewProductDto> productList) {
        this.productList = productList;
    }

    public String getYunfeicha() {
        return yunfeicha;
    }

    public void setYunfeicha(String yunfeicha) {
        this.yunfeicha = yunfeicha;
    }

    public String getProductAmountSum() {
        return productAmountSum;
    }

    public void setProductAmountSum(String productAmountSum) {
        this.productAmountSum = productAmountSum;
    }

    public String getYunfei() {
        return yunfei;
    }

    public void setYunfei(String yunfei) {
        this.yunfei = yunfei;
    }

    public String getOrderAmountSum() {
        return orderAmountSum;
    }

    public void setOrderAmountSum(String orderAmountSum) {
        this.orderAmountSum = orderAmountSum;
    }

    public List<OrderDetailViewBoxDto> getBoxList() {
        return boxList;
    }

    public void setBoxList(List<OrderDetailViewBoxDto> boxList) {
        this.boxList = boxList;
    }

    public String getPowderOrProductFlg() {
        return powderOrProductFlg;
    }

    public void setPowderOrProductFlg(String powderOrProductFlg) {
        this.powderOrProductFlg = powderOrProductFlg;
    }
    
}
