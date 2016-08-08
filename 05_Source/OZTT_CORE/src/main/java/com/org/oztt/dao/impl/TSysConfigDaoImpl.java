/**
 * 
 */
package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TSysConfigDao;
import com.org.oztt.entity.TSysConfig;

/**
 * @author x-wang
 *
 */
@Repository
public class TSysConfigDaoImpl extends BaseDao implements TSysConfigDao {

	@Override
	public int deleteByPrimaryKey(Long no) {
		return 0;
	}

	@Override
	public int insert(TSysConfig record) {
		return 0;
	}

	@Override
	public TSysConfig selectOne() {
		return selectOne("com.org.oztt.dao.TSysConfigDao.selectOne", null);
	}

	@Override
	public int insertSelective(TSysConfig record) {
		return insert("com.org.oztt.dao.TSysConfigDao.insertSelective", record);
	}

	@Override
	public TSysConfig selectByPrimaryKey(Long no) {
		return selectOne("com.org.oztt.dao.TSysConfigDao.selectByPrimaryKey", no);
	}

	@Override
	public int updateByPrimaryKeySelective(TSysConfig record) {
		return update("com.org.oztt.dao.TSysConfigDao.updateByPrimaryKeySelective", record);
	}

	@Override
	public int updateByPrimaryKey(TSysConfig record) {
		return 0;
	}

}
