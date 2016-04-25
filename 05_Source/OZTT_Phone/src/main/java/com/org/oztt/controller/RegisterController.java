package com.org.oztt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.util.CommonUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerSecurityInfo;
import com.org.oztt.formDto.OzTtTpReDto;
import com.org.oztt.service.CustomerService;

@Controller
@RequestMapping("/register")
public class RegisterController extends BaseController {

    @Resource
    private CustomerService customerService;
    /**
     * 注册
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpSession session) {
        try {

            return "register";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 注册
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/register")
    @ResponseBody
    public Map<String, Object> register(Model model, HttpServletResponse response, HttpSession session,
            @RequestBody Map<String, Object> reqBody) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String nickname = CommonUtils.objectToString((String)reqBody.get("nickname"));
            String phone = CommonUtils.objectToString((String)reqBody.get("phone"));
            String verifycode = CommonUtils.objectToString((String)reqBody.get("verifycode"));
            String password = CommonUtils.objectToString((String)reqBody.get("password"));
            // 判断输入的手机验证码是否正确
            boolean isYes = commonService.checkPhoneVerifyCode(phone, verifycode);
            if (!isYes) {
                mapReturn.put("verifyCodeError", true);
                mapReturn.put("isException", false);
                return mapReturn;
            }
            // 判断是否已经登录过了
            TCustomerSecurityInfo cusInfo = customerService.getCustomerByPhone(phone);
            if (cusInfo != null) {
                mapReturn.put("hasbeenRegister", true);
                mapReturn.put("isException", false);
                return mapReturn;
            }
            // 进行登录
            OzTtTpReDto ozTtTpReDto = new OzTtTpReDto();
            ozTtTpReDto.setNickname(nickname);
            ozTtTpReDto.setPhone(phone);
            ozTtTpReDto.setPassword(password);
            String customerNo = customerService.insertRegister(ozTtTpReDto);
            
            session.setAttribute(CommonConstants.SESSION_CUSTOMERNO, customerNo);
            session.setAttribute(CommonConstants.SESSION_CUSTOMERNAME, nickname);

            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

}
