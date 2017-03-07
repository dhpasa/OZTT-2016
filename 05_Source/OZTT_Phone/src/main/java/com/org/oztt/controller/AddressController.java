package com.org.oztt.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TAddressInfo;
import com.org.oztt.service.AddressService;

@Controller
@RequestMapping("/address")
public class AddressController extends BaseController {
    
    @Resource
    private AddressService addressService;
    
    /**
     * 检索当前用户全部的地址
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/showList")
    public String init(Model model, HttpServletResponse response, HttpSession session, @RequestParam String method) {
        try {
            // 获取当前用户所有的地址
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return "redirect:/login/init";
            }
            // 获取所有的地址
            List<TAddressInfo> infoList = addressService.getAllAddress(customerNo, method);
            if (!CollectionUtils.isEmpty(infoList)) {
                for (TAddressInfo info : infoList) {
                    info.setSuburb(addressService.getTSuburbDeliverFeeById(Long.valueOf(info.getSuburb())).getSuburb());
                }
            }
            return "addressList";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 检索单个地址
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/getOneById")
    public String getOneById(Model model, HttpServletResponse response, HttpSession session, @RequestParam String addressId) {
        try {
            // 获取地址
            TAddressInfo info = addressService.getAddressById(Long.valueOf(addressId));
            model.addAttribute("addressItem", info);
            return "addressEdit";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
}
