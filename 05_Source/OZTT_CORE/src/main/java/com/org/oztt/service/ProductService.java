package com.org.oztt.service;

import com.org.oztt.formDto.OrderDetailViewDto;

public interface ProductService {

    /**
     * 获取订单详细情报
     * @param orderNo
     * @param orderFlg 订单是来源奶粉还是保健品
     * @return
     * @throws Exception
     */
    public OrderDetailViewDto getOrderDetail(String orderNo, String orderFlg) throws Exception;
    
    /**
     * 获取订单状态的数据
     * @param orderStatus
     * @return
     * @throws Exception
     */
    public int getOrderCount(String orderStatus, String customerNo) throws Exception;
}
