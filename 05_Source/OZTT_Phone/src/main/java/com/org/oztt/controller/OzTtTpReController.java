package com.org.oztt.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.org.oztt.base.common.MailUtil;
import com.org.oztt.base.common.SendMailDto;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.base.util.UrlParamDecode;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerLoginInfo;
import com.org.oztt.formDto.OzTtTpReDto;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.CustomerService;

@Controller
@RequestMapping("/OZ_TT_TP_RE")
public class OzTtTpReController extends BaseController {

    @Resource
    private CustomerService customerService;

    @Resource
    private CommonService   commonService;

    /**
     * 注册页
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init", method = RequestMethod.GET)
    public String init(Model model) {
        model.addAttribute("ozTtTpReDto", new OzTtTpReDto());
        return "/OZ_TT_TP_RE";
    }

    /**
     * 用户的注册
     * 
     * @param model
     * @param request
     * @param session
     * @param ozTtTpReDto
     * @return
     */
    @RequestMapping("register")
    public String register(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtTpReDto ozTtTpReDto) {
        try {
            // 判断输入的手机验证码是否正确
            boolean isYes = commonService.checkPhoneVerifyCode(ozTtTpReDto.getPhone(), ozTtTpReDto.getVerifyCode());
            if (!isYes) {
                model.addAttribute("phoneVerify", "false");
                model.addAttribute("ozTtTpReDto", ozTtTpReDto);
                return "/OZ_TT_TP_RE";
            }
            
            ozTtTpReDto.setBirthday(DateFormatUtils.strToYYYYMMDDNoCa(ozTtTpReDto.getBirthday()));
            String customerNo = customerService.insertRegister(ozTtTpReDto);
            
            
            //️发信
            SendMailDto sendMailDto = new SendMailDto();
            sendMailDto.setTitle(MessageUtils.getMessage("REGISTER_MAIL_title"));
            StringBuffer sb = new StringBuffer();
            sb.append(MessageUtils.getMessage("REGISTER_MAIL_content"));
            sb.append("</br>");
            // 这里将客户号加密

            sb.append(MessageUtils.getApplicationMessage("base_url") + "OZ_TT_TP_RE/emailRegister?customerNo="
                    + UrlParamDecode.paramEncode(customerNo));
            
            sendMailDto.setContent(sb.toString());
            List<String> mailTo = new ArrayList<String>();
            mailTo.add(ozTtTpReDto.getEmail());
            sendMailDto.setTo(mailTo);
            try {
                //发信
                MailUtil.sendMail(sendMailDto, null);
            } catch (Exception e) {
                // 发信失败的情况删除登录数据
                customerService.deleteRegister(customerNo);
            }
            
            return "redirect:/OZ_TT_TP_LG/init";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 邮件注册
     * @param model
     * @param request
     * @param session
     * @param phone
     * @return
     */
    @RequestMapping("emailRegister")
    public String emailRegister(Model model, HttpServletRequest request, HttpSession session, @RequestParam String customerNo) {
        try {
            customerNo = UrlParamDecode.paramDecode(customerNo);
            TCustomerLoginInfo info = customerService.selectByCustomerNo(customerNo);
            info.setCanlogin(CommonConstants.CAN_LOGIN);
            customerService.updateTCustomerLoginInfo(info);
            return "/notice/EmailRegisterSuccessNotice";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
