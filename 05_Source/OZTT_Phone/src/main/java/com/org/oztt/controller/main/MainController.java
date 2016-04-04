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

            // 获取新货
            List<GroupItemDto> newGoodsList = goodsService.getAllNewArravail();

            if (!CollectionUtils.isEmpty(newGoodsList)) {
                for (GroupItemDto goods : newGoodsList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }
            
            // 获取热卖的商品
            TGoods tGoodsParam = new TGoods();
            tGoodsParam.setDeleteflg(CommonConstants.IS_NOT_DELETE);
            tGoodsParam.setOnsaleflg(CommonConstants.IS_ON_SALE);
            tGoodsParam.setHotsaleflg(CommonConstants.IS_HOT_SALE);
            List<GroupItemDto> hotGoodsList = goodsService.getHotSeller(tGoodsParam);
            
            if (!CollectionUtils.isEmpty(hotGoodsList)) {
                for (GroupItemDto goods : hotGoodsList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }

            // 获取明细分类的数据
            Map<String, String> mapParam = new HashMap<String, String>();
            mapParam.put(CommonConstants.LIMIT_PARAM, CommonConstants.MAIN_LIST_COUNT);
            List<GroupItemDto> tgoodList = goodsService.getGoodsListForMain(mapParam);
            if (!CollectionUtils.isEmpty(tgoodList)) {
                for (GroupItemDto goods : tgoodList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }
            model.addAttribute("hotGoodsList", hotGoodsList);
            model.addAttribute("menucategory", myCategroyList);
            model.addAttribute("newGoodsList", newGoodsList);
            model.addAttribute("tgoodList", tgoodList);

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
