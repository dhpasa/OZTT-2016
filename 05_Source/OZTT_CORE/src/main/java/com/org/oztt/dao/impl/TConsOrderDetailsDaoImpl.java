package com.org.oztt.dao.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.dao.TConsOrderDetailsDao;
import com.org.oztt.entity.TConsOrderDetails;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.OzTtAdSuListDto;

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
        return selectOne("com.org.oztt.dao.TConsOrderDetailsDao.selectByPrimaryKey", no);
    }

    @Override
    public int updateByPrimaryKeySelective(TConsOrderDetails record) {
        return update("com.org.oztt.dao.TConsOrderDetailsDao.updateByPrimaryKeySelective", record);   
    }

    @Override
    public int updateByPrimaryKey(TConsOrderDetails record) {
        return update("com.org.oztt.dao.TConsOrderDetailsDao.updateByPrimaryKey", record);   
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

    @Override
    public PagingResult<OzTtAdSuListDto> getAllOrderByUserPointForAdmin(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TConsOrderDetailsDao.getAllOrderByUserPointForAdmin",
                "com.org.oztt.dao.TConsOrderDetailsDao.getAllOrderByUserPointForAdminCount", pagination);
    }

    @Override
    public BigDecimal selectIsInStockGroupSumAmount(String customerNo, String startDay) {
        Map<String,String> param = new HashMap<String, String>();
        param.put("customerNo", customerNo);
        param.put("startDay", startDay);
        return selectOne("com.org.oztt.dao.TConsOrderDetailsDao.selectIsInStockGroupSumAmount", param);
    }

}
