package com.org.oztt.dao;

import com.org.oztt.entity.TCustomerSecurityInfo;

public interface TCustomerSecurityInfoDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long no);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TCustomerSecurityInfo record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TCustomerSecurityInfo record);

    /**
     * 根据主键查询记录
     */
    TCustomerSecurityInfo selectByPrimaryKey(Long no);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TCustomerSecurityInfo record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TCustomerSecurityInfo record);
    
    /**
     * 根据用户号抽出数据
     * @param customerno
     * @return
     */
    TCustomerSecurityInfo selectByCustomerNo(String customerno);
        
}