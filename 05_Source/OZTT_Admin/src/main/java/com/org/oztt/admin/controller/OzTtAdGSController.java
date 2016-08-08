package com.org.oztt.admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.OzTtAdGsDto;
import com.org.oztt.formDto.OzTtAdGsListDto;
import com.org.oztt.service.GoodsService;

/**
 * 产品维度查询
 *
 * @author x-wang
 */
@Controller
@RequestMapping("/OZ_TT_AD_GS")
public class OzTtAdGSController extends BaseController {

	@Resource
	private GoodsService goodsService;

	/**
	 * 产品维度查询画面
	 *
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/init")
	public String init(Model model, HttpServletRequest request, HttpSession session) {
		try {
			model.addAttribute("openSelect", commonService.getOpenFlg());
			model.addAttribute("ozTtAdGsDto", new OzTtAdGsDto());
			model.addAttribute("pageInfo", new PagingResult<OzTtAdGsListDto>());
			return "OZ_TT_AD_GS";
		} catch (Exception e) {
			logger.error(e.getMessage());
			return CommonConstants.ERROR_PAGE;
		}
	}

	/**
	 * 产品维度查询画面
	 *
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/search")
	public String init(Model model, HttpServletRequest request, HttpSession session,
			@ModelAttribute OzTtAdGsDto ozTtAdGsDto) {
		try {
			model.addAttribute("openSelect", commonService.getOpenFlg());
			session.setAttribute("ozTtAdGsDto", ozTtAdGsDto);

			// 已预订
			Pagination pagination1 = new Pagination(1);
			Map<Object, Object> params1 = new HashMap<Object, Object>();
			params1.put("goodsName", ozTtAdGsDto.getGoodsName());
			params1.put("dateFrom", ozTtAdGsDto.getDateFrom());
			params1.put("dateTo", ozTtAdGsDto.getDateTo());
			params1.put("status", "0");

			pagination1.setParams(params1);
			PagingResult<OzTtAdGsListDto> pageInfo1 = goodsService.getAllGoodsRInfoForAdmin(pagination1);

			// 已购买
			Pagination pagination2 = new Pagination(1);
			Map<Object, Object> params2 = new HashMap<Object, Object>();
			params2.put("goodsName", ozTtAdGsDto.getGoodsName());
			params2.put("dateFrom", ozTtAdGsDto.getDateFrom());
			params2.put("dateTo", ozTtAdGsDto.getDateTo());
			params2.put("status", "0");

			pagination1.setParams(params2);
			PagingResult<OzTtAdGsListDto> pageInfo2 = goodsService.getAllGoodsRInfoForAdmin(pagination2);

			model.addAttribute("ozTtAdGsDto", ozTtAdGsDto);
			model.addAttribute("pageInfo1", pageInfo1);
			model.addAttribute("pageInfo2", pageInfo2);
			return "OZ_TT_AD_GS";
		} catch (Exception e) {
			logger.error(e.getMessage());
			return CommonConstants.ERROR_PAGE;
		}
	}

	/**
	 * 产品维度查询分页选择画面
	 *
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/pageSearch")
	public String init(Model model, HttpServletRequest request, HttpSession session, String pageNo1, String pageNo2) {
		try {
			model.addAttribute("openSelect", commonService.getOpenFlg());
			OzTtAdGsDto ozTtAdGsDto = (OzTtAdGsDto) session.getAttribute("ozTtAdGsDto");

			// 已预订
			Pagination pagination1 = new Pagination(Integer.valueOf(pageNo1));
			Map<Object, Object> params1 = new HashMap<Object, Object>();
			params1.put("goodsName", ozTtAdGsDto.getGoodsName());
			params1.put("dateFrom", ozTtAdGsDto.getDateFrom());
			params1.put("dateTo", ozTtAdGsDto.getDateTo());
			params1.put("status", "0");

			pagination1.setParams(params1);
			PagingResult<OzTtAdGsListDto> pageInfo1 = goodsService.getAllGoodsRInfoForAdmin(pagination1);

			// 已购买
			Pagination pagination2 = new Pagination(Integer.valueOf(pageNo2));
			Map<Object, Object> params2 = new HashMap<Object, Object>();
			params2.put("goodsName", ozTtAdGsDto.getGoodsName());
			params2.put("dateFrom", ozTtAdGsDto.getDateFrom());
			params2.put("dateTo", ozTtAdGsDto.getDateTo());
			params2.put("status", "0");

			pagination1.setParams(params2);
			PagingResult<OzTtAdGsListDto> pageInfo2 = goodsService.getAllGoodsRInfoForAdmin(pagination2);

			model.addAttribute("ozTtAdGsDto", ozTtAdGsDto);
			model.addAttribute("pageInfo1", pageInfo1);
			model.addAttribute("pageInfo2", pageInfo2);

			return "OZ_TT_AD_GS";
		} catch (Exception e) {
			logger.error(e.getMessage());
			return CommonConstants.ERROR_PAGE;
		}
	}

}
