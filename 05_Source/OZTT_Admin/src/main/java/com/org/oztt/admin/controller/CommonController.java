package com.org.oztt.admin.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.service.GoodsService;

/**
 * 定义一些共同的控制器，实现共同的操作
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/COMMON")
public class CommonController extends BaseController {

    @Resource
    private GoodsService goodsService;

    /**
     * 得到产品信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getGoodsItem")
    public Map<String, Object> getCurrentItem(HttpServletRequest request, HttpSession session,
            @RequestParam String goodsId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {

            GoodItemDto goodItemDto = goodsService.getGoodAllItemDto(goodsId);

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("goodItemDto", goodItemDto);
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
     * 得到产品信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/deleteFile")
    public Map<String, Object> deleteFile(HttpServletRequest request, HttpSession session, String fileId, String goodId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            //            TGoods tGoods = goodsService.getGoodsById(goodId);
            //            if (tGoods != null) {
            //                tGoods.setGoodsnormalpic(tGoods.getGoodsnormalpic().replace("," + fileId, "").replace(fileId + ",", "")
            //                        .replace(fileId, ""));
            //                tGoods.setUpdpgmid("COMMON");
            //                tGoods.setUpdtimestamp(new Date());
            //                tGoods.setUpduserkey(CommonConstants.ADMIN_USERKEY);
            //                goodsService.updateGoodsForAdmin(tGoods);
            //            }
            //            CommonUtils.deleteFile(super.getApplicationMessage("DistImgPath") + goodId + "/" + fileId);
            mapReturn.put("fileId", fileId);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return null;
        }
    }

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadFile(HttpServletRequest request, HttpServletResponse response,
            @RequestParam MultipartFile file, String goodId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            //获取文件到map容器中  
            String filename = file.getOriginalFilename();
            String fileType = filename.substring(filename.lastIndexOf(CommonConstants.FILE_SPLIT));
            String uid = "OZTT" + "_" + DateFormatUtils.getNowTimeFormat(DateFormatUtils.PATTEN_YMD_HH_MM_SS_SSS_SEPRATE) + random.nextInt(10);
            String tempUrl = System.getProperty("java.io.tmpdir");
            String fileFullPath = tempUrl + CommonConstants.PATH_SPLIT + CommonConstants.OZTT_ADMIN_PROJECT
                    + CommonConstants.PATH_SPLIT + uid + fileType;
            File destDirectory = new File(tempUrl + CommonConstants.PATH_SPLIT + CommonConstants.OZTT_ADMIN_PROJECT);
            if (!destDirectory.exists()) {
                destDirectory.mkdirs();
            }
            file.transferTo(new File(fileFullPath));
            mapReturn.put("fileId", uid + fileType);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return null;
        }

    }

    /**
     * 删除缩略图信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/deleteThumbFile")
    public Map<String, Object> deleteThumbFile(HttpServletRequest request, HttpSession session, String fileId,
            String goodId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            //            TGoods tGoods = goodsService.getGoodsById(goodId);
            //            if (tGoods != null) {
            //                tGoods.setGoodsthumbnail(fileId);
            //                tGoods.setUpdpgmid("COMMON");
            //                tGoods.setUpdtimestamp(new Date());
            //                tGoods.setUpduserkey(CommonConstants.ADMIN_USERKEY);
            //                goodsService.updateGoodsForAdmin(tGoods);
            //            }
            //            CommonUtils.deleteFile(super.getApplicationMessage("DistImgPath") + goodId + "/" + fileId);
            mapReturn.put("fileId", fileId);
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
