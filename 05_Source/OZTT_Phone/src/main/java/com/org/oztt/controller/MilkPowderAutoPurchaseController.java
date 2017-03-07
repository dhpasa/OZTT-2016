package com.org.oztt.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.org.oztt.base.util.CommonUtils;
import com.org.oztt.base.util.HttpRequest;
import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.base.util.VpcHttpPayUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.entity.TSysConfig;
import com.org.oztt.formDto.PowderCommonDto;
import com.org.oztt.formDto.PowderInfoViewDto;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.PowderService;
import com.org.oztt.service.SysConfigService;

@Controller
@RequestMapping("/milkPowderAutoPurchase")
public class MilkPowderAutoPurchaseController extends BaseController {

    @Resource
    private PowderService    powderService;

    @Resource
    private CustomerService  customerService;

    @Resource
    private SysConfigService sysConfigService;

    /**
     * 奶粉订单系统
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session, String mode) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            // 奶粉订单系统，必需登录才可以进入
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/user/init";
            }
            // 获取蓝天快递的信息
            TExpressInfo tExpressInfo = powderService.selectExpressInfo(Long.valueOf(CommonConstants.EXPRESS_BLUE_SKY));
            // 取得奶粉信息
            List<PowderInfoViewDto> powderList = powderService.selectPowderInfo();
            model.addAttribute("powderList", JSON.toJSONString(powderList));
            List<PowderInfoViewDto> powderListForView = new ArrayList<PowderInfoViewDto>();
            if (powderList != null && powderList.size() > 0) {
                for (PowderInfoViewDto detail : powderList) {
                    PowderInfoViewDto bean = new PowderInfoViewDto();
                    PropertyUtils.copyProperties(bean, detail);
                    bean.setPowderSpec(powderService.getBrandNameByCode(bean.getPowderSpec()));
                    if (CommonConstants.POWDER_TYPE_BABY.equals(detail.getPowderType())) {
                        BigDecimal showprice = tExpressInfo
                                .getPriceCoefficient()
                                .multiply(CommonConstants.BOBY_POWDER_NUMBER)
                                .add(detail.getWeight().multiply(CommonConstants.BOBY_POWDER_NUMBER)
                                        .multiply(tExpressInfo.getBabyKiloCost())
                                        .setScale(2, BigDecimal.ROUND_HALF_UP));
                        showprice = showprice.add(bean.getPowderPrice().multiply(CommonConstants.BOBY_POWDER_NUMBER)
                                .add(detail.getFreeDeliveryParameter()));
                        bean.setPowderPrice(showprice);
                    }
                    else {
                        BigDecimal showprice = tExpressInfo
                                .getPriceCoefficient()
                                .multiply(CommonConstants.ADULT_POWDER_NUMBER)
                                .add(detail.getWeight().multiply(CommonConstants.ADULT_POWDER_NUMBER)
                                        .multiply(tExpressInfo.getInstantKiloCost())
                                        .setScale(2, BigDecimal.ROUND_HALF_UP));
                        showprice = showprice.add(bean.getPowderPrice().multiply(CommonConstants.ADULT_POWDER_NUMBER)
                                .add(detail.getFreeDeliveryParameter()));
                        bean.setPowderPrice(showprice);
                    }
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
                    specDto.setName(powderService.getBrandNameByCode(detail.getPowderSpec()));
                    if (CommonConstants.POWDER_TYPE_BABY.equals(detail.getPowderType())) {
                        specDto.setChild(new PowderCommonDto(3).getChild());
                    }
                    else {
                        specDto.setChild(new PowderCommonDto(6).getChild());
                    }
                    specDtoList.add(specDto);

                    powderBrand = detail.getPowderBrand();
                }
                addDto.setChild(specDtoList);
                powderJsonList.add(addDto);
            }
            // 获取奶粉的附加费用信息
            TSysConfig tSysConfig = sysConfigService.getTSysConfig();
            model.addAttribute("sysconfig", tSysConfig);
            model.addAttribute("powderJson", JSON.toJSONString(powderJsonList));
            model.addAttribute("mode", mode);
            return "milkPowderAutoPurchase";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
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
            logger.error("message", e);
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
            logger.error("message", e);
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
            logger.error("message", e);
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
            logger.error("message", e);
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
            logger.error("message", e);
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
            @RequestBody List<Map<String, Object>> requestList, String payType) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            // 保存订单信息
            Map<String, String> resMap = powderService.insertPowderInfo(requestList, customerBaseInfo.getNo()
                    .toString(), payType);
            mapReturn.put("orderNo", resMap.get("orderNo"));
            mapReturn.put("subAmount", resMap.get("subAmount"));
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
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
            tPowderOrder.setPaymentMethod(CommonEnum.PaymentMethod.ONLINE_PAY_CWB.getCode());
            tPowderOrder.setPaymentStatus(CommonConstants.PAY_STATUS_ING);
            powderService.updatePowderOrder(tPowderOrder);
            logger.error("信用卡付款，优先更新付款方式和付款状态=2(付款进行中)。订单号为：" + orderNo);
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
                logger.error("信用卡付款，付款成功下面开始进行付款成功后的操作。订单号为：" + orderNo);
                powderService.updateOrderAfterPay(orderNo, customerNo, session, serialNo,
                        CommonConstants.TRANSACTION_OBJECT);
                mapReturn.put("isException", false);
            }
            else {
                mapReturn.put("isException", true);
            }
            return mapReturn;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message",e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取未付款的订单
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getNotPayCount")
    @ResponseBody
    public Map<String, Object> getNotPayCount(HttpServletRequest request, HttpServletResponse response,
            HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            //
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            if (customerNo == null) {
                return mapReturn;
            }
            // 获取未付款的订单
            TPowderOrder tPowderOrder = new TPowderOrder();
            tPowderOrder.setCustomerId(customerBaseInfo.getNo().toString());
            tPowderOrder.setStatus(CommonEnum.HandleFlag.NOT_PAY.getCode());
            List<TPowderOrder> orderList = powderService.getTPowderOrderInfoList(tPowderOrder);

            mapReturn.put("sccount", orderList == null ? 0 : orderList.size());
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取待发货的订单
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getNotDeliverCount")
    @ResponseBody
    public Map<String, Object> getNotDeliverCount(HttpServletRequest request, HttpServletResponse response,
            HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            //
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            if (customerNo == null) {
                return mapReturn;
            }
            // 获取处理中订单
            TPowderOrder tPowderOrder = new TPowderOrder();
            tPowderOrder.setCustomerId(customerBaseInfo.getNo().toString());
            tPowderOrder.setStatus(CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode());
            List<TPowderOrder> orderList = powderService.getTPowderOrderInfoList(tPowderOrder);

            mapReturn.put("sccount", orderList == null ? 0 : orderList.size());
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 微信支付通知画面
     * 
     * @param model
     * @param request
     * @param orderId
     * @return
     */
    @RequestMapping(value = "/notify", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> notify(Model model, HttpServletRequest request, String orderId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 微信支付成功画面
     * 
     * @param model
     * @param request
     * @param orderId
     * @return
     */
    @RequestMapping(value = "/redirect", method = RequestMethod.GET)
    public String redirect(Model model, HttpServletRequest request, HttpSession session, String orderId) {
        try {
            logger.error("微信付款成功之后开始调用接口，订单号为：" + orderId);
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TPowderOrder tPowderOrder = powderService.getTPowderOrderByOrderNo(orderId);
            // 优先更新付款方式
            tPowderOrder.setPaymentMethod(CommonEnum.PaymentMethod.WE_CHAT.getCode());
            powderService.updatePowderOrder(tPowderOrder);
            logger.error("微信付款成功之后,先将支付方式设置为微信付款，订单号为：" + orderId);
            logger.error("微信付款成功之后,调用更新接口传的参数分别为订单号：" + orderId + "用户号：" + customerNo);
            powderService.updateOrderAfterPay(orderId, customerNo, session, "000010000",
                    CommonConstants.TRANSACTION_OBJECT);
            logger.error("微信付款成功，并且更新状态，快递单，发短信都成功后跳转画面，订单号为：" + orderId);
            return "redirect:/user/init";
        }
        catch (Exception e) {
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 获取微信支付URL
     * 
     * @param model
     * @param request
     * @param orderId
     * @return
     */
    @RequestMapping(value = "/getWeChatPayUrl")
    @ResponseBody
    public Map<String, Object> getWeChatPayUrl(Model model, HttpServletRequest request, HttpSession session,
            String orderId, @RequestBody String paraMap) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String dTime = String.valueOf(new Date().getTime());
            String uu = UUID.randomUUID().toString().replace("-", "");
            String parterCode = super.getApplicationMessage("partner_code", session);
            String credentialCode = super.getApplicationMessage("credential_code", session);

            String signOrigin = parterCode + "&" + dTime + "&" + uu + "&" + credentialCode;
            String signDes = CommonUtils.sign(signOrigin, "SHA-256");
            logger.error("微信付款，开始调用接口，注册订单信息，订单号为：" + orderId);
            String url = "https://mpay.royalpay.com.au/api/v1.0/wechat_jsapi_gateway/partners/OZTT/orders/" + orderId;
            url = url + "?time=" + dTime + "&nonce_str=" + uu + "&sign=" + signDes;

            String notify_url = super.getApplicationMessage("wechat_notify_url", session) + orderId;

            String redirect_url = super.getApplicationMessage("wechat_redirect", session) + orderId;

            TPowderOrder tPowderOrder = powderService.getTPowderOrderByOrderNo(orderId);
            tPowderOrder.setPaymentStatus(CommonConstants.PAY_STATUS_ING);
            powderService.updatePowderOrder(tPowderOrder);
            logger.error("微信付款，更新付款状态为2(正在付款中)，订单号为：" + orderId);
            
            JSONObject paramJson = (JSONObject) JSONObject.parse(paraMap);
            paramJson.put("price", tPowderOrder.getSumAmount().multiply(new BigDecimal(100)).intValue());
            //paramJson.put("price", 1);
            paramJson.put("notify_url", notify_url);

            String doputInfo = HttpRequest.doPut(url, paramJson.toJSONString());

            String returnUrl = "";
            if (!StringUtils.isEmpty(doputInfo)) {
                dTime = String.valueOf(new Date().getTime());
                uu = UUID.randomUUID().toString().replace("-", "");
                signOrigin = parterCode + "&" + dTime + "&" + uu + "&" + credentialCode;

                String signAgain = CommonUtils.sign(signOrigin, "SHA-256");
                JSONObject putResJson = (JSONObject) JSONObject.parse(doputInfo);
                returnUrl = putResJson.getString("pay_url") + "?redirect=" + redirect_url + "&directpay=false";
                returnUrl += "&time=" + dTime + "&nonce_str=" + uu + "&sign=" + signAgain;
                logger.error("微信付款，订单注册成功，订单号为：" + orderId);
            }

            mapReturn.put("payUrl", returnUrl);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取微信支付已经URL
     * 
     * @param model
     * @param request
     * @param orderId
     * @return
     */
    @RequestMapping(value = "/getWeChatPayUrlHasCreate")
    @ResponseBody
    public Map<String, Object> getWeChatPayUrlHasCreate(Model model, HttpServletRequest request, HttpSession session,
            String orderId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String dTime = String.valueOf(new Date().getTime());
            String uu = UUID.randomUUID().toString().replace("-", "");
            String parterCode = super.getApplicationMessage("partner_code", session);
            String credentialCode = super.getApplicationMessage("credential_code", session);

            String redirect_url = super.getApplicationMessage("wechat_redirect", session) + orderId;

            String signOrigin = parterCode + "&" + dTime + "&" + uu + "&" + credentialCode;
            String signDes = CommonUtils.sign(signOrigin, "SHA-256");
            logger.error("微信付款，订单已经注册成功，直接进行付款。订单号为：" + orderId);
            String url = "https://mpay.royalpay.com.au/api/v1.0/wechat_jsapi_gateway/partners/OZTT_order_" + orderId;
            url += "?redirect=" + redirect_url + "&directpay=false";
            url += "&time=" + dTime + "&nonce_str=" + uu + "&sign=" + signDes;

            mapReturn.put("payUrl", url);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

}
