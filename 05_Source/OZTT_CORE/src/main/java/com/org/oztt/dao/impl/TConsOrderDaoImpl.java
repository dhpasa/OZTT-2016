package com.org.oztt.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.dao.TConsOrderDao;
import com.org.oztt.entity.TConsOrder;
import com.org.oztt.formDto.OrderInfoDto;
import com.org.oztt.formDto.OzTtAdOlListDto;

@Repository
public class TConsOrderDaoImpl extends BaseDao implements TConsOrderDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        TConsOrder record = new TConsOrder();
        record.setNo(no);
        return deleteObj("com.org.oztt.dao.TConsOrderDao.deleteByPrimaryKey", record);
    }

    @Override
    public int insert(TConsOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TConsOrder record) {
        return insert("com.org.oztt.dao.TConsOrderDao.insertSelective", record);
    }

    @Override
    public TConsOrder selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TConsOrder record) {
        return update("com.org.oztt.dao.TConsOrderDao.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TConsOrder record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int deleteByOrderNo(String orderNo) {
        return update("com.org.oztt.dao.TConsOrderDao.deleteByOrderNo", orderNo);
    }

    @Override
    public PagingResult<OrderInfoDto> getOrderByParamForPage(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TConsOrderDao.getOrderByParamForPage",
                "com.org.oztt.dao.TConsOrderDao.getOrderByParamForPageCount", pagination);
    }
    
    @Override
    public List<OrderInfoDto> getOrderByParamNoPage(Map<Object, Object> params) {
        return select("com.org.oztt.dao.TConsOrderDao.getOrderByParamForPage", params);
    }
    
    @Override
    public List<OrderInfoDto> getNotSuccessedOrder(Map<Object, Object> params) {
        return select("com.org.oztt.dao.TConsOrderDao.getNotSuccessedOrder", params);
    }

    @Override
    public TConsOrder selectByOrderId(String orderId) {
        return selectOne("com.org.oztt.dao.TConsOrderDao.selectByOrderId", orderId);
    }

    @Override
    public PagingResult<OzTtAdOlListDto> getAllOrderInfoForAdmin(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TConsOrderDao.getAllOrderInfoForAdmin",
                "com.org.oztt.dao.TConsOrderDao.getAllOrderInfoForAdminCount", pagination);
    }

    @Override
    public List<OzTtAdOlListDto> getAllOrderInfoForAdminAll(Map<Object, Object> params) {
        return select("com.org.oztt.dao.TConsOrderDao.getAllOrderInfoForAdmin", params);
    }

    @Override
    public List<TConsOrder> getNotPayOrderInfo() {
        return select("com.org.oztt.dao.TConsOrderDao.getNotPayOrderInfo");
    }
    
    @Override
    public int getAleadyPurchaseCount(Map<Object, Object> params) {
        return selectOne("com.org.oztt.dao.TConsOrderDao.getAleadyPurchaseCount", params);
    }
}
