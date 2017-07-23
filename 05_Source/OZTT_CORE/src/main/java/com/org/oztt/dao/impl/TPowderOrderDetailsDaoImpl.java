package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TPowderOrderDetailsDao;
import com.org.oztt.entity.TPowderOrderDetails;
import com.org.oztt.formDto.PowderMilkInfo;

@Repository
public class TPowderOrderDetailsDaoImpl extends BaseDao implements TPowderOrderDetailsDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TPowderOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TPowderOrderDetails record) {
        return insert("com.org.oztt.dao.TPowderOrderDetailsMapper.insertSelective", record);
    }

    @Override
    public TPowderOrderDetails selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TPowderOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TPowderOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<PowderMilkInfo> selectPowderDetailList(TPowderOrderDetails record) {
        return select("com.org.oztt.dao.TPowderOrderDetailsMapper.selectPowderDetailList", record);
    }

    @Override
    public List<PowderMilkInfo> selectPowderDetailsListByOrderNo(String orderId) {
        return select("com.org.oztt.dao.TPowderOrderDetailsMapper.selectPowderDetailsListByOrderNo", orderId);
    }

}
