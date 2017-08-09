/**
 * 
 */
package com.org.oztt.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.org.oztt.dao.TSysConfigDao;
import com.org.oztt.entity.TSysConfig;
import com.org.oztt.formDto.OzTtAdScDto;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.SysConfigService;

/**
 * @author x-wang
 */
@Service
public class SysConfigServiceImpl extends BaseService implements SysConfigService {

    @Resource
    TSysConfigDao tSysConfigDao;

    @Override
    public TSysConfig getByNo(Long no) {
        return tSysConfigDao.selectByPrimaryKey(no);
    }

    @Override
    public TSysConfig getTopPageAdPic() {
        return tSysConfigDao.selectOne();
    }

    public void updateTopPageAdPic(Long no, String pic) {
        TSysConfig tmp = tSysConfigDao.selectByPrimaryKey(no);
        tmp.setToppageadpic(pic);
        tSysConfigDao.updateByPrimaryKeySelective(tmp);
    }

    @Override
    public TSysConfig getContent(int division) {
        return tSysConfigDao.selectOne();
    }

    @Override
    public void update(OzTtAdScDto ozTtAdScDto) {
        String starModel = ozTtAdScDto.getStartModel();
        if ("1".equals(starModel)) {
            updateTopPageAdPic(ozTtAdScDto.getNo(), ozTtAdScDto.getToppageadpic());
        }
        else {
            int division = ozTtAdScDto.getDivision();
            TSysConfig tmp = tSysConfigDao.selectByPrimaryKey(ozTtAdScDto.getNo());
            switch (division) {
                case 1:
                    tmp.setContactservice(ozTtAdScDto.getContactservice());
                    break;
                case 2:
                    tmp.setShoppercooperation(ozTtAdScDto.getShoppercooperation());
                    break;
                case 3:
                    tmp.setAboutus(ozTtAdScDto.getAboutus());
                    break;
                default:

                    break;
            }
            tSysConfigDao.updateByPrimaryKeySelective(tmp);
        }
    }

    public TSysConfig tSysConfig = null;

    @Override
    public TSysConfig getTSysConfig() {
        if (tSysConfig == null) {
            tSysConfig = tSysConfigDao.selectOne();
            return tSysConfig;
        }
        else {
            return tSysConfig;
        }
    }

    @Override
    public TSysConfig getTSysConfigInRealTime() {
        return tSysConfigDao.selectOne();
    }

}
