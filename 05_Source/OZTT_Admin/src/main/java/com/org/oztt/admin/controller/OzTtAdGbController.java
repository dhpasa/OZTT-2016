package com.org.oztt.admin.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.formDto.OzTtAdGcListDto;
import com.org.oztt.service.GoodsService;

/**
 * 
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_GB")
public class OzTtAdGbController extends BaseController {

    @Resource
    private GoodsService goodsService;
    /**
     * 批量团购
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session) {
        try {
            List<OzTtAdGcListDto> dtoList = goodsService.getAllGroupsInfoForAdminNoPage();
            model.addAttribute("goodsList", dtoList);
            return "OZ_TT_AD_GB";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 产品团购保存
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/updateBatchGroup")
    @ResponseBody
    public Map<String, Object> updateBatchGroup(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            
            String[] goodsIdArr = map.get("groupIds").split(",");
            for (String str : goodsIdArr) {

                TGoodsGroup tGoodsGroup = new TGoodsGroup();
                tGoodsGroup.setGroupno(str);
                tGoodsGroup = goodsService.getGoodPrice(tGoodsGroup);

                if (!StringUtils.isEmpty(map.get("istopup"))) {
                    tGoodsGroup.setToppageup(map.get("istopup"));
                }
                
                if (!StringUtils.isEmpty(map.get("ispre"))) {
                    tGoodsGroup.setPreflg(map.get("ispre"));
                }
                
                if (!StringUtils.isEmpty(map.get("isinstock"))) {
                    tGoodsGroup.setInstockflg(map.get("isinstock"));
                }
                
                if (!StringUtils.isEmpty(map.get("ishot"))) {
                    tGoodsGroup.setHotflg(map.get("ishot"));
                }
                
                if (!StringUtils.isEmpty(map.get("ishot"))) {
                    tGoodsGroup.setHotflg(map.get("ishot"));
                }
                
                if (!StringUtils.isEmpty(map.get("isdiamond"))) {
                    tGoodsGroup.setDiamondshowflg(map.get("isdiamond"));
                }
                
                if (!StringUtils.isEmpty(map.get("isen"))) {
                    tGoodsGroup.setEnshowflg(map.get("isen"));
                }
                
                if (!StringUtils.isEmpty(map.get("validperiodend"))) {
                    tGoodsGroup.setValidperiodend(DateFormatUtils.string2DateWithFormat(map.get("validperiodend"),
                            DateFormatUtils.PATTEN_HM));
                }
                
                if (!StringUtils.isEmpty(map.get("validperiodstart"))) {
                    tGoodsGroup.setValidperiodstart(DateFormatUtils.string2DateWithFormat(map.get("validperiodstart"),
                            DateFormatUtils.PATTEN_HM));
                }
                
                if (!StringUtils.isEmpty(map.get("maxnumber"))) {
                    tGoodsGroup.setGroupmaxquantity(Long.valueOf(map.get("maxnumber")));
                }
                
                if (!StringUtils.isEmpty(map.get("maxbuy"))) {
                    tGoodsGroup.setGroupquantitylimit(Long.valueOf(map.get("maxbuy")));
                }
                
                if (!StringUtils.isEmpty(map.get("ifopen"))) {
                    tGoodsGroup.setOpenflg(map.get("ifopen"));
                }
                
                // 更新操作
                tGoodsGroup.setUpdpgmid("OZ_TT_AD_GB");
                tGoodsGroup.setUpdtimestamp(new Date());
                tGoodsGroup.setUpduserkey(CommonConstants.ADMIN_USERKEY);
                goodsService.updateGoodsSetGroup(tGoodsGroup);
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


}
