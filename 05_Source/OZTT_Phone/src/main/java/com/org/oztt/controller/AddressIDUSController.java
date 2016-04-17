package com.org.oztt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TAddressInfo;
import com.org.oztt.service.AddressService;

@Controller
@RequestMapping("/addressIDUS")
public class AddressIDUSController extends BaseController {

    @Resource
    private AddressService addressService;

    /**
     * 取的所有的地址
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/list")
    public String init(Model model, HttpServletResponse response, HttpSession session, String fromMode) {
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            // 获取所有的地址
            List<TAddressInfo> infoList = addressService.getAllAddress(customerNo);
            if (!CollectionUtils.isEmpty(infoList)) {
                for (TAddressInfo info : infoList) {
                    info.setSuburb(addressService.getTSuburbDeliverFeeById(Long.valueOf(info.getSuburb())).getSuburb());
                }
            }
            // 后台维护的时候提示让以逗号隔开
            model.addAttribute("addressList", infoList);
            model.addAttribute("fromMode", fromMode);
            return "addressList";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 取得单一的一个地址
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/getAddressById")
    public String getAddressById(Model model, HttpServletResponse response, HttpSession session,
            @RequestParam String addressId, String fromMode) {
        try {
            // 获取地址
            TAddressInfo info = addressService.getAddressById(Long.valueOf(addressId));
            model.addAttribute("suburbSelect", commonService.getSuburbList());
            // 后台维护的时候提示让以逗号隔开
            model.addAttribute("item", info);
            model.addAttribute("fromMode", fromMode);
            return "addressEdit";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 新增一个地址
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/newAddress")
    public String newAddress(Model model, HttpServletResponse response, HttpSession session, String fromMode) {
        try {
            model.addAttribute("suburbSelect", commonService.getSuburbList());
            model.addAttribute("fromMode", fromMode);
            return "addressEdit";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 提交地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/submitAddress")
    @ResponseBody
    public Map<String, Object> submitAddress(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestBody Map<String, String> reqMap) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            String addressId = reqMap.get("addressId");
            // 更新或者增加地址
            TAddressInfo info = new TAddressInfo();

            info.setAddressdetails(reqMap.get("detail"));
            info.setContacttel(reqMap.get("contacttel"));
            info.setCountrycode(reqMap.get("country"));
            info.setCustomerno(customerNo);
            info.setDeliverymethod(CommonEnum.DeliveryMethod.NORMAL.getCode());
            info.setPostcode(reqMap.get("post"));
            info.setReceiver(reqMap.get("reveiver"));
            info.setFlg(CommonConstants.NOT_DEFAULT_ADDRESS);
            List<TAddressInfo> infoList = addressService.getAllAddress(customerNo);
            if (CollectionUtils.isEmpty(infoList)) {
                info.setFlg(CommonConstants.DEFAULT_ADDRESS);
            }
            info.setState(reqMap.get("state"));
            info.setSuburb(reqMap.get("suburb"));
            if (StringUtils.isEmpty(addressId)) {
                // 插入数据
                addressService.insertAddress(info);
            }
            else {
                info.setId(Long.valueOf(addressId));
                // 更新数据
                addressService.updateAddress(info);
            }

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 删除地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/delAddress")
    @ResponseBody
    public Map<String, Object> delAddress(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestParam String addressId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            // 获取所有的地址
            addressService.deleteAddress(Long.valueOf(addressId));
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 设置默认地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/setDefaultAddress")
    @ResponseBody
    public Map<String, Object> setDefaultAddress(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestParam String addressId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            // 获取所有的地址
            addressService.updateDefaultAddress(customerNo, addressId);
            // 后台维护的时候提示让以逗号隔开
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
