package com.org.oztt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.org.oztt.base.common.MyCategroy;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TGoods;
import com.org.oztt.entity.TGoodsClassfication;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.GoodsService;

@Controller
@RequestMapping("/OZ_TT_TP_PL")
public class OzTtTpPlController extends BaseController {

    @Resource
    private CustomerService customerService;

    @Resource
    private GoodsService    goodsService;

    /**
     * 商品一览画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "init", method = RequestMethod.GET)
    public String init(Model model, String classId, String page, String listCount) {
        try {
            // 获取目录
            List<MyCategroy> myCategroyList = super.commonService.getMyCategroy();
            model.addAttribute("menucategory", myCategroyList);

            String imgUrl = super.getApplicationMessage("saveImgUrl");

            // 取得热卖的产品
            TGoods tGoodsParam = new TGoods();
            tGoodsParam.setDeleteflg(CommonConstants.IS_NOT_DELETE);
            tGoodsParam.setOnsaleflg(CommonConstants.IS_ON_SALE);
            tGoodsParam.setHotsaleflg(CommonConstants.IS_HOT_SALE);
            List<GroupItemDto> hotSellerList = goodsService.getFiveHotSeller(tGoodsParam);
            if (!CollectionUtils.isEmpty(hotSellerList)) {
                for (GroupItemDto goods : hotSellerList) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + goods.getGoodsthumbnail());
                }
            }
            // 取出
            String className = "";
            if (!StringUtils.isEmpty(classId)) {
                TGoodsClassfication tGoodsClassfication = goodsService.getGoodsClassficationByClassId(classId);
                className = tGoodsClassfication.getClassname();
                // 二级结构
                tGoodsClassfication = goodsService.getGoodsClassficationByClassId(tGoodsClassfication.getFatherclassid());
                if (tGoodsClassfication != null) {
                    className = tGoodsClassfication.getClassname() + CommonConstants.LEFT_INDICATE + className;
                }
                // 三级结构
//                tGoodsClassfication = goodsService.getGoodsClassficationByClassId(tGoodsClassfication.getFatherclassid());
//                if (tGoodsClassfication != null) {
//                    className = tGoodsClassfication.getClassname() + CommonConstants.LEFT_INDICATE + className;
//                }
                
                
                
            }
            
            // 分页获取商品
            // 获取明细分类的数据
            Pagination pagination = null;
            if (StringUtils.isEmpty(page)) page = "1";
            if (StringUtils.isEmpty(listCount)) {
                pagination = new Pagination(1, CommonConstants.PRODUCT_INIT_COUNT);
                listCount = String.valueOf(CommonConstants.PRODUCT_INIT_COUNT);
            } else {
                pagination = new Pagination(Integer.parseInt(page), Integer.parseInt(listCount));
            }
            Map<Object, Object> mapParam = new HashMap<Object, Object>();
            mapParam.put("classId", classId);
            pagination.setParams(mapParam);
            
            PagingResult<GroupItemDto> pageInfo = goodsService.getGoodsByParamForPage(pagination);
            
            if (!CollectionUtils.isEmpty(pageInfo.getResultList())) {
                for (GroupItemDto goods : pageInfo.getResultList()) {
                    goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + goods.getGoodsthumbnail());
                }
            }

            // 热卖的商品
            model.addAttribute("hotSellerList", hotSellerList);
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("className", className);
            model.addAttribute("classId", classId);
            model.addAttribute("listCount", listCount);

            return "/OZ_TT_TP_PL";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    
    /**
     * 画面点击链接进行检索
     * @param model
     * @param classId
     * @param page
     * @param listCount
     * @return
     */
    @RequestMapping(value = "search", method = RequestMethod.GET)
    public String search(Model model, @RequestParam String listCount, @RequestParam String classId, @RequestParam String pageNo) {
        try {
            return this.init(model, classId, pageNo, listCount);  
        }catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
