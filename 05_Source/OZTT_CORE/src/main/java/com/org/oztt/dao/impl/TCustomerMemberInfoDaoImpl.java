package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TCustomerMemberInfoDao;
import com.org.oztt.entity.TCustomerMemberInfo;

@Repository
public class TCustomerMemberInfoDaoImpl extends BaseDao implements TCustomerMemberInfoDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TCustomerMemberInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TCustomerMemberInfo record) {
        return insert("com.org.oztt.dao.TCustomerMemberInfoDao.insertSelective", record);
    }

    @Override
    public TCustomerMemberInfo selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TCustomerMemberInfo record) {
        return update("com.org.oztt.dao.TCustomerMemberInfoDao.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TCustomerMemberInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TCustomerMemberInfo selectByCustomerNo(String customer) {
        return selectOne("com.org.oztt.dao.TCustomerMemberInfoDao.selectByCustomerNo", customer);
    }

}
