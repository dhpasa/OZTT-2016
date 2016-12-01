package com.org.oztt.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.org.oztt.base.util.DateFormatUtils;
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
import com.org.oztt.formDto.PowderInfoViewDto;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.PowderService;

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
    public Map<String, String> insertPowderInfo(List<Map<String, Object>> resList, String customerId) throws Exception {
        Map<String, String> resMap = new HashMap<String, String>();

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
                tPowderOrderDetails.setQuantity(Long.valueOf(powderNumber));
                tPowderOrderDetails.setUnitPrice(tPowderInfo.getPowderPrice());
                tPowderOrderDetails.setPowderBoxId(String.valueOf(increment));

                tPowderOrderDetailsDao.insertSelective(tPowderOrderDetails);
                sum = sum.add(tPowderOrderDetails.getUnitPrice().multiply(
                        new BigDecimal(tPowderOrderDetails.getQuantity())));

            }

            TPowderBox tPowderBox = new TPowderBox();
            tPowderBox.setElecExpressNo("ELE0001");//TODO
            tPowderBox.setExpressDate(nowDateString);
            tPowderBox.setDeliverId(powderBoxRes.get("expressId").toString());
            tPowderBox.setSenderId(powderBoxRes.get("sendpersonId").toString());
            tPowderBox.setReceiverId(powderBoxRes.get("addresseepersonId").toString());
            tPowderBox.setIfRemarks(powderBoxRes.get("isRemarkFlg").toString());
            tPowderBox.setRemarks(powderBoxRes.get("remarkData").toString());
            tPowderBox.setIfMsg(powderBoxRes.get("isReceivePicFlg").toString());
            tPowderBox.setAdditionalCost(new BigDecimal("123"));//TODO
            tPowderBox.setSumAmount(sum);
            tPowderBox.setOrderId(String.valueOf(orderIncrement));
            tPowderBox.setHandleStatus(CommonEnum.HandleFlag.NOT_PAY.getCode());
            tPowderBoxDao.insertSelective(tPowderBox);

            sumTotal = sumTotal.add(sum);
        }

        // 奶粉订单
        TPowderOrder tPowderOrder = new TPowderOrder();
        tPowderOrder.setOrdreNo(maxOrderNo);
        tPowderOrder.setOrderDate(nowDateString);
        tPowderOrder.setCustomerId(customerId);
        tPowderOrder.setSumAmount(sumTotal);
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
    public void updateOrderAfterPay(String orderId, String customerNo, HttpSession session, String serialNo)
            throws Exception {

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
        tPowderOrder.setPaymentDate(nowDateString);
        this.updatePowderOrder(tPowderOrder);

    }

    @Override
    public void updatePowderOrder(TPowderOrder tPowderOrder) throws Exception {
        tPowderOrderDao.updateByPrimaryKeySelective(tPowderOrder);
    }
}
