package com.org.oztt.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.org.oztt.base.common.MyCategroy;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TGoods;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/OZ_TT_TP_PD")
public class OzTtTpPdController extends BaseController {

    @Resource
    private CustomerService customerService;

    @Resource
    private GoodsService    goodsService;

    /**
     * 商品详情画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init", method = RequestMethod.GET)
    public String init(Model model, @RequestParam String groupId) {
        try {
            // 获取目录
            List<MyCategroy> myCategroyList = super.commonService.getMyCategroy();
            model.addAttribute("menucategory", myCategroyList);

            String imgUrl = super.getApplicationMessage("saveImgUrl");

            // 取得热卖的产品
            TGoods tGoodsParam = new TGoods();
            tGoodsParam.setDeleteflg(CommonConstants.IS_NOT_DELETE);
            tGoodsParam.setOnsaleflg(CommonConstants.IS_ON_SALE);
            tGoodsParam.setHotsaleflg(CommonConstants.IS_HOT_SALE);
            List<GroupItemDto> hotSellerList = goodsService.getFiveHotSeller(tGoodsParam);
            if (!CollectionUtils.isEmpty(hotSellerList)) {
                for (GroupItemDto goods : hotSellerList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + goods.getGoodsthumbnail());
                }
            }

            GoodItemDto goodItemDto = goodsService.getGoodAllItemDto(groupId);

            // 后台维护的时候提示让以逗号隔开
            model.addAttribute("goodItemDto", goodItemDto);
            model.addAttribute("hotSellerList", hotSellerList);

            return "/OZ_TT_TP_PD";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
