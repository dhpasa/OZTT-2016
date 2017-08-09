package com.org.oztt.formDto;

import java.util.Date;
import java.util.List;

/**
 * 订单信息
 * @author linliuan
 *
 */
public class OrderInfoDto {

    private String orderId;
    
    private String orderDate;
    
    private Date orderDateDB;
    
    private String orderStatus;
    
    private String orderStatusFlag;
    
    private String orderAmount;
    
    private String deliveryMethod;
    
    private String deliveryMethodFlag;
    
    private String deliveryCost;
    
    @SuppressWarnings("unused")
    private int detailCount;
    
    private String consignee; //收货人
    
    private List<ContCartItemDto> itemList;
    
    private String paymentMethod;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public List<ContCartItemDto> getItemList() {
        return itemList;
    }

    public void setItemList(List<ContCartItemDto> itemList) {
        this.itemList = itemList;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getDeliveryMethod() {
        return deliveryMethod;
    }

    public void setDeliveryMethod(String deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
    }

    public Date getOrderDateDB() {
        return orderDateDB;
    }

    public void setOrderDateDB(Date orderDateDB) {
        this.orderDateDB = orderDateDB;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public int getDetailCount() {
        return itemList == null ? 0 : itemList.size();
    }

    public void setDetailCount(int detailCount) {
        this.detailCount = detailCount;
    }

    public String getOrderAmount() {
        return orderAmount;
    }

    public void setOrderAmount(String orderAmount) {
        this.orderAmount = orderAmount;
    }

    public String getOrderStatusFlag() {
        return orderStatusFlag;
    }

    public void setOrderStatusFlag(String orderStatusFlag) {
        this.orderStatusFlag = orderStatusFlag;
    }

    public String getDeliveryMethodFlag() {
        return deliveryMethodFlag;
    }

    public void setDeliveryMethodFlag(String deliveryMethodFlag) {
        this.deliveryMethodFlag = deliveryMethodFlag;
    }

    public String getDeliveryCost() {
        return deliveryCost;
    }

    public void setDeliveryCost(String deliveryCost) {
        this.deliveryCost = deliveryCost;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
}
