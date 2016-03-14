package com.org.oztt.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TCustomerLoginInfoDao;
import com.org.oztt.entity.TCustomerLoginInfo;

@Repository
public class TCustomerLoginInfoDaoImpl extends BaseDao implements TCustomerLoginInfoDao {

    public int deleteByPrimaryKey(Long no) {
        return update("com.org.oztt.dao.TCustomerLoginInfoDao.deleteByPrimaryKey", no);
    }

    public int insert(TCustomerLoginInfo record) {

        return 0;
    }

    public int insertSelective(TCustomerLoginInfo record) {
        return insert("com.org.oztt.dao.TCustomerLoginInfoDao.insertSelective", record);
    }

    public TCustomerLoginInfo selectByPrimaryKey(Long no) {

        return null;
    }

    public int updateByPrimaryKeySelective(TCustomerLoginInfo record) {
        return update("com.org.oztt.dao.TCustomerLoginInfoDao.updateByPrimaryKeySelective", record);
    }

    public int updateByPrimaryKey(TCustomerLoginInfo record) {
        return update("com.org.oztt.dao.TCustomerLoginInfoDao.updateByPrimaryKey", record);
    }

    public TCustomerLoginInfo userLogin(Map<String, String> map) {
        return selectOne("com.org.oztt.dao.TCustomerLoginInfoDao.checkLoginSuccess", map);
    }

    public TCustomerLoginInfo selectByEmail(String email) {
        return selectOne("com.org.oztt.dao.TCustomerLoginInfoDao.selectByEmail", email);
    }

    public TCustomerLoginInfo selectByCustomerNo(String customerNo) {
        return selectOne("com.org.oztt.dao.TCustomerLoginInfoDao.selectByCustomerNo", customerNo);
    }

    @Override
    public TCustomerLoginInfo selectByParams(TCustomerLoginInfo info) {
        return selectOne("com.org.oztt.dao.TCustomerLoginInfoDao.selectByParams", info);
    }

}
