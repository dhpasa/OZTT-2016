package com.org.oztt.entity;

import java.io.Serializable;
import java.math.BigDecimal;

public class TSysConfig implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long no;

    private int goodssearchkey1;
    
    private String goodssearchvalue1;
    
    private int goodssearchkey2;
    
    private String goodssearchvalue2;
    
    private int goodssearchkey3;
    
    private String goodssearchvalue3;
    
    private String toppageadpic;
    
    private String contactservice;
    
    private String shoppercooperation;
    
    private String aboutus;
    
    private String levelsumamount;
    
    private BigDecimal pointcalcamount;
    
    private BigDecimal discountrate;

	public Long getNo() {
		return no;
	}

	public void setNo(Long no) {
		this.no = no;
	}

	public int getGoodssearchkey1() {
		return goodssearchkey1;
	}

	public void setGoodssearchkey1(int goodssearchkey1) {
		this.goodssearchkey1 = goodssearchkey1;
	}

	public String getGoodssearchvalue1() {
		return goodssearchvalue1;
	}

	public void setGoodssearchvalue1(String goodssearchvalue1) {
		this.goodssearchvalue1 = goodssearchvalue1;
	}

	public int getGoodssearchkey2() {
		return goodssearchkey2;
	}

	public void setGoodssearchkey2(int goodssearchkey2) {
		this.goodssearchkey2 = goodssearchkey2;
	}

	public String getGoodssearchvalue2() {
		return goodssearchvalue2;
	}

	public void setGoodssearchvalue2(String goodssearchvalue2) {
		this.goodssearchvalue2 = goodssearchvalue2;
	}

	public int getGoodssearchkey3() {
		return goodssearchkey3;
	}

	public void setGoodssearchkey3(int goodssearchkey3) {
		this.goodssearchkey3 = goodssearchkey3;
	}

	public String getGoodssearchvalue3() {
		return goodssearchvalue3;
	}

	public void setGoodssearchvalue3(String goodssearchvalue3) {
		this.goodssearchvalue3 = goodssearchvalue3;
	}

	public String getToppageadpic() {
		return toppageadpic;
	}

	public void setToppageadpic(String toppageadpic) {
		this.toppageadpic = toppageadpic;
	}

	public String getContactservice() {
		return contactservice;
	}

	public void setContactservice(String contactservice) {
		this.contactservice = contactservice;
	}

	public String getShoppercooperation() {
		return shoppercooperation;
	}

	public void setShoppercooperation(String shoppercooperation) {
		this.shoppercooperation = shoppercooperation;
	}

	public String getAboutus() {
		return aboutus;
	}

	public void setAboutus(String aboutus) {
		this.aboutus = aboutus;
	}

	public String getLevelsumamount() {
		return levelsumamount;
	}

	public void setLevelsumamount(String levelsumamount) {
		this.levelsumamount = levelsumamount;
	}

	public BigDecimal getPointcalcamount() {
		return pointcalcamount;
	}

	public void setPointcalcamount(BigDecimal pointcalcamount) {
		this.pointcalcamount = pointcalcamount;
	}

	public BigDecimal getDiscountrate() {
		return discountrate;
	}

	public void setDiscountrate(BigDecimal discountrate) {
		this.discountrate = discountrate;
	}

}