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
        return update("com.org.oztt.dao.TReceiverInfoMapper.deleteByPrimaryKey", id);
    }

    @Override
    public int insert(TReceiverInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TReceiverInfo record) {
        return insert("com.org.oztt.dao.TReceiverInfoMapper.insertSelective", record);
    }

    @Override
    public TReceiverInfo selectByPrimaryKey(Long id) {
        return selectOne("com.org.oztt.dao.TReceiverInfoMapper.selectByPrimaryKey", id);
    }

    @Override
    public int updateByPrimaryKeySelective(TReceiverInfo record) {
        return update("com.org.oztt.dao.TReceiverInfoMapper.updateByPrimaryKeySelective", record);
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
