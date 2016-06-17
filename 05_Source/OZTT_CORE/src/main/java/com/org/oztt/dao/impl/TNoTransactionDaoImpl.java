package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TNoTransactionDao;
import com.org.oztt.entity.TNoTransaction;

@Repository
public class TNoTransactionDaoImpl extends BaseDao implements TNoTransactionDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TNoTransaction record) {
        return insert("com.org.oztt.dao.TNoTransactionDao.insertSelective", record);
    }

    @Override
    public int insertSelective(TNoTransaction record) {
        return insert("com.org.oztt.dao.TNoTransactionDao.insertSelective", record);
    }

    @Override
    public TNoTransaction selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TNoTransaction record) {
        return update("com.org.oztt.dao.TNoTransactionDao.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TNoTransaction record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TNoTransaction getMaxTransactionNo() {
        return selectOne("com.org.oztt.dao.TNoTransactionDao.getMaxTransactionNo", null);
    }

}
