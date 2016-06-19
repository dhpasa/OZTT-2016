package com.org.oztt.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TAdminLoginInfoDao;
import com.org.oztt.entity.TAdminLoginInfo;

@Repository
public class TAdminLoginInfoDaoImpl extends BaseDao implements TAdminLoginInfoDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TAdminLoginInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TAdminLoginInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TAdminLoginInfo selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TAdminLoginInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TAdminLoginInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TAdminLoginInfo userLogin(Map<String, String> map) {
        return selectOne("com.org.oztt.dao.TAdminLoginInfoDao.checkLoginSuccess", map);
    }

    @Override
    public TAdminLoginInfo selectByAdminNo(String adminNo) {
        return selectOne("com.org.oztt.dao.TAdminLoginInfoDao.selectByAdminNo", adminNo);
    }
 
}
