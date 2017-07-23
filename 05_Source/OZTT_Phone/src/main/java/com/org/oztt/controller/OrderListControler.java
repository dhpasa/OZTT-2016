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

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.formDto.OrderDetailViewDto;
import com.org.oztt.formDto.PowderOrderInfo;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.OrderService;
import com.org.oztt.service.PowderService;
import com.org.oztt.service.ProductService;

/**
 * @author x-wang
 */

@Controller
@RequestMapping("/order")
public class OrderListControler extends BaseController {

    @Resource
    OrderService orderService;
    
    @Resource
    CustomerService customerService;
    
    @Resource
    PowderService powderService;
    
    @Resource
    ProductService productService;

    @RequestMapping(value = "/init")
    public String orders(HttpSession session, Model model, HttpServletRequest request, 
            String keyword, String pageNo, String orderStatus) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            if (StringUtils.isEmpty(pageNo)) {
                pageNo = "1";
            }
            
            Pagination pagination = new Pagination(Integer.parseInt(pageNo));
            pagination.setSize(CommonConstants.COMMON_LIST_COUNT);
            Map<Object, Object> paramMap = new HashMap<Object, Object>();
            paramMap.put("customerId", customerBaseInfo.getNo().toString());
            paramMap.put("status", orderStatus);
            paramMap.put("keyword", keyword);
            pagination.setParams(paramMap);
            PagingResult<PowderOrderInfo> orderListPage = powderService.getPowderAndProductOrderPageInfo(pagination);
            
            
            model.addAttribute("orderStatus", orderStatus);
            model.addAttribute("keyword", keyword);
            model.addAttribute("orderList", orderListPage);
            return "/ordersList";
            
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
        
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String order(HttpSession session, @PathVariable String id, Model model, HttpServletRequest request, String orderFlg) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }
            OrderDetailViewDto viewDto = productService.getOrderDetail(id, orderFlg);
            
            String tab = request.getParameter("tab");
            if (!StringUtils.isEmpty(tab)) {
                model.addAttribute("tab", tab);
            }
            model.addAttribute("detailInfo", viewDto);
            return "/orderItem";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
        
    }

}
