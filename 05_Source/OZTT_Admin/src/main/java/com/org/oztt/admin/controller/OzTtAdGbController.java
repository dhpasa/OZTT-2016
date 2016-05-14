package com.org.oztt.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.OzTtAdGlListDto;
import com.org.oztt.service.GoodsService;

/**
 * 
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_GB")
public class OzTtAdGbController extends BaseController {

    @Resource
    private GoodsService goodsService;
    /**
     * 批量团购
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session) {
        try {
            List<OzTtAdGlListDto> dtoList = goodsService.getAllGoodsInfoForAdminNoPage();
            model.addAttribute("goodsList", dtoList);
            return "OZ_TT_AD_GB";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }


}
