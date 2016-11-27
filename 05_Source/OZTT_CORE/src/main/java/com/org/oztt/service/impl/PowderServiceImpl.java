package com.org.oztt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.org.oztt.dao.TExpressInfoDao;
import com.org.oztt.dao.TPowderInfoDao;
import com.org.oztt.dao.TReceiverInfoDao;
import com.org.oztt.dao.TSenderInfoDao;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.entity.TSysCode;
import com.org.oztt.formDto.PowderInfoViewDto;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.CommonService;
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
    
    @Resource
    private CommonService commonService;

    @Override
    public List<TExpressInfo> selectAllExpressInfo() throws Exception {
        return tExpressInfoDao.selectAllExpressInfo();
    }

    @Override
    public List<PowderInfoViewDto> selectPowderInfo() throws Exception {
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

    @Override
    public void insertSendInfo(TSenderInfo tSenderInfo) throws Exception {
        tSenderInfoDao.insertSelective(tSenderInfo);
    }

    @Override
    public void insertReveiverInfo(TReceiverInfo tReceiverInfo) throws Exception {
        tReceiverInfoDao.insertSelective(tReceiverInfo);
    }

    @Override
    public void updateSendInfo(TSenderInfo tSenderInfo) throws Exception {
        tSenderInfoDao.updateByPrimaryKeySelective(tSenderInfo);
    }

    @Override
    public void updateReveiverInfo(TReceiverInfo tReceiverInfo) throws Exception {
        tReceiverInfoDao.updateByPrimaryKeySelective(tReceiverInfo);
    }

    @Override
    public void deleteSendInfo(long id) throws Exception {
        tSenderInfoDao.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteReveiverInfo(long id) throws Exception {
        tReceiverInfoDao.deleteByPrimaryKey(id);
    }

    @Override
    public TSenderInfo getSendInfo(long id) throws Exception {
        return tSenderInfoDao.selectByPrimaryKey(id);
    }

    @Override
    public TReceiverInfo getReveiverInfo(long id) throws Exception {
        return tReceiverInfoDao.selectByPrimaryKey(id);
    }

    @Override
    public String getBrandNameByCode(String code) throws Exception {
        List<TSysCode> codeList = commonService.getPowderStage();
        String res = code;
        if (codeList != null && codeList.size() > 0) {
            for (TSysCode tSysCode : codeList) {
                if (code.equals(tSysCode.getCodedetailid())) {
                    res = tSysCode.getCodedetailname();
                }
            }
        } 
        return res;
    }

}
