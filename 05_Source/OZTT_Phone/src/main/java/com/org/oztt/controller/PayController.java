package com.org.oztt.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.base.util.VpcHttpPayUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TConsOrder;
import com.org.oztt.formDto.OzTtGbOdDto;
import com.org.oztt.formDto.PaypalParam;
import com.org.oztt.service.OrderService;
import com.org.oztt.service.PaypalService;

@Controller
@RequestMapping("/Pay")
public class PayController extends BaseController {

    @Resource
    private PaypalService paypalService;

    @Resource
    private OrderService  orderService;

    /**
     * 跳转到支付画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init")
    public String init(Model model, HttpServletResponse response, HttpSession session, String orderNo, String email) {
        try {
            model.addAttribute("orderNo", orderNo);
            // 取得订单的金额
            OzTtGbOdDto detail = orderService.getOrderDetailInfo(orderNo);
            String amount = new BigDecimal(detail.getXiaoji()).add(new BigDecimal(detail.getYunfei())).toString();
            model.addAttribute("amount", amount);
            model.addAttribute("email", email);
            model.addAttribute("leftTime", detail.getLeftTime());
            return "payment";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 已经有订单，直接付款
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "paymentHasOrder")
    public String paymentHasOrder(Model model, HttpServletResponse response, HttpSession session, String hidDeliMethod,
            String hidAddressId, String hidPayMethod, String orderId) {
        try {
            TConsOrder tConsOrder = orderService.selectByOrderId(orderId);
            // 先判断付款方式
            String rb = "";
            if (CommonEnum.PaymentMethod.ONLINE_PAY_CWB.getCode().equals(hidPayMethod)) {
                // 货到付款
                PaypalParam paypalParam = new PaypalParam();
                paypalParam.setOrderId(orderId);
                if (CommonEnum.DeliveryMethod.HOME_DELIVERY.getCode().equals(hidDeliMethod)) {
                    // 普通快递
                    paypalParam.setPrice(tConsOrder.getOrderamount().add(tConsOrder.getDeliverycost()).toString());
                }
                else if (CommonEnum.DeliveryMethod.PICK_INSTORE.getCode().equals(hidDeliMethod)) {
                    // 来店自提
                    paypalParam.setPrice(tConsOrder.getOrderamount().toString());
                }
                paypalParam.setNotifyUrl(getApplicationMessage("notifyUrl", session) + orderId); //这里是不是通知画面，做一些对数据库的更新操作等
                paypalParam.setCancelReturn(getApplicationMessage("cancelReturn", session) + orderId);//应该返回未完成订单画面订单画面
                paypalParam.setOrderInfo(getApplicationMessage("orderInfo", session));
                paypalParam.setReturnUrl(getApplicationMessage("returnUrl", session));// 同样是当前订单画面
                rb = paypalService.buildRequest(paypalParam);
            }
            if (!StringUtils.isEmpty(rb)) {
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(rb);
                return null;
            }

            return null;

        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
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
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            String orderNo = map.get("orderNo");
            //String email = map.get("email");

            TConsOrder tConsOrder = orderService.selectByOrderId(orderNo);
            BigDecimal amount = tConsOrder.getOrderamount().add(tConsOrder.getDeliverycost());
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
                orderService.updateRecordAfterPay(orderNo, customerNo, session);
                //                if (!StringUtils.isEmpty(email)) {
                //                    // 开启线程进行发信
                //                    orderService.createTaxAndSendMailForPhone(orderNo, customerNo, session, email);
                //                }
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

    /**
     * 付款后的通知
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "paypalNotify")
    public String paypalNotify(Model model, HttpServletResponse response, HttpSession session,
            @RequestParam String orderId) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            orderService.updateRecordAfterPay(orderId, customerNo, session);
            return "redirect:/OZ_TT_GB_OL/itemList?clearCont=1";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    @RequestMapping(value = "TestUrl")
    public void TestUrl(Model model, HttpServletResponse response, HttpSession session) throws Exception {
        orderService.createTaxAndSendMailForPhone("PO20160614000001", "CS20160603000001", session, "578366868@qq.com",
                "linliuan特咖信息技术有限公司", "10003004", "苏州观前街88弄88号88室");
    }

}
