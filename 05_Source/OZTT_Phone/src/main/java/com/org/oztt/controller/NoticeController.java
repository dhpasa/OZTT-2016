package com.org.oztt.controller;

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
import com.org.oztt.formDto.ContCartProItemDto;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/Notice")
public class NoticeController extends BaseController {

    @Resource
    private GoodsService goodsService;
    /**
     * 货到付款通知画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "codNotice")
    public String codNotice(Model model, HttpServletResponse response, HttpSession session) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            
            String imgUrl = super.getApplicationMessage("saveImgUrl");
            
            List<ContCartItemDto> consCarts = goodsService.getAllContCartForCookie(customerNo);
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

            model.addAttribute("conscars", JSONObject.toJSONString(consCarts));
            return "/notice/CODNotice";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
