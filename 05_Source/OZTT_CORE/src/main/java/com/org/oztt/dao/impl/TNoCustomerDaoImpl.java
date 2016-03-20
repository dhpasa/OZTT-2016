package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TNoCustomerDao;
import com.org.oztt.entity.TNoCustomer;

@Repository
public class TNoCustomerDaoImpl extends BaseDao implements TNoCustomerDao {

    public int deleteByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return 0;
    }

    public int insert(TNoCustomer record) {
        return insert("com.org.oztt.dao.TNoCustomerDao.insert", record);
    }

    public int insertSelective(TNoCustomer record) {
        return insert("com.org.oztt.dao.TNoCustomerDao.insertSelective", record);
    }

    public TNoCustomer selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    public int updateByPrimaryKeySelective(TNoCustomer record) {
        return update("com.org.oztt.dao.TNoCustomerDao.updateByPrimaryKeySelective", record);
    }

    public int updateByPrimaryKey(TNoCustomer record) {
        // TODO Auto-generated method stub
        return 0;
    }

    public TNoCustomer getMaxCustomerNo() {
        return selectOne("com.org.oztt.dao.TNoCustomerDao.selectMaxCustomerNo", null);
    }

}
