package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TProductDao;
import com.org.oztt.entity.TProduct;

@Repository
public class TProductDaoImpl extends BaseDao implements TProductDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TProduct record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TProduct record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TProduct selectByPrimaryKey(Long id) {
        return selectOne("com.org.oztt.dao.TProductMapper.selectByPrimaryKey", id);
    }

    @Override
    public int updateByPrimaryKeySelective(TProduct record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TProduct record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TProduct selectByParam(TProduct record) {
        return selectOne("com.org.oztt.dao.TProductMapper.selectByParam", record);
    }

}
