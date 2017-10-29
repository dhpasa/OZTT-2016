package com.org.oztt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerLoginHis;
import com.org.oztt.entity.TCustomerLoginInfo;
import com.org.oztt.service.CustomerService;

@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {

    @Resource
    private CustomerService customerService;
    /**
     * 登录画面初期化
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpSession session) {
        try {
            Object customerNo = session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
//            if (!StringUtils.isEmpty(customerNo)) {
//                return "redirect:/user/init";
//            }
            return "login";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 登录
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/login")
    @ResponseBody
    public Map<String, Object> login(Model model, HttpServletResponse response, HttpSession session, String phone,
            String password) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            TCustomerLoginInfo tCustomerLoginInfo = customerService.userLoginForPhone(phone, password);
            if (tCustomerLoginInfo == null) {
                // 帐号密码不匹配
                mapReturn.put("isException", false);
                mapReturn.put("isWrong", true);
                return mapReturn;
            }
            else if (CommonConstants.CANNOT_LOGIN.equals(tCustomerLoginInfo.getCanlogin())) {
                // 帐号不可以登录
                // 帐号密码不匹配
                mapReturn.put("isException", false);
                mapReturn.put("isWrong", true);
                return mapReturn;
            }

            // 登录成功插入历史记录
            if (CommonConstants.HAS_LOGINED_STATUS.equals(tCustomerLoginInfo.getLoginstatus())) {
                // 用户已经登录着，这时不需要插入历史数据也不需要更新登录表

            }
            else {
                // 插入历史登录数据并且更新登录状态
                TCustomerLoginHis tCustomerLoginHis = new TCustomerLoginHis();
                tCustomerLoginHis.setCustomerno(tCustomerLoginInfo.getCustomerno());
                customerService.insertLoginHisAndUpdateStatus(tCustomerLoginHis);
            }
            
            session.setAttribute(CommonConstants.SESSION_CUSTOMERNO, tCustomerLoginInfo.getCustomerno());
            TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(tCustomerLoginInfo.getCustomerno());
            session.setAttribute(CommonConstants.SESSION_CUSTOMERNAME, baseInfo == null ? "" : baseInfo.getNickname());
            
            mapReturn.put("isException", false);
            mapReturn.put("isWrong", false);
            return mapReturn;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }
    
    /**
     * 用户登出
     * 
     * @param model
     * @param request
     * @param session
     * @return
     */
    @RequestMapping("/logout")
    public String logout(Model model, HttpServletRequest request, HttpSession session) {
        session.removeAttribute(CommonConstants.SESSION_CUSTOMERNO);
        session.removeAttribute(CommonConstants.SESSION_CUSTOMERNAME);
        session.invalidate();
        return "redirect:/login/init";
    }
}
