package com.org.oztt.admin.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.formDto.OzTtAdRlListDto;
import com.org.oztt.service.CustomerService;

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
            TCustomerBasicInfo tCustomerBasicInfo = new TCustomerBasicInfo();
            tCustomerBasicInfo = customerService.selectBaseInfoByCustomerNo(itemDto.getCustomerNo());
            tCustomerBasicInfo.setComments(itemDto.getComments());
            tCustomerBasicInfo.setUpdtimestamp(new Date());
            tCustomerBasicInfo.setUpdpgmid("OZ_TT_AD_RD");
            tCustomerBasicInfo.setUpduserkey(CommonConstants.ADMIN_USERKEY);
            customerService.updateTCustomerBasicInfo(tCustomerBasicInfo);
            return "redirect:/OZ_TT_AD_RL/search";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
}
