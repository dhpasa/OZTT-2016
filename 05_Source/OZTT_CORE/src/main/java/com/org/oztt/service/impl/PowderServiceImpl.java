package com.org.oztt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.org.oztt.dao.TExpressInfoDao;
import com.org.oztt.dao.TPowderInfoDao;
import com.org.oztt.dao.TReceiverInfoDao;
import com.org.oztt.dao.TSenderInfoDao;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TPowderInfo;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.PowderService;

@Service
public class PowderServiceImpl extends BaseService implements PowderService {
    
    @Resource
    private TExpressInfoDao tExpressInfoDao;
    
    @Resource
    private TPowderInfoDao tPowderInfoDao;
    
    @Resource
    private TReceiverInfoDao tReceiverInfoDao;
    
    @Resource
    private TSenderInfoDao tSenderInfoDao;

    @Override
    public List<TExpressInfo> selectAllExpressInfo() throws Exception {
        return tExpressInfoDao.selectAllExpressInfo();
    }

    @Override
    public List<TPowderInfo> selectPowderInfo() throws Exception {
        return tPowderInfoDao.selectAllPowderInfoList();
    }

    @Override
    public List<TReceiverInfo> selectReceiverInfoList(String customerNo) throws Exception {
        return tReceiverInfoDao.selectReceiveList(customerNo);
    }

    @Override
    public List<TSenderInfo> selectSenderInfoList(String customerNo) throws Exception {
        return tSenderInfoDao.selectSendInfoList(customerNo);
    }

}
