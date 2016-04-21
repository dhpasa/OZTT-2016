/**
 * 
 */
package com.org.oztt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.OrderInfoDto;
import com.org.oztt.formDto.OzTtGbOdDto;
import com.org.oztt.service.OrderService;

/**
 * @author x-wang
 *
 */

@Controller
@RequestMapping("/order")
public class OrderListControler extends BaseController {

	@Resource
	OrderService orderService;

	@RequestMapping(method = RequestMethod.GET)
	public String orders(Model model, HttpServletRequest request) {
		String tab = request.getParameter("tab");
		if (!StringUtils.isEmpty(tab)) {
			model.addAttribute("tab", tab);
		}
		return "/ordersList";
	}

	@RequestMapping(value = "/initList", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> orders(HttpServletRequest request, HttpSession session) {
		Map<String, Object> resp = new HashMap<String, Object>();
		try {
			String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
			String handleFlg = request.getParameter("orderStatus");
			String page = "1";
			Pagination pagination = new Pagination(Integer.parseInt(page));
			pagination.setSize(10);
			Map<Object, Object> paramMap = new HashMap<Object, Object>();
			paramMap.put("customerNo", customerNo);
//			paramMap.put("customerNo", "2016041700000001");
			paramMap.put("handleFlg", handleFlg);
			pagination.setParams(paramMap);
			PagingResult<OrderInfoDto> orderListPage = orderService.getAllOrderInfoForPage(pagination);
			resp.put("isException", false);
			String imgUrl = super.getApplicationMessage("saveImgUrl");
			List<OrderInfoDto> orderList = orderListPage.getResultList();
			if (!CollectionUtils.isEmpty(orderList)) {
				for (OrderInfoDto orders : orderList) {
					List<ContCartItemDto> itemList = orders.getItemList();
					for (ContCartItemDto details : itemList) {
						details.setGoodsImage(
								imgUrl + details.getGoodsId() + CommonConstants.PATH_SPLIT + details.getGoodsImage());
					}

				}
			}
			resp.put("orderList", orderListPage.getResultList());
			return resp;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
			resp.put("isException", true);
			return resp;
		}
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String order(@PathVariable String id, Model model) {
		try {
			OzTtGbOdDto detail = orderService.getOrderDetailInfo(id);

			List<ContCartItemDto> itemList = detail.getGoodList();
			for (ContCartItemDto details : itemList) {
				details.setGoodsImage(
						imgUrl + details.getGoodsId() + CommonConstants.PATH_SPLIT + details.getGoodsImage());
			}

			model.addAttribute("detailInfo", detail);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return "/orderItem";
	}

}
