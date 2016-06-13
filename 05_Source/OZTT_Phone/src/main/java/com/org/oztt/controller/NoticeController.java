package com.org.oztt.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/Notice")
public class NoticeController extends BaseController {

    @Resource
    private GoodsService goodsService;
    /**
     * 货到付款通知画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "paysuccess")
    public String paysuccess(Model model, HttpServletResponse response, HttpSession session, String orderNo, String is_success) {
        try {
            if ("1".equals(is_success)) {
                model.addAttribute("pay_success", "1");
            }
            model.addAttribute("orderNo", orderNo);
            return "/notice/paySuccessNotice";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 注册成功通知画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "registersuccess")
    public String registersuccess(Model model, HttpServletResponse response, HttpSession session) {
        try {
            
            return "/notice/registerSuccessNotice";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 登录成功通知画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "loginsuccess")
    public String loginsuccess(Model model, HttpServletResponse response, HttpSession session) {
        try {
            
            return "/notice/loginSuccessNotice";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 忘记密码成功通知画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "updatepasswordsuccess")
    public String updatepasswordsuccess(Model model, HttpServletResponse response, HttpSession session) {
        try {
            
            return "/notice/updatePasswordSuccessNotice";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    
}
