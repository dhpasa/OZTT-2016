package com.org.oztt.admin.controller;

import java.math.BigDecimal;
import java.util.Calendar;
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
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.formDto.OzTtAdGcDto;
import com.org.oztt.formDto.OzTtAdGcListDto;
import com.org.oztt.service.GoodsService;

/**
 * 团购统计
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_GL")
public class OzTtAdGlController extends BaseController {

    @Resource
    private GoodsService goodsService;

    /**
     * 商品团购管理一览画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session) {
        try {
            model.addAttribute("openSelect", commonService.getOpenFlg());
            model.addAttribute("ozTtAdGcDto", new OzTtAdGcDto());
            model.addAttribute("pageInfo", new PagingResult<OzTtAdGcListDto>());
            return "OZ_TT_AD_GL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 商品团购管理一览检索画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/search")
    public String init(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtAdGcDto ozTtAdGcDto) {
        try {
            model.addAttribute("openSelect", commonService.getOpenFlg());
            session.setAttribute("ozTtAdGcDto", ozTtAdGcDto);

            Pagination pagination = new Pagination(1);
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("goodsName", ozTtAdGcDto.getGoodsName());
            params.put("goodsClassId", ozTtAdGcDto.getGoodsClassId());
            params.put("goodsId", ozTtAdGcDto.getGoodsId());
            params.put("dateFrom", ozTtAdGcDto.getDateFrom());
            params.put("dateTo", ozTtAdGcDto.getDateTo());
            params.put("isOpenFlag", ozTtAdGcDto.getOpenFlg());
            if (!StringUtils.isEmpty(ozTtAdGcDto.getGroupArea())) {
                switch (ozTtAdGcDto.getGroupArea()) {
                    case "1":
                        params.put("isTopUp", "1");
                        break;
                    case "2":
                        params.put("isPre", "1");
                        break;
                    case "3":
                        params.put("isInStock", "1");
                        break;
                    case "4":
                        params.put("isHot", "1");
                        break;
                    case "5":
                        params.put("isDiamond", "1");
                        break;
                    case "6":
                        params.put("isEn", "1");
                        break;
                    default:
                        break;
                }
            }
            pagination.setParams(params);
            PagingResult<OzTtAdGcListDto> pageInfo = goodsService.getAllGroupsInfoForAdmin(pagination);

            model.addAttribute("ozTtAdGcDto", ozTtAdGcDto);
            model.addAttribute("pageInfo", pageInfo);
            return "OZ_TT_AD_GL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 商品团购管理一览分页选择画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/pageSearch")
    public String init(Model model, HttpServletRequest request, HttpSession session, String pageNo) {
        try {
            model.addAttribute("openSelect", commonService.getOpenFlg());
            OzTtAdGcDto ozTtAdGcDto = (OzTtAdGcDto) session.getAttribute("ozTtAdGcDto");
            Pagination pagination = new Pagination(Integer.valueOf(pageNo));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("goodsName", ozTtAdGcDto.getGoodsName());
            params.put("goodsClassId", ozTtAdGcDto.getGoodsClassId());
            params.put("goodsId", ozTtAdGcDto.getGoodsId());
            params.put("dateFrom", ozTtAdGcDto.getDateFrom());
            params.put("dateTo", ozTtAdGcDto.getDateTo());
            params.put("isOpenFlag", ozTtAdGcDto.getOpenFlg());
            if (!StringUtils.isEmpty(ozTtAdGcDto.getGroupArea())) {
                switch (ozTtAdGcDto.getGroupArea()) {
                    case "1":
                        params.put("isTopUp", "1");
                        break;
                    case "2":
                        params.put("isPre", "1");
                        break;
                    case "3":
                        params.put("isInStock", "1");
                        break;
                    case "4":
                        params.put("isHot", "1");
                        break;
                    case "5":
                        params.put("isDiamond", "1");
                        break;
                    case "6":
                        params.put("isEn", "1");
                        break;
                    default:
                        break;
                }
            }
            pagination.setParams(params);
            PagingResult<OzTtAdGcListDto> pageInfo = goodsService.getAllGroupsInfoForAdmin(pagination);

            model.addAttribute("ozTtAdGcDto", ozTtAdGcDto);
            model.addAttribute("pageInfo", pageInfo);
            return "OZ_TT_AD_GL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 得到产品团购信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getGroupInfo")
    @ResponseBody
    public Map<String, Object> getGroupInfo(HttpServletRequest request, HttpSession session, String groupId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            TGoodsGroup tGoodsGroup = new TGoodsGroup();
            tGoodsGroup.setGroupno(groupId);
            tGoodsGroup = goodsService.getGoodPrice(tGoodsGroup);
            Map<String, String> res = new HashMap<String, String>();
            res.put("goodsGroupPrice", tGoodsGroup.getGroupprice().toString());
            res.put("goodsGroupNumber", tGoodsGroup.getGroupmaxquantity().toString());
            res.put("goodsGroupLimit", tGoodsGroup.getGroupquantitylimit().toString());
            res.put("goodsGroupCurrent", tGoodsGroup.getGroupcurrentquantity() == null ? "0" : tGoodsGroup
                    .getGroupcurrentquantity().toString());
            res.put("goodsGroupSortOrder", tGoodsGroup.getSortorder() == null ? "0" : tGoodsGroup.getSortorder()
                    .toString());
            res.put("dataFromGroup",
                    DateFormatUtils.date2StringWithFormat(tGoodsGroup.getValidperiodstart(), DateFormatUtils.PATTEN_HM));
            res.put("dataToGroup",
                    DateFormatUtils.date2StringWithFormat(tGoodsGroup.getValidperiodend(), DateFormatUtils.PATTEN_HM));
            res.put("groupComment", tGoodsGroup.getGroupcomments());
            res.put("groupDesc", tGoodsGroup.getGroupdesc());
            res.put("groupReminder", tGoodsGroup.getComsumerreminder());
            res.put("groupRule", tGoodsGroup.getShopperrules());
            res.put("openflg", tGoodsGroup.getOpenflg());
            res.put("isTopUp", tGoodsGroup.getToppageup());
            res.put("isPre", tGoodsGroup.getPreflg());
            res.put("isInStock", tGoodsGroup.getInstockflg());
            res.put("isHot", tGoodsGroup.getHotflg());
            res.put("sellOutInitQuantity", tGoodsGroup.getSelloutinitquantity() == null ? "" : tGoodsGroup
                    .getSelloutinitquantity().toString());
            res.put("sellOutFlg", tGoodsGroup.getSelloutflg() == null ? "" : tGoodsGroup.getSelloutflg());
            res.put("diamondShowFlg", tGoodsGroup.getDiamondshowflg() == null ? "" : tGoodsGroup.getDiamondshowflg());
            res.put("enShowFlg", tGoodsGroup.getEnshowflg() == null ? "" : tGoodsGroup.getEnshowflg());
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
            tGoodsGroup.setGroupno(map.get("groupno"));
            if (!StringUtils.isEmpty(tGoodsGroup.getGroupno())) {
                // 如果有groupNo
                tGoodsGroup = goodsService.getGoodPrice(tGoodsGroup);
            }
            tGoodsGroup.setComsumerreminder(map.get("comsumerreminder"));
            tGoodsGroup.setGroupcomments(map.get("groupcomments"));
            tGoodsGroup.setGroupdesc(map.get("groupdesc"));
            tGoodsGroup.setGroupmaxquantity(Long.valueOf(map.get("groupmaxquantity")));
            tGoodsGroup.setGroupquantitylimit(Long.valueOf(map.get("groupquantitylimit")));
            tGoodsGroup.setGroupcurrentquantity(Long.valueOf(map.get("groupquantitycurrent")));
            tGoodsGroup.setSortorder(Integer.valueOf(map.get("goodsgroupsortorder")));
            tGoodsGroup.setGroupprice(new BigDecimal(map.get("groupprice")));
            tGoodsGroup.setOpenflg(map.get("openflg"));
            tGoodsGroup.setToppageup(map.get("istopup"));
            tGoodsGroup.setPreflg(map.get("ispre"));
            tGoodsGroup.setInstockflg(map.get("isinstock"));
            tGoodsGroup.setHotflg(map.get("ishot"));
            tGoodsGroup.setShopperrules(map.get("shopperrules"));
            tGoodsGroup.setValidperiodend(DateFormatUtils.string2DateWithFormat(map.get("validperiodend"),
                    DateFormatUtils.PATTEN_HM));
            tGoodsGroup.setValidperiodstart(DateFormatUtils.string2DateWithFormat(map.get("validperiodstart"),
                    DateFormatUtils.PATTEN_HM));
            if ("1".equals(tGoodsGroup.getInstockflg())) {
                // 如果是现货
                tGoodsGroup.setValidperiodend(DateFormatUtils.addDate(
                        DateFormatUtils.string2DateWithFormat(map.get("validperiodstart"), DateFormatUtils.PATTEN_HM),
                        Calendar.DATE, CommonConstants.MAX_DAY));
            }
            // 即将售罄数量和即将售罄标志
            tGoodsGroup.setSelloutinitquantity(StringUtils.isEmpty(map.get("sellOutInitQuantity")) ? null
                    : new BigDecimal(map.get("sellOutInitQuantity")));
            tGoodsGroup.setSelloutflg(map.get("sellOutFlg"));
            tGoodsGroup.setDiamondshowflg(map.get("diamondshowflg"));
            tGoodsGroup.setEnshowflg(map.get("enshowflg"));
            // 更新操作
            tGoodsGroup.setUpdpgmid("OZ_TT_AD_GL");
            tGoodsGroup.setUpdtimestamp(new Date());
            tGoodsGroup.setUpduserkey(CommonConstants.ADMIN_USERKEY);
            if (!StringUtils.isEmpty(tGoodsGroup.getGroupno())) {
                goodsService.updateGoodsSetGroup(tGoodsGroup);
            }
            else {
                tGoodsGroup.setGoodsid(map.get("goodsid"));
                tGoodsGroup.setAddtimestamp(new Date());
                tGoodsGroup.setAdduserkey(CommonConstants.ADMIN_USERKEY);
                goodsService.saveGoodsSetGroup(tGoodsGroup);
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
     * 商品团购管理一览画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/groupPreview")
    public String groupPreview(Model model, HttpServletRequest request, HttpSession session, String groupId,
            String pageNo) {
        try {
            GoodItemDto goodItemDto = goodsService.getGoodAllItemDtoForAdmin(groupId);
            //GoodItemDto goodItemDto = goodsService.getGroupAllItemDtoForPreview(groupId);

            // 后台维护的时候提示让以逗号隔开
            model.addAttribute("goodItemDto", goodItemDto);
            model.addAttribute("pageNo", pageNo);
            return "OZ_TT_AD_GP";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 商品团购删除
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/deleteGroup")
    @ResponseBody
    public Map<String, Object> deleteGroup(Model model, HttpServletRequest request, HttpSession session, String groupId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            TGoodsGroup tGoodsGroup = new TGoodsGroup();
            tGoodsGroup.setGroupno(groupId);
            tGoodsGroup = goodsService.getGoodPrice(tGoodsGroup);
            tGoodsGroup.setOpenflg(CommonEnum.GroupOpenFlag.DELETE.getCode());
            goodsService.updateGoodsSetGroup(tGoodsGroup);

            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 商品团购下架
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/cancelGroup")
    @ResponseBody
    public Map<String, Object> cancelGroup(Model model, HttpServletRequest request, HttpSession session, String groupId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            TGoodsGroup tGoodsGroup = new TGoodsGroup();
            tGoodsGroup.setGroupno(groupId);
            tGoodsGroup = goodsService.getGoodPrice(tGoodsGroup);
            tGoodsGroup.setOpenflg(CommonEnum.GroupOpenFlag.CLOSED.getCode());
            goodsService.updateGoodsSetGroup(tGoodsGroup);

            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

}
