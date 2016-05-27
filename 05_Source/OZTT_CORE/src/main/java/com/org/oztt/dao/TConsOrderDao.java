package com.org.oztt.dao;

import java.util.List;
import java.util.Map;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TConsOrder;
import com.org.oztt.formDto.OrderInfoDto;
import com.org.oztt.formDto.OzTtAdOlListDto;

public interface TConsOrderDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long no);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TConsOrder record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TConsOrder record);

    /**
     * 根据主键查询记录
     */
    TConsOrder selectByPrimaryKey(Long no);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TConsOrder record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TConsOrder record);
    
    /**
     * 根据订单号删除记录
     */
    int deleteByOrderNo(String orderNo);
    
    /**
     * 分页获取订单信息
     * @param pagination
     * @return
     */
    PagingResult<OrderInfoDto> getOrderByParamForPage(Pagination pagination);
    
    /**
     * 获取订单信息
     * @param pagination
     * @return
     */
    List<OrderInfoDto> getOrderByParamNoPage(Map<Object, Object> params);
    
    /**
     * 获取订单信息
     * @param pagination
     * @return
     */
    List<OrderInfoDto> getNotSuccessedOrder(Map<Object, Object> params);
    
    /**
     * 通过订单号来取订单信息
     * @param orderId
     * @return
     */
    TConsOrder selectByOrderId(String orderId);
    
    /**
     * 分页获取订单信息(后台)
     * @param pagination
     * @return
     */
    PagingResult<OzTtAdOlListDto> getAllOrderInfoForAdmin(Pagination pagination);
    
    /**
     * 分页获取订单信息(后台)
     * @param pagination
     * @return
     */
    List<OzTtAdOlListDto> getAllOrderInfoForAdminAll(Map<Object, Object> params);
    
    
}