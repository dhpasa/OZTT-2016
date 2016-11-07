/**
 *
 */
package com.org.oztt.admin.controller;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.base.util.CommonUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TSysConfig;
import com.org.oztt.formDto.OzTtAdScDto;
import com.org.oztt.service.SysConfigService;

/**
 * @author x-wang
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
    public String getContent(Model model, HttpServletRequest request) {

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
        model.addAttribute("ozTtAdScDto", ozTtAdScDto);
        return "OZ_TT_AD_SC";
    }

    @RequestMapping(value = "/save")
    public String save(Model model, HttpServletRequest request, @ModelAttribute OzTtAdScDto ozTtAdScDto)
            throws Exception {
        String starModel = ozTtAdScDto.getStartModel();
        sysConfigService.update(ozTtAdScDto);

        if (!StringUtils.isEmpty(ozTtAdScDto.getToppageadpic())) {
            // 将临时文件复制到图片文件服务器中
            String distImgPath = super.getApplicationMessage("DistImgPath");
            String orginPath = System.getProperty("java.io.tmpdir") + CommonConstants.PATH_SPLIT
                    + CommonConstants.OZTT_ADMIN_PROJECT;
            String destPath = distImgPath + "advertisement";
            File fileDictory = new File(destPath);
            if (!fileDictory.exists()) {
                fileDictory.mkdirs();
            }
            String[] adverties = ozTtAdScDto.getToppageadpic().split(",");
            for (String picname : adverties) {
                CommonUtils.copyFile(orginPath + CommonConstants.PATH_SPLIT + picname, destPath
                        + CommonConstants.PATH_SPLIT + picname);
            }
        }

        model.addAttribute("ozTtAdScDto", ozTtAdScDto);
        if ("1".equals(starModel)) {
            return "redirect:initPic";
        }
        else {
            return "redirect:initCont";
        }
    }
}
