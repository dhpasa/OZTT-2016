package com.org.oztt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.formDto.GroupItemDto;
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
            // 这里判断是否已经满团
            if (Integer.valueOf(goodItemDto.getGroupCurrent()) >= Integer.valueOf(goodItemDto.getGroupMax())) {
                model.addAttribute("IS_OVER", "1");
            }
            return "item";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 显示商品更多的信息
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "goodstab", method = RequestMethod.GET)
    public String grouptab(Model model, HttpSession session, String tabId) throws Exception {

        Pagination pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
        Map<Object, Object> params = new HashMap<Object, Object>();
        params.put("tabId", tabId);
        pagination.setParams(params);
        PagingResult<GroupItemDto> goodsList = goodsService.getGoodsTabByParamForPage(pagination);

        if (!CollectionUtils.isEmpty(goodsList.getResultList())) {
            for (GroupItemDto goods : goodsList.getResultList()) {
                goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                        + goods.getGoodsthumbnail());
                goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                goods.setCountdownDay(DateFormatUtils.getBetweenDayTime(goods.getValidEndTime()));
                goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                        .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
            }
        }
        model.addAttribute("tabName", goodsService.getTabName(tabId));
        model.addAttribute("tabId", tabId);
        model.addAttribute("goodsList", (goodsList == null || goodsList.getResultList() == null) ? null
                : goodsList.getResultList());
        return "/grouptabarea";
    }
    
    /**
     * 检索商品的所有信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/goodstabnext")
    public Map<String, Object> grouptabnext(Model model, HttpServletRequest request, HttpSession session,
            String pageNo, String tabId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            Pagination pagination = new Pagination(Integer.parseInt(pageNo),
                    Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("tabId", tabId);
            pagination.setParams(params);
            PagingResult<GroupItemDto> goodsList = goodsService.getGoodsTabByParamForPage(pagination);

            if (!CollectionUtils.isEmpty(goodsList.getResultList())) {
                for (GroupItemDto goods : goodsList.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                    goods.setCountdownDay(DateFormatUtils.getBetweenDayTime(goods.getValidEndTime()));
                    goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                            .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
                }
            }
            model.addAttribute("goodsList", (goodsList == null || goodsList.getResultList() == null) ? null
                    : goodsList.getResultList());
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }
}
