package com.org.oztt.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TConsOrder;
import com.org.oztt.service.OrderService;

/**
 * 支付方式画面
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_GB_OC")
public class OzTtGbOcController extends BaseController {

    @Resource
    private OrderService orderService;
    
    /**
     * 支付方式画面选择方式付款
     * @param model
     * @param session
     * @param hidDeliMethod 运送方式
     * @param hidAddressId  运送地址
     * @param hidPayMethod  付款方式
     * @return
     */
    @RequestMapping(value = "init")
    public String init(Model model, HttpSession session, String hidDeliMethod, String hidAddressId, String hidPayMethod, String hidHomeDeliveryTime) {
        try {
            model.addAttribute("hidDeliMethod", hidDeliMethod);
            model.addAttribute("hidAddressId", hidAddressId);
            model.addAttribute("hidPayMethod", hidPayMethod);
            model.addAttribute("hidHomeDeliveryTime", hidHomeDeliveryTime);
            return "/OZ_TT_GB_OC";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    

    /**
     * 再次付款
     * @param model
     * @param session
     * @param orderId
     * @return
     */
    @RequestMapping(value = "PayAgain")
    public String init(Model model, HttpSession session, String orderId) {
        try {
            TConsOrder orDto = orderService.selectByOrderId(orderId);
            model.addAttribute("hidDeliMethod", orDto.getDeliverymethod());
            model.addAttribute("hidAddressId", orDto.getAddressid());
            model.addAttribute("hidPayMethod", orDto.getPaymentmethod());
            model.addAttribute("hidHomeDeliveryTime", orDto.getHomedeliverytime());
            model.addAttribute("hidOrder", orderId);
            return "/OZ_TT_GB_OC";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
