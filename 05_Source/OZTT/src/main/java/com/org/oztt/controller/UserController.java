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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerMemberInfo;
import com.org.oztt.entity.TCustomerSecurityInfo;
import com.org.oztt.entity.TSysConfig;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.ProductService;
import com.org.oztt.service.SysConfigService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
    
    @Resource
    private SysConfigService sysConfigService;
    
    @Resource
    private CustomerService customerService;
    
    @Resource
    private ProductService productService;
    /**
     * 点击最下面的我
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }
            TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            
            TCustomerSecurityInfo seInfo = customerService.getCustomerSecurityByCustomerNo(customerNo);
            model.addAttribute("userName", baseInfo.getNickname());
            model.addAttribute("phone", seInfo.getTelno());
            model.addAttribute("wechatNo", seInfo.getWechatno());
            return "member";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 获取派送中的订单
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getOrderCount")
    @ResponseBody
    public Map<String, Object> getOrderCount(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, String orderStatus) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            //
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            // 获取派送中的订单
            int orderCount = productService.getOrderCount(orderStatus, customerBaseInfo.getNo().toString());
            
            mapReturn.put("sccount", orderCount);
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
}
