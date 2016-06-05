package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TTabInfoDao;
import com.org.oztt.entity.TTabInfo;

@Repository
public class TTabInfoDaoImpl extends BaseDao implements TTabInfoDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        TTabInfo record = new TTabInfo();
        record.setId(id);
        return deleteObj("com.org.oztt.dao.TTabInfoDao.deleteByPrimaryKey", record);
    }

    @Override
    public int insert(TTabInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TTabInfo record) {
        return insert("com.org.oztt.dao.TTabInfoDao.insertSelective", record);
    }

    @Override
    public TTabInfo selectByPrimaryKey(Long id) {
        return selectOne("com.org.oztt.dao.TTabInfoDao.selectByPrimaryKey", id);
    }

    @Override
    public int updateByPrimaryKeySelective(TTabInfo record) {
        return update("com.org.oztt.dao.TTabInfoDao.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TTabInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<TTabInfo> getAllTabs() {
        return select("com.org.oztt.dao.TTabInfoDao.getAllTabs", null);
    }

    @Override
    public Long getMaxTabId() {
        return selectOne("com.org.oztt.dao.TTabInfoDao.getMaxTabId", null);
    }

    @Override
    public List<TTabInfo> getTabsByGoods(String goodsId) {
        return select("com.org.oztt.dao.TTabInfoDao.getTabsByGoods", goodsId);
    }
}
