package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TReceiverInfoDao;
import com.org.oztt.entity.TReceiverInfo;

@Repository
public class TReceiverInfoDaoImpl extends BaseDao implements TReceiverInfoDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TReceiverInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TReceiverInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TReceiverInfo selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TReceiverInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TReceiverInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<TReceiverInfo> selectReceiveList(String customerId) {
        return select("com.org.oztt.dao.TReceiverInfoMapper.selectReceiveList", customerId);
    }

}
