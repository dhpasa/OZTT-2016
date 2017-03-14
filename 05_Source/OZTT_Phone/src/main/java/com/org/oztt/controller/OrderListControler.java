/**
 * 
 */
package com.org.oztt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.OrderInfoDto;
import com.org.oztt.formDto.OzTtGbOdDto;
import com.org.oztt.service.OrderService;

/**
 * @author x-wang
 */

@Controller
@RequestMapping("/order")
public class OrderListControler extends BaseController {

    @Resource
    OrderService orderService;

    @RequestMapping(value = "/init", method = RequestMethod.GET)
    public String orders(Model model, HttpServletRequest request) {
        String tab = request.getParameter("tab");
        if (!StringUtils.isEmpty(tab)) {
            model.addAttribute("tab", tab);
        }
        return "/ordersList";
    }

    @RequestMapping(value = "/initList", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> orders(HttpServletRequest request, HttpSession session, String pageNo) {
        Map<String, Object> resp = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (StringUtils.isEmpty(customerNo)) {
                resp.put("isException", true);
                return resp;
            }
            String handleFlg = request.getParameter("orderStatus");
            if (StringUtils.isEmpty(pageNo)) {
                pageNo = "1";
            }
            Pagination pagination = new Pagination(Integer.parseInt(pageNo));
            pagination.setSize(10);
            Map<Object, Object> paramMap = new HashMap<Object, Object>();
            paramMap.put("customerNo", customerNo);
            paramMap.put("handleFlg", handleFlg);
            pagination.setParams(paramMap);
            PagingResult<OrderInfoDto> orderListPage = orderService.getAllOrderInfoForPage(pagination);
            resp.put("isException", false);

            resp.put("orderList", orderListPage.getResultList());
            return resp;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            resp.put("isException", true);
            return resp;
        }
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String order(@PathVariable String id, Model model, HttpServletRequest request) {
        try {
            OzTtGbOdDto detail = orderService.getOrderDetailInfo(id);
            String tab = request.getParameter("tab");
            if (!StringUtils.isEmpty(tab)) {
                model.addAttribute("tab", tab);
            }
            model.addAttribute("detailInfo", detail);
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
        }
        return "/orderItem";
    }

}
