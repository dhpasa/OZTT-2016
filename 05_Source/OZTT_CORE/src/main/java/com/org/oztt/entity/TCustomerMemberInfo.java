package com.org.oztt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class TCustomerMemberInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *  
     */
    private Long no;

    /**
     *  
     */
    private String customerNo;

    /**
     *  
     */
    private String memberCardNo;

    /**
     *  
     */
    private Integer points;

    /**
     *  
     */
    private String level;
    
    private BigDecimal sumAmount;
    
    private BigDecimal leftAmount;

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

    public Long getNo() {
        return no;
    }

    public void setNo(Long no) {
        this.no = no;
    }

    public String getCustomerNo() {
        return customerNo;
    }

    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

    public String getMemberCardNo() {
        return memberCardNo;
    }

    public void setMemberCardNo(String memberCardNo) {
        this.memberCardNo = memberCardNo;
    }

    public Integer getPoints() {
        return points;
    }

    public void setPoints(Integer points) {
        this.points = points;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
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

    public BigDecimal getSumAmount() {
        return sumAmount;
    }

    public void setSumAmount(BigDecimal sumAmount) {
        this.sumAmount = sumAmount;
    }

    public BigDecimal getLeftAmount() {
        return leftAmount;
    }

    public void setLeftAmount(BigDecimal leftAmount) {
        this.leftAmount = leftAmount;
    }
}