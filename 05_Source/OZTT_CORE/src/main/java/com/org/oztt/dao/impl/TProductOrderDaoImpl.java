package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TProductOrderDao;
import com.org.oztt.entity.TProductOrder;

@Repository
public class TProductOrderDaoImpl extends BaseDao implements TProductOrderDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TProductOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TProductOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TProductOrder selectByPrimaryKey(Long id) {
        return selectOne("com.org.oztt.dao.TPowderOrderMapper.selectByPrimaryKey", id);
    }

    @Override
    public int updateByPrimaryKeySelective(TProductOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TProductOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

}
