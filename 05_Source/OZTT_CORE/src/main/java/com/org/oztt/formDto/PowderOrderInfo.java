package com.org.oztt.formDto;

import java.util.ArrayList;
import java.util.List;

public class PowderOrderInfo {

    private String orderId;
    
    private String orderNo;
    
    private String status;
    
    private String orderDate;
    
    private List<PowderBoxInfo> boxList = new ArrayList<PowderBoxInfo>();
    
    private String totalAmount;
    
    private String paymentMethod;
    
    private String powderOrProductFlg; // 1 是奶粉 2 是产品

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public List<PowderBoxInfo> getBoxList() {
        return boxList;
    }

    public void setBoxList(List<PowderBoxInfo> boxList) {
        this.boxList = boxList;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPowderOrProductFlg() {
        return powderOrProductFlg;
    }

    public void setPowderOrProductFlg(String powderOrProductFlg) {
        this.powderOrProductFlg = powderOrProductFlg;
    }
}
