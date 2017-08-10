package com.org.oztt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class TPowderInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *  
     */
    private Long              id;

    /**
     *  
     */
    private String            powderNo;

    /**
     *  
     */
    private String            powderType;

    /**
     *  
     */
    private String            powderBrand;

    /**
     *  
     */
    private String            powderSpec;

    /**
     *  
     */
    private BigDecimal        powderPrice;
    
    private BigDecimal        weight;
    
    private BigDecimal        freeDeliveryParameter;
    
    private BigDecimal        freeDeliveryParameter2;
    /**
     *  
     */
    private String            remarks;

    /**
     *  
     */
    private String            status;

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

    public String getPowderNo() {
        return powderNo;
    }

    public void setPowderNo(String powderNo) {
        this.powderNo = powderNo;
    }

    public String getPowderType() {
        return powderType;
    }

    public void setPowderType(String powderType) {
        this.powderType = powderType;
    }

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

    public BigDecimal getPowderPrice() {
        return powderPrice;
    }

    public void setPowderPrice(BigDecimal powderPrice) {
        this.powderPrice = powderPrice;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public BigDecimal getFreeDeliveryParameter2() {
        return freeDeliveryParameter2;
    }

    public void setFreeDeliveryParameter2(BigDecimal freeDeliveryParameter2) {
        this.freeDeliveryParameter2 = freeDeliveryParameter2;
    }

    
}