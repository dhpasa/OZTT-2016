package com.org.oztt.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.formDto.OzTtTpReDto;
import com.org.oztt.service.CustomerService;

@Controller
@RequestMapping("/OZ_TT_CS_PE")
public class OzTtCsPeController extends BaseController {

    @Resource
    private CustomerService customerService;

    /**
     * 个人信息初期画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init", method = RequestMethod.GET)
    public String init(Model model, HttpSession session) {
        try {
            String sessionUserId = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);

            TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(sessionUserId);

            OzTtTpReDto dto = new OzTtTpReDto();
            BeanUtils.copyProperties(baseInfo, dto);
            if (StringUtils.isNotEmpty(dto.getBirthday())) {
                dto.setBirthday(DateFormatUtils.dateFormatFromTo(dto.getBirthday(),
                        DateFormatUtils.PATTEN_YMD_NO_SEPRATE, DateFormatUtils.PATTEN_YMD2));
            }

            // 性别
            model.addAttribute("sexSelect", commonService.getSex());
            // 教育
            model.addAttribute("eduSelect", commonService.getEducation());
            // 婚否
            model.addAttribute("marSelect", commonService.getIsMarried());

            model.addAttribute("ozTtTpReDto", dto);
            return "/OZ_TT_CS_PE";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 用户完善个人信息
     * 
     * @param model
     * @param request
     * @param session
     * @param ozTtTpReDto
     * @return
     */
    @RequestMapping("updateSelf")
    public String updateSelf(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtTpReDto ozTtTpReDto) {
        try {
            String sessionUserId = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);

            TCustomerBasicInfo tCustomerBasicInfo = customerService.selectBaseInfoByCustomerNo(sessionUserId);
            tCustomerBasicInfo.setBirthday(DateFormatUtils.strToYYYYMMDDNoCa(ozTtTpReDto.getBirthday()));
            tCustomerBasicInfo.setCngivenname(ozTtTpReDto.getCngivenname());
            tCustomerBasicInfo.setCnsurname(ozTtTpReDto.getCnsurname());
            tCustomerBasicInfo.setEducation(ozTtTpReDto.getEducation());
            tCustomerBasicInfo.setHeadpic(ozTtTpReDto.getHeadpic());
            tCustomerBasicInfo.setIdcardno(ozTtTpReDto.getIdcardno());
            tCustomerBasicInfo.setMarriage(ozTtTpReDto.getMarriage());
            tCustomerBasicInfo.setOccupation(ozTtTpReDto.getOccupation());
            tCustomerBasicInfo.setPassportno(ozTtTpReDto.getPassportno());
            tCustomerBasicInfo.setSex(ozTtTpReDto.getSex());
            tCustomerBasicInfo.setUpdpgmid("OZ_TT_CS_PE");
            tCustomerBasicInfo.setUpdtimestamp(new Date());
            tCustomerBasicInfo.setUpduserkey(tCustomerBasicInfo.getCustomerno());
            customerService.updateTCustomerBasicInfo(tCustomerBasicInfo);

            // 性别
            model.addAttribute("sexSelect", commonService.getSex());
            // 教育
            model.addAttribute("eduSelect", commonService.getEducation());
            // 婚否
            model.addAttribute("marSelect", commonService.getIsMarried());
            model.addAttribute("ozTtTpReDto", ozTtTpReDto);
            return "/OZ_TT_CS_PE";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
