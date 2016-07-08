package com.org.oztt.admin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TConsOrder;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.formDto.OzTtAdOdDto;
import com.org.oztt.formDto.OzTtAdOdListDto;
import com.org.oztt.formDto.OzTtAdOlDto;
import com.org.oztt.formDto.OzTtAdOlListDto;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.GoodsService;
import com.org.oztt.service.OrderService;

/**
 * 订单一览画面
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/OZ_TT_AD_OL")
public class OzTtAdOlController extends BaseController {

    @Resource
    private CommonService commonService;

    @Resource
    private OrderService  orderService;

    @Resource
    private GoodsService  goodsService;

    /**
     * 订单一览画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/init")
    public String init(Model model, HttpServletRequest request, HttpSession session) {

        try {
            model.addAttribute("orderSelect", commonService.getOrderStatus());
            model.addAttribute("paymentSelect", commonService.getPayment());
            model.addAttribute("deliverySelect", commonService.getDelivery());
            OzTtAdOlDto dto = new OzTtAdOlDto();
            dto.setDataFrom(DateFormatUtils.getNowTimeFormat(DateFormatUtils.PATTEN_YMD2));
            dto.setDataTo(DateFormatUtils.getNowTimeFormat(DateFormatUtils.PATTEN_YMD2));
            model.addAttribute("ozTtAdOlDto", dto);
            this.search(model, request, session, dto);
            return "OZ_TT_AD_OL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 订单一览检索画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/search")
    public String search(Model model, HttpServletRequest request, HttpSession session,
            @ModelAttribute OzTtAdOlDto ozTtAdOlDto) {
        try {
            model.addAttribute("orderSelect", commonService.getOrderStatus());
            model.addAttribute("paymentSelect", commonService.getPayment());
            model.addAttribute("deliverySelect", commonService.getDelivery());

            session.setAttribute("ozTtAdOlDto", ozTtAdOlDto);

            Pagination pagination = new Pagination(1);
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("customerPhone", ozTtAdOlDto.getCustomerPhone());
            params.put("nickName", ozTtAdOlDto.getNickName());
            params.put("orderNo", ozTtAdOlDto.getOrderNo());
            params.put("orderStatus", ozTtAdOlDto.getOrderStatus());
            params.put("payment", ozTtAdOlDto.getPayment());
            params.put("deliveryMethod", ozTtAdOlDto.getDeliveryMethod());
            params.put("dataFrom", ozTtAdOlDto.getDataFrom());
            params.put("dataTo", ozTtAdOlDto.getDataTo());
            pagination.setParams(params);
            PagingResult<OzTtAdOlListDto> pageInfo = orderService.getAllOrderInfoForAdmin(pagination);

            model.addAttribute("ozTtAdOlDto", ozTtAdOlDto);
            model.addAttribute("pageInfo", pageInfo);
            return "OZ_TT_AD_OL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 订单一览分页选择画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/pageSearch")
    public String pageSearch(Model model, HttpServletRequest request, HttpSession session, String pageNo) {
        try {
            OzTtAdOlDto ozTtAdOlDto = (OzTtAdOlDto) session.getAttribute("ozTtAdOlDto");

            model.addAttribute("orderSelect", commonService.getOrderStatus());
            model.addAttribute("paymentSelect", commonService.getPayment());
            model.addAttribute("deliverySelect", commonService.getDelivery());

            Pagination pagination = new Pagination(Integer.valueOf(pageNo));
            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("nickName", ozTtAdOlDto.getNickName());
            params.put("orderNo", ozTtAdOlDto.getOrderNo());
            params.put("orderStatus", ozTtAdOlDto.getOrderStatus());
            params.put("payment", ozTtAdOlDto.getPayment());
            params.put("deliveryMethod", ozTtAdOlDto.getDeliveryMethod());
            params.put("dataFrom", ozTtAdOlDto.getDataFrom());
            params.put("dataTo", ozTtAdOlDto.getDataTo());
            pagination.setParams(params);
            PagingResult<OzTtAdOlListDto> pageInfo = orderService.getAllOrderInfoForAdmin(pagination);

            model.addAttribute("ozTtAdOlDto", ozTtAdOlDto);
            model.addAttribute("pageInfo", pageInfo);
            return "OZ_TT_AD_OL";
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            return CommonConstants.ERROR_PAGE;
        }
    }

    /**
     * 订单一览分页选择画面
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/orderExport")
    public void orderExport(Model model, HttpServletRequest request, HttpSession session, HttpServletResponse response) {
        try {
            OzTtAdOlDto ozTtAdOlDto = (OzTtAdOlDto) session.getAttribute("ozTtAdOlDto");
            if (ozTtAdOlDto == null) {
                ozTtAdOlDto = new OzTtAdOlDto();
                ozTtAdOlDto.setDataFrom(DateFormatUtils.getNowTimeFormat(DateFormatUtils.PATTEN_YMD2));
                ozTtAdOlDto.setDataTo(DateFormatUtils.getNowTimeFormat(DateFormatUtils.PATTEN_YMD2));
            }

            Map<Object, Object> params = new HashMap<Object, Object>();
            params.put("nickName", ozTtAdOlDto.getNickName());
            params.put("orderNo", ozTtAdOlDto.getOrderNo());
            params.put("orderStatus", ozTtAdOlDto.getOrderStatus());
            params.put("payment", ozTtAdOlDto.getPayment());
            params.put("deliveryMethod", ozTtAdOlDto.getDeliveryMethod());
            params.put("dataFrom", ozTtAdOlDto.getDataFrom());
            params.put("dataTo", ozTtAdOlDto.getDataTo());
            List<OzTtAdOlListDto> pageInfo = orderService.getAllOrderInfoForAdminAll(params);
            createExcelAndExport(request, response, pageInfo);
        }
        catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    /**
     * 订单批量修改状态
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/updateBatchOrder")
    @ResponseBody
    public Map<String, Object> updateBatchOrder(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {

            String[] orderIdArr = map.get("orderIds").split(",");
            String status = map.get("status");
            for (String str : orderIdArr) {
                TConsOrder tConsOrder = orderService.selectByOrderId(str);
                
                tConsOrder.setUpdpgmid("OZ_TT_AD_GB");
                tConsOrder.setUpdtimestamp(new Date());
                tConsOrder.setUpduserkey(CommonConstants.ADMIN_USERKEY);
                if (CommonEnum.HandleFlag.DELETED.getCode().equals(status)
                        && CommonEnum.HandleFlag.PLACE_ORDER_SU.getCode().equals(tConsOrder.getHandleflg())
                        && (CommonEnum.PaymentMethod.PAY_INSTORE.getCode().equals(tConsOrder.getPaymentmethod()) || CommonEnum.PaymentMethod.COD
                                .getCode().equals(tConsOrder.getPaymentmethod()))) {
                    // 取消订单的时候
                    tConsOrder.setHandleflg(status);
                    orderService.deleteOrderInfoFormNotPay(tConsOrder);
                }
                else {
                    tConsOrder.setHandleflg(status);
                    orderService.updateOrderInfo(tConsOrder);
                }
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
     * 订单批量修改状态
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/canUpdateBatchOrder")
    @ResponseBody
    public Map<String, Object> canUpdateBatchOrder(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {

            String[] orderIdArr = map.get("orderIds").split(",");
            String canUpdate = "0";
            String canUpdate0 = "0";
            for (String str : orderIdArr) {
                TConsOrder tConsOrder = orderService.selectByOrderId(str);
                if(CommonEnum.HandleFlag.DELETED.getCode().equals(tConsOrder.getHandleflg())) {
                	canUpdate0 = "1";
                	break;
                } else {
                	canUpdate0 = "0";
                }
                // 只有订单是来店自提－到店付款或者送货上门－货到付款
                if (CommonEnum.PaymentMethod.ONLINE_PAY_CWB.getCode().equals(tConsOrder.getPaymentmethod())) {
                    canUpdate = "1";
                    break;
                } else {
                    canUpdate = "0";
                }

            }
            mapReturn.put("canUpdate", canUpdate);
            mapReturn.put("canUpdate0", canUpdate0);
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
     * 输出excel报表
     * 
     * @param request
     * @param response
     * @throws Exception
     */
    private void createExcelAndExport(HttpServletRequest request, HttpServletResponse response,
            List<OzTtAdOlListDto> list) throws Exception {
        String path = request.getSession().getServletContext().getRealPath("");
        String tempPath = path + getApplicationMessage("downloadTempPath");
        String fileName = getApplicationMessage("downloadOrderListName");

        // 获取模板
        File file = new File(tempPath + fileName);
        POIFSFileSystem poifs = new POIFSFileSystem(new FileInputStream(file));

        // 读取模板
        HSSFWorkbook wb = new HSSFWorkbook(poifs);

        // 这里值操作一个SHEET
        HSSFSheet sheet = wb.getSheetAt(0);

        HSSFCellStyle setBorder = wb.createCellStyle();
        // 画线
        setBorder.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        setBorder.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        setBorder.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        setBorder.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        HSSFCell cell = null;
        int number = 1;// 这里说明已经有两行了。
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                number++;
                HSSFRow row = sheet.createRow(number);

                cell = row.createCell(0);
                cell.setCellValue(i + 1);
                cell.setCellStyle(setBorder);

                cell = row.createCell(1);
                cell.setCellValue(list.get(i).getOrderNo());
                cell.setCellStyle(setBorder);

                cell = row.createCell(2);
                cell.setCellValue(list.get(i).getCustomerNo());
                cell.setCellStyle(setBorder);

                cell = row.createCell(3);
                cell.setCellValue(list.get(i).getNickName());
                cell.setCellStyle(setBorder);

                cell = row.createCell(4);
                cell.setCellValue(list.get(i).getOrderStatusView());
                cell.setCellStyle(setBorder);

                cell = row.createCell(5);
                cell.setCellValue(list.get(i).getOrderTime());
                cell.setCellStyle(setBorder);

                cell = row.createCell(6);
                cell.setCellValue(list.get(i).getPaymentMethod());
                cell.setCellStyle(setBorder);

                cell = row.createCell(7);
                cell.setCellValue(list.get(i).getDeliveryMethodView());
                cell.setCellStyle(setBorder);

                cell = row.createCell(8);
                cell.setCellValue(list.get(i).getOrderAmount());
                cell.setCellStyle(setBorder);

                cell = row.createCell(9);
                cell.setCellValue(list.get(i).getDeliveryCost());
                cell.setCellStyle(setBorder);

                //合计
                Double orderAmount = Double.valueOf(list.get(i).getOrderAmount().toString());
                Double deliveryCost = Double.valueOf(list.get(i).getDeliveryCost().toString());
                Double sumAmount = orderAmount + deliveryCost;
                cell = row.createCell(10);
                cell.setCellValue(sumAmount.toString());
                cell.setCellStyle(setBorder);

                //收货人
                cell = row.createCell(11);
                cell.setCellValue(list.get(i).getReceiver());
                cell.setCellStyle(setBorder);

                //联系电话
                cell = row.createCell(12);
                cell.setCellValue(list.get(i).getContactTel());
                cell.setCellStyle(setBorder);

                cell = row.createCell(13);
                cell.setCellValue(list.get(i).getAddress());
                cell.setCellStyle(setBorder);

                cell = row.createCell(14);
                cell.setCellValue(list.get(i).getAtHomeTime());
                cell.setCellStyle(setBorder);

                OzTtAdOdDto ozTtAdOdDto = orderService.getOrderDetailForAdmin(list.get(i).getOrderNo());

                if (ozTtAdOdDto != null && ozTtAdOdDto.getItemList() != null && ozTtAdOdDto.getItemList().size() > 0) {
                    for (OzTtAdOdListDto detail : ozTtAdOdDto.getItemList()) {
                        number++;
                        row = sheet.createRow(number);

                        cell = row.createCell(1);
                        cell.setCellValue(detail.getGoodsGroupId());
                        cell.setCellStyle(setBorder);

                        cell = row.createCell(2);
                        cell.setCellValue(detail.getGoodsId());
                        cell.setCellStyle(setBorder);

                        cell = row.createCell(3);
                        cell.setCellValue(detail.getGoodsName());
                        cell.setCellStyle(setBorder);

                        cell = row.createCell(4);
                        cell.setCellValue(detail.getGoodsPrice());
                        cell.setCellStyle(setBorder);

                        cell = row.createCell(5);
                        cell.setCellValue(detail.getGoodsQuantity());
                        cell.setCellStyle(setBorder);

                        cell = row.createCell(6);
                        cell.setCellValue(detail.getGoodsTotalAmount());
                        cell.setCellStyle(setBorder);
                    }
                }

            }
        }

        String type = "application/x-msdownload";
        response.setContentType(type);
        String downFileName = "OrderList.xls";
        String inlineType = "attachment"; // 是否内联附件
        response.setHeader("Content-Disposition", inlineType + ";filename=\"" + downFileName + "\"");

        // 将数据输出到RESPONSE中
        wb.write(response.getOutputStream());
        response.getOutputStream().flush();
        response.getOutputStream().close();

    }

}
