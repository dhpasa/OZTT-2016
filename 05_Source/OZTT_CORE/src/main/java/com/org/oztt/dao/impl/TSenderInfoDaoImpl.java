package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TSenderInfoDao;
import com.org.oztt.entity.TSenderInfo;

@Repository
public class TSenderInfoDaoImpl extends BaseDao implements TSenderInfoDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TSenderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TSenderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TSenderInfo selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TSenderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TSenderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<TSenderInfo> selectSendInfoList(String customerId) {
        return select("com.org.oztt.dao.TSenderInfoMapper.selectSendInfoList", customerId);
    }

}
