package com.org.oztt.dao;

import com.org.oztt.entity.TSysAccount;

public interface TSysAccountDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long no);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TSysAccount record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TSysAccount record);

    /**
     * 根据主键查询记录
     */
    TSysAccount selectByPrimaryKey(Long no);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TSysAccount record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TSysAccount record);
    
    /**
     * 通过账户编号取得
     * @param TSysAccount
     * @return
     */
    TSysAccount selectByAccountNo(String accountNo);
}