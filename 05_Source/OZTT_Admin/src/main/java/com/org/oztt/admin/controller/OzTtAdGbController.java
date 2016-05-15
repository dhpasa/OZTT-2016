package com.org.oztt.admin.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.formDto.OzTtAdGlListDto;
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
            List<OzTtAdGlListDto> dtoList = goodsService.getAllGoodsInfoForAdminNoPage();
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
    @RequestMapping(value = "/saveBatchGroup")
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
            tGoodsGroup.setGroupprice(new BigDecimal(map.get("groupprice")));
            tGoodsGroup.setOpenflg(map.get("openflg"));
            tGoodsGroup.setToppageup(map.get("istopup"));
            tGoodsGroup.setPreflg(map.get("ispre"));
            tGoodsGroup.setInstockflg(map.get("isinstock"));
            tGoodsGroup.setHotflg(map.get("ishot"));
            tGoodsGroup.setShopperrules(map.get("shopperrules"));
            tGoodsGroup.setValidperiodend(DateFormatUtils.string2DateWithFormat(map.get("validperiodend"),
                    DateFormatUtils.PATTEN_YMD2));
            tGoodsGroup.setValidperiodstart(DateFormatUtils.string2DateWithFormat(map.get("validperiodstart"),
                    DateFormatUtils.PATTEN_YMD2));
            // 插入操作
            tGoodsGroup.setUpdpgmid("OZ_TT_AD_GB");
            tGoodsGroup.setUpdtimestamp(new Date());
            tGoodsGroup.setUpduserkey(CommonConstants.ADMIN_USERKEY);
            String[] goodsIdArr = map.get("goodsid").split(",");
            for (String str : goodsIdArr) {
                TGoodsGroup insertDto = new TGoodsGroup();
                PropertyUtils.copyProperties(insertDto, tGoodsGroup);
                insertDto.setGoodsid(str);
                goodsService.saveGoodsSetGroup(insertDto);
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
