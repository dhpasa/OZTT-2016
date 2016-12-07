package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TPowderBoxDao;
import com.org.oztt.entity.TPowderBox;
import com.org.oztt.formDto.PowderBoxInfo;

@Repository
public class TPowderBoxDaoImpl extends BaseDao implements TPowderBoxDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TPowderBox record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TPowderBox record) {
        return insert("com.org.oztt.dao.TPowderBoxMapper.insertSelective", record);
    }

    @Override
    public TPowderBox selectByPrimaryKey(Long id) {
        return selectOne("com.org.oztt.dao.TPowderBoxMapper.selectByPrimaryKey", id);
    }

    @Override
    public int updateByPrimaryKeySelective(TPowderBox record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TPowderBox record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int selectAutoIncrement() {
        return selectOne("com.org.oztt.dao.TPowderBoxMapper.selectAutoIncrement", null);
    }

    @Override
    public List<PowderBoxInfo> selectTPowderList(TPowderBox record) {
        return select("com.org.oztt.dao.TPowderBoxMapper.selectTPowderList", record);
    }

}
