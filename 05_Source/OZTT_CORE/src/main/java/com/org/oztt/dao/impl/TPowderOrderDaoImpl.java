package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TPowderOrderDao;
import com.org.oztt.entity.TPowderOrder;

@Repository
public class TPowderOrderDaoImpl extends BaseDao implements TPowderOrderDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TPowderOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TPowderOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TPowderOrder selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TPowderOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TPowderOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

}
