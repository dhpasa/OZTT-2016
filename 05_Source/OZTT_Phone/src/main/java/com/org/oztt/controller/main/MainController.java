package com.org.oztt.controller.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.org.oztt.base.common.MyCategroy;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.controller.BaseController;
import com.org.oztt.entity.TGoods;
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
            List<MyCategroy> myCategroyList = super.commonService.getMyCategroy();

            String imgUrl = super.getApplicationMessage("saveImgUrl");

            List<String> tabList = goodsService.getMainSearchTab();

            // 获取新货
            List<GroupItemDto> newGoodsList = goodsService.getAllNewArravail();

            if (!CollectionUtils.isEmpty(newGoodsList)) {
                for (GroupItemDto goods : newGoodsList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                    goods.setCountdownDay(DateFormatUtils.getBetweenDayTime(goods.getValidEndTime()));
                }
            }

            // 获取热卖的商品
            List<GroupItemDto> topPageGoodsList = goodsService.getTopPage();

            if (!CollectionUtils.isEmpty(topPageGoodsList)) {
                for (GroupItemDto goods : topPageGoodsList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }

            // 获取商品的数据

            Pagination pagination = new Pagination(1, Integer.parseInt(CommonConstants.MAIN_LIST_COUNT));
            Map<Object, Object> params = new HashMap<Object, Object>();
            pagination.setParams(params);
            PagingResult<GroupItemDto> pageInfo = goodsService.getGoodsByParamForPage(pagination);

            if (!CollectionUtils.isEmpty(pageInfo.getResultList())) {
                for (GroupItemDto goods : pageInfo.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                    goods.setCountdownTime(DateFormatUtils.getBetweenSecondTime(goods.getValidEndTime()));
                }
            }
            model.addAttribute("hotGoodsList", topPageGoodsList);
            model.addAttribute("menucategory", myCategroyList);
            model.addAttribute("newGoodsList", newGoodsList);
            model.addAttribute("tgoodList",
                    (pageInfo == null || pageInfo.getResultList() == null) ? null : pageInfo.getResultList());
            model.addAttribute("tabList", tabList);

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
}
