package com.org.oztt.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.org.oztt.dao.TPowderOrderDao;
import com.org.oztt.dao.TPowderOrderDetailsDao;
import com.org.oztt.dao.TProductOrderDao;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.entity.TProductOrder;
import com.org.oztt.formDto.OrderDetailViewBoxDto;
import com.org.oztt.formDto.OrderDetailViewDto;
import com.org.oztt.formDto.OrderDetailViewProductDto;
import com.org.oztt.formDto.PowderBoxInfo;
import com.org.oztt.formDto.PowderMilkInfo;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.PowderService;
import com.org.oztt.service.ProductService;

@Service
public class ProductServiceImpl extends BaseService implements ProductService {

    @Resource
    private PowderService powderService;
    
    @Resource
    private TPowderOrderDetailsDao tPowderOrderDetailsDao;
    
    @Resource
    private TPowderOrderDao tPowderOrderDao;
    
    @Resource
    private TProductOrderDao tProductOrderDao;
    
    
    @Override
    public OrderDetailViewDto getOrderDetail(String orderNo, String orderFlg) throws Exception {
        
        OrderDetailViewDto viewDto = new OrderDetailViewDto();
        viewDto.setPowderOrProductFlg(orderFlg);
        if ("1".equals(orderFlg)) {
            //奶粉
            TPowderOrder order = tPowderOrderDao.selectByPrimaryKey(Long.valueOf(orderNo));
            viewDto.setOrderNo(order.getOrdreNo());
            viewDto.setOrderDate(order.getOrderDate());
            viewDto.setOrderDesc(order.getRemarks());
            viewDto.setOrderStatus(order.getStatus());
            // 运费补差
            viewDto.setYunfeicha("8.88");
            
            // 当前订单下的所有商品
            List<PowderMilkInfo> milkList = tPowderOrderDetailsDao.selectPowderDetailsListByOrderNo(orderNo);
            List<OrderDetailViewProductDto> productList = new ArrayList<OrderDetailViewProductDto>();
            
            BigDecimal productSum = BigDecimal.ZERO;
            for (PowderMilkInfo milk : milkList) {
                OrderDetailViewProductDto productDto = new OrderDetailViewProductDto();
                productDto.setProductName(milk.getPowderBrand() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + milk.getPowderSpec() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X" + milk.getNumber());
                productDto.setProductPrice(new BigDecimal(milk.getPowderPrice()).
                        multiply(new BigDecimal(milk.getNumber())).toString()); 
                productList.add(productDto);
                
                productSum = productSum.add(new BigDecimal(milk.getPowderPrice()).
                        multiply(new BigDecimal(milk.getNumber())));
            }
            // 商品列表
            viewDto.setProductList(productList);
            
            // 商品总价
            viewDto.setProductAmountSum(productSum.toString());
            // 运费（国际快递）
            viewDto.setYunfei(order.getSumAmount().subtract(productSum).toString());
            // 订单总价
            viewDto.setOrderAmountSum(order.getSumAmount().toString());
            
            // 获取所有的快递包裹
            List<PowderBoxInfo> boxInfoList = powderService.getPowderBoxListByOrderNo(orderNo);
            List<OrderDetailViewBoxDto> boxList = new ArrayList<OrderDetailViewBoxDto>();
            
            for (PowderBoxInfo box : boxInfoList) {
                OrderDetailViewBoxDto boxDto = new OrderDetailViewBoxDto(); 
                boxDto.setElecExpressNo(box.getElecExpressNo());
                boxDto.setExpressPhotoUrlExitFlg(box.getExpressPhotoUrlExitFlg());
                boxDto.setExpressPhotoUrl(box.getExpressPhotoUrl());
                boxDto.setReceivecardId(box.getReceiveIdCard());
                boxDto.setReceiveCardPhoneAf(box.getReceiveCardPhoneAf());
                boxDto.setReceiveCardPhoneBe(box.getReceiveCardPhoneBe());
                boxDto.setReceiveName(box.getReceiveName());
                boxDto.setOrderStatusView(box.getOrderStatusView());
                boxDto.setReceiveId(box.getReceiveId());
                boxDto.setStatus(box.getStatus());
                boxDto.setBoxId(box.getBoxId());
                boxList.add(boxDto);
            }
            viewDto.setBoxList(boxList);
            
        } else {
            // 保健品
            TProductOrder tProductOrder = tProductOrderDao.selectByPrimaryKey(Long.valueOf(orderNo));
            
            
            viewDto.setOrderNo(tProductOrder.getOrdreNo());
            viewDto.setOrderDate(tProductOrder.getOrderDate());
            viewDto.setOrderDesc(tProductOrder.getRemarks());
            viewDto.setOrderStatus(tProductOrder.getStatus());
            // 运费补差
            viewDto.setYunfeicha("8.88");
            
            // 当前订单下的所有商品
            List<PowderMilkInfo> milkList = tPowderOrderDetailsDao.selectPowderDetailsListByOrderNo(orderNo);
            List<OrderDetailViewProductDto> productList = new ArrayList<OrderDetailViewProductDto>();
            
            
        }
        
        return viewDto;
    }


    @Override
    public int getOrderCount(String orderStatus, String customerNo) throws Exception {
        Map<Object, Object> map = new HashMap<Object, Object>();
        map.put("customerId", customerNo);
        map.put("status", orderStatus);
        return tPowderOrderDao.getPowderAndProductOrder(map);
    }

}
