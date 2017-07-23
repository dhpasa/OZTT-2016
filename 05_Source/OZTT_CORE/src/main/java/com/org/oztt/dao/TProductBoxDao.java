package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TProductBox;
import com.org.oztt.formDto.PowderBoxInfo;

public interface TProductBoxDao {
    int deleteByPrimaryKey(Long id);

    int insert(TProductBox record);

    int insertSelective(TProductBox record);

    TProductBox selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TProductBox record);

    int updateByPrimaryKey(TProductBox record);
    
    List<PowderBoxInfo> selectTProductList(TProductBox record);
}