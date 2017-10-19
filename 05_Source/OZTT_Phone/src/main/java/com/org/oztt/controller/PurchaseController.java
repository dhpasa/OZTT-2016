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

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.CommonUtils;
import com.org.oztt.base.util.HttpRequest;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TProduct;
import com.org.oztt.entity.TProductOrder;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.entity.TSysConfig;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.ExpressBoxInfo;
import com.org.oztt.formDto.ProductBoxDto;
import com.org.oztt.formDto.ProductOrderDetails;
import com.org.oztt.formDto.PurchaseViewDto;
import com.org.oztt.packing.util.PackingUtil;
import com.org.oztt.packing.util.ProductBox;
import com.org.oztt.service.AddressService;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.GoodsService;
import com.org.oztt.service.OrderService;
import com.org.oztt.service.PowderService;
import com.org.oztt.service.ProductService;
import com.org.oztt.service.SysConfigService;

@Controller
@RequestMapping("/purchase")
public class PurchaseController extends BaseController {

    @Resource
    private GoodsService   goodsService;

    @Resource
    private AddressService addressService;

    @Resource
    private OrderService   orderService;
    
    @Resource
    private CustomerService customerService;
    
    @Resource
    private PowderService powderService;
    
    @Resource
    private ProductService productService;
    
    @Resource
    private SysConfigService sysConfigService;

    /**
     * 购买确认画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session, String senderId, String receiveId) {
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            //String canTestCustomer = "CS20160623000001,CS20170205000002,CS20160605000002,CS20160605000001";
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }
            
            //if (canTestCustomer.indexOf(customerNo) < 0){
            //    return "redirect:/main/init"; 
            //}
            // 取得购物车里面选购的内容
            List<ContCartItemDto> consCarts = goodsService.getAllContCartForBuy(customerNo);
            
            PurchaseViewDto viewDto = new PurchaseViewDto();
            BigDecimal productAmount = BigDecimal.ZERO;
            for (ContCartItemDto dto : consCarts) {
                productAmount = productAmount.add(new BigDecimal(dto.getGoodsPrice()));
            }
            
            viewDto.setProductSumAmount(productAmount.toString());
            
            
            // 获取收件人和寄件人信息，取第一个现在在画面上
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            Pagination pagination = new Pagination(1);
            pagination.setSize(CommonConstants.COMMON_LIST_COUNT);
            Map<Object, Object> paramMap = new HashMap<Object, Object>();
            paramMap.put("customerId", customerBaseInfo.getNo());
            pagination.setParams(paramMap);
            
            if (StringUtils.isEmpty(receiveId)){
                PagingResult<TReceiverInfo> receiveList = powderService.selectReceiverInfoPageList(pagination);
                
                if (receiveList != null && receiveList.getResultList() != null && receiveList.getResultList().size() > 0) {
                    viewDto.setReceiveName(receiveList.getResultList().get(0).getReceiverName());
                    viewDto.setReceivePhone(receiveList.getResultList().get(0).getReceiverTel());
                    viewDto.setReceiveAddress(receiveList.getResultList().get(0).getReceiverAddr());
                    viewDto.setReceiveId(receiveList.getResultList().get(0).getId().toString());
                   
                }
            } else {
                TReceiverInfo tReceiverInfo = powderService.getReveiverInfo(Long.valueOf(receiveId));
                viewDto.setReceiveName(tReceiverInfo.getReceiverName());
                viewDto.setReceivePhone(tReceiverInfo.getReceiverTel());
                viewDto.setReceiveAddress(tReceiverInfo.getReceiverAddr());
                viewDto.setReceiveId(receiveId);
            }
            
            
            if (StringUtils.isEmpty(senderId)){
                PagingResult<TSenderInfo> sendList = powderService.selectSenderInfoPageList(pagination);
                if (sendList != null && sendList.getResultList() != null && sendList.getResultList().size() > 0) {
                    viewDto.setSenderName(sendList.getResultList().get(0).getSenderName());
                    viewDto.setSenderPhone(sendList.getResultList().get(0).getSenderTel());
                    viewDto.setSenderId(sendList.getResultList().get(0).getId().toString());
                }
            } else {
                TSenderInfo tSenderInfo = powderService.getSendInfo(Long.valueOf(senderId));
                viewDto.setSenderName(tSenderInfo.getSenderName());
                viewDto.setSenderPhone(tSenderInfo.getSenderTel());
                viewDto.setSenderId(senderId);
            }
            
            // 购买的数据
            List<ProductOrderDetails> orderDetailsList = new ArrayList<ProductOrderDetails>();
            
            int detailsNumber = 0;
            
            for (ContCartItemDto dto : consCarts) {
                TProduct p1 = new TProduct();
                p1.setCode(dto.getCode());
                p1 = productService.getProductByParam(p1);
                BigDecimal goodsUnit = new BigDecimal(dto.getGoodsPrice()).divide(new BigDecimal(dto.getGoodsQuantity()));
                ProductOrderDetails detail = new ProductOrderDetails(p1, Long.valueOf(dto.getGoodsQuantity()), goodsUnit);
                orderDetailsList.add(detail);
                detailsNumber++;
            }
            
            
            // 获取快递信息
            List<TExpressInfo> expressInfoList = powderService.selectAllExpressInfo();
            
            List<ExpressBoxInfo> expressBoxList = new ArrayList<ExpressBoxInfo>();
            // 装箱结果
            List<ProductBox>  addedProductBoxes = new ArrayList<ProductBox>();
            for (TExpressInfo exInf : expressInfoList) {
                ExpressBoxInfo boxInfo = new ExpressBoxInfo();
                boxInfo.settExpressInfo(exInf);
                
                PackingUtil pu=new PackingUtil(exInf.getExpressName(), orderDetailsList, new ArrayList<ProductBox>());
                addedProductBoxes=pu.getAssignedProductBoxes();
                
                Double a = 0D;
                
                List<ProductBoxDto> productBoxList = new ArrayList<ProductBoxDto>();
                for (ProductBox box : addedProductBoxes) {
                    a += box.getWeight();
                    ProductBoxDto dto = new ProductBoxDto(box);
                    productBoxList.add(dto);
                }
                // 总重量
                boxInfo.setWeight(new BigDecimal(a).setScale(2, BigDecimal.ROUND_UP).doubleValue());
                
                // 快递价格系数 * 数量 
                BigDecimal sum = exInf.getPriceCoefficient().multiply(
                        new BigDecimal(detailsNumber));    
                
                boxInfo.setTotalPrice(exInf.getKiloCost().multiply(BigDecimal.valueOf(boxInfo.getWeight())).add(sum).setScale(2, BigDecimal.ROUND_UP));
                boxInfo.setAddedProductBoxes(productBoxList);
                
                expressBoxList.add(boxInfo);
            }
            model.addAttribute("ExpressList", expressBoxList);
            
            model.addAttribute("PurchaseViewDto", viewDto);
            return "/purchase";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 直接付款
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "payment")
    public Map<String, Object> payment(Model model, HttpServletResponse response, HttpSession session,
            @RequestBody Map<String, Object> param) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            String hidPayMethod = param.get("payMethod").toString();
            String hidDeliMethod = param.get("deliveryMethod").toString();
            String hidAddressId = param.get("addressId") == null ? null : param.get("addressId").toString();
            String hidHomeDeliveryTime = param.get("deliveryTime").toString().replaceAll("/", "")
                    + param.get("deliverySelect").toString();
            String isUnify = param.get("isUnify").toString();
            String invoicemail = param.get("invoicemail").toString();
            String needInvoice = param.get("needInvoice").toString();
            String purchaseRemarks = param.get("purchaseRemarks").toString();

            // 先判断付款方式
            String orderNo = orderService.insertOrderInfoForPhone(customerNo, hidPayMethod, hidDeliMethod,
                    hidAddressId, hidHomeDeliveryTime, isUnify, needInvoice, invoicemail, session, purchaseRemarks);
            if (CommonConstants.CART_CANBUY.equals(orderNo)) {
                mapReturn.put("orderPayStatus", CommonConstants.CART_CANBUY);
            }
            mapReturn.put("orderNo", orderNo);
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
     * 提交信息保存数据
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/payment4Product")
    public Map<String, Object> payment4Product(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, Object> requestMap) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (StringUtils.isEmpty(customerNo)) {
                mapReturn.put("isException", true);
                return mapReturn;
            }
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            
            
            String senderId = requestMap.get("senderId").toString();
            String receiveId = requestMap.get("receiveId").toString();
            String ShippingMethodId = requestMap.get("ShippingMethodId").toString();
            String CustomerNote = requestMap.get("CustomerNote").toString();
            String PaymentMethodId = requestMap.get("PaymentMethodId").toString();
            // 保存订单信息
            Map<String, String> resMap = productService.insertProductInfo(customerBaseInfo.getNo()
                    .toString(), customerBaseInfo.getCustomerno(), senderId, receiveId, ShippingMethodId, CustomerNote, PaymentMethodId);
            mapReturn.put("orderNo", resMap.get("orderNo"));
            mapReturn.put("subAmount", resMap.get("subAmount"));
            TSysConfig sysconfig = sysConfigService.getTSysConfigInRealTime();
            
            if (sysconfig != null && sysconfig.getMasterCardFee() != null) {
                String amountStr = resMap.get("subAmount");
                amountStr = new BigDecimal(amountStr).add(new BigDecimal(amountStr).multiply(sysconfig.getMasterCardFee()).setScale(2, BigDecimal.ROUND_HALF_UP)).toString();
                mapReturn.put("subAmount", amountStr);
            }
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

            String url = "https://mpay.royalpay.com.au/api/v1.0/wechat_jsapi_gateway/partners/OZTT/orders/" + orderId;
            url = url + "?time=" + dTime + "&nonce_str=" + uu + "&sign=" + signDes;

            String notify_url = super.getApplicationMessage("wechat_notify_url_fortt", session) + orderId;

            String redirect_url = super.getApplicationMessage("wechat_redirect_url_fortt", session) + orderId;

            TProductOrder productOrder = new TProductOrder();
            productOrder.setOrderNo(orderId);
            productOrder = productService.selectProductByParam(productOrder);

            JSONObject paramJson = (JSONObject) JSONObject.parse(paraMap);
            paramJson.put("price", productOrder.getSumAmount().multiply(new BigDecimal(100)).intValue());
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
            
            String redirect_url = super.getApplicationMessage("wechat_redirect_url_fortt", session) + orderId;

            String signOrigin = parterCode + "&" + dTime + "&" + uu + "&" + credentialCode;
            String signDes = CommonUtils.sign(signOrigin, "SHA-256");
            
            String url = "https://mpay.royalpay.com.au/api/v1.0/wechat_jsapi_gateway/partners/OZTT_order_"+orderId;
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
    
    /**
     * 微信支付通知画面
     * 
     * @param model
     * @param request
     * @param orderId
     * @return
     */
    @RequestMapping(value = "/notify", method = RequestMethod.GET)
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
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            productService.updateRecordAfterPay(orderId, customerNo, session, "000010000");
            return "redirect:/user/init";
        }
        catch (Exception e) {
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
}
