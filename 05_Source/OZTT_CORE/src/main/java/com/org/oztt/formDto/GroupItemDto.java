package com.org.oztt.formDto;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 团购商品信息
 * 
 * @author linliuan
 */
public class GroupItemDto {

    private String     goodsid;

    private String     classid;

    private String     goodsbrand;

    private String     goodsname;

    private String     goodsdesc;

    private String     goodscomments;

    private String     goodsthumbnail;

    private String     goodssmallpic;

    private String     goodsnormalpic;

    private String     onsaleflg;

    private String     hotsaleflg;

    private String     newsaleflg;

    private BigDecimal disprice;

    private BigDecimal costprice;

    private Integer    sortorder;

    private String     deleteflg;

    private String     groupno;

    private Date       validEndTime;

    private String     countdownTime;

    private String     countdownDay;

    private String     groupMax;       //团购最大数量

    private String     groupCurrent;   //团购现在数量

    public String getGoodsid() {
        return goodsid;
    }

    public void setGoodsid(String goodsid) {
        this.goodsid = goodsid;
    }

    public String getClassid() {
        return classid;
    }

    public void setClassid(String classid) {
        this.classid = classid;
    }

    public String getGoodsbrand() {
        return goodsbrand;
    }

    public void setGoodsbrand(String goodsbrand) {
        this.goodsbrand = goodsbrand;
    }

    public String getGoodsname() {
        return goodsname;
    }

    public void setGoodsname(String goodsname) {
        this.goodsname = goodsname;
    }

    public String getGoodsdesc() {
        return goodsdesc;
    }

    public void setGoodsdesc(String goodsdesc) {
        this.goodsdesc = goodsdesc;
    }

    public String getGoodscomments() {
        return goodscomments;
    }

    public void setGoodscomments(String goodscomments) {
        this.goodscomments = goodscomments;
    }

    public String getGoodsthumbnail() {
        return goodsthumbnail;
    }

    public void setGoodsthumbnail(String goodsthumbnail) {
        this.goodsthumbnail = goodsthumbnail;
    }

    public String getGoodssmallpic() {
        return goodssmallpic;
    }

    public void setGoodssmallpic(String goodssmallpic) {
        this.goodssmallpic = goodssmallpic;
    }

    public String getGoodsnormalpic() {
        return goodsnormalpic;
    }

    public void setGoodsnormalpic(String goodsnormalpic) {
        this.goodsnormalpic = goodsnormalpic;
    }

    public String getOnsaleflg() {
        return onsaleflg;
    }

    public void setOnsaleflg(String onsaleflg) {
        this.onsaleflg = onsaleflg;
    }

    public String getHotsaleflg() {
        return hotsaleflg;
    }

    public void setHotsaleflg(String hotsaleflg) {
        this.hotsaleflg = hotsaleflg;
    }

    public String getNewsaleflg() {
        return newsaleflg;
    }

    public void setNewsaleflg(String newsaleflg) {
        this.newsaleflg = newsaleflg;
    }

    public BigDecimal getCostprice() {
        return costprice;
    }

    public void setCostprice(BigDecimal costprice) {
        this.costprice = costprice;
    }

    public Integer getSortorder() {
        return sortorder;
    }

    public void setSortorder(Integer sortorder) {
        this.sortorder = sortorder;
    }

    public String getDeleteflg() {
        return deleteflg;
    }

    public void setDeleteflg(String deleteflg) {
        this.deleteflg = deleteflg;
    }

    public String getGroupno() {
        return groupno;
    }

    public void setGroupno(String groupno) {
        this.groupno = groupno;
    }

    public BigDecimal getDisprice() {
        return disprice;
    }

    public void setDisprice(BigDecimal disprice) {
        this.disprice = disprice;
    }

    public String getCountdownTime() {
        return countdownTime;
    }

    public void setCountdownTime(String countdownTime) {
        this.countdownTime = countdownTime;
    }

    public Date getValidEndTime() {
        return validEndTime;
    }

    public void setValidEndTime(Date validEndTime) {
        this.validEndTime = validEndTime;
    }

    public String getCountdownDay() {
        return countdownDay;
    }

    public void setCountdownDay(String countdownDay) {
        this.countdownDay = countdownDay;
    }

    public String getGroupMax() {
        return groupMax;
    }

    public void setGroupMax(String groupMax) {
        this.groupMax = groupMax;
    }

    public String getGroupCurrent() {
        return groupCurrent;
    }

    public void setGroupCurrent(String groupCurrent) {
        this.groupCurrent = groupCurrent;
    }

}
