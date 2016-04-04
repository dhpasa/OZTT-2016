package com.org.oztt.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/item")
public class ItemController extends BaseController {
    
    @Resource
    private GoodsService goodsService;

    /**
     * 得到团购产品信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getGoodsItem")
    public String getCurrentItem(Model model, HttpServletRequest request, HttpSession session,
            @RequestParam String groupId) {
        try {

            GoodItemDto goodItemDto = goodsService.getGoodAllItemDto(groupId);

            // 后台维护的时候提示让以逗号隔开
            model.addAttribute("goodItemDto", goodItemDto);
            return "item";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
