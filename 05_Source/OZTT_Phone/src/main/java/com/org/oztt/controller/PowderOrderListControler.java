/**
 * 
 */
package com.org.oztt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.formDto.PowderBoxInfo;
import com.org.oztt.formDto.PowderOrderInfo;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.OrderService;
import com.org.oztt.service.PowderService;

/**
 * @author la-lin
 */

@Controller
@RequestMapping("/powderOrder")
public class PowderOrderListControler extends BaseController {

    @Resource
    private PowderService   powderService;

    @Resource
    private CustomerService customerService;

    @Resource
    private OrderService    orderService;

    @RequestMapping(value = "/init", method = RequestMethod.GET)
    public String orders(Model model, HttpServletRequest request) throws Exception {
        String tab = request.getParameter("tab");
        if (!StringUtils.isEmpty(tab)) {
            model.addAttribute("tab", tab);
        }
        return "/powderOrdersList";
    }

    @RequestMapping(value = "/initList", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> orders(HttpServletRequest request, HttpSession session, String pageNo) {
        Map<String, Object> resp = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            String status = request.getParameter("orderStatus");
            if (StringUtils.isEmpty(pageNo)) {
                pageNo = "1";
            }
            Pagination pagination = new Pagination(Integer.parseInt(pageNo));
            pagination.setSize(10);
            Map<Object, Object> paramMap = new HashMap<Object, Object>();
            paramMap.put("customerId", customerBaseInfo.getNo().toString());
            paramMap.put("status", status);
            pagination.setParams(paramMap);
            PagingResult<PowderOrderInfo> orderListPage = powderService.getPowderOrderPageInfo(pagination);
            resp.put("isException", false);

            resp.put("orderList", orderListPage.getResultList());
            return resp;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            resp.put("isException", true);
            return resp;
        }
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String order(@PathVariable String id, Model model, HttpServletRequest request) {
        try {
            PowderBoxInfo detail = powderService.getPowderInfoById(Long.valueOf(id));
            String tab = request.getParameter("tab");
            if (!StringUtils.isEmpty(tab)) {
                model.addAttribute("tab", tab);
            }
            model.addAttribute("detailInfo", detail);
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        }
        return "/powderOrderItem";
    }
    
    /**
     * 跳转到支付画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/toCWLPay")
    public String toCWLPay(Model model, HttpServletResponse response, HttpSession session, String orderId) {
        try {
            model.addAttribute("orderNo", orderId);
            // 取得订单的金额
            TPowderOrder detail = powderService.getTPowderOrderByOrderNo(orderId);
            String amount = detail.getSumAmount().toString();
            model.addAttribute("amount", amount);
            model.addAttribute("leftTime", DateFormatUtils.getTimeBetNowACreate(detail.getUpdTimestamp()));
            return "paymentPowderOrder";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
