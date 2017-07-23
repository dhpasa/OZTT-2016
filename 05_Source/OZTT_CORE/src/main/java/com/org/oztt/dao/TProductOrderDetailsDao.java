package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TProductOrderDetails;
import com.org.oztt.formDto.PowderMilkInfo;

public interface TProductOrderDetailsDao {
    int deleteByPrimaryKey(Long id);

    int insert(TProductOrderDetails record);

    int insertSelective(TProductOrderDetails record);

    TProductOrderDetails selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TProductOrderDetails record);

    int updateByPrimaryKey(TProductOrderDetails record);
    
    List<PowderMilkInfo> selectProductDetailsListByOrderNo(String orderId);
}