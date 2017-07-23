package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TPowderOrderDetails;
import com.org.oztt.formDto.PowderMilkInfo;

public interface TPowderOrderDetailsDao {
    int deleteByPrimaryKey(Long id);

    int insert(TPowderOrderDetails record);

    int insertSelective(TPowderOrderDetails record);

    TPowderOrderDetails selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TPowderOrderDetails record);

    int updateByPrimaryKey(TPowderOrderDetails record);
    
    List<PowderMilkInfo> selectPowderDetailList(TPowderOrderDetails record);
    
    List<PowderMilkInfo> selectPowderDetailsListByOrderNo(String orderId);
    
    
}