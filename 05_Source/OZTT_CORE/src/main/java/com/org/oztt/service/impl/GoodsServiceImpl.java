package com.org.oztt.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.dao.TConsCartDao;
import com.org.oztt.dao.TGoodsAppendItemsDao;
import com.org.oztt.dao.TGoodsClassficationDao;
import com.org.oztt.dao.TGoodsDao;
import com.org.oztt.dao.TGoodsGroupDao;
import com.org.oztt.dao.TGoodsPriceDao;
import com.org.oztt.dao.TGoodsPropertyDao;
import com.org.oztt.entity.TGoods;
import com.org.oztt.entity.TGoodsAppendItems;
import com.org.oztt.entity.TGoodsClassfication;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.entity.TGoodsPrice;
import com.org.oztt.entity.TGoodsProperty;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.formDto.GoodProertyDto;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.GoodsService;

@Service
public class GoodsServiceImpl extends BaseService implements GoodsService {

    @Resource
    private TGoodsDao              tGoodsDao;

    @Resource
    private TGoodsClassficationDao tGoodsClassficationDao;

    @Resource
    private TGoodsPriceDao         tGoodsPriceDao;

    @Resource
    private TGoodsGroupDao         tGoodsGroupDao;

    @Resource
    private TGoodsPropertyDao      tGoodsPropertyDao;

    @Resource
    private TGoodsAppendItemsDao   tGoodsAppendItemsDao;

    @Resource
    private TConsCartDao           tConsCartDao;

    public TGoods getGoodsById(String goodsId) throws Exception {
        return tGoodsDao.selectByGoodsId(goodsId);
    }

    public List<TGoods> getGoodsByParam(TGoods tGoods) throws Exception {
        return tGoodsDao.selectByParams(tGoods);
    }

    public List<TGoods> getFirstThreeNewArravail() throws Exception {
        return tGoodsDao.getFirstThreeNewArravail();
    }

    public List<TGoods> getAllNewArravail() throws Exception {
        return tGoodsDao.getAllNewArravail();
    }

    public List<TGoods> getGoodsListForMain(Map<String, String> map) throws Exception {
        return tGoodsDao.getGoodsListForMain(map);
    }

    public TGoodsClassfication getGoodsClassficationByClassId(String classId) throws Exception {
        return tGoodsClassficationDao.getGoodsClassficationByClassId(classId);
    }

    public PagingResult<TGoods> getGoodsByParamForPage(Pagination pagination) throws Exception {
        return tGoodsDao.getGoodsByParamForPage(pagination);
    }

    @Override
    public TGoodsPrice getGoodPrice(TGoodsPrice tGoodsPrice) throws Exception {
        return tGoodsPriceDao.selectByParams(tGoodsPrice);
    }

    @Override
    public TGoodsGroup getGoodPrice(TGoodsGroup tGoodsGroup) throws Exception {
        return tGoodsGroupDao.selectByParams(tGoodsGroup);
    }

    @Override
    public List<TGoodsProperty> getGoodsProperty(TGoodsProperty tGoodsProperty) throws Exception {
        return tGoodsPropertyDao.selectByParams(tGoodsProperty);
    }

    @Override
    public TGoodsAppendItems getGoodsAppendItems(TGoodsAppendItems tGoodsAppendItems) throws Exception {
        return tGoodsAppendItemsDao.selectByParams(tGoodsAppendItems);
    }

    @Override
    public GoodItemDto getGoodAllItemDto(String goodId) throws Exception {
        // 取得当前商品的所有属性
        TGoods goods = getGoodsById(goodId);
        // 原价   商品定价策略表中
        TGoodsPrice tGoodsPrice = new TGoodsPrice();
        tGoodsPrice.setGoodsid(goodId);
        tGoodsPrice.setOpenflg(CommonConstants.OPEN_FLAG);
        tGoodsPrice = getGoodPrice(tGoodsPrice);
        // 折扣价  团购这张表中
        TGoodsGroup tGoodsGroup = new TGoodsGroup();
        tGoodsGroup.setGoodsid(goodId);
        tGoodsGroup.setOpenflg(CommonConstants.OPEN_FLAG);
        tGoodsGroup = getGoodPrice(tGoodsGroup);

        // 属性（比如：size，颜色）
        // 商品扩展属性定义这张表中
        List<GoodProertyDto> propertiesFormList = new ArrayList<GoodProertyDto>();
        TGoodsProperty tGoodsProperty = new TGoodsProperty();
        tGoodsProperty.setGoodsid(goodId);
        tGoodsProperty.setOpenflg(CommonConstants.OPEN_FLAG);
        List<TGoodsProperty> properties = getGoodsProperty(tGoodsProperty);
        if (!CollectionUtils.isEmpty(properties)) {
            for (TGoodsProperty property : properties) {
                TGoodsAppendItems tGoodsAppendItems = new TGoodsAppendItems();
                tGoodsAppendItems.setItemid(property.getGoodsclassid());
                tGoodsAppendItems.setOpenflg(CommonConstants.OPEN_FLAG);
                tGoodsAppendItems = getGoodsAppendItems(tGoodsAppendItems);

                GoodProertyDto proDto = new GoodProertyDto();
                proDto.setGoodsPropertiesId(property.getGoodsclassid());
                proDto.setGoodsPropertiesName(tGoodsAppendItems.getDisplayname());
                proDto.setGoodsPropertiesType(tGoodsAppendItems.getInputtype());
                proDto.setGoodsPropertiesJson(property.getGoodsclassvalue());

                propertiesFormList.add(proDto);
            }
        }

        String imgUrl = MessageUtils.getApplicationMessage("saveImgUrl");
        // 获取商品的图片
        List<String> goodPicList = new ArrayList<String>();
        if (goods.getGoodsnormalpic() != null) {
            String[] goodsPic = goods.getGoodsnormalpic().split(",");
            if (goodsPic != null && goodsPic.length > 0) {
                for (String pic : goodsPic) {
                    goodPicList.add(imgUrl + pic);
                }
            }
        }

        GoodItemDto goodItemDto = new GoodItemDto();
        goodItemDto.setGoods(goods);
        goodItemDto.setFirstImg((goodPicList != null && goodPicList.size() > 0) ? goodPicList.get(0) : "");
        goodItemDto.setImgList(goodPicList);
        goodItemDto.setNowPrice(tGoodsPrice.getGoodsclassvalue().toString());
        goodItemDto.setDisPrice(tGoodsGroup.getGroupprice().toString());
        goodItemDto.setProductInfo(tGoodsGroup.getGroupcomments());
        goodItemDto.setProductDesc(tGoodsGroup.getGroupdesc());
        goodItemDto.setSellerRule(tGoodsGroup.getShopperrules());
        goodItemDto.setProperties(JSON.toJSONString(propertiesFormList));

        return goodItemDto;
    }

    @SuppressWarnings("unchecked")
    @Override
    public boolean addContCart(String customerNo, List list) throws Exception {
        if (list == null)
            return false;
        for (int i = 0; i < list.size(); i++) {
            Map<String, String> map = (Map<String, String>) list.get(i);
            String goodId = map.get("goodId");
            String customer = map.get("customerNo");
            String goodProperties = map.get("properties");
            String goodQuantity = map.get("quantity");
            // 判断属性是不是相同，如果相同则数量相加
//            TConsCar tConsCartDao = new TConsCartDao();
//            tConsCartDao.setGoodsid(goodId);
//            tConsCartDao.setg
//            tDao.selectByParams(record);
        }
        
        return false;
    }
}
