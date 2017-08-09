package com.org.oztt.controller.main;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.common.MyCategroy;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.controller.BaseController;
import com.org.oztt.entity.TSysConfig;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.formDto.MainCategoryDto;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.GoodsService;
import com.org.oztt.service.SysConfigService;

@Controller
@RequestMapping("/main")
public class MainController extends BaseController {

    @Resource
    private GoodsService     goodsService;

    @Resource
    private CustomerService  customerService;

    @Resource
    private SysConfigService sysConfigService;

    /**
     * 首页显示
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init", method = RequestMethod.GET)
    public String gotoMain(Model model, HttpSession session) {
        try {
            String imgUrl = super.getApplicationMessage("saveImgUrl", session);
            model.addAttribute("imgUrl", imgUrl);


            TSysConfig tSysConfig = sysConfigService.getTSysConfig();
            String pageAllPic = tSysConfig.getToppageadpic();
            if (!StringUtils.isEmpty(pageAllPic)) {
                model.addAttribute("advPicList", Arrays.asList(pageAllPic.split(",")));
            }
            
            List<MyCategroy> categoryList = commonService.getMainCategory();
            
            // 将所有的分区整合成一个数据集
            List<MainCategoryDto> groupItemPageList = new ArrayList<MainCategoryDto>();
            
            for (MyCategroy category : categoryList) {
                Pagination pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_GOODS_LIST));
                HashMap<Object, Object> params = new HashMap<Object, Object>();
                params.put("categoryList", super.commonService.getSubCategory(category.getFatherClass().getClassid()));
                pagination.setParams(params);
                PagingResult<GroupItemDto> goodsCategoryList = goodsService.getGoodsByParamForPageFor3(pagination);
                if (!CollectionUtils.isEmpty(goodsCategoryList.getResultList())) {
                    for (GroupItemDto goods : goodsCategoryList.getResultList()) {
                        goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                                + goods.getGoodsthumbnail());
                    }
                }
                MainCategoryDto mainCategoryDto = new MainCategoryDto();
                mainCategoryDto.setMyCategroy(category);
                mainCategoryDto.setGroupItemDtoList(goodsCategoryList.getResultList());
                groupItemPageList.add(mainCategoryDto);
            }
            
            model.addAttribute("mainCategoryList", groupItemPageList);
            
            //本期团购topPageUp
            Pagination pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_GOODS_LIST));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("topPageUp", "1");
            pagination.setParams(params);
            PagingResult<GroupItemDto> topPageGoodsList = goodsService.getGoodsByParamForPage(pagination, session);

            if (!CollectionUtils.isEmpty(topPageGoodsList.getResultList())) {
                for (GroupItemDto goods : topPageGoodsList.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }
            model.addAttribute(
                    "topPageSellList",
                    (topPageGoodsList == null || topPageGoodsList.getResultList() == null) ? null : topPageGoodsList
                            .getResultList());
            
            //新品推荐hotFlg 
            pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_GOODS_LIST));
            params = new HashMap<Object, Object>();
            params.put("hotFlg", "1");
            pagination.setParams(params);
            PagingResult<GroupItemDto> hotFlgGoodsList = goodsService.getGoodsByParamForPage(pagination, session);

            if (!CollectionUtils.isEmpty(hotFlgGoodsList.getResultList())) {
                for (GroupItemDto goods : hotFlgGoodsList.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }
            model.addAttribute(
                    "hotFlgSellList",
                    (hotFlgGoodsList == null || hotFlgGoodsList.getResultList() == null) ? null : hotFlgGoodsList
                            .getResultList());
            
            // 品牌专区
            model.addAttribute("brandList", CommonConstants.BRAND_INFO);

            // 获取session中的值
            model.addAttribute(CommonConstants.SESSION_CUSTOMERNO,
                    session.getAttribute(CommonConstants.SESSION_CUSTOMERNO));
            model.addAttribute(CommonConstants.SESSION_CUSTOMERNAME,
                    session.getAttribute(CommonConstants.SESSION_CUSTOMERNAME));

            return "/main/main";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    
    /**
     * 得到团购产品信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/searchJson")
    @ResponseBody
    public Map<String, Object> searchJson(HttpServletRequest request, HttpSession session, String searchcontent) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {

            Pagination pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("goodsName", searchcontent);
            
            pagination.setParams(params);
            PagingResult<GroupItemDto> pageInfo = goodsService.getGoodsByParamForPage(pagination, session);

            if (!CollectionUtils.isEmpty(pageInfo.getResultList())) {
                for (GroupItemDto goods : pageInfo.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("itemInfo", (pageInfo == null || pageInfo.getResultList() == null) ? null : pageInfo
                    .getResultList());
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
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
        else if ("4".equals(tab)) {
            //钻石分区
            params.put("diamondShowFlg", "1");
        }

        pagination.setParams(params);
        PagingResult<GroupItemDto> goodsList = goodsService.getGoodsByParamForPage(pagination, session);

        if (!CollectionUtils.isEmpty(goodsList.getResultList())) {
            for (GroupItemDto goods : goodsList.getResultList()) {
                goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                        + goods.getGoodsthumbnail());
                goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                goods.setCountdownDay(DateFormatUtils.getBetweenDayTime(goods.getValidEndTime()));
                goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods.getGroupMax()) ? CommonConstants.OVER_GROUP_YES
                        : CommonConstants.OVER_GROUP_NO);
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
            else if ("4".equals(tab)) {
                //钻石分区
                params.put("diamondShowFlg", "1");
            }

            pagination.setParams(params);
            PagingResult<GroupItemDto> goodsList = goodsService.getGoodsByParamForPage(pagination, session);

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
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }
    
    /**
     * 检索商品的所有信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "toPcInfoJsp", method = RequestMethod.GET)
    public String toPcInfoJsp(Model model, HttpServletRequest request, HttpSession session) {
        return "pc_info";
    }
}
