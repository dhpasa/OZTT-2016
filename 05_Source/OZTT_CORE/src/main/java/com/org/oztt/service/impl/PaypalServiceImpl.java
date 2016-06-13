package com.org.oztt.service.impl;

import org.springframework.stereotype.Service;

import com.org.oztt.formDto.PaypalParam;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.PaypalService;

@Service
public class PaypalServiceImpl extends BaseService implements PaypalService {

    public static String URL_LIVE_ACCOUNT  = getApplicationMessage("url_live_account", null); // 首款账号

    public static String URL_LIVE_CODE_URL = getApplicationMessage("url_live_code_url", null); // 生产付款页面

    public static String CURRENCY_CODE     = getApplicationMessage("currency_code", null);    // 当前货币种类

    /**
     * @param orderId 订单号
     * @param price 付款价格
     * @param returnUrl 返回URL
     * @param notifyUrl 通知URL
     * @param cancelReturn 取消URL
     * @return
     * @throws Exception
     */
    @Override
    public String buildRequest(PaypalParam paypalParam) throws Exception {

        String isTest = super.getApplicationMessage("IS_TEST_PAY", null);
        String sanboxPrice = paypalParam.getPrice();
        if (isTest.equals("1")) {
            sanboxPrice = "0.01";
        }
        StringBuffer sbHtml = new StringBuffer();
        sbHtml.append("<html>");
        sbHtml.append("<head>");
        sbHtml.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
        sbHtml.append("<title>goto paypal</title>");
        sbHtml.append("</head>");
        sbHtml.append("<body>");
        sbHtml.append("<form name=\"fomr\" action=\"" + URL_LIVE_CODE_URL + "\" method=\"post\">"); // 不能省略
        sbHtml.append("<input type='hidden' name='cmd' value='_xclick'>"); // 不能省略
        sbHtml.append("<input type='hidden' name='business' value='" + URL_LIVE_ACCOUNT + "'>"); // 贝宝帐号
        sbHtml.append("<input type='hidden' name='item_name' value='" + paypalParam.getOrderInfo() + "'>"); // payment for
        sbHtml.append("<input type='hidden' name='amount' value='" + sanboxPrice + "'>"); // 订单金额
        sbHtml.append("<input type='hidden' name='currency_code' value='" + CURRENCY_CODE + "'>"); // 货币
        sbHtml.append("<input type='hidden' name='return' value='" + paypalParam.getReturnUrl() + paypalParam.getOrderId() + "'>"); // 付款后页面
        sbHtml.append("<input type='hidden' name='invoice' value='" + paypalParam.getOrderId() + "'>"); // 订单号
        sbHtml.append("<input type='hidden' name='charset' value='utf-8'>"); // 字符集
        sbHtml.append("<input type='hidden' name='no_shipping' value='1'>"); // 不要求客户提供收货地址
        sbHtml.append("<input type='hidden' name='no_note' value=''>"); // 付款说明
        sbHtml.append("<input type='hidden' name='notify_url' value='" + paypalParam.getNotifyUrl() + paypalParam.getOrderId() + "'>");
        sbHtml.append("<input type='hidden' name='rm' value='2'>");
        sbHtml.append("<input type='hidden' name='cancel_return' value='" + paypalParam.getCancelReturn() + "'>");
        sbHtml.append("<input type='submit' style='display:none;' value='Go to Paypal'>"); // 按钮
        sbHtml.append("</form><br /><script type='text/javascript'>document.fomr.submit();</script>");
        sbHtml.append("</body>");
        sbHtml.append("</html>");
        return sbHtml.toString();

    }
}
