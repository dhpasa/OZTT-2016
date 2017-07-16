package com.org.oztt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.PowderService;

@Controller
@RequestMapping("/address")
public class AddressIDUSController extends BaseController {
    
    @Resource
    private PowderService    powderService;

    @Resource
    private CustomerService  customerService;

    /**
     * 取的发件人所有的地址
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/sendList")
    public String sendList(Model model, HttpServletResponse response, HttpSession session, String pageNo, String keywords) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            // 获取所有的地址
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }

            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            if (StringUtils.isEmpty(pageNo)) {
                pageNo = "1";
            }
            Pagination pagination = new Pagination(Integer.parseInt(pageNo));
            pagination.setSize(CommonConstants.COMMON_LIST_COUNT);
            Map<Object, Object> paramMap = new HashMap<Object, Object>();
            paramMap.put("customerId", customerBaseInfo.getNo());
            paramMap.put("keywords", keywords);
            pagination.setParams(paramMap);
            PagingResult<TSenderInfo> sendList = powderService.selectSenderInfoPageList(pagination);
            model.addAttribute("sendListPage", sendList);
            model.addAttribute("keywords", keywords);
            return "addressSendList";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 取的收件人所有的地址
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/receiveList")
    public String receiveList(Model model, HttpServletResponse response, HttpSession session, String pageNo, String keywords) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            // 获取所有的地址
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            if (StringUtils.isEmpty(pageNo)) {
                pageNo = "1";
            }
            Pagination pagination = new Pagination(Integer.parseInt(pageNo));
            pagination.setSize(CommonConstants.COMMON_LIST_COUNT);
            Map<Object, Object> paramMap = new HashMap<Object, Object>();
            paramMap.put("customerId", customerBaseInfo.getNo());
            paramMap.put("keywords", keywords);
            pagination.setParams(paramMap);
            PagingResult<TReceiverInfo> receiveList = powderService.selectReceiverInfoPageList(pagination);
            model.addAttribute("receiveListPage", receiveList);
            model.addAttribute("keywords", keywords);
            // 后台维护的时候提示让以逗号隔开
            return "addressReceiveList";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
        
    /**
     * 地址提交
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/submitAddress")
    public Map<String, Object> submitAddress(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (StringUtils.isEmpty(customerNo)) {
                mapReturn.put("isException", true);
                return mapReturn;
            }
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            // 提交当前的地址信息
            String updateType = map.get("updateType");
            String name = map.get("name");
            String phone = map.get("phone");
            String address = map.get("address");
            String addressId = map.get("addressId");
            String idCard = map.get("idCard");
            if (StringUtils.isEmpty(addressId)) {
                // 新增
                if ("0".equals(updateType)) {
                    // 发件人
                    TSenderInfo tSenderInfo = new TSenderInfo();
                    tSenderInfo.setSenderName(name);
                    tSenderInfo.setSenderTel(phone);
                    tSenderInfo.setDeleteFlg(CommonConstants.IS_NOT_DELETE);
                    tSenderInfo.setCustomerId(customerBaseInfo.getNo().toString());
                    powderService.insertSendInfo(tSenderInfo);
                }
                else {
                    // 收件人
                    TReceiverInfo tReceiverInfo = new TReceiverInfo();
                    tReceiverInfo.setReceiverName(name);
                    tReceiverInfo.setReceiverTel(phone);
                    tReceiverInfo.setReceiverAddr(address);
                    tReceiverInfo.setReceiverIdCardNo(idCard);
                    tReceiverInfo.setDeleteFlg(CommonConstants.IS_NOT_DELETE);
                    tReceiverInfo.setCustomerId(customerBaseInfo.getNo().toString());
                    powderService.insertReveiverInfo(tReceiverInfo);
                }
            }
            else {
                // 更新
                if ("0".equals(updateType)) {
                    // 发件人
                    TSenderInfo tSenderInfo = new TSenderInfo();
                    tSenderInfo.setId(Long.valueOf(addressId));
                    tSenderInfo.setSenderName(name);
                    tSenderInfo.setSenderTel(phone);
                    powderService.updateSendInfo(tSenderInfo);
                }
                else {
                    // 收件人
                    TReceiverInfo tReceiverInfo = new TReceiverInfo();
                    tReceiverInfo.setId(Long.valueOf(addressId));
                    tReceiverInfo.setReceiverName(name);
                    tReceiverInfo.setReceiverTel(phone);
                    tReceiverInfo.setReceiverAddr(address);
                    tReceiverInfo.setReceiverIdCardNo(idCard);
                    powderService.updateReveiverInfo(tReceiverInfo);
                }
            }
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error("message", e);
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getAddress")
    public String getAddress(Model model, HttpServletRequest request, HttpSession session, String updateType,
            String addressId) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            // 获取所有的地址
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }
            TSenderInfo tSenderInfo = new TSenderInfo();
            TReceiverInfo tReceiverInfo = new TReceiverInfo();
            if ("0".equals(updateType)) {
                // 发件人
                if (StringUtils.isNotEmpty(addressId)) {
                    tSenderInfo = powderService.getSendInfo(Long.valueOf(addressId));
                }
            }
            else {
                // 收件人
                if (StringUtils.isNotEmpty(addressId)) {
                    tReceiverInfo = powderService.getReveiverInfo(Long.valueOf(addressId));
                }
            }
            model.addAttribute("senderInfo", tSenderInfo);
            model.addAttribute("receiverInfo", tReceiverInfo);
            if ("0".equals(updateType)) {
                return "addressSendEdit";
            } else {
                return "addressReceiveEdit";
            }
            
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 删除地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/deleteAddress")
    public String deleteAddress(HttpServletRequest request, HttpSession session, String updateType,
            String addressId) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            // 获取所有的地址
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }
            if ("0".equals(updateType)) {
                // 发件人
                powderService.deleteSendInfo(Long.valueOf(addressId));
                return "redirect:/address/sendList";
            }
            else {
                // 收件人
                powderService.deleteReveiverInfo(Long.valueOf(addressId));
                return "redirect:/address/receiveList";
            }
           
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }

}
