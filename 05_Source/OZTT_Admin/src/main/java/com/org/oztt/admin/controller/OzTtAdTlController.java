package com.org.oztt.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TTabInfo;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.GoodsService;

/**
 * 标签一览
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_TL")
public class OzTtAdTlController extends BaseController {

    @Resource
    private GoodsService goodsService;
    
    @Resource
    private CommonService commonService;
    
    
    /**
     * 标签一览
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/search")
    public String init(Model model, HttpServletRequest request, HttpSession session) {
        try {
            List<TTabInfo> tabList = goodsService.getAllTabs();
            model.addAttribute("tabList", tabList);
            return "OZ_TT_AD_TL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 分类信息保存方法
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/delete")
    public String delete(Model model, HttpServletRequest request, HttpSession session, String tabNo) {
        try {
            TTabInfo info = new TTabInfo();
            info.setId(Long.valueOf(tabNo));
            goodsService.deleteTab(info);

            // 删除标签索引信息
            goodsService.deleteTabIndexByTab(String.valueOf(tabNo));

           
            return "redirect:/OZ_TT_AD_TL/search";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }


}
