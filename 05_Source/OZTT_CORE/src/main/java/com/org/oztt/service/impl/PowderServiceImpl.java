package com.org.oztt.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.DeliveryPicOperation;
import com.org.oztt.base.util.SMSUtil;
import com.org.oztt.base.util.ShortUrlUtil;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.dao.TConsTransactionDao;
import com.org.oztt.dao.TExpressInfoDao;
import com.org.oztt.dao.TNoOrderDao;
import com.org.oztt.dao.TNoTransactionDao;
import com.org.oztt.dao.TPowderBoxDao;
import com.org.oztt.dao.TPowderInfoDao;
import com.org.oztt.dao.TPowderOrderDao;
import com.org.oztt.dao.TPowderOrderDetailsDao;
import com.org.oztt.dao.TReceiverInfoDao;
import com.org.oztt.dao.TSenderInfoDao;
import com.org.oztt.entity.TConsTransaction;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TNoOrder;
import com.org.oztt.entity.TNoTransaction;
import com.org.oztt.entity.TPowderBox;
import com.org.oztt.entity.TPowderInfo;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.entity.TPowderOrderDetails;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.entity.TSysCode;
import com.org.oztt.formDto.PowderBoxInfo;
import com.org.oztt.formDto.PowderInfoViewDto;
import com.org.oztt.formDto.PowderMilkInfo;
import com.org.oztt.formDto.PowderOrderInfo;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.PowderService;
import com.org.oztt.service.SysConfigService;

@Service
public class PowderServiceImpl extends BaseService implements PowderService {

    @Resource
    private TExpressInfoDao        tExpressInfoDao;

    @Resource
    private TPowderInfoDao         tPowderInfoDao;

    @Resource
    private TPowderBoxDao          tPowderBoxDao;

    @Resource
    private TReceiverInfoDao       tReceiverInfoDao;

    @Resource
    private TSenderInfoDao         tSenderInfoDao;

    @Resource
    private CommonService          commonService;

    @Resource
    private TNoOrderDao            tNoOrderDao;

    @Resource
    private TPowderOrderDetailsDao tPowderOrderDetailsDao;

    @Resource
    private TPowderOrderDao        tPowderOrderDao;

    @Resource
    private TConsTransactionDao    tConsTransactionDao;

    @Resource
    private TNoTransactionDao      tNoTransactionDao;

    @Resource
    private SysConfigService       sysConfigService;

    @Resource
    private CustomerService        customerService;

    @Override
    public List<TExpressInfo> selectAllExpressInfo() throws Exception {
        return tExpressInfoDao.selectAllExpressInfo();
    }

    @Override
    public List<PowderInfoViewDto> selectPowderInfo() throws Exception {
        return tPowderInfoDao.selectAllPowderInfoList();
    }

    @Override
    public List<TReceiverInfo> selectReceiverInfoList(String customerNo) throws Exception {
        return tReceiverInfoDao.selectReceiveList(customerNo);
    }

    @Override
    public List<TSenderInfo> selectSenderInfoList(String customerNo) throws Exception {
        return tSenderInfoDao.selectSendInfoList(customerNo);
    }

    @Override
    public void insertSendInfo(TSenderInfo tSenderInfo) throws Exception {
        tSenderInfoDao.insertSelective(tSenderInfo);
    }

    @Override
    public void insertReveiverInfo(TReceiverInfo tReceiverInfo) throws Exception {
        tReceiverInfoDao.insertSelective(tReceiverInfo);
    }

    @Override
    public void updateSendInfo(TSenderInfo tSenderInfo) throws Exception {
        tSenderInfoDao.updateByPrimaryKeySelective(tSenderInfo);
    }

    @Override
    public void updateReveiverInfo(TReceiverInfo tReceiverInfo) throws Exception {
        tReceiverInfoDao.updateByPrimaryKeySelective(tReceiverInfo);
    }

    @Override
    public void deleteSendInfo(long id) throws Exception {
        tSenderInfoDao.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteReveiverInfo(long id) throws Exception {
        tReceiverInfoDao.deleteByPrimaryKey(id);
    }

    @Override
    public TSenderInfo getSendInfo(long id) throws Exception {
        return tSenderInfoDao.selectByPrimaryKey(id);
    }

    @Override
    public TReceiverInfo getReveiverInfo(long id) throws Exception {
        return tReceiverInfoDao.selectByPrimaryKey(id);
    }

    @Override
    public String getBrandNameByCode(String code) throws Exception {
        List<TSysCode> codeList = commonService.getPowderStage();
        String res = code;
        if (codeList != null && codeList.size() > 0) {
            for (TSysCode tSysCode : codeList) {
                if (code.equals(tSysCode.getCodedetailid())) {
                    res = tSysCode.getCodedetailname();
                }
            }
        }
        return res;
    }

    @SuppressWarnings("unchecked")
    @Override
    public Map<String, String> insertPowderInfo(List<Map<String, Object>> resList, String customerId, String payType)
            throws Exception {

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

        int orderIncrement = tPowderOrderDao.selectAutoIncrement();
        // 奶粉快递箱
        for (Map<String, Object> powderBoxRes : resList) {

            // 每个快递箱下面有多个订单详细
            int increment = tPowderBoxDao.selectAutoIncrement();
            BigDecimal sum = BigDecimal.ZERO;
            // 快递
            TExpressInfo expressInfo = tExpressInfoDao.selectByPrimaryKey(Long.valueOf(powderBoxRes.get("expressId")
                    .toString()));
            BigDecimal allQuantity = BigDecimal.ZERO;
            for (String powderDetailRes : (List<String>) powderBoxRes.get("selectpowderdetailinfo")) {
                String brandId = powderDetailRes.split(",")[0];
                String powderSpec = powderDetailRes.split(",")[1];
                String powderNumber = powderDetailRes.split(",")[2];
                //检索奶粉信息
                TPowderInfo tPowderInfo = new TPowderInfo();
                tPowderInfo.setPowderBrand(brandId);
                tPowderInfo.setPowderSpec(powderSpec);
                tPowderInfo = tPowderInfoDao.selectByParam(tPowderInfo);
                TPowderOrderDetails tPowderOrderDetails = new TPowderOrderDetails();
                tPowderOrderDetails.setPowderId(tPowderInfo.getId().toString());

                allQuantity = allQuantity.add(new BigDecimal(powderNumber));
                tPowderOrderDetails.setQuantity(Long.valueOf(powderNumber));
                tPowderOrderDetails.setUnitPrice(tPowderInfo.getPowderPrice());
                tPowderOrderDetails.setPowderBoxId(String.valueOf(increment));

                tPowderOrderDetailsDao.insertSelective(tPowderOrderDetails);
                sum = sum.add(tPowderOrderDetails.getUnitPrice().multiply(
                        new BigDecimal(tPowderOrderDetails.getQuantity())));

                // 重量 * 数量 * 快递每公斤运费 
                if (CommonConstants.POWDER_TYPE_BABY.equals(tPowderInfo.getPowderType())) {
                    sum = sum.add(tPowderInfo.getWeight().multiply(new BigDecimal(tPowderOrderDetails.getQuantity()))
                            .multiply(expressInfo.getBabyKiloCost()));
                }
                else {
                    sum = sum.add(tPowderInfo.getWeight().multiply(new BigDecimal(tPowderOrderDetails.getQuantity()))
                            .multiply(expressInfo.getInstantKiloCost()));
                }

                // 快递价格系数 * 数量 
                sum = sum.add(expressInfo.getPriceCoefficient().multiply(
                        new BigDecimal(tPowderOrderDetails.getQuantity())));

                if (tPowderOrderDetails.getQuantity() == 3) {
                    // 数量为3的时候 包邮调整系数
                    sum = sum.add(tPowderInfo.getFreeDeliveryParameter());
                }
            }

            TPowderBox tPowderBox = new TPowderBox();
            tPowderBox.setElecExpressNo("");
            tPowderBox.setExpressDate(nowDateString);

            tPowderBox.setDeliverId(powderBoxRes.get("expressId").toString());
            tPowderBox.setSenderId(powderBoxRes.get("sendpersonId").toString());
            tPowderBox.setReceiverId(powderBoxRes.get("addresseepersonId").toString());
            tPowderBox.setIfRemarks(powderBoxRes.get("isRemarkFlg").toString());
            tPowderBox.setRemarks(powderBoxRes.get("remarkData").toString());
            tPowderBox.setIfMsg(powderBoxRes.get("isReceivePicFlg").toString());
            BigDecimal additional = BigDecimal.ZERO;

            // 接收彩信
            if ("1".equals(tPowderBox.getIfMsg())) {
                additional = additional.add(sysConfigService.getTSysConfig().getMessageFee());
            }
            // 做标记
            if ("1".equals(tPowderBox.getIfRemarks())) {
                additional = additional.add(sysConfigService.getTSysConfig().getRemarkFee().multiply(allQuantity));
            }

            tPowderBox.setAdditionalCost(additional);
            tPowderBox.setSumAmount(sum.add(additional));
            tPowderBox.setOrderId(String.valueOf(orderIncrement));
            tPowderBox.setHandleStatus(CommonEnum.PowderBoxFlag.NOT_PACKED.getCode());
            tPowderBoxDao.insertSelective(tPowderBox);

            sumTotal = sumTotal.add(tPowderBox.getSumAmount());

        }

        // 奶粉订单
        TPowderOrder tPowderOrder = new TPowderOrder();
        tPowderOrder.setOrdreNo(maxOrderNo);
        tPowderOrder.setOrderDate(nowDateStringFull);
        tPowderOrder.setCustomerId(customerId);
        tPowderOrder.setSumAmount(sumTotal);
        // 保存奶粉订单的时候一定是没有付款的
        tPowderOrder.setPaymentStatus(CommonEnum.HandleFlag.NOT_PAY.getCode());
        tPowderOrder.setStatus(CommonEnum.HandleFlag.NOT_PAY.getCode());
        if (StringUtils.isNotEmpty(payType)) {
            tPowderOrder.setPaymentMethod(payType);
        }
        tPowderOrderDao.insertSelective(tPowderOrder);

        resMap.put("orderNo", maxOrderNo);
        resMap.put("subAmount", sumTotal.toString());
        return resMap;
    }

    @Override
    public TPowderOrder getTPowderOrderByOrderNo(String orderNo) throws Exception {
        TPowderOrder tPowderOrder = new TPowderOrder();
        tPowderOrder.setOrdreNo(orderNo);
        return tPowderOrderDao.selectByParam(tPowderOrder);
    }

    @Override
    public void updateOrderAfterPay(String orderId, String customerNo, HttpSession session, String serialNo,
            String transactionType) throws Exception {

        TPowderOrder tPowderOrder = this.getTPowderOrderByOrderNo(orderId);
        // 生成入出账记录
        // 取得最新的入出账记录
        TConsTransaction tConsTransactionLast = tConsTransactionDao.selectLastTransaction();

        // 生成发票数据
        // 产生入出账号
        String maxTranctionNo = "";
        // 获取最大的客户号
        TNoTransaction maxTNoTransaction = tNoTransactionDao.getMaxTransactionNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        String nowDateStringFull = DateFormatUtils.getNowTimeFormat("yyyy/MM/dd HH:mm:ss");
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
        tConsTransaction.setTransactionobject(transactionType);
        tConsTransaction.setTransactioncomments("");
        tConsTransaction.setTransactionno(maxTranctionNo);
        tConsTransaction.setTransactionmethod(tPowderOrder.getPaymentMethod());
        tConsTransaction.setTransactionoperator(customerNo);
        tConsTransaction.setTransactionstatus("1");// 处理成功
        tConsTransaction.setTransactiontimestamp(new Date());

        TConsTransaction tConsTransactionIn = new TConsTransaction();
        BeanUtils.copyProperties(tConsTransaction, tConsTransactionIn);
        // 入账记录
        tConsTransactionIn.setInoutflg("1");//入账
        tConsTransactionIn.setTransactionamount(tPowderOrder.getSumAmount());
        tConsTransactionIn.setTransactionbeforeamount(tConsTransactionLast == null ? BigDecimal.ZERO
                : tConsTransactionLast.getTransactionafteramount());
        tConsTransactionIn.setTransactionafteramount(tPowderOrder.getSumAmount().add(
                tConsTransactionIn.getTransactionbeforeamount()));
        tConsTransactionIn.setTransactiontype("1");// 交易类型（订单支付还是手续费收取）
        tConsTransactionDao.insertSelective(tConsTransactionIn);
        // 出账记录
        TConsTransaction tConsTransactionOut = new TConsTransaction();
        BeanUtils.copyProperties(tConsTransaction, tConsTransactionOut);
        tConsTransactionOut.setInoutflg("2");//入账
        tConsTransactionOut.setTransactionbeforeamount(tConsTransactionIn.getTransactionafteramount());
        tConsTransactionOut.setTransactionamount(BigDecimal.ZERO);
        tConsTransactionOut.setTransactionafteramount(tConsTransactionIn.getTransactionafteramount().subtract(
                tConsTransactionOut.getTransactionamount()));
        tConsTransactionOut.setTransactiontype("2");// 交易类型（订单支付还是手续费收取）
        tConsTransactionDao.insertSelective(tConsTransactionOut);

        // 检索当前订单，更新状态为已经付款
        tPowderOrder.setPaymentStatus(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
        tPowderOrder.setStatus(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
        tPowderOrder.setPaymentDate(nowDateStringFull);
        this.updatePowderOrder(tPowderOrder);

        // 更新订单下面的装箱flag
        TPowderBox param = new TPowderBox();
        param.setOrderId(tPowderOrder.getId().toString());
        List<TPowderBox> powderBoxList = tPowderBoxDao.selectTPowderBoxList(param);
        //        if (powderBoxList != null) {
        //            for (TPowderBox boxInfo : powderBoxList) {
        //                boxInfo.setHandleStatus(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
        //                tPowderBoxDao.updateByPrimaryKeySelective(boxInfo);
        //            }
        //        }

        // 付款成功之后，生成快递单照片和快递信息,一个快递单多个订单号
        String eleExpressNo = getExpressEleNo();
        String s = PowderServiceImpl.class.getResource("/").getPath().toString();
        s = java.net.URLDecoder.decode(s, "UTF-8");
        if (powderBoxList != null) {
            for (TPowderBox boxInfo : powderBoxList) {
                PowderBoxInfo powderInfo = this.getPowderInfoById(boxInfo.getId());

                BigDecimal weightAll = BigDecimal.ZERO;
                DeliveryPicOperation dpOperation = null;
                if (CommonConstants.EXPRESS_BLUE_SKY.equals(boxInfo.getDeliverId())) {
                    // 蓝天快递
                    dpOperation = new DeliveryPicOperation(s + "/bluesky.properties");
                }
                else if (CommonConstants.EXPRESS_FREAK_QUICK.equals(boxInfo.getDeliverId())) {
                    // 狂派物流
                    dpOperation = new DeliveryPicOperation(s + "/freakyquick.properties");
                }
                String eleExpressUrl = "";
                if (dpOperation != null) {
                    HashMap<String, Integer> products = new HashMap<String, Integer>();
                    if (powderInfo.getPowderMikeList() != null) {
                        for (PowderMilkInfo info : powderInfo.getPowderMikeList()) {
                            products.put(info.getPowderBrand() + info.getPowderSpec(),
                                    Integer.valueOf(info.getNumber()));
                            weightAll = weightAll.add(info.getWeight().multiply(new BigDecimal(info.getNumber())));
                        }
                    }

                    String outputPathImg = super.getApplicationMessage("DistImgPath", null) + "EXPRESS"
                            + CommonConstants.PATH_SPLIT;
                    eleExpressUrl = dpOperation.createDeliveryPic(outputPathImg, eleExpressNo,
                            powderInfo.getSenderName(), powderInfo.getSenderPhone(),
                            super.getApplicationMessage("sender_address", null), powderInfo.getReceiveName(),
                            powderInfo.getReceivePhone(), powderInfo.getReceiveAddress(), products,
                            weightAll.toString(), new Date());

                }

                boxInfo.setExpressPhotoUrl(eleExpressUrl);
                boxInfo.setElecExpressNo(eleExpressNo);
                tPowderBoxDao.updateByPrimaryKeySelective(boxInfo);
            }
        }

        // 最后发送短信
        this.sendMsgOnNewOrder(customerService.getCustomerSecurityByCustomerNo(customerNo).getTelno(), powderBoxList);

    }

    @Override
    public void updatePowderOrder(TPowderOrder tPowderOrder) throws Exception {
        tPowderOrderDao.updateByPrimaryKeySelective(tPowderOrder);
    }

    @Override
    public List<TPowderOrder> getTPowderOrderInfoList(TPowderOrder tPowderOrder) throws Exception {
        return tPowderOrderDao.getTPowderOrderInfoList(tPowderOrder);
    }

    @Override
    public PagingResult<PowderOrderInfo> getPowderOrderPageInfo(Pagination pagination) throws Exception {
        PagingResult<PowderOrderInfo> orderList = tPowderOrderDao.getPowderOrderPageInfo(pagination);
        if (orderList != null && orderList.getResultList() != null && orderList.getResultList().size() > 0) {
            for (PowderOrderInfo orderInfo : orderList.getResultList()) {
                // 添加装箱信息
                TPowderBox param = new TPowderBox();
                param.setOrderId(orderInfo.getOrderId());
                List<PowderBoxInfo> powderBoxList = tPowderBoxDao.selectTPowderList(param);
                if (powderBoxList != null && powderBoxList.size() > 0) {
                    for (PowderBoxInfo pbi : powderBoxList) {
                        TPowderOrderDetails detailParam = new TPowderOrderDetails();
                        detailParam.setPowderBoxId(pbi.getBoxId());
                        pbi.setPowderMikeList(tPowderOrderDetailsDao.selectPowderDetailList(detailParam));
                    }
                }
                //                orderInfo.setOrderDate(DateFormatUtils.date2StringWithFormat(DateFormatUtils.string2DateWithFormat(
                //                        orderInfo.getOrderDate(), DateFormatUtils.PATTEN2_HMS), DateFormatUtils.PATTEN_HMS));
                orderInfo.setBoxList(powderBoxList);
            }
        }
        return orderList;
    }

    @Override
    public PowderBoxInfo getPowderInfoById(long id) throws Exception {
        TPowderBox tPowderBox = tPowderBoxDao.selectByPrimaryKey(id);
        PowderBoxInfo powderBoxInfo = new PowderBoxInfo();
        powderBoxInfo.setBoxId(String.valueOf(id));
        powderBoxInfo.setBoxPhotoUrls(super.getApplicationMessage("saveImgUrl", null) + "EXPRESS"
                + CommonConstants.PATH_SPLIT + tPowderBox.getBoxPhotoUrls());
        TExpressInfo tExpressInfo = tExpressInfoDao.selectByPrimaryKey(Long.valueOf(tPowderBox.getDeliverId()));
        powderBoxInfo.setExpressAmount(tExpressInfo.getPriceCoefficient().toString());
        powderBoxInfo.setExpressName(tExpressInfo.getExpressName());
        powderBoxInfo.setExpressPhotoUrl(super.getApplicationMessage("saveImgUrl", null) + "EXPRESS"
                + CommonConstants.PATH_SPLIT + tPowderBox.getExpressPhotoUrl());
        powderBoxInfo.setIfMsg(tPowderBox.getIfMsg());
        powderBoxInfo.setIfRemarks(tPowderBox.getIfRemarks());

        TReceiverInfo tReceiverInfo = tReceiverInfoDao.selectByPrimaryKey(Long.valueOf(tPowderBox.getReceiverId()));
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

        powderBoxInfo.setRemarks(tPowderBox.getRemarks());

        TSenderInfo tSenderInfo = tSenderInfoDao.selectByPrimaryKey(Long.valueOf(tPowderBox.getSenderId()));
        powderBoxInfo.setSenderId(tSenderInfo.getId().toString());
        powderBoxInfo.setSenderName(tSenderInfo.getSenderName());
        powderBoxInfo.setSenderPhone(tSenderInfo.getSenderTel());
        powderBoxInfo.setStatus(tPowderBox.getHandleStatus());
        powderBoxInfo.setTotalAmount(tPowderBox.getSumAmount().add(tPowderBox.getAdditionalCost()).toString());

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

        if (StringUtils.isNotEmpty(tPowderBox.getExpressPhotoUrl())) {
            powderBoxInfo.setExpressPhotoUrlExitFlg("1");
        }
        if (StringUtils.isNotEmpty(tPowderBox.getBoxPhotoUrls())) {
            powderBoxInfo.setBoxPhotoUrlsExitFlg("1");
        }
        powderBoxInfo.setElecExpressNo(tPowderBox.getElecExpressNo());
        powderBoxInfo.setDeliverId(tPowderBox.getDeliverId());
        return powderBoxInfo;
    }

    @Override
    public void deleteNotPayPowderOrderLimitTime() throws Exception {
        tPowderOrderDao.deleteNoPayOrder();
    }

    @Override
    public void createExpressPhotoUrl(String orderNo) throws Exception {
        // TODO Auto-generated method stub

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

    @Override
    public void sendMsgOnNewOrder(String phone, List<TPowderBox> boxList) throws Exception {
        String outputPathImg = super.getApplicationMessage("saveImgUrl", null) + "EXPRESS"
                + CommonConstants.PATH_SPLIT;
        int count = 0;
        String msg = super.getMessage("I0011", null);

        for (TPowderBox detail : boxList) {
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

    @Override
    public TExpressInfo selectExpressInfo(long expressId) throws Exception {
        return tExpressInfoDao.selectByPrimaryKey(expressId);
    }
}
