package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.dao.TPowderOrderDao;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.formDto.PowderOrderInfo;

@Repository
public class TPowderOrderDaoImpl extends BaseDao implements TPowderOrderDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TPowderOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TPowderOrder record) {
        return insert("com.org.oztt.dao.TPowderOrderMapper.insertSelective", record);
    }

    @Override
    public TPowderOrder selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TPowderOrder record) {
        return update("com.org.oztt.dao.TPowderOrderMapper.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TPowderOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int selectAutoIncrement() {
        return selectOne("com.org.oztt.dao.TPowderOrderMapper.selectAutoIncrement", null);
    }

    @Override
    public TPowderOrder selectByParam(TPowderOrder record) {
        return selectOne("com.org.oztt.dao.TPowderOrderMapper.selectByParam", record);
    }

    @Override
    public List<TPowderOrder> getTPowderOrderInfoList(TPowderOrder tPowderOrder) {
        return select("com.org.oztt.dao.TPowderOrderMapper.selectListByParam", tPowderOrder);
    }

    @Override
    public PagingResult<PowderOrderInfo> getPowderOrderPageInfo(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TPowderOrderMapper.getOrderByParamForPage",
                "com.org.oztt.dao.TPowderOrderMapper.getOrderByParamForPageCount", pagination);
    }

    @Override
    public void deleteNoPayOrder() {
        //update("com.org.oztt.dao.TPowderOrderMapper.updateNoPayOrder",null);
        delete("com.org.oztt.dao.TPowderOrderMapper.deleteNoPayOrderDetail", null);
        delete("com.org.oztt.dao.TPowderOrderMapper.deleteNoPayOrderBox", null);
        delete("com.org.oztt.dao.TPowderOrderMapper.deleteNoPayOrder", null);
    }

}
