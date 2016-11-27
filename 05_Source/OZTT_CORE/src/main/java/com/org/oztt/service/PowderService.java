package com.org.oztt.service;

import java.util.List;

import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.formDto.PowderInfoViewDto;

public interface PowderService {

    /**
     * 获取快递信息
     * @return
     * @throws Exception
     */
    public List<TExpressInfo> selectAllExpressInfo() throws Exception;
    
    /**
     * 获取奶粉信息
     * @return
     * @throws Exception
     */
    public List<PowderInfoViewDto> selectPowderInfo() throws Exception;
    
    /**
     * 检索当前客户收件信息
     * @param customerNo 客户号
     * @return
     * @throws Exception
     */
    public List<TReceiverInfo> selectReceiverInfoList(String customerNo) throws Exception;
    
    /**
     * 检索当前客户送件信息
     * @param customerNo
     * @return
     * @throws Exception
     */
    public List<TSenderInfo> selectSenderInfoList(String customerNo) throws Exception;
    
    /**
     * 登录发件人信息
     * @param tSenderInfo
     * @throws Exception
     */
    public void insertSendInfo(TSenderInfo tSenderInfo) throws Exception;
    
    /**
     * 登录收件人信息
     * @param tReceiverInfo
     * @throws Exception
     */
    public void insertReveiverInfo(TReceiverInfo tReceiverInfo) throws Exception;
    
    /**
     * 更新发件人信息
     * @param tSenderInfo
     * @throws Exception
     */
    public void updateSendInfo(TSenderInfo tSenderInfo) throws Exception;
    
    /**
     * 更新收件人信息
     * @param tReceiverInfo
     * @throws Exception
     */
    public void updateReveiverInfo(TReceiverInfo tReceiverInfo) throws Exception;
    
    /**
     * 删除发件人信息
     * @param id
     * @throws Exception
     */
    public void deleteSendInfo(long id) throws Exception;
    
    /**
     * 删除收货人信息
     * @param id
     * @throws Exception
     */
    public void deleteReveiverInfo(long id) throws Exception;
    
    /**
     * 检索发件人信息
     * @param id
     * @throws Exception
     */
    public TSenderInfo getSendInfo(long id) throws Exception;
    
    /**
     * 检索收货人信息
     * @param id
     * @throws Exception
     */
    public TReceiverInfo getReveiverInfo(long id) throws Exception;
    
    /**
     * 通过code获取品牌名称
     * @param code
     * @return
     * @throws Exception
     */
    public String getBrandNameByCode(String code) throws Exception;
}
