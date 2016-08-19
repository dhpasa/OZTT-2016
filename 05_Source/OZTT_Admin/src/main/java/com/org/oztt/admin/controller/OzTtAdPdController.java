package com.org.oztt.admin.controller;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

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
import com.org.oztt.entity.TGoods;
import com.org.oztt.formDto.OzTtAdGdDto;
import com.org.oztt.service.GoodsService;

/**
 * 商品详细画面
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_PD")
public class OzTtAdPdController extends BaseController {

    @Resource
    private GoodsService goodsService;

    /**
     * 商品详细画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session, String goodsId, String pageNo, String back) {
        try {
            if (StringUtils.isEmpty(goodsId) || StringUtils.isEmpty(pageNo)) {
                OzTtAdGdDto ozTtAdGdDto = new OzTtAdGdDto();
                ozTtAdGdDto.setHotSaleFlg("0");
                ozTtAdGdDto.setOnSaleFlg("1");
                ozTtAdGdDto.setNewSaleFlg("0");
                model.addAttribute("ozTtAdGdDto", ozTtAdGdDto);
            }
            else {
                TGoods tGoods = goodsService.getGoodsById(goodsId);
                OzTtAdGdDto ozTtAdGdDto = new OzTtAdGdDto();
                ozTtAdGdDto.setNo(tGoods.getNo());
                ozTtAdGdDto.setGoodsId(tGoods.getGoodsid());
                ozTtAdGdDto.setClassId(tGoods.getClassid());
                ozTtAdGdDto.setGoodsBrand(tGoods.getGoodsbrand());
                ozTtAdGdDto.setGoodsName(tGoods.getGoodsname());
                ozTtAdGdDto.setGoodsDesc(tGoods.getGoodsdesc());
                ozTtAdGdDto.setGoodsComments(tGoods.getGoodscomments());
                ozTtAdGdDto.setGoodsThumbnail(tGoods.getGoodsthumbnail());
                ozTtAdGdDto.setGoodsSmallPic(tGoods.getGoodssmallpic());
                ozTtAdGdDto.setGoodsNormalPic(tGoods.getGoodsnormalpic());
                ozTtAdGdDto.setOnSaleFlg(tGoods.getOnsaleflg());
                ozTtAdGdDto.setHotSaleFlg(tGoods.getHotsaleflg());
                ozTtAdGdDto.setNewSaleFlg(tGoods.getNewsaleflg());
                ozTtAdGdDto.setCostPrice(tGoods.getCostprice().toString());
                ozTtAdGdDto.setSortOrder(tGoods.getSortorder().toString());
                ozTtAdGdDto.setPageNo(Integer.valueOf(pageNo));
                model.addAttribute("ozTtAdGdDto", ozTtAdGdDto);
            }
            model.addAttribute("back", back);
            model.addAttribute("classficationList",
                    goodsService.getSecondClassfication(CommonConstants.BELONG_FATHER_CLASS));
            return "OZ_TT_AD_PD";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 商品保存
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/save")
    public String save(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtAdGdDto ozTtAdGdDto) {
        try {
            TGoods tGoods = new TGoods();
            tGoods.setNo(ozTtAdGdDto.getNo());
            tGoods.setGoodsid(ozTtAdGdDto.getGoodsId());
            tGoods.setClassid(ozTtAdGdDto.getClassId());
            tGoods.setGoodsbrand(ozTtAdGdDto.getGoodsBrand());
            tGoods.setGoodsbranden("");
            tGoods.setGoodsname(ozTtAdGdDto.getGoodsName());
            tGoods.setGoodsnameen("");
            tGoods.setGoodsdesc(ozTtAdGdDto.getGoodsDesc());
            tGoods.setGoodscomments(ozTtAdGdDto.getGoodsComments());
            tGoods.setGoodsthumbnail(ozTtAdGdDto.getGoodsThumbnail());
            tGoods.setGoodssmallpic(ozTtAdGdDto.getGoodsSmallPic());
            tGoods.setGoodsnormalpic(ozTtAdGdDto.getGoodsNormalPic());
            tGoods.setOnsaleflg(ozTtAdGdDto.getOnSaleFlg());
            tGoods.setHotsaleflg(ozTtAdGdDto.getHotSaleFlg());
            tGoods.setNewsaleflg(ozTtAdGdDto.getNewSaleFlg());
            tGoods.setDeleteflg(CommonConstants.IS_NOT_DELETE);
            tGoods.setCostprice(new BigDecimal(ozTtAdGdDto.getCostPrice()));
            tGoods.setSortorder(Integer.valueOf(ozTtAdGdDto.getSortOrder()));
            

            String distImgPath = super.getApplicationMessage("DistImgPath");
            if (tGoods.getNo() == null) {
                String goodId = goodsService.saveGoodsForAdmin(tGoods);
                tGoods.setGoodsid(goodId);
            }
            else {
                TGoods orignGoods = goodsService.getGoodsById(ozTtAdGdDto.getGoodsId());
                // 先将先前不用的图片删除
                if (!orignGoods.getGoodsthumbnail().equals(ozTtAdGdDto.getGoodsThumbnail())) {
                    CommonUtils.deleteFile(distImgPath + ozTtAdGdDto.getGoodsId() + CommonConstants.PATH_SPLIT
                            + orignGoods.getGoodsthumbnail());
                }
                // 取的不用的缩略图
                String[] preNormalPicArr = orignGoods.getGoodsnormalpic().split(",");
                List<String> needDeleteFile = new ArrayList<String>();
                for (int i = 0; i < preNormalPicArr.length; i++) {
                    if (!ozTtAdGdDto.getGoodsNormalPic().contains(preNormalPicArr[i])) {
                        needDeleteFile.add(preNormalPicArr[i]);
                    }
                }
                for (int i = 0; i < needDeleteFile.size(); i++) {
                    CommonUtils.deleteFile(distImgPath + ozTtAdGdDto.getGoodsId() + CommonConstants.PATH_SPLIT
                            + needDeleteFile.get(i));
                }
                goodsService.updateGoodsForAdmin(tGoods);
            }

            // 更新数据库后将数据
            String goodId = tGoods.getGoodsid();
            String orginPath = System.getProperty("java.io.tmpdir") + CommonConstants.PATH_SPLIT
                    + CommonConstants.OZTT_ADMIN_PROJECT;
            String destPath = distImgPath + goodId;
            File fileDictory = new File(destPath);
            if (!fileDictory.exists()) {
                fileDictory.mkdirs();
            }
            // 复制商品缩略图
            CommonUtils.copyFile(orginPath + CommonConstants.PATH_SPLIT + tGoods.getGoodsthumbnail(), destPath
                    + CommonConstants.PATH_SPLIT + tGoods.getGoodsthumbnail());

            // 复制商品图
            String[] normalPicArr = tGoods.getGoodsnormalpic().split(",");
            for (int i = 0; i < normalPicArr.length; i++) {
                CommonUtils.copyFile(orginPath + CommonConstants.PATH_SPLIT + normalPicArr[i], destPath
                        + CommonConstants.PATH_SPLIT + normalPicArr[i]);
            }

            if (StringUtils.isEmpty(ozTtAdGdDto.getNo())) {
                return "redirect:/OZ_TT_AD_PL/init";
            }
            else {
                return "redirect:/OZ_TT_AD_PL/pageSearch?pageNo=" + ozTtAdGdDto.getPageNo();
            }

        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

}
