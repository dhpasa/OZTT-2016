package com.org.oztt.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
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
@RequestMapping("/purchase")
public class PurchaseController extends BaseController {

    @Resource
    private GoodsService goodsService;

    /**
     * 购买确认画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session) {
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            String imgUrl = super.getApplicationMessage("saveImgUrl");
            // 取得购物车里面选购的内容
            List<ContCartItemDto> consCarts = goodsService.getAllContCartForBuy(customerNo);
            Date maxdate = null;
            for (ContCartItemDto dto : consCarts) {
                if (StringUtils.isEmpty(dto.getGoodsPropertiesDB())) {
                    dto.setGoodsProperties(new ArrayList<ContCartProItemDto>());
                }
                else {
                    dto.setGoodsProperties(JSONObject.parseArray(dto.getGoodsPropertiesDB(), ContCartProItemDto.class));
                }
                dto.setGoodsPropertiesDB(StringUtils.EMPTY);
                dto.setGoodsImage(imgUrl + dto.getGoodsId() + CommonConstants.PATH_SPLIT + dto.getGoodsImage());
                dto.setDeliveryDate(DateFormatUtils.date2StringWithFormat(dto.getValidPeriodEnd(),
                        DateFormatUtils.PATTEN_YMD2));
                dto.setGoodsUnitPrice(String.valueOf(new BigDecimal(dto.getGoodsPrice()).divide(
                        new BigDecimal(dto.getGoodsQuantity()), 2, BigDecimal.ROUND_DOWN)));
                if (maxdate == null) {
                    maxdate = dto.getValidPeriodEnd();
                }
                else {
                    if (maxdate.compareTo(dto.getValidPeriodEnd()) < 0) {
                        maxdate = dto.getValidPeriodEnd();
                    }
                }

            }
            // 默认所有送货的最后一天的后一天

            model.addAttribute("deliveryDate", DateFormatUtils.date2StringWithFormat(
                    DateFormatUtils.addDate(maxdate == null ? new Date() : maxdate, Calendar.DATE, 1),
                    DateFormatUtils.PATTEN_YMD2));
            model.addAttribute("deliverySelect", commonService.getDeliveryTime());
            model.addAttribute("cartsList", consCarts);
            return "/purchase";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
