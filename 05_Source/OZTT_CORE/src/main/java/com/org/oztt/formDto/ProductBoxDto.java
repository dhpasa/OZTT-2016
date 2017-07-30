package com.org.oztt.formDto;

import com.org.oztt.packing.util.ProductBox;

public class ProductBoxDto {

    private String elecExpressNo;

    private String expressDate;

    private String expressId;

    private String senderId;

    private String receiverId;

    private String expressName;

    private String senderName;

    private String receiverName;

    private String ifRemarks;

    private String remarks;

    private String ifMsg;

    private String additionalCost;

    private String sumAmount;

    private String expressPhotoUrl;

    private String boxPhotoUrls;

    private String orderId;

    private String handleStatus;

    private String operatorName;

    private String productContent;

    private String weight;

    private String tag;

    public ProductBoxDto(ProductBox box)
    {
        this.elecExpressNo = box.elecExpressNoProperty();
        this.expressDate = box.expressDateProperty();
        this.expressId = box.expressIdProperty();
        this.senderId = box.senderIdProperty();
        this.receiverId = box.receiverIdProperty();
        this.expressName = box.expressNameProperty();
        this.senderName = box.senderNameProperty();
        this.receiverName = box.receiverNameProperty();
        this.ifRemarks = box.ifRemarksProperty();
        this.remarks = box.remarksProperty();
        this.ifMsg = box.ifMsgProperty();
        this.additionalCost = box.additionalCostProperty();
        this.productContent = box.productContentProperty();
        this.expressPhotoUrl = box.expressPhotoUrlProperty();
        this.boxPhotoUrls = box.boxPhotoUrlsProperty();
        this.orderId = box.orderIdProperty();
        this.handleStatus = box.handleStatusProperty();
        this.operatorName = box.operatorNameProperty();
        this.weight = box.weightProperty();
        this.sumAmount = box.sumAmountProperty();
        this.tag = box.tagProperty();
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

    public String getExpressId() {
        return expressId;
    }

    public void setExpressId(String expressId) {
        this.expressId = expressId;
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

    public String getExpressName() {
        return expressName;
    }

    public void setExpressName(String expressName) {
        this.expressName = expressName;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
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

    public String getAdditionalCost() {
        return additionalCost;
    }

    public void setAdditionalCost(String additionalCost) {
        this.additionalCost = additionalCost;
    }

    public String getSumAmount() {
        return sumAmount;
    }

    public void setSumAmount(String sumAmount) {
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

    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    public String getProductContent() {
        return productContent;
    }

    public void setProductContent(String productContent) {
        this.productContent = productContent;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}
