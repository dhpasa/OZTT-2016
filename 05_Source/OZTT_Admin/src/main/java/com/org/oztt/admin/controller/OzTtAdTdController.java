package com.org.oztt.admin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TTabIndex;
import com.org.oztt.entity.TTabInfo;
import com.org.oztt.formDto.OzTtAdGlListDto;
import com.org.oztt.formDto.OzTtAdTdDto;
import com.org.oztt.service.GoodsService;

/**
 * 标签详细
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_TD")
public class OzTtAdTdController extends BaseController {

    @Resource
    private GoodsService goodsService;

    /**
     * 标签明细
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/detail")
    public String init(Model model, HttpServletRequest request, HttpSession session, String tabNo) {
        try {
            OzTtAdTdDto info = new OzTtAdTdDto();
            List<OzTtAdGlListDto> goodsList = goodsService.getAllGoodsInfoForAdminNoPage();
            model.addAttribute("goodsList", goodsList);
            if (StringUtils.isEmpty(tabNo)) {
                // 新增

                model.addAttribute("isAdd", "1");
                model.addAttribute("itemDto", info);
            }
            else {
                TTabInfo tTabInfo = goodsService.getOneTab(Long.valueOf(tabNo));
                String goodStr = goodsService.getAllGoodsByTab(tabNo);
                info.setId(tTabInfo.getId());
                info.setTabname(tTabInfo.getTabname());
                info.setTabIndex(goodStr);
                info.setHiddentabIndex(goodStr);
                model.addAttribute("isAdd", "0");
                model.addAttribute("itemDto", info);
            }
            return "OZ_TT_AD_TD";
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
    @RequestMapping(value = "/save")
    public String init(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute OzTtAdTdDto itemDto) {
        try {
            TTabInfo tTabInfo = new TTabInfo();
            tTabInfo.setId(itemDto.getId());
            tTabInfo.setTabname(itemDto.getTabname());
            if (StringUtils.isEmpty(itemDto.getId())) {
                // 新增的情况
                goodsService.saveTab(tTabInfo);
            }
            else {
                // 更新的情况
                goodsService.updateTab(tTabInfo);
            }

            // 删除标签索引信息
            goodsService.deleteTabIndexByTab(String.valueOf(tTabInfo.getId()));

            // 新增所有信息
            String goods = itemDto.getTabIndex();
            if (goods != null && goods.length() > 0) {
                List<TTabIndex> insertTab = new ArrayList<TTabIndex>();
                String[] goodArr = goods.split(",");
                for (String goodsId : goodArr) {
                    TTabIndex info = new TTabIndex();
                    info.setTabid(tTabInfo.getId() == null ? goodsService.getMaxTabId().toString() : tTabInfo.getId()
                            .toString());
                    info.setGoodsid(goodsId);
                    insertTab.add(info);
                }
                goodsService.saveTabIndexByTab(insertTab);
            }
            return "redirect:/OZ_TT_AD_TL/search";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
