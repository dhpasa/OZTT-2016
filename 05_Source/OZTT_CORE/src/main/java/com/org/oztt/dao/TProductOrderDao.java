package com.org.oztt.dao;

import com.org.oztt.entity.TProductOrder;

public interface TProductOrderDao {
    int deleteByPrimaryKey(Long id);

    int insert(TProductOrder record);

    int insertSelective(TProductOrder record);

    TProductOrder selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TProductOrder record);

    int updateByPrimaryKey(TProductOrder record);
}