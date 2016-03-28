package com.org.oztt.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;

@Controller
@RequestMapping("/shopcart")
public class ShopCartController extends BaseController {
    
    /**
     * 购物车信息一览
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpSession session) {
        try {
            
            return "shopcart";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
