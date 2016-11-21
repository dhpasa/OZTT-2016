package com.org.oztt.dao;

import com.org.oztt.entity.TPowderOrder;

public interface TPowderOrderDao {
    int deleteByPrimaryKey(Long id);

    int insert(TPowderOrder record);

    int insertSelective(TPowderOrder record);

    TPowderOrder selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TPowderOrder record);

    int updateByPrimaryKey(TPowderOrder record);
}