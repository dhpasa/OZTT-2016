package com.org.oztt.admin.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.entity.TGoodsPrice;
import com.org.oztt.formDto.OzTtAdPlDto;
import com.org.oztt.formDto.OzTtAdPlListDto;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.GoodsService;
import com.org.oztt.service.OrderService;

/**
 * 商品管理
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_PL")
public class OzTtAdPlController extends BaseController {

    @Resource
    private CommonService commonService;

    @Resource
    private OrderService  orderService;

    @Resource
    private GoodsService  goodsService;

    /**
     * 商品一览画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session) {
        try {
            model.addAttribute("categoryList", commonService.getMyCategroy());
            model.addAttribute("ozTtAdPlDto", new OzTtAdPlDto());
            model.addAttribute("pageInfo", new PagingResult<OzTtAdPlListDto>());
            return "OZ_TT_AD_PL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 商品一览检索画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/search")
    public String init(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtAdPlDto ozTtAdPlDto) {
        try {
            session.setAttribute("ozTtAdPlDto", ozTtAdPlDto);
            model.addAttribute("categoryList", commonService.getMyCategroy());
            Pagination pagination = new Pagination(1);
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("goodsClass", ozTtAdPlDto.getGoodsClass());
            params.put("goodsName", ozTtAdPlDto.getGoodsName());
            params.put("isHotSale", ozTtAdPlDto.getIsHotSale());
            params.put("isNewSale", ozTtAdPlDto.getIsNewSale());
            params.put("isSetPrice", ozTtAdPlDto.getIsSetPrice());
            pagination.setParams(params);
            PagingResult<OzTtAdPlListDto> pageInfo = goodsService.getAllGoodsPriceInfoForAdmin(pagination);

            model.addAttribute("ozTtAdPlDto", ozTtAdPlDto);
            model.addAttribute("pageInfo", pageInfo);
            return "OZ_TT_AD_PL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 商品一览分页选择画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/pageSearch")
    public String init(Model model, HttpServletRequest request, HttpSession session, String pageNo) {
        try {
            model.addAttribute("categoryList", commonService.getMyCategroy());
            OzTtAdPlDto ozTtAdPlDto = (OzTtAdPlDto) session.getAttribute("ozTtAdPlDto");
            Pagination pagination = new Pagination(Integer.valueOf(pageNo));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("goodsClass", ozTtAdPlDto.getGoodsClass());
            params.put("goodsName", ozTtAdPlDto.getGoodsName());
            params.put("isHotSale", ozTtAdPlDto.getIsHotSale());
            params.put("isNewSale", ozTtAdPlDto.getIsNewSale());
            params.put("isSetPrice", ozTtAdPlDto.getIsSetPrice());
            pagination.setParams(params);
            PagingResult<OzTtAdPlListDto> pageInfo = goodsService.getAllGoodsPriceInfoForAdmin(pagination);

            model.addAttribute("ozTtAdPlDto", ozTtAdPlDto);
            model.addAttribute("pageInfo", pageInfo);
            return "OZ_TT_AD_PL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 得到产品定价时间
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getGoodsSetPriceInfo")
    @ResponseBody
    public Map<String, Object> getGoodsSetPriceInfo(HttpServletRequest request, HttpSession session, String goodsId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            TGoodsPrice tGoodsPrice = goodsService.getGoodsSetPriceInfo(goodsId);
            Map<String, String> res = new HashMap<String, String>();
            res.put("no", tGoodsPrice.getNo().toString());
            res.put("goodsclassvalue", tGoodsPrice.getPricevalue().toString());
            res.put("validperiodstart", DateFormatUtils.date2StringWithFormat(tGoodsPrice.getValidperiodstart(),
                    DateFormatUtils.PATTEN_YMD2));
            res.put("validperiodend",
                    DateFormatUtils.date2StringWithFormat(tGoodsPrice.getValidperiodend(), DateFormatUtils.PATTEN_YMD2));
            res.put("openflg", tGoodsPrice.getOpenflg());
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("resMap", res);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return null;
        }
    }

    /**
     * 产品定价保存
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/saveSetPrice")
    @ResponseBody
    public Map<String, Object> saveSetPrice(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            TGoodsPrice tGoodsPrice = new TGoodsPrice();
            tGoodsPrice.setDefaultflg("1");
            tGoodsPrice.setPricepolicy("0");
            tGoodsPrice.setPricevalue(new BigDecimal(map.get("goodsPrice")));
            tGoodsPrice.setOpenflg(map.get("openFlag"));

            tGoodsPrice.setValidperiodend(DateFormatUtils.string2DateWithFormat(map.get("dataTo"),
                    DateFormatUtils.PATTEN_YMD2));
            tGoodsPrice.setValidperiodstart(DateFormatUtils.string2DateWithFormat(map.get("dataFrom"),
                    DateFormatUtils.PATTEN_YMD2));
            String no = map.get("no");
            if (StringUtils.isEmpty(no)) {
                // 插入操作
                tGoodsPrice.setGoodsid(map.get("goodsId"));
                goodsService.saveGoodsSetPrice(tGoodsPrice);
            }
            else {
                // 更新操作
                tGoodsPrice.setNo(Long.valueOf(no));
                goodsService.updateGoodsSetPrice(tGoodsPrice);
            }

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

    /**
     * 产品团购保存
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/saveSetGroup")
    @ResponseBody
    public Map<String, Object> saveSetGroup(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            TGoodsGroup tGoodsGroup = new TGoodsGroup();
            tGoodsGroup.setComsumerreminder(map.get("comsumerreminder"));
            tGoodsGroup.setGoodsid(map.get("goodsid"));
            tGoodsGroup.setGroupcomments(map.get("groupcomments"));
            tGoodsGroup.setGroupcurrentquantity(0L);
            tGoodsGroup.setGroupdesc(map.get("groupdesc"));
            tGoodsGroup.setGroupmaxquantity(Long.valueOf(map.get("groupmaxquantity")));
            tGoodsGroup.setGroupno(map.get("groupno"));
            tGoodsGroup.setGroupprice(new BigDecimal(map.get("groupprice")));
            tGoodsGroup.setOpenflg(map.get("openflg"));
            tGoodsGroup.setShopperrules(map.get("shopperrules"));
            tGoodsGroup.setValidperiodend(DateFormatUtils.string2DateWithFormat(map.get("validperiodend"),
                    DateFormatUtils.PATTEN_YMD2));
            tGoodsGroup.setValidperiodstart(DateFormatUtils.string2DateWithFormat(map.get("validperiodstart"),
                    DateFormatUtils.PATTEN_YMD2));
            // 插入操作
            tGoodsGroup.setUpdpgmid("OZ_TT_AD_PL");
            tGoodsGroup.setUpdtimestamp(new Date());
            tGoodsGroup.setUpduserkey(CommonConstants.ADMIN_USERKEY);
            goodsService.saveGoodsSetGroup(tGoodsGroup);
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
