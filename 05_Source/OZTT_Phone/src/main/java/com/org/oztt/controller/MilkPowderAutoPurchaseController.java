package com.org.oztt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TPowderInfo;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.formDto.PowderCommonDto;
import com.org.oztt.service.PowderService;

@Controller
@RequestMapping("/milkPowderAutoPurchase")
public class MilkPowderAutoPurchaseController extends BaseController {

    @Resource
    private PowderService powderService;
    /**
     * 奶粉订单系统
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session) {
        try {
            // 取得奶粉信息
            List<TPowderInfo>  powderList = powderService.selectPowderInfo();
            model.addAttribute("powderList", JSON.toJSONString(powderList));
            List<TPowderInfo>  powderListForView = new ArrayList<TPowderInfo>();
            if (powderList != null && powderList.size() > 0) {
                for (TPowderInfo detail : powderList) {
                    TPowderInfo bean = new TPowderInfo();
                    PropertyUtils.copyProperties(bean, detail);
                    bean.setPowderPrice(bean.getPowderPrice().multiply(CommonConstants.POWDER_NUMBER));
                    powderListForView.add(bean);
                } 
            }
            model.addAttribute("PowderInfoList", powderListForView);
            
            // 获取快递信息
            List<TExpressInfo> expressInfoList = powderService.selectAllExpressInfo();
            model.addAttribute("ExpressList", expressInfoList);
            
            // 创建json数据
            String powderBrand = "";
            List<PowderCommonDto> powderJsonList = new ArrayList<PowderCommonDto>();
            PowderCommonDto addDto = new PowderCommonDto();
            
            PowderCommonDto specDto = new PowderCommonDto();
            List<PowderCommonDto> specDtoList = new ArrayList<PowderCommonDto>();
            if (powderList != null && powderList.size() > 0) {
                for (TPowderInfo detail : powderList) {
                    if (!StringUtils.isEmpty(powderBrand) && !powderBrand.equals(detail.getPowderBrand())){
                        addDto.setChild(specDtoList);
                        powderJsonList.add(addDto);
                        addDto = new PowderCommonDto();
                        specDtoList = new ArrayList<PowderCommonDto>();
                    }
                    addDto.setId(detail.getPowderBrand());
                    addDto.setName(detail.getPowderBrand());
                    
                    specDto = new PowderCommonDto();
                    specDto.setId(detail.getPowderSpec());
                    specDto.setName(detail.getPowderSpec());
                    specDto.setChild(new PowderCommonDto(4).getChild());
                    specDtoList.add(specDto);
                    
                    powderBrand = detail.getPowderBrand();
                }
                addDto.setChild(specDtoList);
                powderJsonList.add(addDto);
            }
            model.addAttribute("powderJson", JSON.toJSONString(powderJsonList));
            return "milkPowderAutoPurchase";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 得到当前用户的发件人信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getSenderInfo")
    public Map<String, Object> getSenderInfo(HttpServletRequest request, HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            List<TSenderInfo> sendList = powderService.selectSenderInfoList(customerNo);

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("sendList", sendList);
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
     * 得到当前用户的收件人信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getReceiveInfo")
    public Map<String, Object> getReceiveInfo(HttpServletRequest request, HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            List<TReceiverInfo> receiveList = powderService.selectReceiverInfoList(customerNo);

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("sendList", receiveList);
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
