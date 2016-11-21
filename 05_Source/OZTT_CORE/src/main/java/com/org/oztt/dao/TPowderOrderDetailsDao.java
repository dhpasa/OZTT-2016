package com.org.oztt.dao;

import com.org.oztt.entity.TPowderOrderDetails;

public interface TPowderOrderDetailsDao {
    int deleteByPrimaryKey(Long id);

    int insert(TPowderOrderDetails record);

    int insertSelective(TPowderOrderDetails record);

    TPowderOrderDetails selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TPowderOrderDetails record);

    int updateByPrimaryKey(TPowderOrderDetails record);
}