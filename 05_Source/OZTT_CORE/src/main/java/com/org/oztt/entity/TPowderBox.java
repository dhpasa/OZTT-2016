package com.org.oztt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class TPowderBox implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *  
     */
    private Long              id;

    /**
     *  
     */
    private String            elecExpressNo;

    /**
     *  
     */
    private String            expressDate;

    /**
     *  
     */
    private String            deliverId;

    /**
     *  
     */
    private String            senderId;

    /**
     *  
     */
    private String            receiverId;

    /**
     *  
     */
    private String            ifRemarks;

    /**
     *  
     */
    private String            remarks;

    /**
     *  
     */
    private String            ifMsg;

    /**
     *  
     */
    private BigDecimal        additionalCost;

    /**
     *  
     */
    private BigDecimal        sumAmount;

    /**
     *  
     */
    private String            expressPhotoUrl;

    /**
     *  
     */
    private String            boxPhotoUrls;

    /**
     *  
     */
    private String            orderId;

    /**
     *  
     */
    private String            handleStatus;

    private Date              addTimestamp;

    private String            addUserKey;

    private Date              updTimestamp;

    private String            updUserKey;

    private String            updPgmId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getElecExpressNo() {
        return elecExpressNo;
    }

    public void setElecExpressNo(String elecExpressNo) {
        this.elecExpressNo = elecExpressNo;
    }

    public String getExpressDate() {
        return expressDate;
    }

    public void setExpressDate(String expressDate) {
        this.expressDate = expressDate;
    }

    public String getDeliverId() {
        return deliverId;
    }

    public void setDeliverId(String deliverId) {
        this.deliverId = deliverId;
    }

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    public String getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(String receiverId) {
        this.receiverId = receiverId;
    }

    public String getIfRemarks() {
        return ifRemarks;
    }

    public void setIfRemarks(String ifRemarks) {
        this.ifRemarks = ifRemarks;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getIfMsg() {
        return ifMsg;
    }

    public void setIfMsg(String ifMsg) {
        this.ifMsg = ifMsg;
    }

    public BigDecimal getAdditionalCost() {
        return additionalCost;
    }

    public void setAdditionalCost(BigDecimal additionalCost) {
        this.additionalCost = additionalCost;
    }

    public BigDecimal getSumAmount() {
        return sumAmount;
    }

    public void setSumAmount(BigDecimal sumAmount) {
        this.sumAmount = sumAmount;
    }

    public String getExpressPhotoUrl() {
        return expressPhotoUrl;
    }

    public void setExpressPhotoUrl(String expressPhotoUrl) {
        this.expressPhotoUrl = expressPhotoUrl;
    }

    public String getBoxPhotoUrls() {
        return boxPhotoUrls;
    }

    public void setBoxPhotoUrls(String boxPhotoUrls) {
        this.boxPhotoUrls = boxPhotoUrls;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getHandleStatus() {
        return handleStatus;
    }

    public void setHandleStatus(String handleStatus) {
        this.handleStatus = handleStatus;
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
}