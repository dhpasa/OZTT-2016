package com.org.oztt.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.ContCartProItemDto;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/OZ_TT_GB_SH")
public class OzTtGbShController extends BaseController {

    @Resource
    private GoodsService goodsService;
    
    /**
     * 运送方式选择画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init")
    public String init(Model model, HttpSession session) {
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            String imgUrl = super.getApplicationMessage("saveImgUrl");
            // 取得购物车里面选购的内容
            List<ContCartItemDto> consCarts = goodsService.getAllContCartForBuy(customerNo);
            
            

            if (!CollectionUtils.isEmpty(consCarts)) {
                for (ContCartItemDto dto : consCarts) {
                    if (StringUtils.isEmpty(dto.getGoodsPropertiesDB())) {
                        dto.setGoodsProperties(new ArrayList<ContCartProItemDto>());
                    } else {
                        dto.setGoodsProperties(JSONObject.parseArray(dto.getGoodsPropertiesDB(), ContCartProItemDto.class));
                    }
                    dto.setGoodsPropertiesDB(StringUtils.EMPTY);
                    dto.setGoodsImage(imgUrl + dto.getGoodsId() + CommonConstants.PATH_SPLIT + dto.getGoodsImage());
                }
            }
            model.addAttribute("suburbSelect", commonService.getSuburbList());
            model.addAttribute("conscars", JSONObject.toJSONString(consCarts));
            model.addAttribute("deliverySelect", commonService.getDeliveryTime());
            //明天
            model.addAttribute("tomorrow", DateFormatUtils.getTomorrow(DateFormatUtils.PATTEN_YMD2));
            return "/OZ_TT_GB_SH";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
