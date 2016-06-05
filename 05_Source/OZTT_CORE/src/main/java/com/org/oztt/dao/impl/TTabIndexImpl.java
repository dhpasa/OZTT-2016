package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TTabIndexDao;
import com.org.oztt.entity.TTabIndex;

@Repository
public class TTabIndexImpl extends BaseDao implements TTabIndexDao {

    @Override
    public int insert(TTabIndex record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TTabIndex record) {
        return insert("com.org.oztt.dao.TTabIndexDao.insertSelective", record);
    }

    @Override
    public String getAllGoodsByTab(String tabId) {
        return selectOne("com.org.oztt.dao.TTabIndexDao.getAllGoodsByTab", tabId);
    }

    @Override
    public void deleteByTab(String tabId) {
        update("com.org.oztt.dao.TTabIndexDao.deleteByTab", tabId);
    }

}
