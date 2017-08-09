package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TPowderInfoDao;
import com.org.oztt.entity.TPowderInfo;
import com.org.oztt.formDto.PowderInfoViewDto;

@Repository
public class TPowderInfoDaoImpl extends BaseDao implements TPowderInfoDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TPowderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TPowderInfo record) {
        return 0;
    }

    @Override
    public TPowderInfo selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TPowderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TPowderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<PowderInfoViewDto> selectAllPowderInfoList() {
        return select("com.org.oztt.dao.TPowderInfoMapper.selectAllPowderInfoList", null);
    }

    @Override
    public TPowderInfo selectByParam(TPowderInfo record) {
        return selectOne("com.org.oztt.dao.TPowderInfoMapper.selectByParam", record);
    }

}
