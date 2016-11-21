package com.org.oztt.dao;

import com.org.oztt.entity.TPowderBox;

public interface TPowderBoxDao {
    int deleteByPrimaryKey(Long id);

    int insert(TPowderBox record);

    int insertSelective(TPowderBox record);

    TPowderBox selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TPowderBox record);

    int updateByPrimaryKey(TPowderBox record);
}