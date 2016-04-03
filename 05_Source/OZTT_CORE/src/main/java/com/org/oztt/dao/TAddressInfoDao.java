package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TAddressInfo;

public interface TAddressInfoDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long id);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TAddressInfo record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TAddressInfo record);

    /**
     * 根据主键查询记录
     */
    TAddressInfo selectByPrimaryKey(Long id);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TAddressInfo record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TAddressInfo record);
    
    /**
     * 取得当前用户所有的地址
     * @param customerno
     * @return
     */
    List<TAddressInfo> getAllAddress(String customerno, String deliveryMethod);
    
    /**
     * 取得当前用户所有的地址
     * @param customerno
     * @return
     */
    List<TAddressInfo> getAllAddress(String customerno);
    
    
}