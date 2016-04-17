package com.org.oztt.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.ContCartItemListDto;
import com.org.oztt.formDto.ContCartProItemDto;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/shopcart")
public class ShopCartController extends BaseController {

    @Resource
    private GoodsService goodsService;

    /**
     * 购物车信息一览
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpSession session) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            // 登陆成功以后取得购物车中的数据然后更新Cookie
            List<ContCartItemDto> consCarts = goodsService.getAllContCartForCookie(customerNo);

            List<ContCartItemListDto> cartsList = new ArrayList<ContCartItemListDto>();
            if (!CollectionUtils.isEmpty(consCarts)) {
                for (ContCartItemDto dto : consCarts) {
                    if (StringUtils.isEmpty(dto.getGoodsPropertiesDB())) {
                        dto.setGoodsProperties(new ArrayList<ContCartProItemDto>());
                    }
                    else {
                        dto.setGoodsProperties(JSONObject.parseArray(dto.getGoodsPropertiesDB(),
                                ContCartProItemDto.class));
                    }
                    dto.setGoodsPropertiesDB(StringUtils.EMPTY);
                    dto.setGoodsImage(imgUrl + dto.getGoodsId() + CommonConstants.PATH_SPLIT + dto.getGoodsImage());
                    dto.setGoodsUnitPrice(String.valueOf(new BigDecimal(dto.getGoodsPrice()).divide(
                            new BigDecimal(dto.getGoodsQuantity()), 2, BigDecimal.ROUND_DOWN)));
                }

                // 取得购物车天数数据
                String[] prostr = getShopCartPro();

                ContCartItemListDto contCartItemListDto = new ContCartItemListDto();
                List<ContCartItemDto> timeDto = new ArrayList<ContCartItemDto>();
                int q = 0;
                for (int i = 0; i < prostr.length; i++) {
                    contCartItemListDto = new ContCartItemListDto();
                    timeDto = new ArrayList<ContCartItemDto>();
                    for (ContCartItemDto dto : consCarts) {
                        if (i == 0) {
                            if (Integer.valueOf(prostr[i]) >= Integer.valueOf(dto.getCanbuyDay())) {
                                timeDto.add(dto);
                                q++;
                            }
                        }
                        else {
                            if (Integer.valueOf(prostr[i - 1]) < Integer.valueOf(dto.getCanbuyDay())
                                    && Integer.valueOf(prostr[i]) >= Integer.valueOf(dto.getCanbuyDay())) {
                                timeDto.add(dto);
                                q++;
                            }
                        }

                    }
                    if (timeDto.size() > 0) {
                        contCartItemListDto.setQueryDay(prostr[i]);
                        contCartItemListDto.setItemList(timeDto);
                        cartsList.add(contCartItemListDto);
                    }

                }
                // 将剩余的购物的放入list中
                contCartItemListDto = new ContCartItemListDto();
                timeDto = new ArrayList<ContCartItemDto>();
                for (int i = 0; i < consCarts.size(); i++) {
                    if (i >= q) {
                        timeDto.add(consCarts.get(i));
                    }
                }

                if (timeDto.size() > 0) {
                    contCartItemListDto.setQueryDay(super.getApplicationMessage("shopcart_other_time"));
                    contCartItemListDto.setItemList(timeDto);
                    cartsList.add(contCartItemListDto);
                }

                model.addAttribute("count", consCarts.size());
            }

            model.addAttribute("cartsList", cartsList);
            return "shopcart";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
