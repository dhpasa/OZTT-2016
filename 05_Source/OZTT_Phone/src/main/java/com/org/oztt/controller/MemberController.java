package com.org.oztt.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.SysConfigService;

@Controller
@RequestMapping("/member")
public class MemberController extends BaseController {
    
    @Resource
    private SysConfigService sysConfigService;
    
    @Resource
    private CustomerService customerService;
    
    
    /**
     * 点击会员信息按钮
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
        try {
            
            return "member";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
}
