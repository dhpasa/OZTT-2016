package com.org.oztt.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.base.util.VpcHttpPayUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.formDto.PowderCommonDto;
import com.org.oztt.formDto.PowderInfoViewDto;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.PowderService;

@Controller
@RequestMapping("/milkPowderAutoPurchase")
public class MilkPowderAutoPurchaseController extends BaseController {

    @Resource
    private PowderService   powderService;

    @Resource
    private CustomerService customerService;

    /**
     * 奶粉订单系统
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session) {
        try {
            // 取得奶粉信息
            List<PowderInfoViewDto> powderList = powderService.selectPowderInfo();
            model.addAttribute("powderList", JSON.toJSONString(powderList));
            List<PowderInfoViewDto> powderListForView = new ArrayList<PowderInfoViewDto>();
            if (powderList != null && powderList.size() > 0) {
                for (PowderInfoViewDto detail : powderList) {
                    PowderInfoViewDto bean = new PowderInfoViewDto();
                    PropertyUtils.copyProperties(bean, detail);
                    bean.setPowderSpec(powderService.getBrandNameByCode(bean.getPowderSpec()));
                    bean.setPowderPrice(bean.getPowderPrice().multiply(CommonConstants.POWDER_NUMBER));
                    powderListForView.add(bean);
                }
            }
            model.addAttribute("PowderInfoList", powderListForView);

            // 获取快递信息
            List<TExpressInfo> expressInfoList = powderService.selectAllExpressInfo();
            model.addAttribute("ExpressList", expressInfoList);

            // 创建json数据
            String powderBrand = "";
            List<PowderCommonDto> powderJsonList = new ArrayList<PowderCommonDto>();
            PowderCommonDto addDto = new PowderCommonDto();

            PowderCommonDto specDto = new PowderCommonDto();
            List<PowderCommonDto> specDtoList = new ArrayList<PowderCommonDto>();
            if (powderList != null && powderList.size() > 0) {
                for (PowderInfoViewDto detail : powderList) {
                    if (!StringUtils.isEmpty(powderBrand) && !powderBrand.equals(detail.getPowderBrand())) {
                        addDto.setChild(specDtoList);
                        powderJsonList.add(addDto);
                        addDto = new PowderCommonDto();
                        specDtoList = new ArrayList<PowderCommonDto>();
                    }
                    addDto.setId(detail.getPowderBrand());
                    addDto.setName(detail.getPowderBrandName());

                    specDto = new PowderCommonDto();
                    specDto.setId(detail.getPowderSpec());
                    specDto.setName(detail.getPowderSpec());
                    specDto.setChild(new PowderCommonDto(3).getChild());
                    specDtoList.add(specDto);

                    powderBrand = detail.getPowderBrand();
                }
                addDto.setChild(specDtoList);
                powderJsonList.add(addDto);
            }
            model.addAttribute("powderJson", JSON.toJSONString(powderJsonList));
            return "milkPowderAutoPurchase";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 得到当前用户的发件人信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getSenderInfo")
    public Map<String, Object> getSenderInfo(HttpServletRequest request, HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            List<TSenderInfo> sendList = powderService.selectSenderInfoList(customerBaseInfo.getNo().toString());

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("addressList", sendList);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 得到当前用户的收件人信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getReceiveInfo")
    public Map<String, Object> getReceiveInfo(HttpServletRequest request, HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            List<TReceiverInfo> receiveList = powderService.selectReceiverInfoList(customerBaseInfo.getNo().toString());

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("addressList", receiveList);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 地址提交
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/submitAddress")
    public Map<String, Object> submitAddress(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            // 提交当前的地址信息
            String updateType = map.get("updateType");
            String name = map.get("name");
            String phone = map.get("phone");
            String address = map.get("address");
            String addressId = map.get("addressId");
            if (StringUtils.isEmpty(addressId)) {
                // 新增
                if ("0".equals(updateType)) {
                    // 发件人
                    TSenderInfo tSenderInfo = new TSenderInfo();
                    tSenderInfo.setSenderName(name);
                    tSenderInfo.setSenderTel(phone);
                    tSenderInfo.setDeleteFlg(CommonConstants.IS_NOT_DELETE);
                    tSenderInfo.setCustomerId(customerBaseInfo.getNo().toString());
                    powderService.insertSendInfo(tSenderInfo);
                }
                else {
                    // 收件人
                    TReceiverInfo tReceiverInfo = new TReceiverInfo();
                    tReceiverInfo.setReceiverName(name);
                    tReceiverInfo.setReceiverTel(phone);
                    tReceiverInfo.setReceiverAddr(address);
                    tReceiverInfo.setDeleteFlg(CommonConstants.IS_NOT_DELETE);
                    tReceiverInfo.setCustomerId(customerBaseInfo.getNo().toString());
                    powderService.insertReveiverInfo(tReceiverInfo);
                }
            }
            else {
                // 更新
                if ("0".equals(updateType)) {
                    // 发件人
                    TSenderInfo tSenderInfo = new TSenderInfo();
                    tSenderInfo.setId(Long.valueOf(addressId));
                    tSenderInfo.setSenderName(name);
                    tSenderInfo.setSenderTel(phone);
                    powderService.updateSendInfo(tSenderInfo);
                }
                else {
                    // 收件人
                    TReceiverInfo tReceiverInfo = new TReceiverInfo();
                    tReceiverInfo.setId(Long.valueOf(addressId));
                    tReceiverInfo.setReceiverName(name);
                    tReceiverInfo.setReceiverTel(phone);
                    tReceiverInfo.setReceiverAddr(address);
                    powderService.updateReveiverInfo(tReceiverInfo);
                }
            }
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getAddress")
    public Map<String, Object> getAddress(HttpServletRequest request, HttpSession session, String updateType,
            String addressId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            TSenderInfo tSenderInfo = null;
            TReceiverInfo tReceiverInfo = null;
            if ("0".equals(updateType)) {
                // 发件人
                tSenderInfo = powderService.getSendInfo(Long.valueOf(addressId));
            }
            else {
                // 收件人
                tReceiverInfo = powderService.getReveiverInfo(Long.valueOf(addressId));
            }
            mapReturn.put("senderInfo", tSenderInfo);
            mapReturn.put("receiverInfo", tReceiverInfo);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 删除地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/deleteAddress")
    public Map<String, Object> deleteAddress(HttpServletRequest request, HttpSession session, String updateType,
            String addressId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            if ("0".equals(updateType)) {
                // 发件人
                powderService.deleteSendInfo(Long.valueOf(addressId));
            }
            else {
                // 收件人
                powderService.deleteReveiverInfo(Long.valueOf(addressId));
            }
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 提交信息保存数据
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/submitPowderDate")
    public Map<String, Object> submitPowderDate(HttpServletRequest request, HttpSession session,
            @RequestBody List<Map<String, Object>> requestList) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            // 保存订单信息
            Map<String, String> resMap = powderService.insertPowderInfo(requestList, customerBaseInfo.getNo().toString());
            mapReturn.put("orderNo", resMap.get("orderNo"));
            mapReturn.put("subAmount", resMap.get("subAmount"));
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }
    
    /**
     * 付款
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "toPay")
    public Map<String, Object> toPay(Model model, HttpServletResponse response, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
        try {
            String orderNo = map.get("orderNo");

            TPowderOrder tPowderOrder = powderService.getTPowderOrderByOrderNo(orderNo);
            // 优先更新付款方式
            tPowderOrder.setPaymentMethod(CommonEnum.PaymentMethod.WE_CHAT.getCode());
            powderService.updatePowderOrder(tPowderOrder);
            BigDecimal amount = tPowderOrder.getSumAmount();
            Map<String, String> payMap = new HashMap<String, String>();
            payMap.put("vpc_Version", MessageUtils.getApplicationMessage("vpc_Version", session));
            payMap.put("vpc_Command", MessageUtils.getApplicationMessage("vpc_Command", session));
            payMap.put("vpc_AccessCode", MessageUtils.getApplicationMessage("vpc_AccessCode", session));
            payMap.put("vpc_MerchTxnRef", MessageUtils.getApplicationMessage("vpc_MerchTxnRef", session));
            payMap.put("vpc_Merchant", MessageUtils.getApplicationMessage("vpc_Merchant", session));
            payMap.put("vpc_OrderInfo", MessageUtils.getApplicationMessage("vpc_OrderInfo", session));
            payMap.put("vpc_Amount", String.valueOf(amount.multiply(new BigDecimal(100)).intValue()));
            payMap.put("vpc_CardNum", map.get("vpc_CardNum"));

            String vpcCardExp = map.get("vpc_CardExp");
            String[] cardExp = vpcCardExp.split("/");
            String cardexp = cardExp[1] + cardExp[0];
            payMap.put("vpc_CardExp", cardexp);

            payMap.put("vpc_CardSecurityCode", map.get("vpc_CardSecurityCode"));
            payMap.put("vpc_CSCLevel", MessageUtils.getApplicationMessage("vpc_CSCLevel", session));
            payMap.put("vpc_TicketNo", "");
            Map<String, String> resMap = VpcHttpPayUtils.http("https://migs.mastercard.com.au/vpcdps", payMap);
            if (resMap != null && "0".equals(resMap.get(VpcHttpPayUtils.VPC_TXNRESPONSECODE))) {
                String serialNo = resMap.get(CommonConstants.TRANSACTION_SERIAL_NO);
                powderService.updateOrderAfterPay(orderNo, customerNo, session, serialNo);
                mapReturn.put("isException", false);
            }
            else {
                mapReturn.put("isException", true);
            }
            return mapReturn;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }
}
