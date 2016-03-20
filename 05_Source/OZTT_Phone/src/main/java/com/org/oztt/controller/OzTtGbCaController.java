package com.org.oztt.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/OZ_TT_GB_CA")
public class OzTtGbCaController extends BaseController {

    @Resource
    private GoodsService goodsService;
    /**
     * 购物车一览初期画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init")
    public String init(Model model, HttpSession session) {
        try {
            return "/OZ_TT_GB_CA";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
