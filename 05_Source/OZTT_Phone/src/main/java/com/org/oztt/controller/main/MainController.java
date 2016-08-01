package com.org.oztt.controller.main;

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

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.controller.BaseController;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/main")
public class MainController extends BaseController {

    @Resource
    private GoodsService goodsService;

    /**
     * 首页显示
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init", method = RequestMethod.GET)
    public String gotoMain(Model model, HttpSession session) {
        try {
            // 获取目录
            //List<MyCategroy> myCategroyList = super.commonService.getMyCategroy();
            //List<String> tabList = goodsService.getMainSearchTab();
            String imgUrl = super.getApplicationMessage("saveImgUrl", session);
            model.addAttribute("imgUrl", imgUrl);
            // 获取秒杀的商品
            Pagination pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_TOPPAGE_LIST));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("topPageUp", "1");
            pagination.setParams(params);
            PagingResult<GroupItemDto> topPageGoodsList = goodsService.getGoodsByParamForPage(pagination);

            if (!CollectionUtils.isEmpty(topPageGoodsList.getResultList())) {
                for (GroupItemDto goods : topPageGoodsList.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                    goods.setCountdownDay(DateFormatUtils.getBetweenDayTime(goods.getValidEndTime()));
                    goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                            .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
                }
            }
            model.addAttribute(
                    "topPageSellList",
                    (topPageGoodsList == null || topPageGoodsList.getResultList() == null) ? null : topPageGoodsList
                            .getResultList());

            // 预售
            pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_GOODS_LIST));
            params = new HashMap<Object, Object>();
            params.put("preFlg", "1");
            pagination.setParams(params);
            PagingResult<GroupItemDto> pageInfoPre = goodsService.getGoodsByParamForPage(pagination);
            if (!CollectionUtils.isEmpty(pageInfoPre.getResultList())) {
                for (GroupItemDto goods : pageInfoPre.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                    goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                            .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
                    // 判断团购开始是否已经到
                    if (goods.getValidStartTime().compareTo(DateFormatUtils.getCurrentDate()) > 0) {
                        goods.setIsOnWay(CommonConstants.IS_ON_WAY);
                    }
                }
            }
            model.addAttribute("preSellList", (pageInfoPre == null || pageInfoPre.getResultList() == null) ? null
                    : pageInfoPre.getResultList());

            // 现货
            pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_GOODS_LIST));
            params = new HashMap<Object, Object>();
            params.put("inStockFlg", "1");
            pagination.setParams(params);
            PagingResult<GroupItemDto> pageInfoNow = goodsService.getGoodsByParamForPage(pagination);
            if (!CollectionUtils.isEmpty(pageInfoNow.getResultList())) {
                for (GroupItemDto goods : pageInfoNow.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                    goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                            .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
                    // 判断团购开始是否已经到
                    if (goods.getValidStartTime().compareTo(DateFormatUtils.getCurrentDate()) > 0) {
                        goods.setIsOnWay(CommonConstants.IS_ON_WAY);
                    }
                }
            }
            model.addAttribute("nowSellList", (pageInfoNow == null || pageInfoNow.getResultList() == null) ? null
                    : pageInfoNow.getResultList());

            // 获取session中的值
            model.addAttribute(CommonConstants.SESSION_CUSTOMERNO,
                    session.getAttribute(CommonConstants.SESSION_CUSTOMERNO));
            model.addAttribute(CommonConstants.SESSION_CUSTOMERNAME,
                    session.getAttribute(CommonConstants.SESSION_CUSTOMERNAME));

            return "/main/main";
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
    @RequestMapping(value = "grouptab", method = RequestMethod.GET)
    public String grouptab(Model model, HttpSession session, String tab) throws Exception {

        Pagination pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
        Map<Object, Object> params = new HashMap<Object, Object>();
        if ("1".equals(tab)) {
            //秒杀
            params.put("topPageUp", "1");
        }
        else if ("2".equals(tab)) {
            params.put("preFlg", "1");
            //预售
        }
        else if ("3".equals(tab)) {
            //现货
            params.put("inStockFlg", "1");
        }

        pagination.setParams(params);
        PagingResult<GroupItemDto> goodsList = goodsService.getGoodsByParamForPage(pagination);

        if (!CollectionUtils.isEmpty(goodsList.getResultList())) {
            for (GroupItemDto goods : goodsList.getResultList()) {
                goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                        + goods.getGoodsthumbnail());
                goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                goods.setCountdownDay(DateFormatUtils.getBetweenDayTime(goods.getValidEndTime()));
                goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                        .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
                // 判断团购开始是否已经到
                if (goods.getValidStartTime().compareTo(DateFormatUtils.getCurrentDate()) > 0) {
                    goods.setIsOnWay(CommonConstants.IS_ON_WAY);
                }
            }
        }
        model.addAttribute("tab", tab);
        model.addAttribute("goodsList",
                (goodsList == null || goodsList.getResultList() == null) ? null : goodsList.getResultList());

        return "/grouparea";
    }

    /**
     * 检索商品的所有信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/grouptabnext")
    public Map<String, Object> grouptabnext(Model model, HttpServletRequest request, HttpSession session,
            String pageNo, String tab) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            Pagination pagination = new Pagination(Integer.parseInt(pageNo),
                    Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
            Map<Object, Object> params = new HashMap<Object, Object>();
            if ("1".equals(tab)) {
                //秒杀
                params.put("topPageUp", "1");
            }
            else if ("2".equals(tab)) {
                params.put("preFlg", "1");
                //预售
            }
            else if ("3".equals(tab)) {
                //现货
                params.put("inStockFlg", "1");
            }

            pagination.setParams(params);
            PagingResult<GroupItemDto> goodsList = goodsService.getGoodsByParamForPage(pagination);

            if (!CollectionUtils.isEmpty(goodsList.getResultList())) {
                for (GroupItemDto goods : goodsList.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                    goods.setCountdownDay(DateFormatUtils.getBetweenDayTime(goods.getValidEndTime()));
                    goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                            .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
                    // 判断团购开始是否已经到
                    if (goods.getValidStartTime().compareTo(DateFormatUtils.getCurrentDate()) > 0) {
                        goods.setIsOnWay(CommonConstants.IS_ON_WAY);
                    }
                }
            }
            model.addAttribute("goodsList",
                    (goodsList == null || goodsList.getResultList() == null) ? null : goodsList.getResultList());
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
