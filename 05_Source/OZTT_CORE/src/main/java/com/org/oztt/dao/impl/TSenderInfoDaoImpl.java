package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.dao.TSenderInfoDao;
import com.org.oztt.entity.TSenderInfo;

@Repository
public class TSenderInfoDaoImpl extends BaseDao implements TSenderInfoDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        return update("com.org.oztt.dao.TSenderInfoMapper.deleteByPrimaryKey", id);
    }

    @Override
    public int insert(TSenderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TSenderInfo record) {
        return insert("com.org.oztt.dao.TSenderInfoMapper.insertSelective", record);
    }

    @Override
    public TSenderInfo selectByPrimaryKey(Long id) {
        return selectOne("com.org.oztt.dao.TSenderInfoMapper.selectByPrimaryKey", id);
    }

    @Override
    public int updateByPrimaryKeySelective(TSenderInfo record) {
        return update("com.org.oztt.dao.TSenderInfoMapper.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TSenderInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<TSenderInfo> selectSendInfoList(String customerId) {
        return select("com.org.oztt.dao.TSenderInfoMapper.selectSendInfoList", customerId);
    }

    @Override
    public PagingResult<TSenderInfo> selectSendInfoPageList(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TSenderInfoMapper.selectSendInfoNewList",
                "com.org.oztt.dao.TSenderInfoMapper.selectSendInfoNewListCount", pagination);
    }

}
