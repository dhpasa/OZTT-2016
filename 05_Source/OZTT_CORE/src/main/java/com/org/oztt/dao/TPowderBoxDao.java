package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TPowderBox;
import com.org.oztt.formDto.PowderBoxInfo;

public interface TPowderBoxDao {
    int deleteByPrimaryKey(Long id);

    int insert(TPowderBox record);

    int insertSelective(TPowderBox record);

    TPowderBox selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TPowderBox record);

    int updateByPrimaryKey(TPowderBox record);
    
    int selectAutoIncrement();
    
    List<PowderBoxInfo> selectTPowderList(TPowderBox record);
    
    List<TPowderBox> selectTPowderBoxList(TPowderBox record);
}