package com.org.oztt.dao;

import com.org.oztt.entity.TSysConfig;

public interface TSysConfigDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long no);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TSysConfig record);
    
    /**
     * 查询单条记录
     */
    TSysConfig selectOne();

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TSysConfig record);

    /**
     * 根据主键查询记录
     */
    TSysConfig selectByPrimaryKey(Long no);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TSysConfig record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TSysConfig record);

}