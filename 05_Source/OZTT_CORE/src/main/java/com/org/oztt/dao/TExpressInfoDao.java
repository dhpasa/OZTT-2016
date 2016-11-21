package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TExpressInfo;

public interface TExpressInfoDao {
    int deleteByPrimaryKey(Long id);

    int insert(TExpressInfo record);

    int insertSelective(TExpressInfo record);

    TExpressInfo selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TExpressInfo record);

    int updateByPrimaryKey(TExpressInfo record);
    
    List<TExpressInfo> selectAllExpressInfo();
}