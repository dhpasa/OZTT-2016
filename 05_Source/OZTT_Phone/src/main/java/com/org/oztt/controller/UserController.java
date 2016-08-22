package com.org.oztt.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerMemberInfo;
import com.org.oztt.entity.TSysConfig;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.SysConfigService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
    
    @Resource
    private SysConfigService sysConfigService;
    
    @Resource
    private CustomerService customerService;
    /**
     * 点击最下面的我
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
        try {
            TSysConfig tSysConfig = sysConfigService.getTSysConfig();
            Object customerNo = request.getSession().getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (!StringUtils.isEmpty(customerNo)) {
                //已经登录的场合取得，当前用户的积分和级别
                TCustomerMemberInfo memberInfo = customerService.getCustomerMemberInfo(customerNo.toString());
                if (memberInfo != null) {
                    model.addAttribute("Points", memberInfo.getPoints());
                    model.addAttribute("Level", memberInfo.getLevel());
                }
            }
            model.addAttribute("tSysConfig", tSysConfig);
            return "user";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
