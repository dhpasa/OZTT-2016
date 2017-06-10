package com.org.oztt.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class TExpressInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *  
     */
    private Long              id;

    /**
     *  
     */
    private String            expressName;

    /**
     *  
     */
    private String            remarks;

    /**
     *  
     */
    private BigDecimal        priceCoefficient;

    private BigDecimal        babyKiloCost;         //婴儿奶粉每公斤运费

    private BigDecimal        instantKiloCost;      // 成人奶粉每公斤运费

    private String            babyOriginalBoxFlg;   // 婴儿奶粉6罐原装许可

    private String            instantOriginalBoxFlg; // 成人奶粉8罐原装许可

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

    public String getExpressName() {
        return expressName;
    }

    public void setExpressName(String expressName) {
        this.expressName = expressName;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public BigDecimal getPriceCoefficient() {
        return priceCoefficient;
    }

    public void setPriceCoefficient(BigDecimal priceCoefficient) {
        this.priceCoefficient = priceCoefficient;
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

    public BigDecimal getBabyKiloCost() {
        return babyKiloCost;
    }

    public void setBabyKiloCost(BigDecimal babyKiloCost) {
        this.babyKiloCost = babyKiloCost;
    }

    public BigDecimal getInstantKiloCost() {
        return instantKiloCost;
    }

    public void setInstantKiloCost(BigDecimal instantKiloCost) {
        this.instantKiloCost = instantKiloCost;
    }

    public String getBabyOriginalBoxFlg() {
        return babyOriginalBoxFlg;
    }

    public void setBabyOriginalBoxFlg(String babyOriginalBoxFlg) {
        this.babyOriginalBoxFlg = babyOriginalBoxFlg;
    }

    public String getInstantOriginalBoxFlg() {
        return instantOriginalBoxFlg;
    }

    public void setInstantOriginalBoxFlg(String instantOriginalBoxFlg) {
        this.instantOriginalBoxFlg = instantOriginalBoxFlg;
    }
}