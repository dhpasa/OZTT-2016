package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TTabInfo;

public interface TTabInfoDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long id);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TTabInfo record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TTabInfo record);

    /**
     * 根据主键查询记录
     */
    TTabInfo selectByPrimaryKey(Long id);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TTabInfo record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TTabInfo record);
    
    /**
     * 获取所有的标签
     * @return
     */
    List<TTabInfo> getAllTabs();
    
    Long getMaxTabId();
    
    /**
     * 通过商品取得所有的标签属性
     * @param goodsId
     * @return
     */
    List<TTabInfo> getTabsByGoods(String goodsId);
    
}