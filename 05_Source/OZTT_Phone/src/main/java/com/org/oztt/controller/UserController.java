package com.org.oztt.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
    
    /**
     * 点击最下面的我
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpSession session) {
        try {
            
            return "user";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
