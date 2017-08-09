/**
 * 
 */
package com.org.oztt.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import sun.misc.BASE64Decoder;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.DeliveryInfoCrawler;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSysConfig;
import com.org.oztt.formDto.PowderBoxInfo;
import com.org.oztt.formDto.PowderOrderInfo;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.OrderService;
import com.org.oztt.service.PowderService;
import com.org.oztt.service.SysConfigService;

/**
 * @author la-lin
 */

@Controller
@RequestMapping("/powderOrder")
public class PowderOrderListControler extends BaseController {

    @Resource
    private PowderService   powderService;

    @Resource
    private CustomerService customerService;

    @Resource
    private OrderService    orderService;
    
    @Resource
    private SysConfigService sysConfigService;

    @RequestMapping(value = "/init", method = RequestMethod.GET)
    public String orders(Model model, HttpServletRequest request) throws Exception {
        String tab = request.getParameter("tab");
        if (!StringUtils.isEmpty(tab)) {
            model.addAttribute("tab", tab);
        }
        return "/powderOrdersList";
    }

    @RequestMapping(value = "/initList", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> orders(HttpServletRequest request, HttpSession session, String pageNo) {
        Map<String, Object> resp = new HashMap<String, Object>();
        try {
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (StringUtils.isEmpty(customerNo)) {
                resp.put("isException", true);
                return resp;
            }
            TCustomerBasicInfo customerBaseInfo = customerService.selectBaseInfoByCustomerNo(customerNo);
            String status = request.getParameter("orderStatus");
            if (StringUtils.isEmpty(pageNo)) {
                pageNo = "1";
            }
            Pagination pagination = new Pagination(Integer.parseInt(pageNo));
            pagination.setSize(10);
            Map<Object, Object> paramMap = new HashMap<Object, Object>();
            paramMap.put("customerId", customerBaseInfo.getNo().toString());
            paramMap.put("status", status);
            pagination.setParams(paramMap);
            PagingResult<PowderOrderInfo> orderListPage = powderService.getPowderOrderPageInfo(pagination);
            resp.put("isException", false);

            resp.put("orderList", orderListPage.getResultList());
            return resp;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            resp.put("isException", true);
            return resp;
        }
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String order(@PathVariable String id, Model model, HttpServletRequest request) {
        try {
            PowderBoxInfo detail = powderService.getPowderInfoById(Long.valueOf(id));
            String tab = request.getParameter("tab");
            if (!StringUtils.isEmpty(tab)) {
                model.addAttribute("tab", tab);
            }
            model.addAttribute("detailInfo", detail);
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
        }
        return "/powderOrderItem";
    }

    /**
     * 跳转到支付画面
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/toCWLPay")
    public String toCWLPay(Model model, HttpServletResponse response, HttpSession session, String orderId) {
        try {
            model.addAttribute("orderNo", orderId);
            // 取得订单的金额
            TPowderOrder detail = powderService.getTPowderOrderByOrderNo(orderId);
            String amount = detail.getSumAmount().toString();
            model.addAttribute("amount", amount);
            TSysConfig sysconfig = sysConfigService.getTSysConfigInRealTime();
            
            if (sysconfig != null && sysconfig.getMasterCardFee() != null) {
                model.addAttribute("amount",detail.getSumAmount().add(detail.getSumAmount().multiply(sysconfig.getMasterCardFee()).setScale(2, BigDecimal.ROUND_HALF_UP)).toString());
            }
            
            model.addAttribute("leftTime", DateFormatUtils.getTimeBetNowACreate(detail.getUpdTimestamp()));
            return "paymentPowderOrder";
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            return CommonConstants.ERROR_PAGE;
        }
    }
    
    /**
     * 更新身份证信息
     * @param request
     * @param session
     * @param type
     * @param receiveId
     * @param dataMap
     * @return
     */
    @RequestMapping(value = "/updateCard")
    public Map<String, Object> updateCard(HttpServletRequest request, HttpSession session, String receiveId,
            @RequestBody Map<String, String> dataMap) {
        Map<String, Object> resp = new HashMap<String, Object>();
        try {
            String cardNo = dataMap.get("cardNo");
        
            // 将文件名称保存到数据库中
            TReceiverInfo tReceiverInfo = powderService.getReveiverInfo(Long.valueOf(receiveId));
            tReceiverInfo.setReceiverIdCardNo(cardNo);
            powderService.updateReveiverInfo(tReceiverInfo);
            resp.put("isException", false);
            return resp;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            resp.put("isException", true);
            return resp;
        }
    }

    /**
     * 上传图片
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/addImage")
    public Map<String, Object> addImage(HttpServletRequest request, HttpSession session, String type, String receiveId,
            @RequestBody Map<String, String> dataMap) {
        Map<String, Object> resp = new HashMap<String, Object>();
        try {
            String base64StrImgData = dataMap.get("base64StrImgData");

            if (!StringUtils.isEmpty(base64StrImgData)) {
                // 创建图片路径
                // 生成jpeg图片
                String desFileName = UUID.randomUUID().toString() + CommonConstants.IMG_TYPE_PNG;
                String desFilePath = super.getApplicationMessage("DistImgPath", session) + CommonConstants.ID_CARD;
                String desFilePathName = desFilePath + CommonConstants.PATH_SPLIT + desFileName;
                BASE64Decoder decoder = new BASE64Decoder();
                File destDirectory = new File(desFilePath);
                if (!destDirectory.exists()) {
                    destDirectory.mkdir();
                }
                try {
                    // Base64解码
                    byte[] b = decoder.decodeBuffer(base64StrImgData);
                    for (int i = 0; i < b.length; ++i) {
                        if (b[i] < 0) { //调整异常数据
                            b[i] += 256;
                        }
                    }
                    OutputStream out = new FileOutputStream(desFilePathName);
                    out.write(b);
                    out.flush();
                    out.close();
                }
                catch (Exception e) {
                }

                // 将文件名称保存到数据库中
                TReceiverInfo tReceiverInfo = powderService.getReveiverInfo(Long.valueOf(receiveId));
                if (tReceiverInfo != null) {
                    String phoneUrl = tReceiverInfo.getReceiverIdCardPhotoUrls() == null ? "" : tReceiverInfo.getReceiverIdCardPhotoUrls();
                    String[] phoneArr = phoneUrl.split("\\|");
                    int cardLength = phoneUrl == null ? 0 : phoneArr.length;
                    if ("0".equals(type)) {
                        // 将身份证前面的照片路径替换掉
                        if (cardLength > 1) {
                            // 将前面的替换掉
                            phoneArr[0] = desFileName;
                            tReceiverInfo.setReceiverIdCardPhotoUrls(org.apache.commons.lang.StringUtils.join(phoneArr,
                                    '|'));
                            powderService.updateReveiverInfo(tReceiverInfo);
                        }
                        else {
                            tReceiverInfo.setReceiverIdCardPhotoUrls(desFileName + "| ");
                            powderService.updateReveiverInfo(tReceiverInfo);
                        }
                    }
                    else {
                        // 将身份证后面的照片路径替换掉
                        if (cardLength > 1) {
                            // 将前面的替换掉
                            phoneArr[1] = desFileName;
                            tReceiverInfo.setReceiverIdCardPhotoUrls(org.apache.commons.lang.StringUtils.join(phoneArr,
                                    '|'));
                            powderService.updateReveiverInfo(tReceiverInfo);
                        }
                        else {
                            tReceiverInfo.setReceiverIdCardPhotoUrls(" |" + desFileName);
                            powderService.updateReveiverInfo(tReceiverInfo);
                        }
                    }
                }
            }
            resp.put("isException", false);

            return resp;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            resp.put("isException", true);
            return resp;
        }
    }
    
    
    /**
     * 获取物流信息
     * @param request
     * @param session
     * @param type
     * @param receiveId
     * @param dataMap
     * @return
     */
    @RequestMapping(value = "/getExpressInfo")
    public Map<String, Object> getExpressInfo(HttpServletRequest request, HttpSession session, String expressEleNo, String boxId) {
        Map<String, Object> resp = new HashMap<String, Object>();
        try {
            List<String> strList = new ArrayList<String>();
            String s = PowderOrderListControler.class.getResource("/").getPath().toString();
            s = java.net.URLDecoder.decode(s, "UTF-8");
            PowderBoxInfo boxInfo = powderService.getPowderInfoById(Long.valueOf(boxId));
            DeliveryInfoCrawler diCrawler = null;
            if (CommonConstants.EXPRESS_BLUE_SKY.equals(boxInfo.getDeliverId())) {
                diCrawler = new DeliveryInfoCrawler(s + "bluesky.properties");
            } else if (CommonConstants.EXPRESS_FREAK_QUICK.equals(boxInfo.getDeliverId())){
                diCrawler = new DeliveryInfoCrawler(s + "freakyquick.properties");
            } else if (CommonConstants.EXPRESS_LONGMEN.equals(boxInfo.getDeliverId())){
                diCrawler = new DeliveryInfoCrawler(s + "longmen.properties");
            } else if (CommonConstants.EXPRESS_SUPIN.equals(boxInfo.getDeliverId())){
                diCrawler = new DeliveryInfoCrawler(s + "supin.properties");
            }
            LinkedHashMap<String, String> infos = diCrawler.getDeliveryInfo(expressEleNo);
            for (Entry<String, String> info : infos.entrySet()) {
                strList.add(info.getKey() + "   " + info.getValue());
            }
            // 将物流信息返回画面
            resp.put("expressInfo", strList);
            resp.put("isException", false);
            return resp;
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("message", e);
            resp.put("isException", true);
            return resp;
        }
    }
}
