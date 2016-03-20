package com.org.oztt.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TConsOrder;
import com.org.oztt.formDto.OzTtGbOdDto;
import com.org.oztt.service.OrderService;

/**
 * 订单详细画面
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_GB_OD")
public class OzTtGbOdController extends BaseController {

    @Resource
    private OrderService orderService;

    /**
     * 订单详细画面
     * 
     * @param model
     * @param session
     * @return
     */
    @RequestMapping(value = "init")
    public String itemList(Model model, HttpSession session, String orderId) {
        try {
            OzTtGbOdDto ozTtGbOdDto = orderService.getOrderDetailInfo(orderId);
            model.addAttribute("ozTtGbOdDto", ozTtGbOdDto);
            return "/OZ_TT_GB_OD";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 未付款的订单－－>到支付画面
     * 
     * @param model
     * @param session
     * @param orderId
     * @return
     */
    @RequestMapping(value = "toPay")
    public String toPay(Model model, HttpSession session, String orderId) {
        try {
            TConsOrder tConsOrder = orderService.selectByOrderId(orderId);
            String hidDeliMethod = tConsOrder.getDeliverymethod();
            String hidAddressId = String.valueOf(tConsOrder.getAddressid());
            String hidPayMethod = tConsOrder.getPaymentmethod();
            return "redirect:/Pay/paymentHasOrder?hidDeliMethod=" + hidDeliMethod + "&hidAddressId=" + hidAddressId
                    + "&hidPayMethod=" + hidPayMethod + "&orderId=" + orderId;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
