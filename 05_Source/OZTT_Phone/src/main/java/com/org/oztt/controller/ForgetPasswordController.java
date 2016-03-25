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
import com.org.oztt.formDto.OzTtTpFpDto;
import com.org.oztt.service.CustomerService;

@Controller
@RequestMapping("/forgetPassword")
public class ForgetPasswordController extends BaseController {

    @Resource
    private CustomerService customerService;
    
    /**
     * 忘记密码
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpSession session) {
        try {

            return "forgetPassword";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 忘记密码
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/forgetPassword")
    @ResponseBody
    public Map<String, Object> forgetPassword(Model model, HttpServletResponse response, HttpSession session,
            @RequestBody Map<String, Object> reqBody) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
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
            if (cusInfo == null) {
                mapReturn.put("hasNotRegister", true);
                mapReturn.put("isException", false);
                return mapReturn;
            }
            //更新密码
            OzTtTpFpDto ozTtTpFpDto = new OzTtTpFpDto();
            ozTtTpFpDto.setNewPassword(password);
            ozTtTpFpDto.setCustomerNo(cusInfo.getCustomerno());
            customerService.updatePassword(ozTtTpFpDto);

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
