package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TProductOrderDetailsDao;
import com.org.oztt.entity.TProductOrderDetails;
import com.org.oztt.formDto.PowderMilkInfo;

@Repository
public class TProductOrderDetailsDaoImpl extends BaseDao implements TProductOrderDetailsDao {

    @Override
    public int deleteByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(TProductOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TProductOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TProductOrderDetails selectByPrimaryKey(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TProductOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TProductOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<PowderMilkInfo> selectProductDetailsListByOrderNo(String orderId) {
        return select("com.org.oztt.dao.TPowderOrderDetailsMapper.selectProductDetailsListByOrderNo", orderId);
    }
    

}
