package com.org.oztt.formDto;

import java.util.List;

/**
 * 订单详细画面
 * @author linliuan
 *
 */
public class OzTtGbOdDto {
    
    private String orderNo;
    
    private String orderStatusView;
    
    private String orderStatus;
    
    private String addressId;
    
    private String receiver;
    
    private String receiverAddress;
    
    private String receiverPhone;
    
    private String paymethod;
    
    private String deliveryCost;
    
    private String deliveryDate;
    
    private String deleveryTime;
    
    private String invoiceType;
    
    private String invoiceHead;
    
    private String invoiceContent;
    
    private String xiaoji;
    
    private String yunfei;
    
    private String heji;
    
    private String deliveryMethod;
    
    private String deliveryMethodView;
    
    private List<ContCartItemDto> goodList;

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderStatusView() {
        return orderStatusView;
    }

    public void setOrderStatusView(String orderStatusView) {
        this.orderStatusView = orderStatusView;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getPaymethod() {
        return paymethod;
    }

    public void setPaymethod(String paymethod) {
        this.paymethod = paymethod;
    }

    public String getDeliveryCost() {
        return deliveryCost;
    }

    public void setDeliveryCost(String deliveryCost) {
        this.deliveryCost = deliveryCost;
    }

    public String getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public String getDeleveryTime() {
        return deleveryTime;
    }

    public void setDeleveryTime(String deleveryTime) {
        this.deleveryTime = deleveryTime;
    }

    public String getInvoiceType() {
        return invoiceType;
    }

    public void setInvoiceType(String invoiceType) {
        this.invoiceType = invoiceType;
    }

    public String getInvoiceHead() {
        return invoiceHead;
    }

    public void setInvoiceHead(String invoiceHead) {
        this.invoiceHead = invoiceHead;
    }

    public String getInvoiceContent() {
        return invoiceContent;
    }

    public void setInvoiceContent(String invoiceContent) {
        this.invoiceContent = invoiceContent;
    }

    public List<ContCartItemDto> getGoodList() {
        return goodList;
    }

    public void setGoodList(List<ContCartItemDto> goodList) {
        this.goodList = goodList;
    }

    public String getXiaoji() {
        return xiaoji;
    }

    public void setXiaoji(String xiaoji) {
        this.xiaoji = xiaoji;
    }

    public String getYunfei() {
        return yunfei;
    }

    public void setYunfei(String yunfei) {
        this.yunfei = yunfei;
    }

    public String getHeji() {
        return heji;
    }

    public void setHeji(String heji) {
        this.heji = heji;
    }

    public String getDeliveryMethod() {
        return deliveryMethod;
    }

    public void setDeliveryMethod(String deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
    }

    public String getAddressId() {
        return addressId;
    }

    public void setAddressId(String addressId) {
        this.addressId = addressId;
    }

    public String getDeliveryMethodView() {
        return deliveryMethodView;
    }

    public void setDeliveryMethodView(String deliveryMethodView) {
        this.deliveryMethodView = deliveryMethodView;
    }
    
    
}
