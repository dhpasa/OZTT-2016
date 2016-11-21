package com.org.oztt.service;

import java.util.List;

import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TPowderInfo;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;

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
    public List<TPowderInfo> selectPowderInfo() throws Exception;
    
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
}
