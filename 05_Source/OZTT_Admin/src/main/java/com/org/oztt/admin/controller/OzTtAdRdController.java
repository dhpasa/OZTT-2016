package com.org.oztt.admin.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TGoodsClassfication;
import com.org.oztt.formDto.OzTtAdRlListDto;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.GoodsService;

/**
 * 注册用户明细
 * 
 * @author R
 */
@Controller
@RequestMapping("/OZ_TT_AD_RD")
public class OzTtAdRdController extends BaseController {

    @Resource
    private CustomerService customerService;

    /**
     * 注册用户明细
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/detail")
    public String init(Model model, HttpServletRequest request, HttpSession session, String customerNo) {
        try {
        	OzTtAdRlListDto dto = new OzTtAdRlListDto();
        	dto = customerService.getCustomerInfoForAdmin(customerNo);
            model.addAttribute("ozTtAdRlListDto", dto);
            
            return "OZ_TT_AD_RD";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 注册用户信息保存方法
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/save")
    public String init(Model model, HttpServletRequest request, HttpSession session, @ModelAttribute OzTtAdRlListDto itemDto) {
        try {
            //TGoodsClassfication tGoodsClassfication = new TGoodsClassfication();
                // 更新的情况
            //    tGoodsClassfication.setNo(Long.valueOf(itemDto.getNo()));
            //    tGoodsClassfication.setUpdtimestamp(new Date());
            //    tGoodsClassfication.setUpdpgmid("OZ_TT_AD_CD");
            //    tGoodsClassfication.setUpduserkey(CommonConstants.ADMIN_USERKEY);
            //    goodsService.updateClassFication(tGoodsClassfication);
           // }
            return "redirect:/OZ_TT_AD_RL/init";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
