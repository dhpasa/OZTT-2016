package com.org.oztt.dao;

import com.org.oztt.entity.TTabIndex;

public interface TTabIndexDao {
    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TTabIndex record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TTabIndex record);
    
    String getAllGoodsByTab(String tabId);
    
    void deleteByTab(String tabId);
}