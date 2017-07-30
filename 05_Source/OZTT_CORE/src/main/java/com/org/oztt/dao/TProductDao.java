package com.org.oztt.dao;

import com.org.oztt.entity.TProduct;

public interface TProductDao {
    int deleteByPrimaryKey(Long id);

    int insert(TProduct record);

    int insertSelective(TProduct record);

    TProduct selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TProduct record);

    int updateByPrimaryKey(TProduct record);
    
    TProduct selectByParam(TProduct record);
}