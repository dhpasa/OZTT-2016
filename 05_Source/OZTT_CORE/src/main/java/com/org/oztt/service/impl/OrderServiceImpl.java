package com.org.oztt.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.Vector;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.org.oztt.base.common.MailUtil;
import com.org.oztt.base.common.SendMailDto;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.CommonUtils;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.dao.TAddressInfoDao;
import com.org.oztt.dao.TConsCartDao;
import com.org.oztt.dao.TConsInvoiceDao;
import com.org.oztt.dao.TConsOrderDao;
import com.org.oztt.dao.TConsOrderDetailsDao;
import com.org.oztt.dao.TConsTransactionDao;
import com.org.oztt.dao.TCustomerSecurityInfoDao;
import com.org.oztt.dao.TGoodsGroupDao;
import com.org.oztt.dao.TNoInvoiceDao;
import com.org.oztt.dao.TNoOrderDao;
import com.org.oztt.dao.TNoTransactionDao;
import com.org.oztt.dao.TSuburbDeliverFeeDao;
import com.org.oztt.dao.TSysAccountDao;
import com.org.oztt.dto.InvoiceDto;
import com.org.oztt.entity.TAddressInfo;
import com.org.oztt.entity.TConsInvoice;
import com.org.oztt.entity.TConsOrder;
import com.org.oztt.entity.TConsOrderDetails;
import com.org.oztt.entity.TConsTransaction;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerSecurityInfo;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.entity.TNoInvoice;
import com.org.oztt.entity.TNoOrder;
import com.org.oztt.entity.TNoTransaction;
import com.org.oztt.entity.TSysAccount;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.ContCartProItemDto;
import com.org.oztt.formDto.OrderInfoDto;
import com.org.oztt.formDto.OzTtAdOdDto;
import com.org.oztt.formDto.OzTtAdOdListDto;
import com.org.oztt.formDto.OzTtAdOlListDto;
import com.org.oztt.formDto.OzTtAdSuListDto;
import com.org.oztt.formDto.OzTtGbOdDto;
import com.org.oztt.service.AddressService;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.OrderService;
import com.org.oztt.service.PaypalService;

@Service
public class OrderServiceImpl extends BaseService implements OrderService {

    @Resource
    private TConsCartDao             tConsCartDao;

    @Resource
    private TConsOrderDao            tConsOrderDao;

    @Resource
    private TConsTransactionDao      tConsTransactionDao;

    @Resource
    private TNoOrderDao              tNoOrderDao;

    @Resource
    private TConsOrderDetailsDao     tConsOrderDetailsDao;

    @Resource
    private PaypalService            paypalService;

    @Resource
    private TNoInvoiceDao            tNoInvoiceDao;

    @Resource
    private TNoTransactionDao        tNoTransactionDao;

    @Resource
    private TConsInvoiceDao          tConsInvoiceDao;

    @Resource
    private TAddressInfoDao          tAddressInfoDao;

    @Resource
    private TSuburbDeliverFeeDao     tSuburbDeliverFeeDao;

    @Resource
    private TGoodsGroupDao           tGoodsGroupDao;

    @Resource
    private CustomerService          customerService;

    @Resource
    private TCustomerSecurityInfoDao tCustomerSecurityInfoDao;

    @Resource
    private AddressService           addressService;
    
    @Resource
    private TSysAccountDao           tSysAccountDao;

    @Override
    public String insertOrderInfoForPhone(String customerNo, String payMethod, String hidDeliMethod,
            String hidAddressId, String hidHomeDeliveryTime, String isUnify, String invoiceFlg, String invoicemail,
            HttpSession session, String purchaseRemarks) throws Exception {

        List<ContCartItemDto> payList = tConsCartDao.getAllContCartForBuy(customerNo);
        if (CollectionUtils.isEmpty(payList))
            return CommonConstants.CART_CANBUY;
        // 产生订单号
        String maxOrderNo = "";
        // 获取最大的客户号
        TNoOrder maxTNoOrder = tNoOrderDao.getMaxOrderNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        Integer len = CommonConstants.FIRST_NUMBER.length();
        if (maxTNoOrder == null) {
            maxOrderNo = nowDateString + CommonConstants.FIRST_NUMBER;
            // 订单号最大值的保存
            TNoOrder tNoOrder = new TNoOrder();
            tNoOrder.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoOrder.setMaxno(maxOrderNo);
            tNoOrderDao.insertSelective(tNoOrder);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE).equals(maxTNoOrder.getDate())) {
                // 属于同一天
                // 订单号最大值的保存
                maxOrderNo = nowDateString
                        + StringUtils.leftPad(String.valueOf(Integer.valueOf(maxTNoOrder.getMaxno().substring(8)) + 1),
                                len, "0");
                maxTNoOrder.setMaxno(maxOrderNo);
                tNoOrderDao.updateByPrimaryKeySelective(maxTNoOrder);
            }
            else {
                maxOrderNo = nowDateString + CommonConstants.FIRST_NUMBER;
                // 订单号最大值的保存
                TNoOrder tNoOrder = new TNoOrder();
                tNoOrder.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoOrder.setMaxno(maxOrderNo);
                tNoOrderDao.insertSelective(tNoOrder);
            }
        }

        maxOrderNo = "PO" + maxOrderNo;
        // 订单总金额
        BigDecimal orderAmount = BigDecimal.ZERO;
        // 生成订单表以及订单详细表
        for (ContCartItemDto itemDto : payList) {
            TConsOrderDetails tConsOrderDetails = new TConsOrderDetails();
            tConsOrderDetails.setGroupno(itemDto.getGroupId());
            tConsOrderDetails.setOrderno(maxOrderNo);
            tConsOrderDetails.setCustomerno(customerNo);
            tConsOrderDetails.setGoodsid(itemDto.getGoodsId());
            tConsOrderDetails.setSpecifications(itemDto.getGoodsPropertiesDB());
            tConsOrderDetails.setQuantity(itemDto.getGoodsQuantity() == null ? 0L : Long.valueOf(itemDto
                    .getGoodsQuantity()));
            tConsOrderDetails.setSumamount(itemDto.getGoodsPrice() == null ? BigDecimal.ZERO : new BigDecimal(itemDto
                    .getGoodsPrice()));
            tConsOrderDetails.setUnitprice(tConsOrderDetails.getSumamount().divide(
                    new BigDecimal(itemDto.getGoodsQuantity()), 2, BigDecimal.ROUND_DOWN));
            tConsOrderDetails.setAddtimestamp(new Date());

            if (CommonEnum.DeliveryMethod.HOME_DELIVERY.getCode().equals(hidDeliMethod) && !"true".equals(isUnify)) {
                //只有在送货上门，且不是统一送货的情况下
                tConsOrderDetails.setDeliverytime(DateFormatUtils.date2StringWithFormat(DateFormatUtils.addDate(
                        itemDto.getValidPeriodEnd() == null ? new Date() : itemDto.getValidPeriodEnd(), Calendar.DATE,
                        1), DateFormatUtils.PATTEN_YMD_NO_SEPRATE)
                        + "00");
            }
            tConsOrderDetails.setAdduserkey(customerNo);
            tConsOrderDetails.setHandleflg(CommonEnum.OrderDetailHandleFlag.PLACE_ORDER_SU.getCode());
            tConsOrderDetailsDao.insertSelective(tConsOrderDetails);
            orderAmount = orderAmount.add(tConsOrderDetails.getSumamount());

            // 生成明细订单的时候
            TGoodsGroup tGoodsGroup = new TGoodsGroup();
            tGoodsGroup.setGoodsid(itemDto.getGoodsId());
            tGoodsGroup.setGroupcurrentquantity(tConsOrderDetails.getQuantity());
            tGoodsGroup.setUpdtimestamp(new Date());
            tGoodsGroup.setUpdpgmid("PAY");
            tGoodsGroup.setUpduserkey(customerNo);
            tGoodsGroupDao.updateCurrentQuantity(tGoodsGroup);
        }

        // 生成发票数据
        // 产生订单号
        String maxInvoiceNo = "";
        // 获取最大的客户号
        TNoInvoice maxTNoInvoice = tNoInvoiceDao.getMaxInvoiceNo();

        if (maxTNoInvoice == null) {
            maxInvoiceNo = nowDateString + CommonConstants.FIRST_NUMBER;
            // 订单号最大值的保存
            TNoInvoice tNoInvoice = new TNoInvoice();
            tNoInvoice.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoInvoice.setMaxno(maxInvoiceNo);
            tNoInvoiceDao.insertSelective(tNoInvoice);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE).equals(maxTNoInvoice.getDate())) {
                // 属于同一天
                // 订单号最大值的保存
                maxInvoiceNo = nowDateString
                        + StringUtils.leftPad(
                                String.valueOf(Integer.valueOf(maxTNoInvoice.getMaxno().substring(8)) + 1), len, "0");
                maxTNoInvoice.setMaxno(maxInvoiceNo);
                tNoInvoiceDao.updateByPrimaryKeySelective(maxTNoInvoice);
            }
            else {
                maxInvoiceNo = nowDateString + CommonConstants.FIRST_NUMBER;
                // 订单号最大值的保存
                TNoInvoice tNoInvoice = new TNoInvoice();
                tNoInvoice.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoInvoice.setMaxno(maxInvoiceNo);
                tNoInvoiceDao.insertSelective(tNoInvoice);
            }
        }

        maxInvoiceNo = "IN" + maxInvoiceNo;
        TConsInvoice tConsInvoice = new TConsInvoice();
        tConsInvoice.setCustomerno(customerNo);
        tConsInvoice.setInvoiceno(maxInvoiceNo);
        tConsInvoiceDao.insertSelective(tConsInvoice);

        // 生成订单表
        TConsOrder tConsOrder = new TConsOrder();
        tConsOrder.setOrderno(maxOrderNo);
        tConsOrder.setCustomerno(customerNo);

        tConsOrder.setOrderamount(orderAmount);

        tConsOrder.setPaymentmethod(payMethod);
        tConsOrder.setOrdertimestamp(new Date());
        tConsOrder.setPaymenttimestamp(null);//付款时间
        if (CommonEnum.PaymentMethod.ONLINE_PAY_CWB.getCode().equals(payMethod)) {
            tConsOrder.setHandleflg(CommonEnum.HandleFlag.NOT_PAY.getCode());
        }
        else {
            tConsOrder.setHandleflg(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
        }

        tConsOrder.setDeliverymethod(hidDeliMethod);
        if (CommonEnum.DeliveryMethod.PICK_INSTORE.getCode().equals(hidDeliMethod)) {
            // 最后一个团购最后一个团购结束日的后一天
            // 获取最后一个团购的后一天
            Date maxdate = null;
            for (ContCartItemDto dto : payList) {
                if (maxdate == null) {
                    maxdate = dto.getValidPeriodEnd();
                }
                else {
                    if (maxdate.compareTo(dto.getValidPeriodEnd()) < 0) {
                        maxdate = dto.getValidPeriodEnd();
                    }
                }
            }
            tConsOrder.setHomedeliverytime(DateFormatUtils.date2StringWithFormat(
                    DateFormatUtils.addDate(maxdate == null ? new Date() : maxdate, Calendar.DATE, 1),
                    DateFormatUtils.PATTEN_YMD_NO_SEPRATE) + "00");

        }
        else if (CommonEnum.DeliveryMethod.HOME_DELIVERY.getCode().equals(hidDeliMethod)) {
            // 送货上门的情况
            if ("true".equals(isUnify)) {
                // 送货上门并且是统一送货
                tConsOrder.setHomedeliverytime(hidHomeDeliveryTime.replaceAll("/", ""));
            }
            else {
                // 如果不是上述的不是统一送货
                tConsOrder.setHomedeliverytime(null);
            }
        }

        tConsOrder.setAddressid(StringUtils.isEmpty(hidAddressId) ? 0L : Long.valueOf(hidAddressId));
        TAddressInfo addressInfo = tAddressInfoDao.selectByPrimaryKey(tConsOrder.getAddressid());
        //这里需要取运费
        BigDecimal deleveryCost = BigDecimal.ZERO;
        if (addressInfo != null) {
            deleveryCost = tSuburbDeliverFeeDao.selectByPrimaryKey(Long.valueOf(addressInfo.getSuburb()))
                    .getDeliverfee();
        }
        Date columnDate = null;
        int freight = 0;
        for (ContCartItemDto itemDto : payList) {
            if (!itemDto.getValidPeriodEnd().equals(columnDate)) {
                columnDate = itemDto.getValidPeriodEnd();
                freight++;
            }
        }
        // 这里的运费需要分统一送货还是不是统一送货
        if ("true".equals(isUnify)) {
            tConsOrder.setDeliverycost(deleveryCost);
        } else {
            tConsOrder.setDeliverycost(deleveryCost.multiply(new BigDecimal(freight)));
        }
        
        tConsOrder.setAddtimestamp(new Date());
        tConsOrder.setAdduserkey(customerNo);
        //        if ("1".equals(payMethod) || "1".equals(invoiceFlg)) {
        //            tConsOrder.setInvoiceflg("1");
        //            tConsOrder.setInvoiceno(maxInvoiceNo);
        //        }
        tConsOrder.setInvoiceflg("0");
        // 备注
        tConsOrder.setCommentscustomer(purchaseRemarks);
        tConsOrderDao.insertSelective(tConsOrder);

        // 将购物车中的数据删除
        tConsCartDao.deleteCurrentBuyGoods(customerNo);

        //        String rb = "";
        //        if (CommonEnum.DeliveryMethod.COD.getCode().equals(hidDeliMethod)) {
        //            // 货到付款是不需要付款的直接派送
        //        }
        //        else {
        //            if (CommonEnum.PaymentMethod.PAYPAL.getCode().equals(payMethod)) {
        //                // 货到付款
        //                PaypalParam paypalParam = new PaypalParam();
        //                paypalParam.setOrderId(maxOrderNo);
        //                if (CommonEnum.DeliveryMethod.NORMAL.getCode().equals(hidDeliMethod)) {
        //                    // 普通快递
        //                    paypalParam.setPrice(orderAmount.add(deleveryCost).toString());
        //                }
        //                else if (CommonEnum.DeliveryMethod.SELF_PICK.getCode().equals(hidDeliMethod)) {
        //                    // 来店自提
        //                    paypalParam.setPrice(orderAmount.toString());
        //                }
        //                paypalParam.setNotifyUrl(getApplicationMessage("notifyUrl") + maxOrderNo); //这里是不是通知画面，做一些对数据库的更新操作等
        //                paypalParam.setCancelReturn(getApplicationMessage("cancelReturn") + maxOrderNo);//应该返回未完成订单画面订单画面
        //                paypalParam.setOrderInfo(getApplicationMessage("orderInfo"));
        //                paypalParam.setReturnUrl(getApplicationMessage("returnUrl"));// 同样是当前订单画面
        //                rb = paypalService.buildRequest(paypalParam);
        //            }
        //
        //        }

        return maxOrderNo;

    }

    @Override
    public String insertOrderInfo(String customerNo, String payMethod, String hidDeliMethod, String hidAddressId,
            String hidHomeDeliveryTime) throws Exception {
        List<ContCartItemDto> payList = tConsCartDao.getAllContCartForBuy(customerNo);
        if (payList == null)
            return null;
        // 产生订单号
        String maxOrderNo = "";
        // 获取最大的客户号
        TNoOrder maxTNoOrder = tNoOrderDao.getMaxOrderNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        Integer len = CommonConstants.FIRST_NUMBER.length();
        if (maxTNoOrder == null) {
            maxOrderNo = nowDateString + CommonConstants.FIRST_NUMBER;
            // 订单号最大值的保存
            TNoOrder tNoOrder = new TNoOrder();
            tNoOrder.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoOrder.setMaxno(maxOrderNo);
            tNoOrderDao.insertSelective(tNoOrder);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE).equals(maxTNoOrder.getDate())) {
                // 属于同一天
                // 订单号最大值的保存
                maxOrderNo = nowDateString
                        + StringUtils.leftPad(String.valueOf(Integer.valueOf(maxTNoOrder.getMaxno().substring(8)) + 1),
                                len, "0");
                maxTNoOrder.setMaxno(maxOrderNo);
                tNoOrderDao.updateByPrimaryKeySelective(maxTNoOrder);
            }
            else {
                maxOrderNo = nowDateString + CommonConstants.FIRST_NUMBER;
                // 订单号最大值的保存
                TNoOrder tNoOrder = new TNoOrder();
                tNoOrder.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoOrder.setMaxno(maxOrderNo);
                tNoOrderDao.insertSelective(tNoOrder);
            }
        }

        maxOrderNo = "PO" + maxOrderNo;
        // 订单总金额
        BigDecimal orderAmount = BigDecimal.ZERO;
        // 生成订单表以及订单详细表
        for (ContCartItemDto itemDto : payList) {
            TConsOrderDetails tConsOrderDetails = new TConsOrderDetails();
            tConsOrderDetails.setGroupno(itemDto.getGroupId());
            tConsOrderDetails.setOrderno(maxOrderNo);
            tConsOrderDetails.setCustomerno(customerNo);
            tConsOrderDetails.setGoodsid(itemDto.getGoodsId());
            tConsOrderDetails.setSpecifications(itemDto.getGoodsPropertiesDB());
            tConsOrderDetails.setQuantity(itemDto.getGoodsQuantity() == null ? 0L : Long.valueOf(itemDto
                    .getGoodsQuantity()));
            tConsOrderDetails.setSumamount(itemDto.getGoodsPrice() == null ? BigDecimal.ZERO : new BigDecimal(itemDto
                    .getGoodsPrice()));
            tConsOrderDetails.setUnitprice(tConsOrderDetails.getSumamount().divide(
                    new BigDecimal(itemDto.getGoodsQuantity()), 2, BigDecimal.ROUND_DOWN));
            tConsOrderDetails.setAddtimestamp(new Date());
            tConsOrderDetails.setAdduserkey(customerNo);
            tConsOrderDetailsDao.insertSelective(tConsOrderDetails);
            orderAmount = orderAmount.add(tConsOrderDetails.getSumamount());

            // 生成明细订单的时候
            TGoodsGroup tGoodsGroup = new TGoodsGroup();
            tGoodsGroup.setGoodsid(itemDto.getGoodsId());
            tGoodsGroup.setGroupcurrentquantity(tConsOrderDetails.getQuantity());
            tGoodsGroup.setUpdtimestamp(new Date());
            tGoodsGroup.setUpdpgmid("PAY");
            tGoodsGroup.setUpduserkey(customerNo);
            tGoodsGroupDao.updateCurrentQuantity(tGoodsGroup);
        }

        // 生成发票数据
        // 产生订单号
        String maxInvoiceNo = "";
        // 获取最大的客户号
        TNoInvoice maxTNoInvoice = tNoInvoiceDao.getMaxInvoiceNo();

        if (maxTNoInvoice == null) {
            maxInvoiceNo = nowDateString + CommonConstants.FIRST_NUMBER;
            // 订单号最大值的保存
            TNoInvoice tNoInvoice = new TNoInvoice();
            tNoInvoice.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoInvoice.setMaxno(maxInvoiceNo);
            tNoInvoiceDao.insertSelective(tNoInvoice);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE).equals(maxTNoInvoice.getDate())) {
                // 属于同一天
                // 订单号最大值的保存
                maxInvoiceNo = nowDateString
                        + StringUtils.leftPad(
                                String.valueOf(Integer.valueOf(maxTNoInvoice.getMaxno().substring(8)) + 1), len, "0");
                maxTNoInvoice.setMaxno(maxInvoiceNo);
                tNoInvoiceDao.updateByPrimaryKeySelective(maxTNoInvoice);
            }
            else {
                maxInvoiceNo = nowDateString + CommonConstants.FIRST_NUMBER;
                // 订单号最大值的保存
                TNoInvoice tNoInvoice = new TNoInvoice();
                tNoInvoice.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoInvoice.setMaxno(maxInvoiceNo);
                tNoInvoiceDao.insertSelective(tNoInvoice);
            }
        }
        maxInvoiceNo = "IN" + maxInvoiceNo;
        TConsInvoice tConsInvoice = new TConsInvoice();
        tConsInvoice.setCustomerno(customerNo);
        tConsInvoice.setInvoiceno(maxInvoiceNo);
        tConsInvoiceDao.insertSelective(tConsInvoice);

        // 生成订单表
        TConsOrder tConsOrder = new TConsOrder();
        tConsOrder.setOrderno(maxOrderNo);
        tConsOrder.setCustomerno(customerNo);

        tConsOrder.setOrderamount(orderAmount);
        tConsOrder.setPaymentmethod(CommonEnum.PaymentMethod.ONLINE_PAY_CWB.getCode());
        tConsOrder.setOrdertimestamp(new Date());
        tConsOrder.setPaymenttimestamp(null);//付款时间
        tConsOrder.setHandleflg(CommonEnum.HandleFlag.NOT_PAY.getCode());
        tConsOrder.setDeliverymethod(hidDeliMethod);
        tConsOrder.setHomedeliverytime(hidHomeDeliveryTime.replaceAll("/", ""));

        tConsOrder.setAddressid(StringUtils.isEmpty(hidAddressId) ? 0L : Long.valueOf(hidAddressId));
        TAddressInfo addressInfo = tAddressInfoDao.selectByPrimaryKey(tConsOrder.getAddressid());
        //这里需要取运费
        BigDecimal deleveryCost = BigDecimal.ZERO;
        if (addressInfo != null) {
            deleveryCost = tSuburbDeliverFeeDao.selectByPrimaryKey(Long.valueOf(addressInfo.getSuburb()))
                    .getDeliverfee();
        }
        tConsOrder.setDeliverycost(deleveryCost);
        tConsOrder.setAddtimestamp(new Date());
        tConsOrder.setAdduserkey(customerNo);
        tConsOrderDao.insertSelective(tConsOrder);

        // 将购物车中的数据删除
        tConsCartDao.deleteCurrentBuyGoods(customerNo);

        String rb = "";
        //        if (CommonEnum.DeliveryMethod.COD.getCode().equals(hidDeliMethod)) {
        //            // 货到付款是不需要付款的直接派送
        //        }
        //        else {
        //            if (CommonEnum.PaymentMethod.CREDIT_CARD.getCode().equals(payMethod)) {
        //                // 货到付款
        //                PaypalParam paypalParam = new PaypalParam();
        //                paypalParam.setOrderId(maxOrderNo);
        //                if (CommonEnum.DeliveryMethod.NORMAL.getCode().equals(hidDeliMethod)) {
        //                    // 普通快递
        //                    paypalParam.setPrice(orderAmount.add(deleveryCost).toString());
        //                }
        //                else if (CommonEnum.DeliveryMethod.SELF_PICK.getCode().equals(hidDeliMethod)) {
        //                    // 来店自提
        //                    paypalParam.setPrice(orderAmount.toString());
        //                }
        //                paypalParam.setNotifyUrl(getApplicationMessage("notifyUrl") + maxOrderNo); //这里是不是通知画面，做一些对数据库的更新操作等
        //                paypalParam.setCancelReturn(getApplicationMessage("cancelReturn") + maxOrderNo);//应该返回未完成订单画面订单画面
        //                paypalParam.setOrderInfo(getApplicationMessage("orderInfo"));
        //                paypalParam.setReturnUrl(getApplicationMessage("returnUrl"));// 同样是当前订单画面
        //                rb = paypalService.buildRequest(paypalParam);
        //            }
        //
        //        }
        return rb;

    }

    @Override
    public PagingResult<OrderInfoDto> getAllOrderInfoForPage(Pagination pagination) throws Exception {

        PagingResult<OrderInfoDto> orderDBInfoPage = tConsOrderDao.getOrderByParamForPage(pagination);

        String imgUrl = super.getApplicationMessage("saveImgUrl", null);

        if (orderDBInfoPage != null && orderDBInfoPage.getResultList() != null
                && orderDBInfoPage.getResultList().size() > 0) {
            for (OrderInfoDto orderDB : orderDBInfoPage.getResultList()) {
                List<ContCartItemDto> detailList = tConsOrderDetailsDao.selectByOrderId(orderDB.getOrderId());
                if (!CollectionUtils.isEmpty(detailList)) {
                    for (ContCartItemDto dto : detailList) {
                        if (StringUtils.isEmpty(dto.getGoodsPropertiesDB())) {
                            dto.setGoodsProperties(new ArrayList<ContCartProItemDto>());
                        }
                        else {
                            dto.setGoodsProperties(JSONObject.parseArray(dto.getGoodsPropertiesDB(),
                                    ContCartProItemDto.class));
                        }
                        dto.setGoodsPropertiesDB(StringUtils.EMPTY);
                        dto.setGoodsImage(imgUrl + dto.getGoodsId() + CommonConstants.PATH_SPLIT + dto.getGoodsImage());
                    }
                }
                orderDB.setItemList(detailList);
                orderDB.setDetailCount(detailList.size());
                orderDB.setOrderStatusFlag(orderDB.getOrderStatus());
                orderDB.setOrderDate(DateFormatUtils.date2StringWithFormat(orderDB.getOrderDateDB(),
                        DateFormatUtils.PATTEN_HMS));
                orderDB.setOrderStatus(CommonEnum.HandleFlag.getEnumLabel(orderDB.getOrderStatus()));
                orderDB.setDeliveryMethodFlag(orderDB.getDeliveryMethod());
                orderDB.setDeliveryMethod(CommonEnum.DeliveryMethod.getEnumLabel(orderDB.getDeliveryMethod()));

                orderDB.setOrderAmount(new BigDecimal(orderDB.getDeliveryCost() == null ? "0" : orderDB
                        .getDeliveryCost()).add(
                        new BigDecimal(orderDB.getOrderAmount() == null ? "0" : orderDB.getOrderAmount())).toString());
            }

        }
        return orderDBInfoPage;

    }

    @Override
    public List<OrderInfoDto> getAllOrderInfoNoPage(Map<Object, Object> params) throws Exception {

        List<OrderInfoDto> orderDBInfoNoPage = tConsOrderDao.getOrderByParamNoPage(params);
        return orderDBInfoNoPage;

    }

    @Override
    public List<OrderInfoDto> getNotSuccessedOrder(Map<Object, Object> params) throws Exception {
        List<OrderInfoDto> orderDBInfoNoPage = tConsOrderDao.getNotSuccessedOrder(params);
        return orderDBInfoNoPage;
    }

    @Override
    public void deleteOrderById(String orderNo, String customerNo) throws Exception {
        // 删除订单信息
        TConsOrder tConsOrder = tConsOrderDao.selectByOrderId(orderNo);
        if (tConsOrder != null) {
            tConsOrder.setUpdpgmid("OrderServiceImpl");
            tConsOrder.setUpdtimestamp(new Date());
            tConsOrder.setUpduserkey(customerNo);
            tConsOrder.setHandleflg(CommonEnum.HandleFlag.DELETED.getCode());
            tConsOrderDao.updateByPrimaryKeySelective(tConsOrder);
        }
    }

    @Override
    public void updateOrderInfo(TConsOrder tConsOrder) throws Exception {
        tConsOrderDao.updateByPrimaryKeySelective(tConsOrder);
        List<TConsOrderDetails> listTConsOrderDetails = new ArrayList<TConsOrderDetails>();
        listTConsOrderDetails = tConsOrderDetailsDao.selectDetailsByOrderId(tConsOrder.getOrderno());
        if((listTConsOrderDetails != null) && (listTConsOrderDetails.size() > 0)) {
        	for(TConsOrderDetails tConsOrderDetails : listTConsOrderDetails) {
                TConsOrderDetails orderDetail = tConsOrderDetailsDao.selectByPrimaryKey(tConsOrderDetails.getNo());
                orderDetail.setHandleflg(tConsOrder.getHandleflg());
                orderDetail.setUpduserkey(CommonConstants.ADMIN_USERKEY);
                orderDetail.setUpdtimestamp(DateFormatUtils.getSystemTimestamp());
                tConsOrderDetailsDao.updateByPrimaryKeySelective(orderDetail);
            }
        }
    }

    @Override
    public TConsOrder selectByOrderId(String orderId) throws Exception {
        return tConsOrderDao.selectByOrderId(orderId);
    }

    @Override
    public OzTtGbOdDto getOrderDetailInfo(String orderId) throws Exception {
        OzTtGbOdDto formDto = new OzTtGbOdDto();
        // 取得订单信息
        TConsOrder tConsOrder = this.selectByOrderId(orderId);
        formDto.setOrderNo(tConsOrder.getOrderno());
        formDto.setOrderStatus(tConsOrder.getHandleflg());
        formDto.setOrderStatusView(CommonEnum.HandleFlag.getEnumLabel(tConsOrder.getHandleflg()));
        formDto.setDeliveryMethod(tConsOrder.getDeliverymethod());
        formDto.setDeliveryMethodView(CommonEnum.DeliveryMethod.getEnumLabel(tConsOrder.getDeliverymethod()));
        // 取得地址信息
        if (tConsOrder.getAddressid() != 0) {
            TAddressInfo tAddressInfo = tAddressInfoDao.selectByPrimaryKey(tConsOrder.getAddressid());
            formDto.setReceiver(tAddressInfo.getReceiver());
            formDto.setReceiverAddress(tAddressInfo.getAddressdetails() + " "
                    + tSuburbDeliverFeeDao.selectByPrimaryKey(Long.valueOf(tAddressInfo.getSuburb())).getSuburb() + " "
                    + tAddressInfo.getState() + " " + tAddressInfo.getCountrycode() + " " + tAddressInfo.getPostcode());
            formDto.setReceiverPhone(tAddressInfo.getContacttel());
        }
        else {
            formDto.setReceiverAddress(super.getPageMessage("COMMON_SHOPADDRESS", null));
        }

        formDto.setAddressId(tConsOrder.getAddressid().toString());

        // 支付和配送方式
        formDto.setPaymethod(CommonEnum.PaymentMethod.getEnumLabel(tConsOrder.getPaymentmethod()));
        formDto.setDeliveryCost(tConsOrder.getDeliverycost().toString());
        String homeTime = tConsOrder.getHomedeliverytime();
        if (homeTime != null && homeTime.length() > 9) {
            formDto.setDeliveryDate(DateFormatUtils.dateFormatFromTo(homeTime.substring(0, 8),
                    DateFormatUtils.PATTEN_YMD_NO_SEPRATE, DateFormatUtils.PATTEN_YMD));
            formDto.setDeleveryTime(CommonEnum.DeliveryTime.getEnumLabel(homeTime.substring(8)));
        }
        String imgUrl = super.getApplicationMessage("saveImgUrl", null);
        List<ContCartItemDto> detailList = tConsOrderDetailsDao.selectByOrderId(orderId);
        if (!CollectionUtils.isEmpty(detailList)) {
            for (ContCartItemDto dto : detailList) {
                if (StringUtils.isEmpty(dto.getGoodsPropertiesDB())) {
                    dto.setGoodsProperties(new ArrayList<ContCartProItemDto>());
                }
                else {
                    dto.setGoodsProperties(JSONObject.parseArray(dto.getGoodsPropertiesDB(), ContCartProItemDto.class));
                }
                dto.setGoodsPropertiesDB(StringUtils.EMPTY);
                dto.setGoodsUnitPrice(new BigDecimal(dto.getGoodsPrice()).divide(
                        new BigDecimal(dto.getGoodsQuantity()), 2, BigDecimal.ROUND_UP).toString());
                dto.setGoodsImage(imgUrl + dto.getGoodsId() + CommonConstants.PATH_SPLIT + dto.getGoodsImage());
            }
        }

        // 设定小计合计等值
        formDto.setXiaoji(tConsOrder.getOrderamount().toString());
        formDto.setYunfei(tConsOrder.getDeliverycost().toString());
        formDto.setHeji(tConsOrder.getOrderamount().add(tConsOrder.getDeliverycost()).toString());
        formDto.setLeftTime(DateFormatUtils.getTimeBetNowACreate(tConsOrder.getOrdertimestamp()));
        formDto.setGoodList(detailList);

        return formDto;
    }

    @Override
    public void updateRecordAfterPay(String orderId, String customerNo, HttpSession session, String serialNo)
            throws Exception {
        TConsOrder tConsOrder = this.selectByOrderId(orderId);
        // 生成入出账记录
        // 取得最新的入出账记录
        TConsTransaction tConsTransactionLast = tConsTransactionDao.selectLastTransaction();

        // 生成发票数据
        // 产生入出账号
        String maxTranctionNo = "";
        // 获取最大的客户号
        TNoTransaction maxTNoTransaction = tNoTransactionDao.getMaxTransactionNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        Integer len = CommonConstants.FIRST_NUMBER.length();
        if (maxTNoTransaction == null) {
            maxTranctionNo = nowDateString + CommonConstants.FIRST_NUMBER;
            // 入出账号号最大值的保存
            TNoTransaction tNoTransaction = new TNoTransaction();
            tNoTransaction.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoTransaction.setMaxno(maxTranctionNo);
            tNoTransactionDao.insertSelective(tNoTransaction);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE).equals(
                    maxTNoTransaction.getDate())) {
                // 属于同一天
                // 入出账号号最大值的保存
                maxTranctionNo = nowDateString
                        + StringUtils.leftPad(
                                String.valueOf(Integer.valueOf(maxTNoTransaction.getMaxno().substring(8)) + 1), len,
                                "0");
                maxTNoTransaction.setMaxno(maxTranctionNo);
                tNoTransactionDao.updateByPrimaryKeySelective(maxTNoTransaction);
            }
            else {
                maxTranctionNo = nowDateString + CommonConstants.FIRST_NUMBER;
                // 入出账号最大值的保存
                TNoTransaction tNoTransaction = new TNoTransaction();
                tNoTransaction.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoTransaction.setMaxno(maxTranctionNo);
                tNoTransactionDao.insertSelective(tNoTransaction);
            }
        }

        maxTranctionNo = "TS" + maxTranctionNo;
        // 第一次生成入出账记录
        TConsTransaction tConsTransaction = new TConsTransaction();
        tConsTransaction.setAccountno("");
        tConsTransaction.setAddtimestamp(new Date());
        tConsTransaction.setAdduserkey(customerNo);
        tConsTransaction.setCustomerno(customerNo);
        tConsTransaction.setTransactionserialno(serialNo);
        tConsTransaction.setTransactionobject(CommonConstants.TRANSACTION_OBJECT);
        tConsTransaction.setTransactioncomments("");
        tConsTransaction.setTransactionno(maxTranctionNo);
        tConsTransaction.setTransactionmethod(tConsOrder.getPaymentmethod());//付款方式（PayPal）
        tConsTransaction.setTransactionoperator(customerNo);
        tConsTransaction.setTransactionstatus("1");// 处理成功
        tConsTransaction.setTransactiontimestamp(new Date());

        TConsTransaction tConsTransactionIn = new TConsTransaction();
        BeanUtils.copyProperties(tConsTransaction, tConsTransactionIn);
        // 入账记录
        tConsTransactionIn.setInoutflg("1");//入账
        tConsTransactionIn.setTransactionamount(tConsOrder.getOrderamount().add(tConsOrder.getDeliverycost()));
        tConsTransactionIn.setTransactionbeforeamount(tConsTransactionLast == null ? BigDecimal.ZERO
                : tConsTransactionLast.getTransactionafteramount());
        tConsTransactionIn.setTransactionafteramount(tConsOrder.getOrderamount().add(tConsOrder.getDeliverycost())
                .add(tConsTransactionIn.getTransactionbeforeamount()));
        tConsTransactionIn.setTransactiontype("1");// 交易类型（订单支付还是手续费收取）
        tConsTransactionDao.insertSelective(tConsTransactionIn);
        // 出账记录
        TConsTransaction tConsTransactionOut = new TConsTransaction();
        BeanUtils.copyProperties(tConsTransaction, tConsTransactionOut);
        tConsTransactionOut.setInoutflg("2");//入账
        tConsTransactionOut.setTransactionbeforeamount(tConsTransactionIn.getTransactionafteramount());
        tConsTransactionOut.setTransactionamount(getCostMoney(tConsTransactionIn.getTransactionafteramount()));
        tConsTransactionOut.setTransactionafteramount(tConsTransactionIn.getTransactionafteramount().subtract(
                tConsTransactionOut.getTransactionamount()));
        tConsTransactionOut.setTransactiontype("2");// 交易类型（订单支付还是手续费收取）
        tConsTransactionDao.insertSelective(tConsTransactionOut);
        
        // 检索当前订单，更新状态为已经付款
        tConsOrder.setHandleflg(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
        tConsOrder.setTransactionno(maxTranctionNo);
        this.updateOrderInfo(tConsOrder);
        
        // 检索当前详细订单，更新状态下单成功
        // 获取订单明细
        List<TConsOrderDetails> detailList = tConsOrderDetailsDao.selectDetailsByOrderId(orderId);
        for (TConsOrderDetails detail : detailList) {
            detail.setHandleflg(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
            tConsOrderDetailsDao.updateByPrimaryKeySelective(detail);
        }
        
        tConsOrderDao.updateByPrimaryKeySelective(tConsOrder);

        TSysAccount tSysAccount = tSysAccountDao.selectByAccountNo("10000001"); 
        BigDecimal oldBalance = tSysAccount.getAccountbalance();
        BigDecimal tempBalance = tConsOrder.getOrderamount()
        		.add(tConsOrder.getDeliverycost())
        				.subtract(getCostMoney(tConsTransactionIn.getTransactionafteramount()));
        BigDecimal newBalance = oldBalance.add(tempBalance);
        tSysAccount.setAccountbalance(newBalance);
        tSysAccountDao.updateByPrimaryKeySelective(tSysAccount);
    }

    /**
     * 得到PAYPAL的扣款比率
     * 
     * @param amount
     * @return
     */
    private BigDecimal getCostMoney(BigDecimal amount) {
        return BigDecimal.ZERO;
        //        String percent = super.getApplicationMessage("PAYPAL_PECENT");
        //        String additional = super.getApplicationMessage("PAYPAL_ADDITIONAL");
        //        return amount.multiply(new BigDecimal(percent)).add(new BigDecimal(additional));
    }

    @Override
    public PagingResult<OzTtAdOlListDto> getAllOrderInfoForAdmin(Pagination pagination) throws Exception {
        PagingResult<OzTtAdOlListDto> dtoPage = tConsOrderDao.getAllOrderInfoForAdmin(pagination);
        if (dtoPage.getResultList() != null && dtoPage.getResultList().size() > 0) {
            int i = 0;
            for (OzTtAdOlListDto detail : dtoPage.getResultList()) {
                detail.setDetailNo(String.valueOf((dtoPage.getCurrentPage() - 1) * dtoPage.getPageSize() + ++i));
                detail.setOrderStatusView(CommonEnum.HandleFlag.getEnumLabel(detail.getOrderStatusView()));
                detail.setPaymentMethod(CommonEnum.PaymentMethod.getEnumLabel(detail.getPaymentMethod()));
                detail.setDeliveryMethodView(CommonEnum.DeliveryMethod.getEnumLabel(detail.getDeliveryMethodView()));
                if (detail.getAtHomeTime() != null && detail.getAtHomeTime().length() > 8) {
                    detail.setAtHomeTime(DateFormatUtils.dateFormatFromTo(detail.getAtHomeTime().substring(0, 8),
                            DateFormatUtils.PATTEN_YMD_NO_SEPRATE, DateFormatUtils.PATTEN_YMD)
                            + " "
                            + CommonEnum.DeliveryTime.getEnumLabel(detail.getAtHomeTime().substring(8)));
                }

            }
        }
        return dtoPage;
    }

    @Override
    public List<OzTtAdOlListDto> getAllOrderInfoForAdminAll(Map<Object, Object> params) throws Exception {
        List<OzTtAdOlListDto> dtoPage = tConsOrderDao.getAllOrderInfoForAdminAll(params);
        if (dtoPage != null && dtoPage.size() > 0) {
            for (OzTtAdOlListDto detail : dtoPage) {
                detail.setOrderStatusView(CommonEnum.HandleFlag.getEnumLabel(detail.getOrderStatusView()));
                detail.setPaymentMethod(CommonEnum.PaymentMethod.getEnumLabel(detail.getPaymentMethod()));
                detail.setDeliveryMethodView(CommonEnum.DeliveryMethod.getEnumLabel(detail.getDeliveryMethodView()));
                if (detail.getAtHomeTime() != null && detail.getAtHomeTime().length() > 8) {
                    detail.setAtHomeTime(DateFormatUtils.dateFormatFromTo(detail.getAtHomeTime().substring(0, 8),
                            DateFormatUtils.PATTEN_YMD_NO_SEPRATE, DateFormatUtils.PATTEN_YMD)
                            + " "
                            + CommonEnum.DeliveryTime.getEnumLabel(detail.getAtHomeTime().substring(8)));
                }
            }
        }
        return dtoPage;
    }

    @Override
    public OzTtAdOdDto getOrderDetailForAdmin(String orderNo) throws Exception {
        // 获取订单
        TConsOrder tConsOrder = this.selectByOrderId(orderNo);

        // 获取订单明细
        List<ContCartItemDto> detailList = tConsOrderDetailsDao.selectByOrderId(orderNo);

        OzTtAdOdDto dto = new OzTtAdOdDto();
        dto.setOrderNo(orderNo);
        dto.setCustomerNo(tConsOrder.getCustomerno());
        dto.setOrderStatusView(CommonEnum.HandleFlag.getEnumLabel(tConsOrder.getHandleflg()));
        dto.setOrderStatus(tConsOrder.getHandleflg());
        dto.setDeliveryMethodFlag(tConsOrder.getDeliverymethod());
        dto.setOrderTimestamp(DateFormatUtils.date2StringWithFormat(tConsOrder.getOrdertimestamp(), "yyyyDDmm"));
        dto.setPaymentMethod(CommonEnum.PaymentMethod.getEnumLabel(tConsOrder.getPaymentmethod()));
        dto.setDeliveryMethod(CommonEnum.DeliveryMethod.getEnumLabel(tConsOrder.getDeliverymethod()));
        dto.setInvoiceFlg(CommonEnum.InvoiceFlg.getEnumLabel(tConsOrder.getInvoiceflg()));
        dto.setOrderAmount(tConsOrder.getOrderamount().toString());
        dto.setCommentsCustomer(tConsOrder.getCommentscustomer());
        dto.setCommentsAdmin(tConsOrder.getCommentsadmin());
        
        if (tConsOrder.getAddressid() != 0) {
            // 获取地址
            TAddressInfo tAddressInfo = tAddressInfoDao.selectByPrimaryKey(tConsOrder.getAddressid());
            if (tAddressInfo != null) {
                dto.setReceiver(tAddressInfo.getReceiver());
                dto.setReceAddress(tAddressInfo.getAddressdetails() + " "
                        + tSuburbDeliverFeeDao.selectByPrimaryKey(Long.valueOf(tAddressInfo.getSuburb())).getSuburb()
                        + " " + tAddressInfo.getState() + " " + tAddressInfo.getCountrycode());
                dto.setPhone(tAddressInfo.getContacttel());
            }
        }

        String homeTime = tConsOrder.getHomedeliverytime();
        if (homeTime != null && homeTime.length() > 9) {
            String date = DateFormatUtils.dateFormatFromTo(homeTime.substring(0, 8),
                    DateFormatUtils.PATTEN_YMD_NO_SEPRATE, DateFormatUtils.PATTEN_YMD);
            String time = CommonEnum.DeliveryTime.getEnumLabel(homeTime.substring(8));
            dto.setWantArriveTime(date + " " + time);
        }
        dto.setYunfei(tConsOrder.getDeliverycost().toString());

        if (!CollectionUtils.isEmpty(detailList)) {
            List<OzTtAdOdListDto> itemList = new ArrayList<OzTtAdOdListDto>();
            int i = 0;
            for (ContCartItemDto item : detailList) {
                OzTtAdOdListDto odDto = new OzTtAdOdListDto();
                odDto.setDetailNo(String.valueOf(++i));
                odDto.setGoodsGroupId(item.getGroupId());
                odDto.setGoodsId(item.getGoodsId());
                odDto.setGoodsName(item.getGoodsName());
                odDto.setGoodsPic(item.getGoodsImage());
                odDto.setGoodsPrice(item.getGoodsPrice());
                odDto.setGoodsProperties(item.getGoodsPropertiesDB());
                odDto.setGoodsQuantity(item.getGoodsQuantity());
                odDto.setGoodsTotalAmount(new BigDecimal(item.getGoodsPrice()).multiply(
                        new BigDecimal(item.getGoodsQuantity())).toString());
                odDto.setDetailStatus(item.getDetailStatus() == null ? " " : CommonEnum.DetailStatus.getEnumLabel(item.getDetailStatus()));
                String deliveryTime = item.getDeliveryDate();
                if (deliveryTime != null && deliveryTime.length() > 9) {
                    String dateD = DateFormatUtils.dateFormatFromTo(deliveryTime.substring(0, 8),
                            DateFormatUtils.PATTEN_YMD_NO_SEPRATE, DateFormatUtils.PATTEN_YMD);
                    String timeD = CommonEnum.DeliveryTime.getEnumLabel(deliveryTime.substring(8));
                    odDto.setDeliveryTime(dateD + " " + timeD);
                }

                itemList.add(odDto);
            }

            dto.setItemList(itemList);
        }
        return dto;

    }

    /**
     * @param orderId
     * @param customerNo
     * @param session
     * @throws Exception
     */
    public void createTaxAndSendMail(String orderId, String customerNo, HttpSession session) throws Exception {
        // 是客户操作
        List<InvoiceDto> dataSource = new ArrayList<InvoiceDto>();
        Map<String, Object> params = new HashMap<String, Object>();

        TCustomerSecurityInfo securityInfo = tCustomerSecurityInfoDao.selectByCustomerNo(customerNo);

        TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);

        // 取得订单信息
        TConsOrder tConsOrder = this.selectByOrderId(orderId);

        TAddressInfo tAddressInfo = new TAddressInfo();
        // 取得地址信息
        if (tConsOrder.getAddressid() != 0) {
            tAddressInfo = tAddressInfoDao.selectByPrimaryKey(tConsOrder.getAddressid());
        }

        List<ContCartItemDto> detailList = tConsOrderDetailsDao.selectByOrderId(orderId);

        params.put("name", baseInfo.getNickname());
        params.put("email", securityInfo.getEmailaddr());
        params.put("phone", securityInfo.getTelno());
        params.put("detailAddress", CommonUtils.objectToString(tAddressInfo.getAddressdetails()));
        params.put("city", CommonUtils.objectToString(tAddressInfo.getSuburb()));
        params.put("state", CommonUtils.objectToString(tAddressInfo.getState()));
        params.put(
                "coutryAndPost",
                CommonUtils.objectToString(tAddressInfo.getCountrycode()) + " "
                        + CommonUtils.objectToString(tAddressInfo.getPostcode()));
        params.put("orderNo", orderId);
        params.put("orderDate",
                DateFormatUtils.date2StringWithFormat(tConsOrder.getOrdertimestamp(), DateFormatUtils.PATTEN_YMD2));
        params.put("complateDate", DateFormatUtils.getNowTimeFormat(DateFormatUtils.PATTEN_YMD2));
        params.put("warehouse", "Main warehouse");
        params.put("deliveryMethod", CommonEnum.DeliveryMethod.getEnumLabel(tConsOrder.getDeliverymethod()));
        params.put("subtotal", tConsOrder.getOrderamount().toString());
        params.put("tax", tConsOrder.getOrderamount()
                .multiply(new BigDecimal(super.getApplicationMessage("TAX", null))).setScale(2, BigDecimal.ROUND_HALF_UP).toString());
        params.put(
                "total",
                tConsOrder
                        .getOrderamount()
                        .subtract(
                                tConsOrder.getOrderamount()
                                        .multiply(new BigDecimal(super.getApplicationMessage("TAX", null))).setScale(2, BigDecimal.ROUND_HALF_UP))
                        .toString());
        String ireportPath = session.getServletContext().getRealPath("") + "/ireport/";
        JasperCompileManager.compileReportToFile(ireportPath + "INVOICE_TAX.jrxml", ireportPath + "INVOICE_TAX.jasper");

        for (ContCartItemDto dto : detailList) {
            InvoiceDto invoiceDto = new InvoiceDto();
            invoiceDto.setCode(dto.getGoodsId());
            invoiceDto.setDescription(dto.getGoodsName());
            //            invoiceDto.setPrice(String.valueOf(new BigDecimal(dto.getGoodsPrice()).divide(new BigDecimal(dto
            //                    .getGoodsQuantity()))));
            invoiceDto.setPrice(dto.getGoodsPrice());
            invoiceDto.setQty(dto.getGoodsQuantity());
            invoiceDto.setTax((new BigDecimal(dto.getGoodsPrice()))
                    .multiply(new BigDecimal(super.getApplicationMessage("TAX", null))).setScale(2, BigDecimal.ROUND_HALF_UP).toString());
            //            invoiceDto.setTotal(dto.getGoodsPrice());
            invoiceDto.setTotal(String.valueOf(new BigDecimal(dto.getGoodsPrice()).divide(new BigDecimal(dto
                    .getGoodsQuantity()))));
            dataSource.add(invoiceDto);
        }

        JRBeanCollectionDataSource beanColDataSource = new JRBeanCollectionDataSource(dataSource);

        JasperFillManager.fillReportToFile(ireportPath + "INVOICE_TAX.jasper", params, beanColDataSource);
        String tempUrl = System.getProperty("java.io.tmpdir");
        File destDirectory = new File(tempUrl + CommonConstants.PATH_SPLIT + UUID.randomUUID());
        if (!destDirectory.exists()) {
            destDirectory.mkdirs();
        }

        JasperExportManager.exportReportToPdfFile(ireportPath + "INVOICE_TAX.jrprint", destDirectory
                + CommonConstants.PATH_SPLIT + "INVOICE_TAX.pdf");

        //️发信
        SendMailDto sendMailDto = new SendMailDto();
        sendMailDto.setTitle(MessageUtils.getMessage("TAX_MAIL_TITLE", null));
        StringBuffer sb = new StringBuffer();
        sb.append(MessageUtils.getMessage("TAX_MAIL_CONTENT", null));
        sb.append("</br>");

        sendMailDto.setContent(sb.toString());
        List<String> mailTo = new ArrayList<String>();
        mailTo.add(securityInfo.getEmailaddr());
        sendMailDto.setTo(mailTo);
        Vector<String> files = new Vector<String>();
        files.add(destDirectory + CommonConstants.PATH_SPLIT + "INVOICE_TAX.pdf");
        sendMailDto.setFile(files);
        MailUtil.sendMail(sendMailDto, null);
    }

    /**
     * @param orderId
     * @param customerNo
     * @param session
     * @throws Exception
     */
    public void createTaxAndSendMailForPhone(String orderId, String customerNo, HttpSession session, String email,
            String invoicename, String invoiceabn, String invoiceads) throws Exception {
        StartSendMail sendMail = new StartSendMail();
        sendMail.orderId = orderId;
        sendMail.customerNo = customerNo;
        sendMail.session = session;
        sendMail.email = email;
        sendMail.tax = super.getApplicationMessage("TAX", null);
        sendMail.invoicename = invoicename;
        sendMail.invoiceabn = invoiceabn;
        sendMail.invoiceads = invoiceads;
        sendMail.start();
        // 是客户操作
        //        List<InvoiceDto> dataSource = new ArrayList<InvoiceDto>();
        //        Map<String, Object> params = new HashMap<String, Object>();
        //
        //        TCustomerSecurityInfo securityInfo = tCustomerSecurityInfoDao.selectByCustomerNo(customerNo);
        //
        //        TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
        //
        //        // 取得订单信息
        //        TConsOrder tConsOrder = this.selectByOrderId(orderId);
        //
        //        TAddressInfo tAddressInfo = new TAddressInfo();
        //        // 取得地址信息
        //        if (tConsOrder.getAddressid() != 0) {
        //            tAddressInfo = tAddressInfoDao.selectByPrimaryKey(tConsOrder.getAddressid());
        //        }
        //
        //        List<ContCartItemDto> detailList = tConsOrderDetailsDao.selectByOrderId(orderId);
        //
        //        params.put("name", baseInfo.getNickname());
        //        params.put("email", email);
        //        params.put("phone", securityInfo.getTelno());
        //        params.put("detailAddress", CommonUtils.objectToString(tAddressInfo.getAddressdetails()));
        //        params.put("city", CommonUtils.objectToString(tAddressInfo.getSuburb()));
        //        params.put("state", CommonUtils.objectToString(tAddressInfo.getState()));
        //        params.put(
        //                "coutryAndPost",
        //                CommonUtils.objectToString(tAddressInfo.getCountrycode()) + " "
        //                        + CommonUtils.objectToString(tAddressInfo.getPostcode()));
        //        params.put("orderNo", orderId);
        //        params.put("orderDate",
        //                DateFormatUtils.date2StringWithFormat(tConsOrder.getOrdertimestamp(), DateFormatUtils.PATTEN_YMD2));
        //        params.put("complateDate", DateFormatUtils.getNowTimeFormat(DateFormatUtils.PATTEN_YMD2));
        //        params.put("warehouse", "Main warehouse");
        //        params.put("deliveryMethod", CommonEnum.DeliveryMethod.getEnumLabel(tConsOrder.getDeliverymethod()));
        //        params.put("total", tConsOrder.getOrderamount().toString());
        //        params.put("tax", tConsOrder.getOrderamount().multiply(new BigDecimal(super.getApplicationMessage("TAX")))
        //                .setScale(2).toString());
        //        params.put(
        //                "subtotal",
        //                tConsOrder
        //                        .getOrderamount()
        //                        .subtract(
        //                                tConsOrder.getOrderamount()
        //                                        .multiply(new BigDecimal(super.getApplicationMessage("TAX"))).setScale(2))
        //                        .toString());
        //        String ireportPath = session.getServletContext().getRealPath("") + "/ireport/";
        //        JasperCompileManager.compileReportToFile(ireportPath + "INVOICE_TAX.jrxml", ireportPath + "INVOICE_TAX.jasper");
        //
        //        for (ContCartItemDto dto : detailList) {
        //            InvoiceDto invoiceDto = new InvoiceDto();
        //            invoiceDto.setCode(dto.getGoodsId());
        //            invoiceDto.setDescription(dto.getGoodsName());
        //            invoiceDto.setPrice(String.valueOf(new BigDecimal(dto.getGoodsPrice())));
        //            invoiceDto.setQty(dto.getGoodsQuantity());
        //            invoiceDto.setTax((new BigDecimal(dto.getGoodsPrice())).multiply(
        //                    new BigDecimal(super.getApplicationMessage("TAX"))).toString());
        //            invoiceDto.setTotal(dto.getGoodsPrice());
        //            dataSource.add(invoiceDto);
        //        }
        //
        //        JRBeanCollectionDataSource beanColDataSource = new JRBeanCollectionDataSource(dataSource);
        //
        //        JasperFillManager.fillReportToFile(ireportPath + "INVOICE_TAX.jasper", params, beanColDataSource);
        //        String tempUrl = System.getProperty("java.io.tmpdir");
        //        File destDirectory = new File(tempUrl + CommonConstants.PATH_SPLIT + UUID.randomUUID());
        //        if (!destDirectory.exists()) {
        //            destDirectory.mkdirs();
        //        }
        //
        //        JasperExportManager.exportReportToPdfFile(ireportPath + "INVOICE_TAX.jrprint", destDirectory
        //                + CommonConstants.PATH_SPLIT + "INVOICE_TAX.pdf");
        //
        //        //️发信
        //        SendMailDto sendMailDto = new SendMailDto();
        //        sendMailDto.setTitle(MessageUtils.getMessage("TAX_MAIL_TITLE"));
        //        StringBuffer sb = new StringBuffer();
        //        sb.append(MessageUtils.getMessage("TAX_MAIL_CONTENT"));
        //        sb.append("</br>");
        //
        //        sendMailDto.setContent(sb.toString());
        //        List<String> mailTo = new ArrayList<String>();
        //        mailTo.add(email);
        //        sendMailDto.setTo(mailTo);
        //        Vector<String> files = new Vector<String>();
        //        files.add(destDirectory + CommonConstants.PATH_SPLIT + "INVOICE_TAX.pdf");
        //        sendMailDto.setFile(files);
        //        MailUtil.sendMail(sendMailDto, null);
    }

    class StartSendMail extends Thread {

        public String      orderId;

        public String      customerNo;

        public HttpSession session;

        public String      email;

        public String      tax;

        public String      invoicename;

        public String      invoiceabn;

        public String      invoiceads;

        public void run() {
            try {
                // 是客户操作
                List<InvoiceDto> dataSource = new ArrayList<InvoiceDto>();
                Map<String, Object> params = new HashMap<String, Object>();

                TCustomerSecurityInfo securityInfo = tCustomerSecurityInfoDao.selectByCustomerNo(customerNo);

                //TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);

                // 取得订单信息
                TConsOrder tConsOrder = selectByOrderId(orderId);

                TAddressInfo tAddressInfo = null;
                // 取得地址信息
                if (tConsOrder.getAddressid() != 0) {
                    tAddressInfo = tAddressInfoDao.selectByPrimaryKey(tConsOrder.getAddressid());
                }

                List<ContCartItemDto> detailList = tConsOrderDetailsDao.selectByOrderId(orderId);

                params.put("name", invoicename + " " + invoiceabn);
                params.put("companyAddress", invoiceads);
                params.put("email", email);
                params.put("phone", securityInfo.getTelno());
                if (tAddressInfo != null) {
                    params.put("detailAddress", CommonUtils.objectToString(tAddressInfo.getAddressdetails()));
                    params.put(
                            "city",
                            CommonUtils.objectToString(addressService.getTSuburbDeliverFeeById(
                                    Long.valueOf(tAddressInfo.getSuburb())).getSuburb()));
                    params.put("state", CommonUtils.objectToString(tAddressInfo.getState()));
                    params.put("coutryAndPost", CommonUtils.objectToString(tAddressInfo.getCountrycode()) + " "
                            + CommonUtils.objectToString(tAddressInfo.getPostcode()));
                }
                else {
                    params.put("detailAddress", "");
                    params.put("city", "");
                    params.put("state", "");
                    params.put("coutryAndPost", "");
                }

                params.put("orderNo", orderId);
                params.put("orderDate", DateFormatUtils.date2StringWithFormat(tConsOrder.getOrdertimestamp(),
                        DateFormatUtils.PATTEN_YMD2));
                params.put("complateDate", DateFormatUtils.getNowTimeFormat(DateFormatUtils.PATTEN_YMD2));
                params.put("warehouse", "Main warehouse");
                params.put("deliveryMethod", CommonEnum.DeliveryMethod.getEnumLabel(tConsOrder.getDeliverymethod()));
                params.put("total", tConsOrder.getOrderamount().toString());
                params.put("tax",
                        tConsOrder.getOrderamount().multiply(new BigDecimal(getApplicationMessage("TAX", null)))
                                .setScale(2, BigDecimal.ROUND_HALF_UP).toString());
                params.put(
                        "subtotal",
                        tConsOrder.getOrderamount()
                                .subtract(tConsOrder.getOrderamount().multiply(new BigDecimal(tax)).setScale(2, BigDecimal.ROUND_HALF_UP))
                                .toString());
                String ireportPath = session.getServletContext().getRealPath("") + "/ireport/";
                JasperCompileManager.compileReportToFile(ireportPath + "INVOICE_TAX.jrxml", ireportPath
                        + "INVOICE_TAX.jasper");

                for (ContCartItemDto dto : detailList) {
                    InvoiceDto invoiceDto = new InvoiceDto();
                    invoiceDto.setCode(dto.getGoodsId());
                    invoiceDto.setDescription(dto.getGoodsName());
                    invoiceDto.setPrice(String.valueOf(new BigDecimal(dto.getGoodsPrice())));
                    invoiceDto.setQty(dto.getGoodsQuantity());
                    BigDecimal total = new BigDecimal(0);
                    total = new BigDecimal(dto.getGoodsPrice()).multiply(new BigDecimal(dto.getGoodsQuantity()));
                    invoiceDto.setTax(total.multiply(new BigDecimal(tax)).setScale(2, BigDecimal.ROUND_HALF_UP).toString());
                    invoiceDto.setTotal(total.toString());
                    dataSource.add(invoiceDto);
                }

                JRBeanCollectionDataSource beanColDataSource = new JRBeanCollectionDataSource(dataSource);

                JasperFillManager.fillReportToFile(ireportPath + "INVOICE_TAX.jasper", params, beanColDataSource);
                String tempUrl = System.getProperty("java.io.tmpdir");
                File destDirectory = new File(tempUrl + CommonConstants.PATH_SPLIT + UUID.randomUUID());
                if (!destDirectory.exists()) {
                    destDirectory.mkdirs();
                }

                JasperExportManager.exportReportToPdfFile(ireportPath + "INVOICE_TAX.jrprint", destDirectory
                        + CommonConstants.PATH_SPLIT + "INVOICE_TAX.pdf");

                //️发信
                SendMailDto sendMailDto = new SendMailDto();
                sendMailDto.setTitle(MessageUtils.getMessage("TAX_MAIL_TITLE", null));
                StringBuffer sb = new StringBuffer();
                sb.append(MessageUtils.getMessage("TAX_MAIL_CONTENT", null));
                sb.append("</br>");

                sendMailDto.setContent(sb.toString());
                List<String> mailTo = new ArrayList<String>();
                mailTo.add(email);
                sendMailDto.setTo(mailTo);
                Vector<String> files = new Vector<String>();
                files.add(destDirectory + CommonConstants.PATH_SPLIT + "INVOICE_TAX.pdf");
                sendMailDto.setFile(files);
                MailUtil.sendMail(sendMailDto, null);

                // 这里即表示发送邮件成功，之后更新订单表
                TConsOrder orderInfo = tConsOrderDao.selectByOrderId(orderId);
                orderInfo.setInvoiceflg(CommonConstants.HAS_SEND_INVOICE);
                tConsOrderDao.updateByPrimaryKeySelective(orderInfo);
            }
            catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }

    @Override
    public void cleanOrderInfo() throws Exception {
        // 取得三十分钟没有没有付款的订单
        List<TConsOrder> orderList = tConsOrderDao.getNotPayOrderInfo();
        if (!CollectionUtils.isEmpty(orderList)) {
            // 取出所有明细的数据
            for (TConsOrder tConsOrder : orderList) {
                List<TConsOrderDetails> details = tConsOrderDetailsDao.selectDetailsByOrderId(tConsOrder.getOrderno());
                if (!CollectionUtils.isEmpty(details)) {
                    for (TConsOrderDetails detail : details) {
                        // 优先更新团购表信息
                        TGoodsGroup tGoodsGroup = new TGoodsGroup();
                        tGoodsGroup.setGroupno(detail.getGroupno());
                        tGoodsGroup = tGoodsGroupDao.selectByParams(tGoodsGroup);
                        tGoodsGroup.setGroupcurrentquantity(tGoodsGroup.getGroupcurrentquantity()
                                - detail.getQuantity());
                        tGoodsGroupDao.updateByPrimaryKeySelective(tGoodsGroup);
                        // 删除详细内容
                        tConsOrderDetailsDao.deleteByPrimaryKey(detail.getNo());
                    }
                }

                tConsOrderDao.deleteByPrimaryKey(tConsOrder.getNo());
            }
        }
    }

    @Override
    public void deleteOrderInfoFormNotPay(TConsOrder tConsOrder) throws Exception {
        tConsOrderDao.updateByPrimaryKeySelective(tConsOrder);
        // 为付款的订单，回滚团购件数
        List<TConsOrderDetails> details = tConsOrderDetailsDao.selectDetailsByOrderId(tConsOrder.getOrderno());
        if (details != null && details.size() > 0) {
            for (TConsOrderDetails detail : details) {
                TGoodsGroup tGoodsGroup = new TGoodsGroup();
                tGoodsGroup.setGroupno(detail.getGroupno());
                tGoodsGroup = tGoodsGroupDao.selectByParams(tGoodsGroup);
                tGoodsGroup.setGroupcurrentquantity(tGoodsGroup.getGroupcurrentquantity() - detail.getQuantity());
                tGoodsGroupDao.updateByPrimaryKeySelective(tGoodsGroup);
            }
        }
    }

    @Override
    public int getAleadyPurchaseCount(Map<Object, Object> params) throws Exception {
        int sum = tConsOrderDao.getAleadyPurchaseCount(params);
        return sum;

    }

    @Override
    public PagingResult<OzTtAdSuListDto> getAllOrderByUserPointForAdmin(Pagination pagination) throws Exception {
        PagingResult<OzTtAdSuListDto> dtoPage = tConsOrderDetailsDao.getAllOrderByUserPointForAdmin(pagination);
        if (dtoPage.getResultList() != null && dtoPage.getResultList().size() > 0) {
            int i = 0;
            for (OzTtAdSuListDto detail : dtoPage.getResultList()) {
                detail.setDetailNo(String.valueOf((dtoPage.getCurrentPage() - 1) * dtoPage.getPageSize() + ++i));
                if (!StringUtils.isEmpty(detail.getDetailStatus())) {
                    detail.setDetailStatusView(CommonEnum.OrderDetailHandleFlag.getEnumLabel(detail.getDetailStatus()));
                }
            }
        }
        return dtoPage;
    }

    @Override
    public void updateOrderDetailStatus(String[] orderDetailId, String status, String adminComment) throws Exception {
        // 将所有详细订单的状态更新
        for(String detailId : orderDetailId) {
            TConsOrderDetails orderDetail = tConsOrderDetailsDao.selectByPrimaryKey(Long.valueOf(detailId));
            orderDetail.setHandleflg(status);
            orderDetail.setUpduserkey(CommonConstants.ADMIN_USERKEY);
            orderDetail.setUpdtimestamp(DateFormatUtils.getSystemTimestamp());
            tConsOrderDetailsDao.updateByPrimaryKeySelective(orderDetail);
        }       
       
        // 更新父状态
        for(String detailId : orderDetailId) {
            TConsOrderDetails orderDetail = tConsOrderDetailsDao.selectByPrimaryKey(Long.valueOf(detailId));
            
            // 获取订单明细
            List<TConsOrderDetails> detailList = tConsOrderDetailsDao.selectDetailsByOrderId(orderDetail.getOrderno());
            
            if (CommonEnum.OrderDetailHandleFlag.SENDING.getCode().equals(status)) {
                // 配送中
                TConsOrder tConsOrder = tConsOrderDao.selectByOrderId(orderDetail.getOrderno());
                tConsOrder.setHandleflg(CommonEnum.HandleFlag.SENDING.getCode());
                tConsOrder.setCommentsadmin(adminComment);
                // 判断是否有完成的订单
                boolean hasComplete = false;
                for (TConsOrderDetails detail : detailList) {
                    if (CommonEnum.OrderDetailHandleFlag.COMPLATE.getCode().equals(detail.getHandleflg())) {
                        // 完成
                        hasComplete = true;
                        break;
                    }
                }
                if (hasComplete) {
                    tConsOrder.setHandleflg(CommonEnum.HandleFlag.PART_COMPLATE.getCode());
                }
                tConsOrderDao.updateByPrimaryKeySelective(tConsOrder);
                
            } else if (CommonEnum.OrderDetailHandleFlag.COMPLATE.getCode().equals(status)) {
                
                // 完成
                boolean isAllUpate = true;
                for (TConsOrderDetails detail : detailList) {
                    if (!CommonEnum.OrderDetailHandleFlag.COMPLATE.getCode().equals(detail.getHandleflg()) && orderDetail.getNo() != detail.getNo()) {
                        // 非完成
                        isAllUpate = false;
                        break;
                    } 
                }
                TConsOrder tConsOrder = tConsOrderDao.selectByOrderId(orderDetail.getOrderno());
                if (isAllUpate) {
                    tConsOrder.setHandleflg(CommonEnum.HandleFlag.COMPLATE.getCode());
                    tConsOrder.setCommentsadmin(adminComment);
                    tConsOrderDao.updateByPrimaryKeySelective(tConsOrder);
                } else {
                    tConsOrder.setHandleflg(CommonEnum.HandleFlag.PART_COMPLATE.getCode());
                    tConsOrder.setCommentsadmin(adminComment);
                    tConsOrderDao.updateByPrimaryKeySelective(tConsOrder);
                }
                
                // 更新当前的积分制度
                customerService.updateCustomerPointsAndLevels(detailId, tConsOrder.getCustomerno());
            }
            
        }
    }
}
