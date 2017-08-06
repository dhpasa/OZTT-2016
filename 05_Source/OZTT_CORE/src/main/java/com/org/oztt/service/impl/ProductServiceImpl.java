package com.org.oztt.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.DeliveryPicOperation;
import com.org.oztt.base.util.SMSUtil;
import com.org.oztt.base.util.ShortUrlUtil;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.dao.TConsCartDao;
import com.org.oztt.dao.TCustomerBasicInfoDao;
import com.org.oztt.dao.TExpressInfoDao;
import com.org.oztt.dao.TNoOrderDao;
import com.org.oztt.dao.TPowderOrderDao;
import com.org.oztt.dao.TPowderOrderDetailsDao;
import com.org.oztt.dao.TProductBoxDao;
import com.org.oztt.dao.TProductDao;
import com.org.oztt.dao.TProductOrderDao;
import com.org.oztt.dao.TProductOrderDetailsDao;
import com.org.oztt.dao.TReceiverInfoDao;
import com.org.oztt.dao.TSenderInfoDao;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TNoOrder;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.entity.TPowderOrderDetails;
import com.org.oztt.entity.TProduct;
import com.org.oztt.entity.TProductBox;
import com.org.oztt.entity.TProductOrder;
import com.org.oztt.entity.TProductOrderDetails;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.OrderDetailViewBoxDto;
import com.org.oztt.formDto.OrderDetailViewDto;
import com.org.oztt.formDto.OrderDetailViewProductDto;
import com.org.oztt.formDto.PowderBoxInfo;
import com.org.oztt.formDto.PowderMilkInfo;
import com.org.oztt.formDto.ProductOrderDetails;
import com.org.oztt.packing.util.PackingUtil;
import com.org.oztt.packing.util.ProductBox;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.GoodsService;
import com.org.oztt.service.PowderService;
import com.org.oztt.service.ProductService;
import com.org.oztt.service.SysConfigService;

@Service
public class ProductServiceImpl extends BaseService implements ProductService {

    @Resource
    private PowderService powderService;
    
    @Resource
    private TPowderOrderDetailsDao tPowderOrderDetailsDao;
    
    @Resource
    private TPowderOrderDao tPowderOrderDao;
    
    @Resource
    private TProductOrderDao tProductOrderDao;
    
    @Resource
    private TProductOrderDetailsDao tProductOrderDetailsDao;
    
    @Resource
    private TExpressInfoDao tExpressInfoDao;
    
    @Resource
    private TSenderInfoDao tSenderInfoDao;
    
    @Resource
    private TReceiverInfoDao tReceiverInfoDao;
    
    @Resource
    private TProductBoxDao tProductBoxDao;
    
    @Resource
    private TProductDao tProductDao;
    
    @Resource
    private TNoOrderDao tNoOrderDao;
    
    @Resource
    private SysConfigService sysConfigService;
    
    @Resource
    private GoodsService goodsService;
    
    @Resource
    private TCustomerBasicInfoDao tCustomerBasicInfoDao;
    
    @Resource
    private CustomerService customerService;
    
    @Resource
    private TConsCartDao tConsCartDao;
   
    
    
    @Override
    public OrderDetailViewDto getOrderDetail(String orderNo, String orderFlg) throws Exception {
        
        OrderDetailViewDto viewDto = new OrderDetailViewDto();
        viewDto.setPowderOrProductFlg(orderFlg);
        if ("1".equals(orderFlg)) {
            //奶粉
            TPowderOrder order = tPowderOrderDao.selectByPrimaryKey(Long.valueOf(orderNo));
            viewDto.setOrderNo(order.getOrdreNo());
            viewDto.setOrderDate(order.getOrderDate());
            viewDto.setOrderDesc(order.getRemarks());
            viewDto.setOrderStatus(order.getStatus());
            // 支付方式
            viewDto.setPaymentMethod(order.getPaymentMethod());
            // 运费补差
            //viewDto.setYunfeicha("8.88");//TODO
            
            // 当前订单下的所有商品
            List<PowderMilkInfo> milkList = tPowderOrderDetailsDao.selectPowderDetailsListByOrderNo(orderNo);
            List<OrderDetailViewProductDto> productList = new ArrayList<OrderDetailViewProductDto>();
            
            BigDecimal productSum = BigDecimal.ZERO;
            for (PowderMilkInfo milk : milkList) {
                OrderDetailViewProductDto productDto = new OrderDetailViewProductDto();
                productDto.setProductName(milk.getPowderBrand() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + milk.getPowderSpec() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X" + milk.getNumber());
                productDto.setProductPrice(new BigDecimal(milk.getPowderPrice()).
                        multiply(new BigDecimal(milk.getNumber())).toString()); 
                productList.add(productDto);
                
                productSum = productSum.add(new BigDecimal(milk.getPowderPrice()).
                        multiply(new BigDecimal(milk.getNumber())));
            }
            // 商品列表
            viewDto.setProductList(productList);
            
            // 商品总价
            viewDto.setProductAmountSum(productSum.setScale(2, BigDecimal.ROUND_UP).toString());
            // 运费（国际快递）
            viewDto.setYunfei(order.getSumAmount().subtract(productSum).setScale(2, BigDecimal.ROUND_UP).toString());
            // 订单总价
            viewDto.setOrderAmountSum(order.getSumAmount().toString());
            
            // 获取所有的快递包裹
            List<PowderBoxInfo> boxInfoList = powderService.getPowderBoxListByOrderNo(orderNo);
            List<OrderDetailViewBoxDto> boxList = new ArrayList<OrderDetailViewBoxDto>();
            
            for (PowderBoxInfo box : boxInfoList) {
                OrderDetailViewBoxDto boxDto = new OrderDetailViewBoxDto(); 
                boxDto.setElecExpressNo(box.getElecExpressNo());
                boxDto.setExpressPhotoUrlExitFlg(box.getExpressPhotoUrlExitFlg());
                boxDto.setExpressPhotoUrl(box.getExpressPhotoUrl());
                boxDto.setReceivecardId(box.getReceiveIdCard());
                boxDto.setReceiveCardPhoneAf(box.getReceiveCardPhoneAf());
                boxDto.setReceiveCardPhoneBe(box.getReceiveCardPhoneBe());
                boxDto.setReceiveName(box.getReceiveName());
                boxDto.setOrderStatusView(box.getOrderStatusView());
                boxDto.setReceiveId(box.getReceiveId());
                boxDto.setStatus(box.getStatus());
                boxDto.setBoxId(box.getBoxId());
                boxDto.setBoxPhotoUrlExitFlg(box.getBoxPhotoUrlsExitFlg());
                boxDto.setBoxPhotoUrl(box.getBoxPhotoUrls());
                boxList.add(boxDto);
            }
            viewDto.setBoxList(boxList);
            
        } else {
            // 保健品
            TProductOrder tProductOrder = tProductOrderDao.selectByPrimaryKey(Long.valueOf(orderNo));
            
            
            viewDto.setOrderNo(tProductOrder.getOrderNo());
            viewDto.setOrderDate(tProductOrder.getOrderDate());
            viewDto.setOrderDesc(tProductOrder.getCustomerRemarks());
            viewDto.setOrderStatus(tProductOrder.getStatus());
            // 运费补差
            //viewDto.setYunfeicha("8.88");//TODO
            
            // 当前订单下的所有商品
            BigDecimal productSum = BigDecimal.ZERO;
            List<OrderDetailViewProductDto> productList = tProductOrderDetailsDao.selectProductDetailsListByOrderNo(orderNo);
            for (OrderDetailViewProductDto productDto : productList) {
                productDto.setProductPath(super.getApplicationMessage("saveImgUrl", null) + productDto.getProductPath());
                
                productSum = productSum.add(new BigDecimal(productDto.getProductPrice()).
                        multiply(new BigDecimal(productDto.getProductNumber())));
            }
            
            // 商品列表
            viewDto.setProductList(productList);
            
            // 商品总价
            viewDto.setProductAmountSum(productSum.setScale(2, BigDecimal.ROUND_UP).toString());
            // 运费（国际快递）
            viewDto.setYunfei(tProductOrder.getSumAmount().subtract(productSum).setScale(2, BigDecimal.ROUND_UP).toString());
            // 订单总价
            viewDto.setOrderAmountSum(tProductOrder.getSumAmount().toString());
            
            
            //============
            // 获取所有的快递包裹
            List<PowderBoxInfo> boxInfoList = this.getProductBoxListByOrderNo(orderNo);
            List<OrderDetailViewBoxDto> boxList = new ArrayList<OrderDetailViewBoxDto>();
            
            for (PowderBoxInfo box : boxInfoList) {
                OrderDetailViewBoxDto boxDto = new OrderDetailViewBoxDto(); 
                boxDto.setElecExpressNo(box.getElecExpressNo());
                boxDto.setExpressPhotoUrlExitFlg(box.getExpressPhotoUrlExitFlg());
                boxDto.setExpressPhotoUrl(box.getExpressPhotoUrl());
                boxDto.setReceivecardId(box.getReceiveIdCard());
                boxDto.setReceiveCardPhoneAf(box.getReceiveCardPhoneAf());
                boxDto.setReceiveCardPhoneBe(box.getReceiveCardPhoneBe());
                boxDto.setReceiveName(box.getReceiveName());
                boxDto.setOrderStatusView(box.getOrderStatusView());
                boxDto.setReceiveId(box.getReceiveId());
                boxDto.setStatus(box.getStatus());
                boxDto.setBoxId(box.getBoxId());
                boxList.add(boxDto);
            }
            viewDto.setBoxList(boxList);
        }
        
        return viewDto;
    }


    @Override
    public int getOrderCount(String orderStatus, String customerNo) throws Exception {
        Map<Object, Object> map = new HashMap<Object, Object>();
        map.put("customerId", customerNo);
        map.put("status", orderStatus);
        return tPowderOrderDao.getPowderAndProductOrder(map);
    }


    @Override
    public List<PowderBoxInfo> getProductBoxListByOrderNo(String orderNo) throws Exception {

        
        TProductBox record = new TProductBox();
        record.setOrderId(orderNo);
        List<TProductBox> productList = tProductBoxDao.selectTProductBoxList(record);
        List<PowderBoxInfo> powderInfoList = new ArrayList<PowderBoxInfo>();
        
        for (TProductBox product : productList) {
            TProductBox tProductBox = tProductBoxDao.selectByPrimaryKey(product.getId());
            PowderBoxInfo powderBoxInfo = new PowderBoxInfo();
            powderBoxInfo.setBoxId(String.valueOf(product.getId()));
            List<String> urlList = new ArrayList<String>();
            if (StringUtils.isNotEmpty(tProductBox.getBoxPhotoUrls())) {
                // 装箱照片
                String[] str = tProductBox.getBoxPhotoUrls().split("\\|");
                for (int i = 0; i < str.length; i++) {
                    urlList.add(super.getApplicationMessage("saveImgUrl", null) + "EXPRESS" + CommonConstants.PATH_SPLIT
                            + str[i]);
                }
            }
            powderBoxInfo.setBoxPhotoUrls(urlList);

            TExpressInfo tExpressInfo = tExpressInfoDao.selectByPrimaryKey(Long.valueOf(tProductBox.getDeliverId()));
            powderBoxInfo.setExpressAmount(tExpressInfo.getPriceCoefficient().toString());
            powderBoxInfo.setExpressName(tExpressInfo.getExpressName());
            powderBoxInfo.setExpressPhotoUrl(super.getApplicationMessage("saveImgUrl", null) + "EXPRESS"
                    + CommonConstants.PATH_SPLIT + tProductBox.getExpressPhotoUrl());
            powderBoxInfo.setIfMsg(tProductBox.getIfMsg());
            powderBoxInfo.setIfRemarks(tProductBox.getIfRemarks());

            TReceiverInfo tReceiverInfo = tReceiverInfoDao.selectByPrimaryKey(Long.valueOf(tProductBox.getReceiverId()));
            powderBoxInfo.setReceiveId(tReceiverInfo.getId().toString());
            powderBoxInfo.setReceiveAddress(tReceiverInfo.getReceiverAddr());
            powderBoxInfo.setReceiveName(tReceiverInfo.getReceiverName());
            powderBoxInfo.setReceivePhone(tReceiverInfo.getReceiverTel());
            powderBoxInfo.setReceiveIdCard(tReceiverInfo.getReceiverIdCardNo());
            if (!StringUtils.isEmpty(tReceiverInfo.getReceiverIdCardPhotoUrls())) {
                String[] idCardPhotoArr = tReceiverInfo.getReceiverIdCardPhotoUrls().split("\\|");
                powderBoxInfo.setReceiveCardPhoneBe((idCardPhotoArr[0] == null || StringUtils.isEmpty(idCardPhotoArr[0]
                        .trim())) ? "" : (super.getApplicationMessage("saveImgUrl", null) + CommonConstants.ID_CARD
                        + CommonConstants.PATH_SPLIT + idCardPhotoArr[0]));
                powderBoxInfo.setReceiveCardPhoneAf((idCardPhotoArr[1] == null || StringUtils.isEmpty(idCardPhotoArr[1]
                        .trim())) ? "" : (super.getApplicationMessage("saveImgUrl", null) + CommonConstants.ID_CARD
                        + CommonConstants.PATH_SPLIT + idCardPhotoArr[1]));
            }
            else {
                powderBoxInfo.setReceiveCardPhoneAf("");
                powderBoxInfo.setReceiveCardPhoneBe("");
            }

            powderBoxInfo.setRemarks(tProductBox.getRemarks());

            TSenderInfo tSenderInfo = tSenderInfoDao.selectByPrimaryKey(Long.valueOf(tProductBox.getSenderId()));
            powderBoxInfo.setSenderId(tSenderInfo.getId().toString());
            powderBoxInfo.setSenderName(tSenderInfo.getSenderName());
            powderBoxInfo.setSenderPhone(tSenderInfo.getSenderTel());
            powderBoxInfo.setStatus(tProductBox.getHandleStatus());
            powderBoxInfo.setTotalAmount(tProductBox.getSumAmount().add(tProductBox.getAdditionalCost()).toString());

            TPowderOrderDetails detailParam = new TPowderOrderDetails();
            detailParam.setPowderBoxId(powderBoxInfo.getBoxId());

            List<PowderMilkInfo> detailList = tPowderOrderDetailsDao.selectPowderDetailList(detailParam);
            powderBoxInfo.setPowderMikeList(detailList);
            BigDecimal priceCount = BigDecimal.ZERO;
            if (detailList != null && detailList.size() > 0) {
                for (PowderMilkInfo detail : detailList) {
                    priceCount = priceCount.add(new BigDecimal(detail.getNumber()).multiply(new BigDecimal(detail
                            .getPowderPrice())));
                }

            }
            powderBoxInfo.setPricecount(priceCount.toString());
            // 状态
            powderBoxInfo.setOrderStatusView(CommonEnum.PowderBoxFlag.getEnumLabel(powderBoxInfo.getStatus()));

            if (StringUtils.isNotEmpty(tProductBox.getExpressPhotoUrl())) {
                powderBoxInfo.setExpressPhotoUrlExitFlg("1");
            }
            if (StringUtils.isNotEmpty(tProductBox.getBoxPhotoUrls())) {
                powderBoxInfo.setBoxPhotoUrlsExitFlg("1");
            }
            powderBoxInfo.setElecExpressNo(tProductBox.getElecExpressNo());
            powderBoxInfo.setDeliverId(tProductBox.getDeliverId());
            
            powderInfoList.add(powderBoxInfo);
        }
        
        return powderInfoList;
    
    }


    @Override
    public TProduct getProductByParam(TProduct tProduct) throws Exception {
        return tProductDao.selectByParam(tProduct);
    }


    @Override
    public Map<String, String> insertProductInfo(String customerId, String customerNo, String senderId, String receiveId,
            String shippingMethodId, String customerNote, String paymentMethodId) throws Exception {


        Map<String, String> resMap = new HashMap<String, String>();

        // 产生订单号
        String maxOrderNo = "";
        // 获取最大的客户号
        TNoOrder maxTNoOrder = tNoOrderDao.getMaxOrderNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        String nowDateStringFull = DateFormatUtils.getNowTimeFormat("yyyy/MM/dd HH:mm:ss");
        Integer len = CommonConstants.FIRST_NUMBER.length();
        if (maxTNoOrder == null) {
            maxOrderNo = nowDateString + CommonConstants.FIRST_NUMBER;
            // 订单号最大值的保存
            TNoOrder tNoOrder = new TNoOrder();
            tNoOrder.setDate(nowDateString);
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
                tNoOrder.setDate(nowDateString);
                tNoOrder.setMaxno(maxOrderNo);
                tNoOrderDao.insertSelective(tNoOrder);
            }
        }

        maxOrderNo = "PO" + maxOrderNo;
        // 奶粉订单表,优先创建订单表

        BigDecimal sumTotal = BigDecimal.ZERO;
        
        // 通过当前的用户名取得购物车的数据
        List<ContCartItemDto> consCarts = goodsService.getAllContCartForBuy(customerNo);
        
        // 购买的数据
        List<ProductOrderDetails> orderDetailsList = new ArrayList<ProductOrderDetails>();

        for (ContCartItemDto dto : consCarts) {
            TProduct p1 = new TProduct();
            p1.setCode(dto.getCode());
            p1 = this.getProductByParam(p1);
            BigDecimal goodsUnit = new BigDecimal(dto.getGoodsPrice()).divide(new BigDecimal(dto.getGoodsQuantity()));
            ProductOrderDetails detail = new ProductOrderDetails(p1, Long.valueOf(dto.getGoodsQuantity()), goodsUnit);
            orderDetailsList.add(detail);
        }
        
        // 获取快递公司信息
        TExpressInfo tExpressInfo = tExpressInfoDao.selectByPrimaryKey(Long.valueOf(shippingMethodId));
        
        // 装箱结果
        List<ProductBox>  addedProductBoxes = new ArrayList<ProductBox>();
        
        PackingUtil pu=new PackingUtil(tExpressInfo.getExpressName(), orderDetailsList, new ArrayList<ProductBox>());
        addedProductBoxes=pu.getAssignedProductBoxes();

        int orderIncrement = tProductOrderDao.selectAutoIncrement();
        // 奶粉快递箱
        for (ProductBox box : addedProductBoxes) {

            // 每个快递箱下面有多个订单详细
            int increment = tProductBoxDao.selectAutoIncrement();

            
            BigDecimal productAmount = BigDecimal.ZERO;
            
            int detailsCount = 0;
            
            for (ProductOrderDetails detail : box.getProductOrderDetailsList()) {
                // 明细项目的添加
                TProductOrderDetails tProductOrderDetails = new TProductOrderDetails();
                
                tProductOrderDetails.setProductBoxId(String.valueOf(increment));
                tProductOrderDetails.setProductId(detail.getProduct().getId().toString());
                tProductOrderDetails.setQuantity(BigDecimal.valueOf(detail.getQuantity()));
                tProductOrderDetails.setUnitPrice(detail.getUnitPrice());
                
                tProductOrderDetailsDao.insertSelective(tProductOrderDetails);
                
                productAmount = productAmount.add(tProductOrderDetails.getQuantity().multiply(tProductOrderDetails.getUnitPrice()).setScale(2, BigDecimal.ROUND_DOWN));
                
                detailsCount++;
            }
            
        

            TProductBox tProductBox = new TProductBox();
            tProductBox.setElecExpressNo("");
            tProductBox.setExpressDate(nowDateString);

            tProductBox.setDeliverId(shippingMethodId);
            tProductBox.setSenderId(senderId);
            tProductBox.setReceiverId(receiveId);
            if (StringUtils.isNotEmpty(customerNote)){
                tProductBox.setIfRemarks("1");
                tProductBox.setRemarks(customerNote);
            }
            
            //tProductBox.setIfMsg(powderBoxRes.get("isReceivePicFlg").toString());
            BigDecimal additional = BigDecimal.ZERO;

            // 接收彩信
            if ("1".equals(tProductBox.getIfMsg())) {
                additional = additional.add(sysConfigService.getTSysConfig().getMessageFee());
            }
            // 做标记
            if ("1".equals(tProductBox.getIfRemarks())) {
                additional = additional.add(sysConfigService.getTSysConfig().getRemarkFee());
            }
            
            tProductBox.setAdditionalCost(additional);
            // 每个商品的总价+运费总额+额外费用+快递额外费用
            tProductBox.setSumAmount(productAmount.add(additional).
                    add(new BigDecimal(box.getWeight() * tExpressInfo.getKiloCost().doubleValue()))
                    .add(new BigDecimal(detailsCount).multiply(tExpressInfo.getPriceCoefficient()))
                    .setScale(2, BigDecimal.ROUND_UP));
            tProductBox.setOrderId(String.valueOf(orderIncrement));
            tProductBox.setHandleStatus(CommonEnum.PowderBoxFlag.NOT_PACKED.getCode());
            tProductBoxDao.insertSelective(tProductBox);

            sumTotal = sumTotal.add(tProductBox.getSumAmount());

        }

        // 奶粉订单
        TProductOrder tProductOrder = new TProductOrder();
        tProductOrder.setOrderNo(maxOrderNo);
        tProductOrder.setOrderDate(nowDateStringFull);
        tProductOrder.setCustomerId(customerId);
        tProductOrder.setCustomerRemarks(customerNote);
        tProductOrder.setSumAmount(sumTotal);
        // 保存奶粉订单的时候一定是没有付款的
        tProductOrder.setPaymentStatus(CommonEnum.HandleFlag.NOT_PAY.getCode());
        tProductOrder.setStatus(CommonEnum.HandleFlag.NOT_PAY.getCode());
        if (StringUtils.isNotEmpty(paymentMethodId)) {
            tProductOrder.setPaymentMethod(paymentMethodId);
        }
        tProductOrderDao.insertSelective(tProductOrder);
        
        // 将购物车中的数据删除
        tConsCartDao.deleteCurrentBuyGoods(customerNo);

        resMap.put("orderNo", maxOrderNo);
        resMap.put("subAmount", sumTotal.toString());
        return resMap;
    }


    @Override
    public TProductOrder selectProductOrderById(String orderId) throws Exception {
        return tProductOrderDao.selectByPrimaryKey(Long.valueOf(orderId));
    }


    @Override
    public void updateRecordAfterPay(String orderId, String customerNo, HttpSession session, String serialNo)
            throws Exception {
        TProductOrder tProductOrder = new TProductOrder();
        tProductOrder.setOrderNo(orderId);
        tProductOrder = this.selectProductByParam(tProductOrder);
        
        // 订单状态
        String statusPre = tProductOrder.getStatus();
        
        String nowDateStringFull = DateFormatUtils.getNowTimeFormat("yyyy/MM/dd HH:mm:ss");
        
        // 检索当前订单，更新状态为已经付款
        tProductOrder.setPaymentStatus(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
        tProductOrder.setStatus(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
        tProductOrder.setPaymentDate(nowDateStringFull);
        this.updateProductOrder(tProductOrder);
        logger.error("付款成功后，更新订单支付状态为1(下单成功),订单状态为1(下单成功)。订单号为：" + orderId);
        // 更新订单下面的装箱flag
        TProductBox param = new TProductBox();
        param.setOrderId(tProductOrder.getId().toString());
        List<TProductBox> productBoxList = tProductBoxDao.selectTProductBoxList(param);


        // 付款成功之后，生成快递单照片和快递信息,一个快递单多个订单号

        String s = PowderServiceImpl.class.getResource("/").getPath().toString();
        s = java.net.URLDecoder.decode(s, "UTF-8");
        if (productBoxList != null) {
            TReceiverInfo tReceiverInfo = tReceiverInfoDao.selectByPrimaryKey(Long.valueOf(productBoxList.get(0).getReceiverId()));
            TSenderInfo tSenderInfo = tSenderInfoDao.selectByPrimaryKey(Long.valueOf(productBoxList.get(0).getSenderId()));
            
            for (TProductBox boxInfo : productBoxList) {
                
                // 如果已经分配了快递单号就不再更新快递单号
                if (StringUtils.isNotEmpty(boxInfo.getElecExpressNo())) {
                    continue;
                }
                
                // 获取电子订单号
                String eleExpressNo = getExpressEleNo();

                Double weightAll = 0D;
                DeliveryPicOperation dpOperation = null;
                if (CommonConstants.EXPRESS_BLUE_SKY.equals(boxInfo.getDeliverId())) {
                    // 蓝天快递
                    dpOperation = new DeliveryPicOperation(s + "/bluesky.properties");
                }
                else if (CommonConstants.EXPRESS_FREAK_QUICK.equals(boxInfo.getDeliverId())) {
                    // 狂派物流
                    dpOperation = new DeliveryPicOperation(s + "/freakyquick.properties");
                }
                else if (CommonConstants.EXPRESS_LONGMEN.equals(boxInfo.getDeliverId())) {
                    // 龙门物流
                    dpOperation = new DeliveryPicOperation(s + "/longmen.properties");
                }
                else if (CommonConstants.EXPRESS_SUPIN.equals(boxInfo.getDeliverId())) {
                    // 速品物流
                    dpOperation = new DeliveryPicOperation(s + "/supin.properties");
                }
                else if (CommonConstants.EXPRESS_XINGSUDI.equals(boxInfo.getDeliverId())) {
                    // 速品物流
                    dpOperation = new DeliveryPicOperation(s + "/xingsudi.properties");
                }
                String eleExpressUrl = "";
                if (dpOperation != null) {
                    HashMap<String, Integer> products = new HashMap<String, Integer>();
                    
                    List<ProductBox> boxList = this.selectProductBoxInfo(boxInfo.getId().toString());
                    if (boxList != null) {
                        for (ProductBox info : boxList) {
                            for (ProductOrderDetails details : info.getProductOrderDetailsList()) {
                                products.put(details.getProduct().getName(), details.getQuantity().intValue());
                            }
                            
                            weightAll = weightAll += info.getWeight();
                        }
                    }

                    String outputPathImg = super.getApplicationMessage("DistImgPath", null) + "EXPRESS"
                            + CommonConstants.PATH_SPLIT;
                    eleExpressUrl = dpOperation.createDeliveryPic(outputPathImg, eleExpressNo,
                            tSenderInfo.getSenderName(), tSenderInfo.getSenderTel(),
                            //super.getApplicationMessage("sender_address", null), powderInfo.getReceiveName(),
                            "", tReceiverInfo.getReceiverName(), tReceiverInfo.getReceiverTel(),
                            tReceiverInfo.getReceiverAddr(), products, weightAll.toString(), new Date());

                }

                boxInfo.setExpressPhotoUrl(eleExpressUrl);
                boxInfo.setElecExpressNo(eleExpressNo);
                tProductBoxDao.updateByPrimaryKeySelective(boxInfo);
            }
        }
        logger.error("付款成功后，更新订单Box的电子订单号和制定电子订单路径。订单号为：" + orderId);

        if (!CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode().equals(statusPre)) {
            // 最后开线程发送短信
            SendMsgThreadForProduct sendMsg = new SendMsgThreadForProduct();
            sendMsg.orderId = orderId;
            sendMsg.customerId = tProductOrder.getCustomerId();
            sendMsg.productBoxList = productBoxList;
            sendMsg.start(); 
        }
        
    }


    @Override
    public void updateProductOrder(TProductOrder tProductOrder) throws Exception {
        tProductOrderDao.updateByPrimaryKeySelective(tProductOrder);
    }
    
    @Override
    public void sendMsgOnNewOrder(String phone, List<TProductBox> boxList) throws Exception {
        try {
            String outputPathImg = super.getApplicationMessage("saveImgUrl", null) + "EXPRESS" + CommonConstants.PATH_SPLIT;
            int count = 0;
            String msg = super.getMessage("I0011", null);

            for (TProductBox detail : boxList) {
                if ("0".equals(detail.getIfMsg()))
                    continue;
                count++;
                String url = outputPathImg + detail.getExpressPhotoUrl();
                try {
                    url = ShortUrlUtil.getShortUrl(url);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                msg += detail.getElecExpressNo() + ":" + url + "，";
            }
            msg += super.getMessage("I0012", null);

            if (count > 0) {
                SMSUtil.sendMessage(phone, msg);
            }
        }
        catch (Exception e) {
            logger.error("message", e);
        }
        
    }
    
    private String getExpressEleNo() throws Exception {
        String expressEleNoFile = super.getApplicationMessage("eleExpressNoPath", null);
        RandomAccessFile fis = null;
        FileLock flin = null;
        String s = PowderServiceImpl.class.getResource("/").getPath().toString();
        s = java.net.URLDecoder.decode(s, "UTF-8");
        try {
            File file = new File(s + "checkSync.txt");
            fis = new RandomAccessFile(file, "rw");
            FileChannel fcin = fis.getChannel();
            while (true) {
                try {
                    flin = fcin.tryLock();
                    break;
                }
                catch (Exception e) {
                    // 加锁失败说明文件被锁
                    Thread.sleep(500);
                }
            }
            //读取文件信息
            Properties prop = new Properties();
            InputStream inputStream = new FileInputStream(expressEleNoFile);
            prop.load(inputStream);
            String expressEleNo = prop.getProperty("expressEleNo");
            String nextEleNo = "";
            if (StringUtils.isEmpty(expressEleNo)) {
                // 快递电子单号信息
                prop.setProperty("expressEleNo", CommonConstants.EXPRESS_ELE_NO);
                nextEleNo = CommonConstants.EXPRESS_ELE_NO;
            }
            else {
                // 取下一位电子快递单号
                nextEleNo = expressEleNo.substring(0, 2) + (Long.valueOf(expressEleNo.substring(2)) + 1);
                prop.setProperty("expressEleNo", nextEleNo);
                try (FileOutputStream fos = new FileOutputStream(expressEleNoFile)) {
                    prop.store(fos, null);
                }
            }

            return nextEleNo;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            // 无论有错没有错，将锁关闭。
            if (flin != null) {
                flin.release();
                flin.close();
                flin = null;
            }
            if (fis != null) {
                fis.close();
                fis = null;
            }
        }

    }
    
    /**
     * 发送短信的线程
     * @author linliuan
     *
     */
    class SendMsgThreadForProduct extends Thread {

        public String      customerId;

        public List<TProductBox>      productBoxList;
        
        public String orderId;

        public void run() {
            try {
                TCustomerBasicInfo cusomterBasicInfo = tCustomerBasicInfoDao.selectByPrimaryKey(Long.valueOf(customerId));
                sendMsgOnNewOrder(customerService.getCustomerSecurityByCustomerNo(cusomterBasicInfo.getCustomerno()).getTelno(), productBoxList);  
                logger.error("付款成功后，如果有需要发短信的则发送短信成功。订单号为：" + orderId);
            }
            catch (Exception e) {
                logger.error("message", e);
            }
        }

        
    }

    @Override
    public List<ProductBox> selectProductBoxInfo(String boxId) throws Exception {
        TProductOrderDetails param = new TProductOrderDetails();
        param.setProductBoxId(boxId);
        
        TProductBox tProductBox = tProductBoxDao.selectByPrimaryKey(Long.valueOf(boxId));
        List<TProductOrderDetails> details = tProductOrderDetailsDao.selectByParam(param);
        
        
        // 购买的数据
        List<ProductOrderDetails> orderDetailsList = new ArrayList<ProductOrderDetails>();
        
        for (TProductOrderDetails detail : details) {
            TProduct p1 = tProductDao.selectByPrimaryKey(Long.valueOf(detail.getProductId()));
            ProductOrderDetails Boxdetail = new ProductOrderDetails(p1, detail.getQuantity().longValue(), detail.getUnitPrice());
            orderDetailsList.add(Boxdetail);
        }
        
        // 装箱结果
        List<ProductBox>  addedProductBoxes = new ArrayList<ProductBox>();
        
        PackingUtil pu=new PackingUtil(tExpressInfoDao.selectByPrimaryKey(Long.valueOf(tProductBox.getDeliverId())).getExpressName(), orderDetailsList, new ArrayList<ProductBox>());
        addedProductBoxes=pu.getAssignedProductBoxes();
        
        
//        List<ProductBoxDto> productBoxList = new ArrayList<ProductBoxDto>();
//        for (ProductBox box : addedProductBoxes) {
//            ProductBoxDto dto = new ProductBoxDto(box);
//            productBoxList.add(dto);
//        }
        
        return addedProductBoxes;
    }


    @Override
    public TProductBox selectProductBoxById(String boxId) throws Exception {
        return tProductBoxDao.selectByPrimaryKey(Long.valueOf(boxId));
    }


    @Override
    public TProductOrder selectProductByParam(TProductOrder tProductOrder) throws Exception {
        return tProductOrderDao.selectByParam(tProductOrder);
    }


    @Override
    public void deleteNoPayOrder() throws Exception {
        tProductOrderDao.deleteNoPayOrder();
    }

}
