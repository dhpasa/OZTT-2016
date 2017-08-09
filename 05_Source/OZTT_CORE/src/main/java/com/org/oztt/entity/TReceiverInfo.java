package com.org.oztt.entity;

import java.io.Serializable;
import java.util.Date;

public class TReceiverInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *  
     */
    private Long              id;

    /**
     *  
     */
    private String            receiverName;

    /**
     *  
     */
    private String            receiverTel;

    /**
     *  
     */
    private String            receiverAddr;

    /**
     *  
     */
    private String            receiverIdCardNo;

    /**
     *  
     */
    private String            receiverIdCardPhotoUrls;

    /**
     *  
     */
    private String            customerId;

    /**
     *  
     */
    private String            deleteFlg;

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

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverTel() {
        return receiverTel;
    }

    public void setReceiverTel(String receiverTel) {
        this.receiverTel = receiverTel;
    }

    public String getReceiverAddr() {
        return receiverAddr;
    }

    public void setReceiverAddr(String receiverAddr) {
        this.receiverAddr = receiverAddr;
    }

    public String getReceiverIdCardNo() {
        return receiverIdCardNo;
    }

    public void setReceiverIdCardNo(String receiverIdCardNo) {
        this.receiverIdCardNo = receiverIdCardNo;
    }

    public String getReceiverIdCardPhotoUrls() {
        return receiverIdCardPhotoUrls;
    }

    public void setReceiverIdCardPhotoUrls(String receiverIdCardPhotoUrls) {
        this.receiverIdCardPhotoUrls = receiverIdCardPhotoUrls;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getDeleteFlg() {
        return deleteFlg;
    }

    public void setDeleteFlg(String deleteFlg) {
        this.deleteFlg = deleteFlg;
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