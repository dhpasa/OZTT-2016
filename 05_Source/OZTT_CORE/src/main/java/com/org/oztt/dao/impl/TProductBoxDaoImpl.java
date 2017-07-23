package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TProductBoxDao;
import com.org.oztt.entity.TProductBox;
import com.org.oztt.formDto.PowderBoxInfo;

@Repository
public class TProductBoxDaoImpl extends BaseDao implements TProductBoxDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TProductBox record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TProductBox record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TProductBox selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TProductBox record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TProductBox record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<PowderBoxInfo> selectTProductList(TProductBox record) {
        return select("com.org.techcoffee.dao.TProductBoxMapper.selectTProductList", record);
    }

}
