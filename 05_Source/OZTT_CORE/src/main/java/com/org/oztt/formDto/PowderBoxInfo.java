package com.org.oztt.formDto;

import java.util.ArrayList;
import java.util.List;

public class PowderBoxInfo {

    private String               boxId;

    private String               orderStatusView;

    private String               status;

    private List<PowderMilkInfo> powderMikeList = new ArrayList<PowderMilkInfo>();

    private String               pricecount;

    private String               expressAmount;

    private String               expressName;

    private String               totalAmount;

    private String               receiveId;

    private String               receiveName;

    private String               receivePhone;

    private String               receiveAddress;

    private String               receiveIdCard;

    private String               receiveCardPhoneBe;

    private String               receiveCardPhoneAf;

    private String               senderId;

    private String               senderName;

    private String               senderPhone;

    private String               senderAddress;

    private String               ifMsg;

    private String               ifRemarks;

    private String               remarks;

    private String               expressPhotoUrlExitFlg;

    private String               expressPhotoUrl;

    private String               boxPhotoUrls;

    private String               boxPhotoUrlsExitFlg;

    private String               elecExpressNo;

    private String               deliverId;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<PowderMilkInfo> getPowderMikeList() {
        return powderMikeList;
    }

    public void setPowderMikeList(List<PowderMilkInfo> powderMikeList) {
        this.powderMikeList = powderMikeList;
    }

    public String getPricecount() {
        return pricecount;
    }

    public void setPricecount(String pricecount) {
        this.pricecount = pricecount;
    }

    public String getExpressName() {
        return expressName;
    }

    public void setExpressName(String expressName) {
        this.expressName = expressName;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getReceiveName() {
        return receiveName;
    }

    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    public String getReceivePhone() {
        return receivePhone;
    }

    public void setReceivePhone(String receivePhone) {
        this.receivePhone = receivePhone;
    }

    public String getReceiveAddress() {
        return receiveAddress;
    }

    public void setReceiveAddress(String receiveAddress) {
        this.receiveAddress = receiveAddress;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSenderPhone() {
        return senderPhone;
    }

    public void setSenderPhone(String senderPhone) {
        this.senderPhone = senderPhone;
    }

    public String getSenderAddress() {
        return senderAddress;
    }

    public void setSenderAddress(String senderAddress) {
        this.senderAddress = senderAddress;
    }

    public String getIfMsg() {
        return ifMsg;
    }

    public void setIfMsg(String ifMsg) {
        this.ifMsg = ifMsg;
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

    public String getBoxId() {
        return boxId;
    }

    public void setBoxId(String boxId) {
        this.boxId = boxId;
    }

    public String getExpressAmount() {
        return expressAmount;
    }

    public void setExpressAmount(String expressAmount) {
        this.expressAmount = expressAmount;
    }

    public String getOrderStatusView() {
        return orderStatusView;
    }

    public void setOrderStatusView(String orderStatusView) {
        this.orderStatusView = orderStatusView;
    }

    public String getExpressPhotoUrlExitFlg() {
        return expressPhotoUrlExitFlg;
    }

    public void setExpressPhotoUrlExitFlg(String expressPhotoUrlExitFlg) {
        this.expressPhotoUrlExitFlg = expressPhotoUrlExitFlg;
    }

    public String getBoxPhotoUrlsExitFlg() {
        return boxPhotoUrlsExitFlg;
    }

    public void setBoxPhotoUrlsExitFlg(String boxPhotoUrlsExitFlg) {
        this.boxPhotoUrlsExitFlg = boxPhotoUrlsExitFlg;
    }

    public String getElecExpressNo() {
        return elecExpressNo;
    }

    public void setElecExpressNo(String elecExpressNo) {
        this.elecExpressNo = elecExpressNo;
    }

    public String getReceiveId() {
        return receiveId;
    }

    public void setReceiveId(String receiveId) {
        this.receiveId = receiveId;
    }

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    public String getReceiveIdCard() {
        return receiveIdCard;
    }

    public void setReceiveIdCard(String receiveIdCard) {
        this.receiveIdCard = receiveIdCard;
    }

    public String getReceiveCardPhoneBe() {
        return receiveCardPhoneBe;
    }

    public void setReceiveCardPhoneBe(String receiveCardPhoneBe) {
        this.receiveCardPhoneBe = receiveCardPhoneBe;
    }

    public String getReceiveCardPhoneAf() {
        return receiveCardPhoneAf;
    }

    public void setReceiveCardPhoneAf(String receiveCardPhoneAf) {
        this.receiveCardPhoneAf = receiveCardPhoneAf;
    }

    public String getDeliverId() {
        return deliverId;
    }

    public void setDeliverId(String deliverId) {
        this.deliverId = deliverId;
    }
}
