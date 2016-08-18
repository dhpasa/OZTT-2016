package com.org.oztt.admin.controller;

import java.math.BigDecimal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerSecurityInfo;
import com.org.oztt.formDto.OzTtAdOdDto;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.OrderService;

/**
 * 订单详细画面
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_SD")
public class OzTtAdSdController extends BaseController {

    @Resource
    private CommonService   commonService;

    @Resource
    private OrderService    orderService;

    @Resource
    private CustomerService customerService;

    /**
     * 订单详细画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session, String orderNo, String pageNo, String pageNoComplete) {
        try {
            OzTtAdOdDto ozTtAdOdDto = orderService.getOrderDetailForAdmin(orderNo);
            if (CommonEnum.DeliveryMethod.PICK_INSTORE.getCode().equals(ozTtAdOdDto.getDeliveryMethodFlag())) {
                // 来店自提
                TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(ozTtAdOdDto.getCustomerNo());
                TCustomerSecurityInfo securityInfo = customerService.getCustomerSecurityByCustomerNo(ozTtAdOdDto
                        .getCustomerNo());
                ozTtAdOdDto.setReceiver(baseInfo.getNickname());
                ozTtAdOdDto.setPhone(securityInfo.getTelno());
            }
            else if (CommonEnum.DeliveryMethod.HOME_DELIVERY.getCode().equals(ozTtAdOdDto.getDeliveryMethodFlag())) {
                // 送货上门
            }
            model.addAttribute("ozTtAdOdDto", ozTtAdOdDto);
            model.addAttribute("OrderAmountAndFre", new BigDecimal(ozTtAdOdDto.getOrderAmount()).add(new BigDecimal(
                    ozTtAdOdDto.getYunfei() == null ? "0" : ozTtAdOdDto.getYunfei())));
            model.addAttribute("pageNo", pageNo);
            model.addAttribute("pageNoComplete", pageNoComplete);
            return "OZ_TT_AD_SD";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
