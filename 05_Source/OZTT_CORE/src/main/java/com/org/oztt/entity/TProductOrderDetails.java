package com.org.oztt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class TProductOrderDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *  
     */
    private Long id;

    /**
     *  
     */
    private String productId;

    /**
     *  
     */
    private BigDecimal quantity;

    /**
     *  
     */
    private BigDecimal unitPrice;

    /**
     *  
     */
    private String productBoxId;

    /**
     *  
     */
    private Date addTimestamp;

    /**
     *  
     */
    private String addUserKey;

    /**
     *  
     */
    private Date updTimestamp;

    /**
     *  
     */
    private String updUserKey;

    /**
     *  
     */
    private String updPgmId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getProductBoxId() {
        return productBoxId;
    }

    public void setProductBoxId(String productBoxId) {
        this.productBoxId = productBoxId;
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