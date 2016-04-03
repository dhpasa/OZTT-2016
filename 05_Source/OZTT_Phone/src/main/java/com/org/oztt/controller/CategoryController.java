package com.org.oztt.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.org.oztt.base.common.MyCategroy;
import com.org.oztt.contants.CommonConstants;

@Controller
@RequestMapping("/category")
public class CategoryController extends BaseController {

    /**
     * 分类
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletResponse response, HttpSession session) {
        try {
            // 获取目录
            List<MyCategroy> myCategroyList = super.commonService.getMyCategroy();
            model.addAttribute("category", myCategroyList);
            model.addAttribute("categoryHost", super.getApplicationMessage("categoryImgUrl"));
            return "category";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
