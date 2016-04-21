package com.org.oztt.entity;

import java.math.BigDecimal;
import java.util.Date;

public class TConsOrder {
    private Long no;

    private String orderno;

    private String customerno;

    private BigDecimal orderamount;

    private String paymentmethod;

    private Date ordertimestamp;

    private Date paymenttimestamp;

    private String handleflg;

    private String deliverymethod;

    private Long addressid;
    
    private String homedeliverytime;

    private String invoiceflg;
    
    private String invoiceno;

    private BigDecimal deliverycost;

    private String transactionno;

    private Date addtimestamp;

    private String adduserkey;

    private Date updtimestamp;

    private String upduserkey;

    private String updpgmid;

    public Long getNo() {
        return no;
    }

    public void setNo(Long no) {
        this.no = no;
    }

    public String getOrderno() {
        return orderno;
    }

    public void setOrderno(String orderno) {
        this.orderno = orderno;
    }

    public String getCustomerno() {
        return customerno;
    }

    public void setCustomerno(String customerno) {
        this.customerno = customerno;
    }

    public BigDecimal getOrderamount() {
        return orderamount;
    }

    public void setOrderamount(BigDecimal orderamount) {
        this.orderamount = orderamount;
    }

    public String getPaymentmethod() {
        return paymentmethod;
    }

    public void setPaymentmethod(String paymentmethod) {
        this.paymentmethod = paymentmethod;
    }

    public Date getOrdertimestamp() {
        return ordertimestamp;
    }

    public void setOrdertimestamp(Date ordertimestamp) {
        this.ordertimestamp = ordertimestamp;
    }

    public Date getPaymenttimestamp() {
        return paymenttimestamp;
    }

    public void setPaymenttimestamp(Date paymenttimestamp) {
        this.paymenttimestamp = paymenttimestamp;
    }

    public String getHandleflg() {
        return handleflg;
    }

    public void setHandleflg(String handleflg) {
        this.handleflg = handleflg;
    }

    public String getDeliverymethod() {
        return deliverymethod;
    }

    public void setDeliverymethod(String deliverymethod) {
        this.deliverymethod = deliverymethod;
    }

    public Long getAddressid() {
        return addressid;
    }

    public void setAddressid(Long addressid) {
        this.addressid = addressid;
    }

    public BigDecimal getDeliverycost() {
        return deliverycost;
    }

    public void setDeliverycost(BigDecimal deliverycost) {
        this.deliverycost = deliverycost;
    }

    public String getTransactionno() {
        return transactionno;
    }

    public void setTransactionno(String transactionno) {
        this.transactionno = transactionno;
    }

    public Date getAddtimestamp() {
        return addtimestamp;
    }

    public void setAddtimestamp(Date addtimestamp) {
        this.addtimestamp = addtimestamp;
    }

    public String getAdduserkey() {
        return adduserkey;
    }

    public void setAdduserkey(String adduserkey) {
        this.adduserkey = adduserkey;
    }

    public Date getUpdtimestamp() {
        return updtimestamp;
    }

    public void setUpdtimestamp(Date updtimestamp) {
        this.updtimestamp = updtimestamp;
    }

    public String getUpduserkey() {
        return upduserkey;
    }

    public void setUpduserkey(String upduserkey) {
        this.upduserkey = upduserkey;
    }

    public String getUpdpgmid() {
        return updpgmid;
    }

    public void setUpdpgmid(String updpgmid) {
        this.updpgmid = updpgmid;
    }

    public String getHomedeliverytime() {
        return homedeliverytime;
    }

    public void setHomedeliverytime(String homedeliverytime) {
        this.homedeliverytime = homedeliverytime;
    }

    public String getInvoiceflg() {
        return invoiceflg;
    }

    public void setInvoiceflg(String invoiceflg) {
        this.invoiceflg = invoiceflg;
    }

    public String getInvoiceno() {
        return invoiceno;
    }

    public void setInvoiceno(String invoiceno) {
        this.invoiceno = invoiceno;
    }


}