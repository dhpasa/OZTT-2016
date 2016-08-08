/**
 *
 */
package com.org.oztt.admin.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.entity.TSysConfig;
import com.org.oztt.formDto.OzTtAdScDto;
import com.org.oztt.service.SysConfigService;

/**
 * @author x-wang
 *
 */
@Controller
@RequestMapping("/OZ_TT_AD_SC")
public class OzTtAdScController extends BaseController {

	@Resource
	SysConfigService sysConfigService;

	@RequestMapping(value = "/initPic")
	public String initPic(Model model, HttpServletRequest request, HttpSession session) {
		TSysConfig tSysConfig = sysConfigService.getTopPageAdPic();
		OzTtAdScDto ozTtAdScDto = new OzTtAdScDto();
		ozTtAdScDto.setNo(tSysConfig.getNo());
		ozTtAdScDto.setToppageadpic(tSysConfig.getToppageadpic());
		ozTtAdScDto.setStartModel("1");
		model.addAttribute("ozTtAdScDto", ozTtAdScDto);
		return "OZ_TT_AD_SC";
	}

	@RequestMapping(value = "/initCont")
	public String initCont(Model model, HttpServletRequest request, HttpSession session) {
		OzTtAdScDto ozTtAdScDto = new OzTtAdScDto();
		ozTtAdScDto.setDivision(1);
		ozTtAdScDto.setStartModel("2");
		TSysConfig tSysConfig = sysConfigService.getContent(1);
		ozTtAdScDto.setNo(tSysConfig.getNo());
		ozTtAdScDto.setContactservice(tSysConfig.getContactservice());
		model.addAttribute("ozTtAdScDto", ozTtAdScDto);
		return "OZ_TT_AD_SC";
	}

	@RequestMapping(value = "/getCont")
	public String getContent(HttpServletRequest request) {

		String divisionStr = request.getParameter("division") == null ? "0" : request.getParameter("division");
		int division = Integer.parseInt(divisionStr);
		TSysConfig tSysConfig = sysConfigService.getContent(division);

		OzTtAdScDto ozTtAdScDto = new OzTtAdScDto();
		ozTtAdScDto.setDivision(division);
		ozTtAdScDto.setStartModel("2");
		ozTtAdScDto.setNo(tSysConfig.getNo());
		ozTtAdScDto.setContactservice(tSysConfig.getContactservice());
		ozTtAdScDto.setShoppercooperation(tSysConfig.getShoppercooperation());
		ozTtAdScDto.setAboutus(tSysConfig.getAboutus());

		return "OZ_TT_AD_SC";
	}

	@RequestMapping(value = "/save")
	public String save(Model model, HttpServletRequest request, @ModelAttribute OzTtAdScDto ozTtAdScDto) {
		String starModel = ozTtAdScDto.getStartModel();
		sysConfigService.update(ozTtAdScDto);
		model.addAttribute("ozTtAdScDto", ozTtAdScDto);
		if ("1".equals(starModel)) {
			return "redirect:initPic";
		} else {
			return "redirect:initCont";
		}
	}
}
