package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TConsOrderDetailsDao;
import com.org.oztt.entity.TConsOrderDetails;
import com.org.oztt.formDto.ContCartItemDto;

@Repository
public class TConsOrderDetailsDaoImpl extends BaseDao implements TConsOrderDetailsDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        TConsOrderDetails record = new TConsOrderDetails();
        record.setNo(no);
        return deleteObj("com.org.oztt.dao.TConsOrderDetailsDao.deleteByPrimaryKey", record);
    }

    @Override
    public int insert(TConsOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TConsOrderDetails record) {
        return update("com.org.oztt.dao.TConsOrderDetailsDao.insertSelective", record);    
    }

    @Override
    public TConsOrderDetails selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TConsOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(TConsOrderDetails record) {
        // TODO Auto-generated method stub
        return 0;
    }
    
    @Override
    public int deleteByOrderNo(String orderNo) {
        return update("com.org.oztt.dao.TConsOrderDetailsDao.deleteByOrderNo", orderNo);
    }

    @Override
    public List<ContCartItemDto> selectByOrderId(String orderId) {
        return select("com.org.oztt.dao.TConsOrderDetailsDao.selectByOrderId", orderId);
    }

    @Override
    public List<TConsOrderDetails> selectDetailsByOrderId(String orderId) {
        return select("com.org.oztt.dao.TConsOrderDetailsDao.selectDetailsByOrderId", orderId);
    }

}
