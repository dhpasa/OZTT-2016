package com.org.oztt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum.SearchModeFlag;
import com.org.oztt.entity.TGoodsClassfication;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/search")
public class SearchController extends BaseController {

    @Resource
    private GoodsService goodsService;

    /**
     * 检索商品的所有信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session, String mode, String searchcontent, String classId, String page, 
            String topPageUp, String hotFlg, String inStockFlg, String brand) {
        try {
            String imgUrl = super.getApplicationMessage("saveImgUrl", session);
            model.addAttribute("imgUrl", imgUrl);
            // 首先获取当前分类的子分类
            List<TGoodsClassfication> classficationList = new ArrayList<TGoodsClassfication>();
            if (StringUtils.isNotEmpty(classId)) {
                classficationList = goodsService.getChildrenClassfication(classId);
            }
            model.addAttribute("SubClassficationList", classficationList);
            
            if (StringUtils.isEmpty(page)) {
                page = "1";
            }
            Pagination pagination = new Pagination(Integer.valueOf(page), Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("goodsName", searchcontent);
            params.put("classId", classId);
            params.put("topPageUp", topPageUp);
            params.put("hotFlg", hotFlg);
            params.put("inStockFlg", inStockFlg);
            params.put("brand", brand);
            
            pagination.setParams(params);
            PagingResult<GroupItemDto> pageInfo = goodsService.getGoodsByParamForPage(pagination, session);

            if (!CollectionUtils.isEmpty(pageInfo.getResultList())) {
                for (GroupItemDto goods : pageInfo.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }
            model.addAttribute("classId", classId);
            
            model.addAttribute("topPageUp", topPageUp);
            model.addAttribute("hotFlg", hotFlg);
            model.addAttribute("inStockFlg", inStockFlg);
            
            if (brand != null || searchcontent != null) {
                model.addAttribute("showFlg", 1);
            }
            
            if ("1".equals(topPageUp)){
                // 本期团购
                searchcontent = CommonConstants.VIEW_TOPPAGEUP;
            }
            if ("1".equals(hotFlg)){
                // 热卖
                searchcontent = CommonConstants.VIEW_HOTFLG;
            }
            if ("1".equals(inStockFlg)){
                // 特价产品
                searchcontent = CommonConstants.VIEW_INSTOCKFLG;
            }
            if (StringUtils.isNotEmpty(brand)) {
                // 品牌
                searchcontent = brand;
            }
            
            model.addAttribute("viewcontent", searchcontent);
            if (StringUtils.isNotEmpty(classId)) {
                model.addAttribute("viewcontent", goodsService.getGoodsClassficationByClassId(classId).getClassname()); 
            }
            model.addAttribute("goodsList", pageInfo);
            
            return "search";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 检索商品的所有信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/next")
    public Map<String, Object> next(Model model, HttpServletRequest request, HttpSession session, String mode,
            String pageNo, String searchcontent, String classId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            Pagination pagination = new Pagination(Integer.parseInt(pageNo),
                    Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
            Map<Object, Object> params = new HashMap<Object, Object>();
            if (SearchModeFlag.NEWGOODS.getCode().equals(mode)) {
                // 新品
                params.put("newSaleFlg", CommonConstants.IS_NEW_SALE);
            } else if (SearchModeFlag.CLASS.getCode().equals(mode)) {
                // 新品
                params.put("classId", classId);
            }
            params.put("mode", mode);
            params.put("goodsName", searchcontent);
            pagination.setParams(params);
            PagingResult<GroupItemDto> pageInfo = goodsService.getGoodsByParamForPage(pagination, session);

            if (!CollectionUtils.isEmpty(pageInfo.getResultList())) {
                for (GroupItemDto goods : pageInfo.getResultList()) {
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
            mapReturn.put("isException", false);
            mapReturn.put("goodsList",
                    (pageInfo == null || pageInfo.getResultList() == null) ? null : pageInfo.getResultList());
            return mapReturn;
        }
        catch (Exception e) {
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }
}
