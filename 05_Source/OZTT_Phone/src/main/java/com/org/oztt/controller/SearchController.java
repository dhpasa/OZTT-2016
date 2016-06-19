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

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum.SearchModeFlag;
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
    public String init(Model model, HttpServletRequest request, HttpSession session, String mode, String searchcontent, String classId) {
        try {

            Pagination pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("mode", mode);
            params.put("goodsName", searchcontent);
            params.put("classId", classId);
            pagination.setParams(params);
            PagingResult<GroupItemDto> pageInfo = goodsService.getGoodsByParamForPage(pagination);

            if (!CollectionUtils.isEmpty(pageInfo.getResultList())) {
                for (GroupItemDto goods : pageInfo.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                    goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                            .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
                }
            }
            model.addAttribute("classId", classId);
            model.addAttribute("mode", mode);
            model.addAttribute("searchcontent", searchcontent);
            if (SearchModeFlag.CLASS.getCode().equals(mode)) {
                model.addAttribute("searchcontent", goodsService.getGoodsClassficationByClassId(classId).getClassname());
                
            }
            model.addAttribute("goodsList",
                    (pageInfo == null || pageInfo.getResultList() == null) ? null : pageInfo.getResultList());
            return "search";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
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
            PagingResult<GroupItemDto> pageInfo = goodsService.getGoodsByParamForPage(pagination);

            if (!CollectionUtils.isEmpty(pageInfo.getResultList())) {
                for (GroupItemDto goods : pageInfo.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                    goods.setIsOverGroup(Integer.valueOf(goods.getGroupCurrent()) >= Integer.valueOf(goods
                            .getGroupMax()) ? CommonConstants.OVER_GROUP_YES : CommonConstants.OVER_GROUP_NO);
                }
            }
            mapReturn.put("isException", false);
            mapReturn.put("goodsList",
                    (pageInfo == null || pageInfo.getResultList() == null) ? null : pageInfo.getResultList());
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }
}
