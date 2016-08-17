package com.org.oztt.admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.OzTtAdSuDto;
import com.org.oztt.formDto.OzTtAdSuListDto;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.GoodsService;
import com.org.oztt.service.OrderService;

/**
 * 用户角度维度查询
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_SU")
public class OzTtAdSuController extends BaseController {

    @Resource
    private CommonService commonService;

    @Resource
    private OrderService  orderService;

    @Resource
    private GoodsService  goodsService;

    /**
     * 订单用户维度一览检索画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/search")
    public String search(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtAdSuDto ozTtAdSuDto) {
        try {

            session.setAttribute("ozTtAdSuDto", ozTtAdSuDto);

            Pagination pagination = new Pagination(1);
            Pagination paginationComplete = new Pagination(1);
            
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("customerPhone", ozTtAdSuDto.getCustomerPhone());
            params.put("dataFrom", ozTtAdSuDto.getDataFrom());
            params.put("dataTo", ozTtAdSuDto.getDataTo());
            params.put("nickName", ozTtAdSuDto.getNickName());
            params.put("detailHandFlg", "0"); // 未完成订单
            model.addAttribute("ozTtAdSuDto", ozTtAdSuDto);
            
            pagination.setParams(params);
            pagination.setSize(10);
            PagingResult<OzTtAdSuListDto> pageInfo = orderService.getAllOrderByUserPointForAdmin(pagination);
            
            params.put("detailHandFlg", "1"); // 已经完成订单
            
            paginationComplete.setParams(params);
            paginationComplete.setSize(10);
            PagingResult<OzTtAdSuListDto> pageInfoCom = orderService.getAllOrderByUserPointForAdmin(paginationComplete);
            
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("pageInfoCom", pageInfoCom);
            return "OZ_TT_AD_SU";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 订单用户维度一览分页检索画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/pageSearch")
    public String pageSearch(Model model, HttpServletRequest request, HttpSession session, String pageNo, String pageNoComplete) {
        try {
            OzTtAdSuDto ozTtAdSuDto = (OzTtAdSuDto) session.getAttribute("ozTtAdSuDto");

            Pagination pagination = new Pagination(Integer.valueOf(pageNo));
            Pagination paginationComplete = new Pagination(Integer.valueOf(pageNoComplete));
            
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("customerPhone", ozTtAdSuDto.getCustomerPhone());
            params.put("dataFrom", ozTtAdSuDto.getDataFrom());
            params.put("dataTo", ozTtAdSuDto.getDataTo());
            params.put("nickName", ozTtAdSuDto.getNickName());
            params.put("detailHandFlg", "0"); // 未完成订单
            model.addAttribute("ozTtAdSuDto", ozTtAdSuDto);
            
            pagination.setParams(params);
            pagination.setSize(10);
            PagingResult<OzTtAdSuListDto> pageInfo = orderService.getAllOrderByUserPointForAdmin(pagination);
            

            params.put("detailHandFlg", "1"); // 已经完成订单
            paginationComplete.setParams(params);
            paginationComplete.setSize(10);
            PagingResult<OzTtAdSuListDto> pageInfoCom = orderService.getAllOrderByUserPointForAdmin(paginationComplete);
            
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("pageInfoCom", pageInfoCom);
            return "OZ_TT_AD_SU";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 订单批量修改状态
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/updateBatchOrder")
    @ResponseBody
    public Map<String, Object> updateBatchOrder(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {

            String[] orderIdArr = map.get("orderIds").split(",");
            String status = map.get("status");
            String adminComment = map.get("adminComments");
            orderService.updateOrderDetailStatus(orderIdArr, status, adminComment);
            
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return null;
        }
    }

}
