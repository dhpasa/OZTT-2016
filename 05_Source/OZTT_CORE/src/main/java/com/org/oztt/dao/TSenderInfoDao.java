package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TSenderInfo;

public interface TSenderInfoDao {
    int deleteByPrimaryKey(Long id);

    int insert(TSenderInfo record);

    int insertSelective(TSenderInfo record);

    TSenderInfo selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TSenderInfo record);

    int updateByPrimaryKey(TSenderInfo record);
    
    List<TSenderInfo> selectSendInfoList(String customerId);
}