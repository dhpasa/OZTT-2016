package com.org.oztt.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;

@Controller
@RequestMapping("/AboutUs")
public class AboutUsController extends BaseController {
    
    /**
     * 链接画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/AU")
    public String aboutus(Model model, HttpServletResponse response, HttpSession session) {
        try {
            return "aboutus";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 链接画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/RS")
    public String refundspolicy(Model model, HttpServletResponse response, HttpSession session) {
        try {
            return "refundspolicy";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
