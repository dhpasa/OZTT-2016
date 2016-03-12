package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TCustomerSecurityInfoDao;
import com.org.oztt.entity.TCustomerSecurityInfo;

@Repository
public class TCustomerSecurityInfoDaoImpl extends BaseDao implements TCustomerSecurityInfoDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TCustomerSecurityInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TCustomerSecurityInfo record) {
        return insert("com.org.oztt.dao.TCustomerSecurityInfoDao.insertSelective", record);
    }

    @Override
    public TCustomerSecurityInfo selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TCustomerSecurityInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TCustomerSecurityInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TCustomerSecurityInfo selectByCustomerNo(String customerno) {
        return selectOne("com.org.oztt.dao.TCustomerSecurityInfoDao.selectByCustomerNo", customerno);
    }

}
