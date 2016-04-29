package com.org.oztt.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
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

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TConsOrder;
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
            model.addAttribute("email", email);
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
            if (CommonEnum.PaymentMethod.PAYPAL.getCode().equals(hidPayMethod)) {
                // 货到付款
                PaypalParam paypalParam = new PaypalParam();
                paypalParam.setOrderId(orderId);
                if (CommonEnum.DeliveryMethod.NORMAL.getCode().equals(hidDeliMethod)) {
                    // 普通快递
                    paypalParam.setPrice(tConsOrder.getOrderamount().add(tConsOrder.getDeliverycost()).toString());
                }
                else if (CommonEnum.DeliveryMethod.SELF_PICK.getCode().equals(hidDeliMethod)) {
                    // 来店自提
                    paypalParam.setPrice(tConsOrder.getOrderamount().toString());
                }
                paypalParam.setNotifyUrl(getApplicationMessage("notifyUrl") + orderId); //这里是不是通知画面，做一些对数据库的更新操作等
                paypalParam.setCancelReturn(getApplicationMessage("cancelReturn") + orderId);//应该返回未完成订单画面订单画面
                paypalParam.setOrderInfo(getApplicationMessage("orderInfo"));
                paypalParam.setReturnUrl(getApplicationMessage("returnUrl"));// 同样是当前订单画面
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
     * 付款后的通知
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
            String card = map.get("card");
            String password = map.get("password");
            String verifycode = map.get("verifycode");
            String orderNo = map.get("orderNo");
            String email = map.get("email");
            orderService.updateRecordAfterPay(orderNo, customerNo, session);

            TConsOrder tConsOrder = orderService.selectByOrderId(orderNo);
            BigDecimal amount = tConsOrder.getOrderamount();
            if (paymoney(card, password, verifycode, amount)) {
                if (!StringUtils.isEmpty(email)){
                    orderService.createTaxAndSendMailForPhone(orderNo, customerNo, session, email);
                }
            }
            
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
        // 是客户操作
        // 将文件输出
        InputStream inStream = new FileInputStream("/Users/linliuan/ireport/INVOICE_TAX.pdf");
        // 输出格式
        response.reset();
        response.setContentType("application/pdf");
        response.addHeader("Content-Disposition", "attachment; filename=\"" + "TEST.pdf" + "\"");
        // 循环取出流中的数据
        byte[] b = new byte[100];
        int len;
        try {
            while ((len = inStream.read(b)) > 0)
                response.getOutputStream().write(b, 0, len);
            inStream.close();
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 调用接口实现付款
     * 
     * @param card
     * @param password
     * @param verifycode
     * @param amount
     * @return
     */
    private boolean paymoney(String card, String password, String verifycode, BigDecimal amount) {

        try {
            return true;
        }
        catch (Exception e) {
            return false;
        }

    }

}
