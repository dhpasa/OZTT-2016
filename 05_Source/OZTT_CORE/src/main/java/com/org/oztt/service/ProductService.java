package com.org.oztt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.org.oztt.entity.TProduct;
import com.org.oztt.entity.TProductBox;
import com.org.oztt.entity.TProductOrder;
import com.org.oztt.formDto.OrderDetailViewDto;
import com.org.oztt.formDto.PowderBoxInfo;
import com.org.oztt.packing.util.ProductBox;

public interface ProductService {

    /**
     * 获取订单详细情报
     * 
     * @param orderNo
     * @param orderFlg 订单是来源奶粉还是保健品
     * @return
     * @throws Exception
     */
    public OrderDetailViewDto getOrderDetail(String orderNo, String orderFlg) throws Exception;

    /**
     * 获取订单状态的数据
     * 
     * @param orderStatus
     * @return
     * @throws Exception
     */
    public int getOrderCount(String orderStatus, String customerNo) throws Exception;

    /**
     * 通过订单号ID获取所有装箱信息
     * 
     * @param id
     * @return
     * @throws Exception
     */
    public List<PowderBoxInfo> getProductBoxListByOrderNo(String orderNo) throws Exception;

    /**
     * @param id
     * @return
     * @throws Exception
     */
    public TProduct getProductByParam(TProduct tProduct) throws Exception;

    /**
     * 将数据登录到数据库
     * 
     * @param resList
     * @throws Exception
     */
    public Map<String, String> insertProductInfo(String customerId, String customerNo, String senderId, String receiveId,
            String shippingMethodId, String customerNote, String paymentMethodId) throws Exception;
    
    /**
     * 通过ID获取订单
     * @param orderId
     * @return
     * @throws Exception
     */
    public TProductOrder selectProductOrderById(String orderId)  throws Exception;
    
    /**
     * 付款结束后，更新订单，生成入出账记录
     * 
     * @param orderId
     * @throws Exception
     */
    public void updateRecordAfterPay(String orderId, String customerNo, HttpSession session, String serialNo) throws Exception;

    /**
     * 更新订单
     * @param tProductOrder
     * @throws Exception
     */
    public void updateProductOrder(TProductOrder tProductOrder) throws Exception;
    
    /**
     * 发送信息
     * @param powderOrder
     * @throws Exception
     */
    public void sendMsgOnNewOrder(String phone, List<TProductBox> boxList) throws Exception;
    
    /**
     * 选择产品装箱信息
     * @param boxId
     * @return
     * @throws Exception
     */
    public List<ProductBox> selectProductBoxInfo(String boxId) throws Exception;
    
    /**
     * 通过ID获取产品装箱信息
     * @param boxId
     * @return
     * @throws Exception
     */
    public TProductBox selectProductBoxById(String boxId) throws Exception;
    
    /**
     * 通过参数获取订单
     * @param orderId
     * @return
     * @throws Exception
     */
    public TProductOrder selectProductByParam(TProductOrder tProductOrder)  throws Exception;
    
    /**
     * 
     * @throws Exception
     */
    public void deleteNoPayOrder() throws Exception;
}
