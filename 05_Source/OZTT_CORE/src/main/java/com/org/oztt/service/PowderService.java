package com.org.oztt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TPowderBox;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.formDto.PowderBoxInfo;
import com.org.oztt.formDto.PowderInfoViewDto;
import com.org.oztt.formDto.PowderOrderInfo;

public interface PowderService {

    /**
     * 获取快递信息
     * 
     * @return
     * @throws Exception
     */
    public List<TExpressInfo> selectAllExpressInfo() throws Exception;

    /**
     * 获取奶粉信息
     * 
     * @return
     * @throws Exception
     */
    public List<PowderInfoViewDto> selectPowderInfo() throws Exception;

    /**
     * 检索当前客户收件信息
     * 
     * @param customerNo 客户号
     * @return
     * @throws Exception
     */
    public List<TReceiverInfo> selectReceiverInfoList(String customerNo) throws Exception;

    /**
     * 检索当前客户送件信息
     * 
     * @param customerNo
     * @return
     * @throws Exception
     */
    public List<TSenderInfo> selectSenderInfoList(String customerNo) throws Exception;

    /**
     * 登录发件人信息
     * 
     * @param tSenderInfo
     * @throws Exception
     */
    public void insertSendInfo(TSenderInfo tSenderInfo) throws Exception;

    /**
     * 登录收件人信息
     * 
     * @param tReceiverInfo
     * @throws Exception
     */
    public void insertReveiverInfo(TReceiverInfo tReceiverInfo) throws Exception;

    /**
     * 更新发件人信息
     * 
     * @param tSenderInfo
     * @throws Exception
     */
    public void updateSendInfo(TSenderInfo tSenderInfo) throws Exception;

    /**
     * 更新收件人信息
     * 
     * @param tReceiverInfo
     * @throws Exception
     */
    public void updateReveiverInfo(TReceiverInfo tReceiverInfo) throws Exception;

    /**
     * 删除发件人信息
     * 
     * @param id
     * @throws Exception
     */
    public void deleteSendInfo(long id) throws Exception;

    /**
     * 删除收货人信息
     * 
     * @param id
     * @throws Exception
     */
    public void deleteReveiverInfo(long id) throws Exception;

    /**
     * 检索发件人信息
     * 
     * @param id
     * @throws Exception
     */
    public TSenderInfo getSendInfo(long id) throws Exception;

    /**
     * 检索收货人信息
     * 
     * @param id
     * @throws Exception
     */
    public TReceiverInfo getReveiverInfo(long id) throws Exception;

    /**
     * 通过code获取品牌名称
     * 
     * @param code
     * @return
     * @throws Exception
     */
    public String getBrandNameByCode(String code) throws Exception;

    /**
     * 将数据登录到数据库
     * @param resList
     * @throws Exception
     */
    public Map<String, String> insertPowderInfo(List<Map<String, Object>> resList, String customerId, String payType) throws Exception;
    
    /**
     * 通过订单号获取奶粉订单信息
     * @param orderNo
     * @return
     * @throws Exception
     */
    public TPowderOrder getTPowderOrderByOrderNo(String orderNo) throws Exception;
    
    /**
     * 生成入出账记录
     * @param orderId
     * @param customerNo
     * @param session
     * @param serialNo
     * @throws Exception
     */
    public void updateOrderAfterPay(String orderId, String customerNo, HttpSession session, String serialNo, String transactionType) throws Exception;
    
    /**
     * 更新奶粉订单数据
     * @param tPowderOrder
     */
    public void updatePowderOrder(TPowderOrder tPowderOrder) throws Exception;
    
    /**
     * 通过参数获取
     * @param orderNo
     * @return
     * @throws Exception
     */
    public List<TPowderOrder> getTPowderOrderInfoList(TPowderOrder tPowderOrder) throws Exception;
    
    /**
     * 
     * @param tPowderOrder
     * @return
     * @throws Exception
     */
    public PagingResult<PowderOrderInfo> getPowderOrderPageInfo(Pagination pagination) throws Exception;
    
    /**
     * 通过ID获取装箱信息
     * @param id
     * @return
     * @throws Exception
     */
    public PowderBoxInfo getPowderInfoById(long id) throws Exception;
    
    /**
     * 删除三十分钟之内没有付款的订单
     * @return
     * @throws Exception
     */
    public void deleteNotPayPowderOrderLimitTime() throws Exception;
    
    /**
     * 生成快递单照片
     * @param orderNo 订单号码
     * @throws Exception
     */
    public void createExpressPhotoUrl(String orderNo) throws Exception;
    
    /**
     * 发送信息
     * @param powderOrder
     * @throws Exception
     */
    public void sendMsgOnNewOrder(String phone, List<TPowderBox> boxList) throws Exception;
}
