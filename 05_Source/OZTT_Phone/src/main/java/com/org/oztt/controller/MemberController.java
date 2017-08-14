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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.util.CommonUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerSecurityInfo;
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
     * 更新用户信息
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/modifyMember")
    @ResponseBody
    public Map<String, Object> modifyMember(Model model, HttpServletResponse response, HttpSession session,
            @RequestBody Map<String, Object> reqBody) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            
            String username = CommonUtils.objectToString((String)reqBody.get("username"));
            //String phone = CommonUtils.objectToString((String)reqBody.get("phone"));
            String wechatNo = CommonUtils.objectToString((String)reqBody.get("wechatNo"));
            // 判断输入的手机验证码是否正确
            TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            baseInfo.setNickname(username);
            customerService.updateTCustomerBasicInfo(baseInfo);
            
            TCustomerSecurityInfo securityInfo = customerService.getCustomerSecurityByCustomerNo(customerNo);
            
            securityInfo.setWechatno(wechatNo);
            customerService.updateTCustomerSecurityInfo(securityInfo);
            

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
