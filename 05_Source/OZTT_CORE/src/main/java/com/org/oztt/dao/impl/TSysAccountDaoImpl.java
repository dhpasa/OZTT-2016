package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TSysAccountDao;
import com.org.oztt.entity.TSysAccount;

@Repository
public class TSysAccountDaoImpl extends BaseDao implements TSysAccountDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TSysAccount record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TSysAccount record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TSysAccount selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TSysAccount record) {
        return update("com.org.oztt.dao.TSysAccountDao.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TSysAccount record) {
        // TODO Auto-generated method stub
        return 0;
    }

	@Override
	public TSysAccount selectByAccountNo(String accountNo) {
		return selectOne("com.org.oztt.dao.TSysAccountDao.selectByAccountNo", accountNo);
	}



}
