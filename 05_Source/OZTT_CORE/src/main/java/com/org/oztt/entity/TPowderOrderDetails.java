package com.org.oztt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class TPowderOrderDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *  
     */
    private Long              id;

    /**
     *  
     */
    private String            powderId;

    /**
     *  
     */
    private Long              quantity;

    /**
     *  
     */
    private BigDecimal        unitPrice;

    /**
     *  
     */
    private String            powderBoxId;

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

    public String getPowderId() {
        return powderId;
    }

    public void setPowderId(String powderId) {
        this.powderId = powderId;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getPowderBoxId() {
        return powderBoxId;
    }

    public void setPowderBoxId(String powderBoxId) {
        this.powderBoxId = powderBoxId;
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