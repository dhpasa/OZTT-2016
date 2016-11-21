package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TExpressInfoDao;
import com.org.oztt.entity.TExpressInfo;

@Repository
public class TExpressInfoDaoImpl extends BaseDao implements TExpressInfoDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TExpressInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TExpressInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TExpressInfo selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TExpressInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TExpressInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<TExpressInfo> selectAllExpressInfo() {
        return select("com.org.oztt.dao.TExpressInfoMapper.selectAllExpressInfo", null);
    }

}
