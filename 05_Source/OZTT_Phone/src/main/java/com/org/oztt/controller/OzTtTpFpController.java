package com.org.oztt.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.org.oztt.base.common.MailUtil;
import com.org.oztt.base.common.SendMailDto;
import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.base.util.UrlParamDecode;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerLoginInfo;
import com.org.oztt.formDto.OzTtTpFpDto;
import com.org.oztt.service.CustomerService;

@Controller
@RequestMapping("/OZ_TT_TP_FP")
public class OzTtTpFpController extends BaseController {

    @Resource
    private CustomerService customerService;

    /**
     * 忘记密码发送邮件页
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init", method = RequestMethod.GET)
    public String init(Model model) {
        model.addAttribute("ozTtTpFpDto", new OzTtTpFpDto());
        return "/OZ_TT_TP_FP";
    }

    /**
     * 忘记密码页
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "changepw/{customerNo}", method = RequestMethod.GET)
    public String changepw(Model model, @PathVariable String customerNo) {
        OzTtTpFpDto ozTtTpFpDto = new OzTtTpFpDto();
        ozTtTpFpDto.setCustomerNo(customerNo);
        model.addAttribute("ozTtTpFpDto", ozTtTpFpDto);
        return "/OZ_TT_TP_FP_CO";
    }

    /**
     * 确认修改密码
     * 
     * @param model
     * @param request
     * @param session
     * @param ozTtTpFpDto
     * @return
     */
    @RequestMapping(value = "surechangepw", method = RequestMethod.POST)
    public String surechangepw(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtTpFpDto ozTtTpFpDto) {
        try {
            ozTtTpFpDto.setCustomerNo(UrlParamDecode.paramDecode(ozTtTpFpDto.getCustomerNo()));
            customerService.updatePassword(ozTtTpFpDto);
            // 修改完密码之后到login画面
            return "redirect:/OZ_TT_TP_LG/init";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 忘记密码,需要调用发信组件
     * 
     * @param model
     * @param request
     * @param session
     * @param loginFormDto
     * @return
     */
    @RequestMapping(value = "sendMail", method = RequestMethod.POST)
    public String sendMail(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtTpFpDto ozTtTpFpDto) {
        try {
            // 先通过email拿到客户号
            TCustomerLoginInfo tCustomerLoginInfo = customerService.selectByEmail(ozTtTpFpDto.getEmail());
            if (tCustomerLoginInfo != null) {
                String customerNo = tCustomerLoginInfo.getCustomerno();
                SendMailDto sendMailDto = new SendMailDto();
                sendMailDto.setTitle(MessageUtils.getMessage("FORGET_PASSWORD_title"));
                
                StringBuffer sb = new StringBuffer();
                sb.append(MessageUtils.getMessage("FORGET_PASSWORD_content"));
                sb.append("</br>");
                // 这里将客户号加密
                sb.append(MessageUtils.getApplicationMessage("base_url") + "/OZ_TT_TP_FP/changepw/" + UrlParamDecode.paramEncode(customerNo));
                sendMailDto.setContent(sb.toString());
                List<String> mailTo = new ArrayList<String>();
                mailTo.add(ozTtTpFpDto.getEmail());
                sendMailDto.setTo(mailTo);
                MailUtil.sendMail(sendMailDto, null);
            }

            return "redirect:/OZ_TT_TP_LG/init";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }

    }

}
