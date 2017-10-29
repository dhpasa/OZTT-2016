/**
 * 
 */
package com.org.oztt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DeliveryInfoCrawler;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TProductBox;
import com.org.oztt.formDto.OrderDetailViewDto;
import com.org.oztt.formDto.PowderOrderInfo;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.OrderService;
import com.org.oztt.service.PowderService;
import com.org.oztt.service.ProductService;

/**
 * @author x-wang
 */

@Controller
@RequestMapping("/order")
public class OrderListControler extends BaseController {

    @Resource
    OrderService orderService;
    
    @Resource
    CustomerService customerService;
    
    @Resource
    PowderService powderService;
    
    @Resource
    ProductService productService;

    @RequestMapping(value = "/init")
    public String orders(HttpSession session, Model model, HttpServletRequest request, 
            String searchcontent, String pageNo, String orderStatus) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
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
            paramMap.put("customerId", customerBaseInfo.getNo().toString());
            paramMap.put("status", orderStatus);
            paramMap.put("keyword", searchcontent);
            pagination.setParams(paramMap);
            PagingResult<PowderOrderInfo> orderListPage = powderService.getPowderAndProductOrderPageInfo(pagination);
            
            
            model.addAttribute("orderStatus", orderStatus);
            model.addAttribute("keyword", searchcontent);
            model.addAttribute("orderList", orderListPage);
            return "/ordersList";
            
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
        
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String order(HttpSession session, @PathVariable String id, Model model, HttpServletRequest request, String orderFlg) {
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (StringUtils.isEmpty(customerNo)) {
                return "redirect:/login/init";
            }
            OrderDetailViewDto viewDto = productService.getOrderDetail(id, orderFlg);
            
            String tab = request.getParameter("tab");
            if (!StringUtils.isEmpty(tab)) {
                model.addAttribute("tab", tab);
            }
            model.addAttribute("detailInfo", viewDto);
            return "/orderItem";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
        
    }
    
    /**
     * 获取物流信息
     * @param request
     * @param session
     * @param type
     * @param receiveId
     * @param dataMap
     * @return
     */
    @RequestMapping(value = "/getExpressInfo")
    public Map<String, Object> getExpressInfo(HttpServletRequest request, HttpSession session, String expressEleNo, String boxId) {
        Map<String, Object> resp = new HashMap<String, Object>();
        try {
            List<String> strList = new ArrayList<String>();
            String s = PowderOrderListControler.class.getResource("/").getPath().toString();
            s = java.net.URLDecoder.decode(s, "UTF-8");
            TProductBox tProductBox = productService.selectProductBoxById(boxId);
            DeliveryInfoCrawler diCrawler = null;
            if (CommonConstants.EXPRESS_BLUE_SKY.equals(tProductBox.getDeliverId())) {
                diCrawler = new DeliveryInfoCrawler(s + "bluesky.properties");
            } else if (CommonConstants.EXPRESS_FREAK_QUICK.equals(tProductBox.getDeliverId())){
                diCrawler = new DeliveryInfoCrawler(s + "freakyquick.properties");
            } else if (CommonConstants.EXPRESS_LONGMEN.equals(tProductBox.getDeliverId())){
                diCrawler = new DeliveryInfoCrawler(s + "longmen.properties");
            } else if (CommonConstants.EXPRESS_SUPIN.equals(tProductBox.getDeliverId())){
                diCrawler = new DeliveryInfoCrawler(s + "supin.properties");
            } else if (CommonConstants.EXPRESS_XINGSUDI.equals(tProductBox.getDeliverId())) {
                diCrawler = new DeliveryInfoCrawler(s + "xingsudi.properties");
            }
            LinkedHashMap<String, String> infos = diCrawler.getDeliveryInfo(expressEleNo);
            for (Entry<String, String> info : infos.entrySet()) {
                strList.add(info.getKey() + "   " + info.getValue());
            }
            // 将物流信息返回画面
            resp.put("expressInfo", strList);
            resp.put("isException", false);
            return resp;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            resp.put("isException", true);
            return resp;
        }
    }

}
