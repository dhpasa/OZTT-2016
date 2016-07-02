package com.org.oztt.formDto;

import java.util.List;

public class OzTtAdOdDto {
    
    private String orderNo;
    
    private String orderStatus;
    
    private String orderStatusView;
    
    private String deliveryMethodFlag;
    
    private String customerNo;
    
    private String receiver;
    
    private String receAddress;
    
    private String phone;
    
    private String wantArriveTime;
    
    private String yunfei;
    
    private String orderTimestamp;
    
    private String paymentMethod;
    
    private String deliveryMethod;
    
    private String invoiceFlg;
    
    private String orderAmount;
    
    private List<OzTtAdOdListDto> itemList;

    public String getInvoiceFlg() {
		return invoiceFlg;
	}

	public void setInvoiceFlg(String invoiceFlg) {
		this.invoiceFlg = invoiceFlg;
	}

	public String getOrderTimestamp() {
		return orderTimestamp;
	}

	public void setOrderTimestamp(String orderTimestamp) {
		this.orderTimestamp = orderTimestamp;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getDeliveryMethod() {
		return deliveryMethod;
	}

	public void setDeliveryMethod(String deliveryMethod) {
		this.deliveryMethod = deliveryMethod;
	}

	public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getCustomerNo() {
        return customerNo;
    }

    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

    public List<OzTtAdOdListDto> getItemList() {
        return itemList;
    }

    public void setItemList(List<OzTtAdOdListDto> itemList) {
        this.itemList = itemList;
    }

    public String getOrderStatusView() {
        return orderStatusView;
    }

    public void setOrderStatusView(String orderStatusView) {
        this.orderStatusView = orderStatusView;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getReceAddress() {
        return receAddress;
    }

    public void setReceAddress(String receAddress) {
        this.receAddress = receAddress;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getWantArriveTime() {
        return wantArriveTime;
    }

    public void setWantArriveTime(String wantArriveTime) {
        this.wantArriveTime = wantArriveTime;
    }

    public String getYunfei() {
        return yunfei;
    }

    public void setYunfei(String yunfei) {
        this.yunfei = yunfei;
    }

    public String getDeliveryMethodFlag() {
        return deliveryMethodFlag;
    }

    public void setDeliveryMethodFlag(String deliveryMethodFlag) {
        this.deliveryMethodFlag = deliveryMethodFlag;
    }

    public String getOrderAmount() {
        return orderAmount;
    }

    public void setOrderAmount(String orderAmount) {
        this.orderAmount = orderAmount;
    }
}
