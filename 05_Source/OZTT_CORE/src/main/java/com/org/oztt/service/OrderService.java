package com.org.oztt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TConsOrder;
import com.org.oztt.formDto.OrderInfoDto;
import com.org.oztt.formDto.OzTtAdOdDto;
import com.org.oztt.formDto.OzTtAdOlListDto;
import com.org.oztt.formDto.OzTtGbOdDto;

public interface OrderService {

    /**
     * 插入订单信息
     * 
     * @throws Exception
     */
    public String insertOrderInfo(String customerNo, String payMethod, String hidDeliMethod, String hidAddressId,
            String hidHomeDeliveryTime) throws Exception;

    /**
     * 插入订单信息
     * 
     * @throws Exception
     */
    public String insertOrderInfoForPhone(String customerNo, String payMethod, String hidDeliMethod,
            String hidAddressId, String hidHomeDeliveryTime, String isUnify, String needInvoice, String invoicemail,
            HttpSession session) throws Exception;

    /**
     * 获取当前用户所有的订单信息
     * 
     * @return
     * @throws Exception
     */
    public PagingResult<OrderInfoDto> getAllOrderInfoForPage(Pagination pagination) throws Exception;
    
    /**
     * 获取当前用户所有的订单信息
     * 
     * @return
     * @throws Exception
     */
    public List<OrderInfoDto> getAllOrderInfoNoPage(Map<Object, Object> params) throws Exception;
    
    /**
     * 获取当前用户未完成的订单信息
     * 
     * @return
     * @throws Exception
     */
    public List<OrderInfoDto> getNotSuccessedOrder(Map<Object, Object> params) throws Exception;

    /**
     * 删除订单信息
     * 
     * @param id
     * @throws Exception
     */
    public void deleteOrderById(String id, String customerNo) throws Exception;

    /**
     * 更新订单信息
     * 
     * @param tConsOrder
     * @throws Exception
     */
    public void updateOrderInfo(TConsOrder tConsOrder) throws Exception;

    /**
     * 取得当前的某个订单
     * 
     * @param orderId
     * @return
     * @throws Exception
     */
    public TConsOrder selectByOrderId(String orderId) throws Exception;

    /**
     * 获取订单的详细信息
     * 
     * @param orderId
     * @return
     * @throws Exception
     */
    public OzTtGbOdDto getOrderDetailInfo(String orderId) throws Exception;

    /**
     * 付款结束后，更新订单，生成入出账记录
     * 
     * @param orderId
     * @throws Exception
     */
    public void updateRecordAfterPay(String orderId, String customerNo, HttpSession session) throws Exception;

    /**
     * admin端所有订单的获取
     * 
     * @param pagination
     * @return
     * @throws Exception
     */
    public PagingResult<OzTtAdOlListDto> getAllOrderInfoForAdmin(Pagination pagination) throws Exception;
    
    /**
     * admin端所有订单的获取
     * 
     * @param pagination
     * @return
     * @throws Exception
     */
    public List<OzTtAdOlListDto> getAllOrderInfoForAdminAll(Map<Object, Object> params) throws Exception;
    

    /**
     * admin端获取订单详情
     * 
     * @param orderNo
     * @return
     * @throws Exception
     */
    public OzTtAdOdDto getOrderDetailForAdmin(String orderNo) throws Exception;

    /**
     * 创建内容并且发信
     * 
     * @param orderId
     * @param customerNo
     * @param session
     * @throws Exception
     */
    public void createTaxAndSendMail(String orderId, String customerNo, HttpSession session) throws Exception;

    /**
     * 创建内容并且发信
     * 
     * @param orderId
     * @param customerNo
     * @param session
     * @throws Exception
     */
    public void createTaxAndSendMailForPhone(String orderId, String customerNo, HttpSession session, String email)
            throws Exception;
    
    /**
     * 清空未处理的订单信息
     * @throws Exception
     */
    public void cleanOrderInfo() throws Exception;

}
