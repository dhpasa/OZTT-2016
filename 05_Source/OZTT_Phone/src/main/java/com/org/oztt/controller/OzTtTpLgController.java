package com.org.oztt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSONObject;
import com.org.oztt.base.common.MyCategroy;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerLoginHis;
import com.org.oztt.entity.TCustomerLoginInfo;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.ContCartProItemDto;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.formDto.OzTtTpLgDto;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/OZ_TT_TP_LG")
public class OzTtTpLgController extends BaseController {

    @Resource
    private CustomerService customerService;

    @Resource
    private GoodsService    goodsService;

    /**
     * 登录页
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init", method = RequestMethod.GET)
    public String gotoMain(Model model) {
        try {
            model.addAttribute("ozTtTpLgDto", new OzTtTpLgDto());
            return "/OZ_TT_TP_LG";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 用户登录操作
     * 
     * @param model
     * @param request
     * @param session
     * @param loginFormDto
     * @return
     */
    @RequestMapping("login")
    public String login(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtTpLgDto ozTtTpLgDto) {
        try {
            // 进入登录画面
            String username = ozTtTpLgDto.getUsername();
            String password = ozTtTpLgDto.getPassword();
            TCustomerLoginInfo tCustomerLoginInfo = customerService.userLogin(username, password);
            if (tCustomerLoginInfo == null) {
                // 没有取到数据,清空密码
                ozTtTpLgDto = new OzTtTpLgDto();
                ozTtTpLgDto.setUsername(username);
                // 错误信息
                model.addAttribute("ozTtTpLgDto", ozTtTpLgDto);
                model.addAttribute("cannotLogin", "1");
                return "/OZ_TT_TP_LG";
            }
            else if (CommonConstants.CANNOT_LOGIN.equals(tCustomerLoginInfo.getCanlogin())) {
                // 没有取到数据,清空密码
                ozTtTpLgDto = new OzTtTpLgDto();
                ozTtTpLgDto.setUsername(username);
                // 错误信息
                model.addAttribute("ozTtTpLgDto", ozTtTpLgDto);
                model.addAttribute("cannotLogin", "1");
                return "/OZ_TT_TP_LG";
            }

            // 登录成功插入历史记录
            if (CommonConstants.HAS_LOGINED_STATUS.equals(tCustomerLoginInfo.getLoginstatus())) {
                // 用户已经登录着，这时不需要插入历史数据也不需要更新登录表

            }
            else {
                // 插入历史登录数据并且更新登录状态
                TCustomerLoginHis tCustomerLoginHis = new TCustomerLoginHis();
                tCustomerLoginHis.setCustomerno(tCustomerLoginInfo.getCustomerno());
                customerService.insertLoginHisAndUpdateStatus(tCustomerLoginHis);
            }

            String imgUrl = super.getApplicationMessage("saveImgUrl");

            // 当前用户已经登录, 直接跳转到主菜单画面。
            // 这里当用户已经登录的时候，就不需要再插入历史记录了。
            // 登陆成功以后取得购物车中的数据然后更新Cookie
            List<ContCartItemDto> consCarts = goodsService.getAllContCartForCookie(tCustomerLoginInfo.getCustomerno());
            if (!CollectionUtils.isEmpty(consCarts)) {
                for (ContCartItemDto dto : consCarts) {
                    if (StringUtils.isEmpty(dto.getGoodsPropertiesDB())) {
                        dto.setGoodsProperties(new ArrayList<ContCartProItemDto>());
                    } else {
                        dto.setGoodsProperties(JSONObject.parseArray(dto.getGoodsPropertiesDB(), ContCartProItemDto.class));
                    }
                    dto.setGoodsPropertiesDB(StringUtils.EMPTY);
                    dto.setGoodsImage(imgUrl + dto.getGoodsId() + CommonConstants.PATH_SPLIT + dto.getGoodsImage());
                }
            }

            model.addAttribute("conscars", JSONObject.toJSONString(consCarts));
            model.addAttribute("needSync", "1");

            // 可以取到数据，将所用的数据放入session 中
            session.setAttribute(CommonConstants.SESSION_CUSTOMERNO, tCustomerLoginInfo.getCustomerno());
            TCustomerBasicInfo baseInfo = customerService.selectBaseInfoByCustomerNo(tCustomerLoginInfo.getCustomerno());
            session.setAttribute(CommonConstants.SESSION_CUSTOMERNAME, baseInfo == null ? "" : baseInfo.getNickname());

            //=============================================================
            // 获取目录
            List<MyCategroy> myCategroyList = super.commonService.getMyCategroy();

            // 获取新货
            List<GroupItemDto> allGoodsList = goodsService.getAllNewArravail();

            if (!CollectionUtils.isEmpty(allGoodsList)) {
                for (GroupItemDto goods : allGoodsList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }

            // 获取明细分类的数据
            Map<String, String> mapParam = new HashMap<String, String>();
            mapParam.put(CommonConstants.LIMIT_PARAM, CommonConstants.MAIN_LIST_COUNT);
            List<GroupItemDto> tgoodList = goodsService.getGoodsListForMain(mapParam);
            if (!CollectionUtils.isEmpty(tgoodList)) {
                for (GroupItemDto goods : tgoodList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT
                            + goods.getGoodsthumbnail());
                }
            }
            model.addAttribute("menucategory", myCategroyList);
            model.addAttribute("allGoodsList", allGoodsList);
            model.addAttribute("tgoodList", tgoodList);

            // 获取session中的值
            model.addAttribute(CommonConstants.SESSION_CUSTOMERNO,
                    session.getAttribute(CommonConstants.SESSION_CUSTOMERNO));
            model.addAttribute(CommonConstants.SESSION_CUSTOMERNAME,
                    session.getAttribute(CommonConstants.SESSION_CUSTOMERNAME));
            //============================================================================

            return "/main/main";

        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }

    }

    /**
     * 用户登出
     * 
     * @param model
     * @param request
     * @param session
     * @return
     */
    @RequestMapping("logout")
    public String logout(Model model, HttpServletRequest request, HttpSession session) {
        session.removeAttribute(CommonConstants.SESSION_CUSTOMERNO);
        session.removeAttribute(CommonConstants.SESSION_CUSTOMERNAME);
        session.invalidate();
        return "redirect:/main/init";
    }

}
