package com.org.oztt.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.dao.TConsCartDao;
import com.org.oztt.dao.TGoodsAppendItemsDao;
import com.org.oztt.dao.TGoodsClassficationDao;
import com.org.oztt.dao.TGoodsDao;
import com.org.oztt.dao.TGoodsGroupDao;
import com.org.oztt.dao.TGoodsPriceDao;
import com.org.oztt.dao.TGoodsPropertyDao;
import com.org.oztt.dao.TNoGoodsDao;
import com.org.oztt.dao.TNoGroupDao;
import com.org.oztt.dao.TNoPriceDao;
import com.org.oztt.dao.TTabIndexDao;
import com.org.oztt.dao.TTabInfoDao;
import com.org.oztt.entity.TConsCart;
import com.org.oztt.entity.TGoods;
import com.org.oztt.entity.TGoodsAppendItems;
import com.org.oztt.entity.TGoodsClassfication;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.entity.TGoodsPrice;
import com.org.oztt.entity.TGoodsProperty;
import com.org.oztt.entity.TNoGoods;
import com.org.oztt.entity.TNoGroup;
import com.org.oztt.entity.TNoPrice;
import com.org.oztt.entity.TTabIndex;
import com.org.oztt.entity.TTabInfo;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.ContCartProItemDto;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.formDto.GoodProertyDto;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.formDto.GroupItemIdDto;
import com.org.oztt.formDto.OzTtAdClDto;
import com.org.oztt.formDto.OzTtAdGcListDto;
import com.org.oztt.formDto.OzTtAdGlListDto;
import com.org.oztt.formDto.OzTtAdGsListDto;
import com.org.oztt.formDto.OzTtAdPlListDto;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.GoodsService;
import com.org.oztt.service.OrderService;

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

    @Resource
    private TNoPriceDao            tNoPriceDao;

    @Resource
    private TNoGroupDao            tNoGroupDao;

    @Resource
    private TNoGoodsDao            tNoGoodsDao;

    @Resource
    private TTabInfoDao            tTabInfoDao;

    @Resource
    private TTabIndexDao           tTabIndexDao;
    
    @Resource
    private OrderService           orderService;

    public TGoods getGoodsById(String goodsId) throws Exception {
        return tGoodsDao.selectByGoodsId(goodsId);
    }

    public List<TGoods> getGoodsByParam(TGoods tGoods) throws Exception {
        return tGoodsDao.selectByParams(tGoods);
    }

    public List<GroupItemDto> getAllNewArravail() throws Exception {
        return tGoodsDao.getAllNewArravail();
    }

    public List<GroupItemDto> getGoodsListForMain(Map<String, String> map) throws Exception {
        return tGoodsDao.getGoodsListForMain(map);
    }

    public TGoodsClassfication getGoodsClassficationByClassId(String classId) throws Exception {
        return tGoodsClassficationDao.getGoodsClassficationByClassId(classId);
    }

    public PagingResult<GroupItemDto> getGoodsByParamForPage(Pagination pagination) throws Exception {
        PagingResult<GroupItemDto> itemList = tGoodsDao.getGoodsByParamForPage(pagination);
        if (!CollectionUtils.isEmpty(itemList.getResultList())) {
            for (GroupItemDto goods : itemList.getResultList()) {
                if (StringUtils.isNotEmpty(goods.getSellOutInitQuantity())) {
                    if (new BigDecimal(goods.getSellOutInitQuantity()).compareTo(new BigDecimal(goods.getGroupCurrent())) >= 0) {
                        goods.setSellOutFlg(CommonConstants.SELL_OUT_FLG);
                    }
                }
                
            }
        }
        return itemList;
    }

    @Override
    public PagingResult<GroupItemDto> getGoodsTabByParamForPage(Pagination pagination) throws Exception {
        return tGoodsDao.getGoodsTabByParamForPage(pagination);
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
    public GoodItemDto getGoodAllItemDto(String groupId) throws Exception {

        String imgUrl = MessageUtils.getApplicationMessage("saveImgUrl", null);
        // 折扣价  团购这张表中
        TGoodsGroup tGoodsGroup = new TGoodsGroup();
        tGoodsGroup.setGroupno(groupId);
        tGoodsGroup.setOpenflg(CommonConstants.OPEN_FLAG_GROUP);
        tGoodsGroup = getGoodPrice(tGoodsGroup);
        // 取得当前商品的所有属性
        String goodId = tGoodsGroup.getGoodsid();
        TGoods goods = getGoodsById(goodId);
        goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + goods.getGoodsthumbnail());
        // 原价   商品定价策略表中
        TGoodsPrice tGoodsPrice = new TGoodsPrice();
        tGoodsPrice.setGoodsid(goodId);
        tGoodsPrice.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
        tGoodsPrice = getGoodPrice(tGoodsPrice);

        // 属性（比如：size，颜色）
        // 商品扩展属性定义这张表中
        List<GoodProertyDto> propertiesFormList = new ArrayList<GoodProertyDto>();
        TGoodsProperty tGoodsProperty = new TGoodsProperty();
        tGoodsProperty.setGoodsid(goodId);
        tGoodsProperty.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
        List<TGoodsProperty> properties = getGoodsProperty(tGoodsProperty);
        if (!CollectionUtils.isEmpty(properties)) {
            for (TGoodsProperty property : properties) {
                TGoodsAppendItems tGoodsAppendItems = new TGoodsAppendItems();
                tGoodsAppendItems.setItemid(property.getGoodsclassid());
                tGoodsAppendItems.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
                tGoodsAppendItems = getGoodsAppendItems(tGoodsAppendItems);

                GoodProertyDto proDto = new GoodProertyDto();
                proDto.setGoodsPropertiesId(property.getGoodsclassid());
                proDto.setGoodsPropertiesName(tGoodsAppendItems.getDisplayname());
                proDto.setGoodsPropertiesType(tGoodsAppendItems.getInputtype());
                proDto.setGoodsPropertiesJson(property.getGoodsclassvalue());

                propertiesFormList.add(proDto);
            }
        }

        // 获取商品的图片
        List<String> goodPicList = new ArrayList<String>();
        if (goods.getGoodsnormalpic() != null) {
            String[] goodsPic = goods.getGoodsnormalpic().split(",");
            if (goodsPic != null && goodsPic.length > 0) {
                for (String pic : goodsPic) {
                    goodPicList.add(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + pic);
                }
            }
        }

        GoodItemDto goodItemDto = new GoodItemDto();
        goodItemDto.setGoods(goods);
        goodItemDto.setGroupId(groupId);
        goodItemDto.setFirstImg((goodPicList != null && goodPicList.size() > 0) ? goodPicList.get(0) : "");
        goodItemDto.setImgList(goodPicList);
        goodItemDto.setNowPrice(tGoodsPrice.getPricevalue().toString());
        goodItemDto.setDisPrice(tGoodsGroup.getGroupprice().toString());
        goodItemDto.setProductInfo(tGoodsGroup.getComsumerreminder());
        goodItemDto.setProductDesc(tGoodsGroup.getGroupdesc());
        goodItemDto.setSellerRule(tGoodsGroup.getShopperrules());
        goodItemDto.setGroupMax(String.valueOf(tGoodsGroup.getGroupmaxquantity()));
        if (tGoodsGroup.getGroupcurrentquantity() >= tGoodsGroup.getGroupmaxquantity()) {
            goodItemDto.setGroupCurrent(String.valueOf(tGoodsGroup.getGroupmaxquantity()));
            goodItemDto.setIsOver(CommonConstants.OVER_GROUP_YES);
        }
        else {
            goodItemDto.setGroupCurrent(String.valueOf(tGoodsGroup.getGroupcurrentquantity()));
            goodItemDto.setIsOver(CommonConstants.OVER_GROUP_NO);
        }
        goodItemDto.setValidPeriodStart(DateFormatUtils.date2StringWithFormat(tGoodsGroup.getValidperiodstart(),
                DateFormatUtils.PATTEN_YMD));
        goodItemDto.setValidPeriodEnd(DateFormatUtils.date2StringWithFormat(tGoodsGroup.getValidperiodend(),
                DateFormatUtils.PATTEN_YMD));
        if (DateFormatUtils.getCurrentDate().before(tGoodsGroup.getValidperiodstart())
                || DateFormatUtils.getCurrentDate().after(tGoodsGroup.getValidperiodend())) {
            // 不在范围内
            goodItemDto.setIsOverTime(CommonConstants.OVERTIME_GROUP_YES);
        }
        else {
            goodItemDto.setIsOverTime(CommonConstants.OVERTIME_GROUP_NO);
        }
        goodItemDto.setProperties(JSON.toJSONString(propertiesFormList));
        goodItemDto.setCountdownTime(DateFormatUtils.getBetweenSecondTime(tGoodsGroup.getValidperiodend()));
        // 获取当前商品的标签属性
        goodItemDto.setGoodsTabs(tTabInfoDao.getTabsByGoods(goods.getGoodsid()));
        return goodItemDto;
    }
    
    @Override
    public GoodItemDto getGoodAllItemDtoForAdmin(String groupId) throws Exception {

        String imgUrl = MessageUtils.getApplicationMessage("saveImgUrl", null);
        // 折扣价  团购这张表中
        TGoodsGroup tGoodsGroup = new TGoodsGroup();
        tGoodsGroup.setGroupno(groupId);
        //tGoodsGroup.setOpenflg(CommonConstants.OPEN_FLAG_GROUP);
        tGoodsGroup = getGoodPrice(tGoodsGroup);
        // 取得当前商品的所有属性
        String goodId = tGoodsGroup.getGoodsid();
        TGoods goods = getGoodsById(goodId);
        goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + goods.getGoodsthumbnail());
        // 原价   商品定价策略表中
        TGoodsPrice tGoodsPrice = new TGoodsPrice();
        tGoodsPrice.setGoodsid(goodId);
        //tGoodsPrice.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
        tGoodsPrice = getGoodPrice(tGoodsPrice);

        // 属性（比如：size，颜色）
        // 商品扩展属性定义这张表中
        List<GoodProertyDto> propertiesFormList = new ArrayList<GoodProertyDto>();
        TGoodsProperty tGoodsProperty = new TGoodsProperty();
        tGoodsProperty.setGoodsid(goodId);
        tGoodsProperty.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
        List<TGoodsProperty> properties = getGoodsProperty(tGoodsProperty);
        if (!CollectionUtils.isEmpty(properties)) {
            for (TGoodsProperty property : properties) {
                TGoodsAppendItems tGoodsAppendItems = new TGoodsAppendItems();
                tGoodsAppendItems.setItemid(property.getGoodsclassid());
                tGoodsAppendItems.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
                tGoodsAppendItems = getGoodsAppendItems(tGoodsAppendItems);

                GoodProertyDto proDto = new GoodProertyDto();
                proDto.setGoodsPropertiesId(property.getGoodsclassid());
                proDto.setGoodsPropertiesName(tGoodsAppendItems.getDisplayname());
                proDto.setGoodsPropertiesType(tGoodsAppendItems.getInputtype());
                proDto.setGoodsPropertiesJson(property.getGoodsclassvalue());

                propertiesFormList.add(proDto);
            }
        }

        // 获取商品的图片
        List<String> goodPicList = new ArrayList<String>();
        if (goods.getGoodsnormalpic() != null) {
            String[] goodsPic = goods.getGoodsnormalpic().split(",");
            if (goodsPic != null && goodsPic.length > 0) {
                for (String pic : goodsPic) {
                    goodPicList.add(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + pic);
                }
            }
        }

        GoodItemDto goodItemDto = new GoodItemDto();
        goodItemDto.setGoods(goods);
        goodItemDto.setGroupId(groupId);
        goodItemDto.setFirstImg((goodPicList != null && goodPicList.size() > 0) ? goodPicList.get(0) : "");
        goodItemDto.setImgList(goodPicList);
        goodItemDto.setNowPrice(tGoodsPrice.getPricevalue().toString());
        goodItemDto.setDisPrice(tGoodsGroup.getGroupprice().toString());
        goodItemDto.setProductInfo(tGoodsGroup.getComsumerreminder());
        goodItemDto.setProductDesc(tGoodsGroup.getGroupdesc());
        goodItemDto.setSellerRule(tGoodsGroup.getShopperrules());
        goodItemDto.setGroupMax(String.valueOf(tGoodsGroup.getGroupmaxquantity()));
        if (tGoodsGroup.getGroupcurrentquantity() >= tGoodsGroup.getGroupmaxquantity()) {
            goodItemDto.setGroupCurrent(String.valueOf(tGoodsGroup.getGroupmaxquantity()));
            goodItemDto.setIsOver(CommonConstants.OVER_GROUP_YES);
        }
        else {
            goodItemDto.setGroupCurrent(String.valueOf(tGoodsGroup.getGroupcurrentquantity()));
            goodItemDto.setIsOver(CommonConstants.OVER_GROUP_NO);
        }
        goodItemDto.setValidPeriodStart(DateFormatUtils.date2StringWithFormat(tGoodsGroup.getValidperiodstart(),
                DateFormatUtils.PATTEN_YMD));
        goodItemDto.setValidPeriodEnd(DateFormatUtils.date2StringWithFormat(tGoodsGroup.getValidperiodend(),
                DateFormatUtils.PATTEN_YMD));
        if (DateFormatUtils.getCurrentDate().before(tGoodsGroup.getValidperiodstart())
                || DateFormatUtils.getCurrentDate().after(tGoodsGroup.getValidperiodend())) {
            // 不在范围内
            goodItemDto.setIsOverTime(CommonConstants.OVERTIME_GROUP_YES);
        }
        else {
            goodItemDto.setIsOverTime(CommonConstants.OVERTIME_GROUP_NO);
        }
        goodItemDto.setProperties(JSON.toJSONString(propertiesFormList));
        goodItemDto.setCountdownTime(DateFormatUtils.getBetweenSecondTime(tGoodsGroup.getValidperiodend()));
        // 获取当前商品的标签属性
        goodItemDto.setGoodsTabs(tTabInfoDao.getTabsByGoods(goods.getGoodsid()));
        return goodItemDto;
    }

    @Override
    public GoodItemDto getGroupAllItemDtoForPreview(String groupId) throws Exception {

        // 折扣价  团购这张表中
        TGoodsGroup tGoodsGroup = new TGoodsGroup();
        tGoodsGroup.setGroupno(groupId);
        tGoodsGroup = getGoodPrice(tGoodsGroup);

        String goodId = tGoodsGroup.getGoodsid();

        String imgUrl = MessageUtils.getApplicationMessage("saveImgUrl", null);
        // 取得当前商品的所有属性
        TGoods goods = getGoodsById(goodId);
        goods.setGoodsthumbnail(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + goods.getGoodsthumbnail());
        // 原价   商品定价策略表中
        TGoodsPrice tGoodsPrice = new TGoodsPrice();
        tGoodsPrice.setGoodsid(goodId);
        tGoodsPrice.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
        tGoodsPrice = getGoodPrice(tGoodsPrice);

        // 属性（比如：size，颜色）
        // 商品扩展属性定义这张表中
        List<GoodProertyDto> propertiesFormList = new ArrayList<GoodProertyDto>();
        TGoodsProperty tGoodsProperty = new TGoodsProperty();
        tGoodsProperty.setGoodsid(goodId);
        tGoodsProperty.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
        List<TGoodsProperty> properties = getGoodsProperty(tGoodsProperty);
        if (!CollectionUtils.isEmpty(properties)) {
            for (TGoodsProperty property : properties) {
                TGoodsAppendItems tGoodsAppendItems = new TGoodsAppendItems();
                tGoodsAppendItems.setItemid(property.getGoodsclassid());
                tGoodsAppendItems.setOpenflg(CommonConstants.OPEN_FLAG_OTHER);
                tGoodsAppendItems = getGoodsAppendItems(tGoodsAppendItems);

                GoodProertyDto proDto = new GoodProertyDto();
                proDto.setGoodsPropertiesId(property.getGoodsclassid());
                proDto.setGoodsPropertiesName(tGoodsAppendItems.getDisplayname());
                proDto.setGoodsPropertiesType(tGoodsAppendItems.getInputtype());
                proDto.setGoodsPropertiesJson(property.getGoodsclassvalue());

                propertiesFormList.add(proDto);
            }
        }

        // 获取商品的图片
        List<String> goodPicList = new ArrayList<String>();
        if (goods.getGoodsnormalpic() != null) {
            String[] goodsPic = goods.getGoodsnormalpic().split(",");
            if (goodsPic != null && goodsPic.length > 0) {
                for (String pic : goodsPic) {
                    goodPicList.add(imgUrl + goods.getGoodsid() + CommonConstants.PATH_SPLIT + pic);
                }
            }
        }

        GoodItemDto goodItemDto = new GoodItemDto();
        goodItemDto.setGoods(goods);
        goodItemDto.setFirstImg((goodPicList != null && goodPicList.size() > 0) ? goodPicList.get(0) : "");
        goodItemDto.setImgList(goodPicList);
        goodItemDto.setNowPrice(tGoodsPrice.getPricevalue().toString());
        goodItemDto.setDisPrice(tGoodsGroup.getGroupprice().toString());
        goodItemDto.setProductInfo(tGoodsGroup.getGroupcomments());
        goodItemDto.setProductDesc(tGoodsGroup.getGroupdesc());
        goodItemDto.setSellerRule(tGoodsGroup.getShopperrules());
        goodItemDto.setGroupMax(String.valueOf(tGoodsGroup.getGroupmaxquantity()));
        if (tGoodsGroup.getGroupcurrentquantity() >= tGoodsGroup.getGroupmaxquantity()) {
            goodItemDto.setGroupCurrent(String.valueOf(tGoodsGroup.getGroupmaxquantity()));
            goodItemDto.setIsOver(CommonConstants.OVER_GROUP_YES);
        }
        else {
            goodItemDto.setGroupCurrent(String.valueOf(tGoodsGroup.getGroupcurrentquantity()));
            goodItemDto.setIsOver(CommonConstants.OVER_GROUP_NO);
        }
        goodItemDto.setValidPeriodStart(DateFormatUtils.date2StringWithFormat(tGoodsGroup.getValidperiodstart(),
                DateFormatUtils.PATTEN_YMD));
        goodItemDto.setValidPeriodEnd(DateFormatUtils.date2StringWithFormat(tGoodsGroup.getValidperiodend(),
                DateFormatUtils.PATTEN_YMD));
        if (DateFormatUtils.getCurrentDate().before(tGoodsGroup.getValidperiodstart())
                || DateFormatUtils.getCurrentDate().after(tGoodsGroup.getValidperiodend())) {
            // 不在范围内
            goodItemDto.setIsOverTime(CommonConstants.OVERTIME_GROUP_YES);
        }
        else {
            goodItemDto.setIsOverTime(CommonConstants.OVERTIME_GROUP_NO);
        }
        goodItemDto.setProperties(JSON.toJSONString(propertiesFormList));
        goodItemDto.setCountdownTime(DateFormatUtils.getBetweenSecondTime(tGoodsGroup.getValidperiodend()));
        // 获取当前商品的标签属性
        goodItemDto.setGoodsTabs(tTabInfoDao.getTabsByGoods(goods.getGoodsid()));

        return goodItemDto;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public boolean addContCart(String customerNo, List list) throws Exception {
        if (list == null)
            return false;
        for (int i = 0; i < list.size(); i++) {
            Map<String, String> map = (Map<String, String>) list.get(i);
            String groupId = map.get("groupId");
            String goodProperties = map.get("goodsProperties");
            if (goodProperties != null) {
                List<ContCartProItemDto> concartContentList = JSONObject.parseArray(goodProperties,
                        ContCartProItemDto.class);
                if (concartContentList == null || concartContentList.size() == 0) {
                    goodProperties = "";
                }
            }
            String goodQuantity = map.get("goodsQuantity");
            // 判断属性是不是相同，如果相同则数量相加
            TConsCart tConsCart = new TConsCart();
            tConsCart.setGroupno(groupId);
            tConsCart.setCustomerno(customerNo);
            tConsCart.setGoodsspecifications(goodProperties);
            tConsCart = tConsCartDao.selectByParams(tConsCart);

            if (tConsCart == null) {
                // 没有数据则需要插入数据
                // 商品团购
                TGoodsGroup tGoodsGroup = new TGoodsGroup();
                tGoodsGroup.setGroupno(groupId);
                tGoodsGroup = this.getGoodPrice(tGoodsGroup);

                tConsCart = new TConsCart();

                tConsCart.setGroupno(groupId);
                tConsCart.setAddcarttimestamp(new Date());
                tConsCart.setAddtimestamp(new Date());
                tConsCart.setAdduserkey(customerNo);
                tConsCart.setCustomerno(customerNo);
                tConsCart.setGoodsid(tGoodsGroup.getGoodsid());
                tConsCart.setGoodsspecifications(goodProperties);
                // 商品价格
                TGoodsPrice tGoodsPrice = new TGoodsPrice();
                tGoodsPrice.setGoodsid(tGoodsGroup.getGoodsid());
                tGoodsPrice = this.getGoodPrice(tGoodsPrice);
                tConsCart.setPriceno(tGoodsPrice.getPriceno());

                tConsCart.setIfgroup(CommonConstants.IS_GROUP);
                tConsCart.setQuantity(Long.valueOf(goodQuantity));
                tConsCartDao.insertSelective(tConsCart);

            }
            else {
                // 有数据则增加数量
                tConsCart.setQuantity(Long.parseLong(goodQuantity) + tConsCart.getQuantity());
                tConsCart.setUpdpgmid(CommonConstants.UP_CART);
                tConsCart.setUpdtimestamp(new Date());
                tConsCart.setUpduserkey(customerNo);
                tConsCartDao.updateByPrimaryKey(tConsCart);
            }
        }

        return true;
    }

    @Override
    public List<GroupItemDto> getFiveHotSeller(TGoods tGoods) throws Exception {
        return tGoodsDao.getFiveHotSeller(tGoods);
    }

    @Override
    public List<GroupItemDto> getHotSeller(TGoods tGoods) throws Exception {
        return tGoodsDao.getHotSeller(tGoods);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public boolean deleteContCart(String customerNo, List list) throws Exception {
        if (list == null)
            return false;
        for (int i = 0; i < list.size(); i++) {
            Map<String, String> map = (Map<String, String>) list.get(i);
            String groupId = map.get("groupId");
            String goodProperties = map.get("goodsProperties");
            if (goodProperties != null) {
                List<ContCartProItemDto> concartContentList = JSONObject.parseArray(goodProperties,
                        ContCartProItemDto.class);
                if (concartContentList == null || concartContentList.size() == 0) {
                    goodProperties = "";
                }
            }
            // 判断属性是不是相同，如果相同则数量相加
            TConsCart tConsCart = new TConsCart();
            tConsCart.setGroupno(groupId);
            tConsCart.setCustomerno(customerNo);
            tConsCart.setGoodsspecifications(goodProperties);
            tConsCart = tConsCartDao.selectByParams(tConsCart);
            if (tConsCart != null) {
                tConsCartDao.deleteByPrimaryKey(tConsCart.getNo());
            }
        }

        return true;
    }

    @Override
    public boolean deleteAllContCart(String customerNo) throws Exception {
        tConsCartDao.deleteAllContCard(customerNo);
        return true;
    }

    @Override
    public List<GroupItemDto> getGoodsBySearchParam(String goodsParam) throws Exception {
        return tGoodsDao.getGoodsBySearchParam(goodsParam);
    }

    @Override
    public List<TConsCart> getAllContCart(String customerNo) throws Exception {
        return tConsCartDao.getAllContCart(customerNo);
    }

    @Override
    public List<ContCartItemDto> getAllContCartForCookie(String customerNo) throws Exception {
        return tConsCartDao.getAllContCartForCookie(customerNo);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public boolean purchaseAsyncContCart(String customerNo, List list) throws Exception {
        if (list == null)
            return false;
        for (int i = 0; i < list.size(); i++) {
            Map<String, String> map = (Map<String, String>) list.get(i);
            String groupId = map.get("groupId");
            String goodProperties = map.get("goodsProperties");
            if (goodProperties != null) {
                List<ContCartProItemDto> concartContentList = JSONObject.parseArray(goodProperties,
                        ContCartProItemDto.class);
                if (concartContentList == null || concartContentList.size() == 0) {
                    goodProperties = "";
                }
            }
            String goodQuantity = map.get("goodsQuantity");
            // 判断属性是不是相同，如果相同则数量相加
            TConsCart tConsCart = new TConsCart();
            tConsCart.setGroupno(groupId);
            tConsCart.setCustomerno(customerNo);
            tConsCart.setGoodsspecifications(goodProperties);
            tConsCart = tConsCartDao.selectByParams(tConsCart);
            if (tConsCart == null) {
                // 没有数据则需要插入数据
                // 商品团购
                TGoodsGroup tGoodsGroup = new TGoodsGroup();
                tGoodsGroup.setGroupno(groupId);
                tGoodsGroup = this.getGoodPrice(tGoodsGroup);

                tConsCart = new TConsCart();
                tConsCart.setGroupno(groupId);
                tConsCart.setAddcarttimestamp(new Date());
                tConsCart.setAddtimestamp(new Date());
                tConsCart.setAdduserkey(customerNo);
                tConsCart.setCustomerno(customerNo);
                tConsCart.setGoodsid(tGoodsGroup.getGoodsid());
                tConsCart.setGoodsspecifications(goodProperties);
                // 商品价格
                TGoodsPrice tGoodsPrice = new TGoodsPrice();
                tGoodsPrice.setGoodsid(tGoodsGroup.getGoodsid());
                tGoodsPrice = this.getGoodPrice(tGoodsPrice);
                tConsCart.setPriceno(tGoodsPrice.getPriceno());

                tConsCart.setIfgroup(CommonConstants.IS_GROUP);
                tConsCart.setQuantity(Long.valueOf(goodQuantity));
                tConsCart.setPurchasecurrent(CommonConstants.CURRENT_BUY);
                tConsCartDao.insertSelective(tConsCart);

            }
            else {
                // 有数据
                tConsCart.setQuantity(Long.parseLong(goodQuantity));
                tConsCart.setPurchasecurrent(CommonConstants.CURRENT_BUY);
                tConsCart.setUpdpgmid(CommonConstants.UP_CART);
                tConsCart.setUpdtimestamp(new Date());
                tConsCart.setUpduserkey(customerNo);
                tConsCartDao.updateByPrimaryKey(tConsCart);
            }
        }
        return true;
    }

    @Override
    public List<ContCartItemDto> getAllContCartForBuy(String customerNo) throws Exception {
        return tConsCartDao.getAllContCartForBuy(customerNo);
    }

    @Override
    public List<OzTtAdClDto> getAllClassficationForAdmin() throws Exception {
        List<OzTtAdClDto> dtoList = tGoodsClassficationDao.getAllClassficationForAdmin();
        if (!CollectionUtils.isEmpty(dtoList)) {
            for (OzTtAdClDto dto : dtoList) {
                dto.setOpenFlgView("0".equals(dto.getOpenFlg()) ? CommonConstants.OPEN : CommonConstants.NO_OPEN);
            }
        }
        return dtoList;

    }

    @Override
    public TGoodsClassfication getClassficationByNo(Long no) throws Exception {
        return tGoodsClassficationDao.selectByPrimaryKey(no);
    }

    @Override
    public List<TGoodsClassfication> getChildrenClassfication(String classId) throws Exception {
        return tGoodsClassficationDao.getChildrenKey(classId);
    }

    @Override
    public List<TGoodsClassfication> getNotChildrenClassfication(String classId) throws Exception {
        List<TGoodsClassfication> origin = tGoodsClassficationDao.getChildrenKey(CommonConstants.BELONG_FATHER_CLASS);
        List<TGoodsClassfication> dest = new ArrayList<TGoodsClassfication>();
        if (!CollectionUtils.isEmpty(origin)) {
            for (TGoodsClassfication ori : origin) {
                if (!classId.equals(ori.getClassid())) {
                    dest.add(ori);
                }
            }
        }
        return dest;
    }

    @Override
    public void saveClassFication(TGoodsClassfication tGoodsClassfication) throws Exception {
        tGoodsClassficationDao.insertSelective(tGoodsClassfication);

    }

    @Override
    public void updateClassFication(TGoodsClassfication tGoodsClassfication) throws Exception {
        tGoodsClassficationDao.updateByPrimaryKeySelective(tGoodsClassfication);
    }

    @Override
    public String getMaxClassNo(String fatherId) throws Exception {
        String maxClassID = tGoodsClassficationDao.getMaxClassNo(fatherId);
        if (StringUtils.isEmpty(fatherId)) {
            // 父分类
            if (StringUtils.isEmpty(maxClassID)) {
                return CommonConstants.FATHER_CLASS + StringUtils.leftPad("1", 4, "0");
            }
            else {
                return CommonConstants.FATHER_CLASS
                        + StringUtils.leftPad(String.valueOf(Integer.valueOf(maxClassID.substring(2)) + 1), 4, "0");
            }
        }
        else {
            // 子分类
            if (StringUtils.isEmpty(maxClassID)) {
                return CommonConstants.CHILDREN_CLASS + StringUtils.leftPad("1", 4, "0");
            }
            else {
                return CommonConstants.CHILDREN_CLASS
                        + StringUtils.leftPad(String.valueOf(Integer.valueOf(maxClassID.substring(2)) + 1), 4, "0");
            }
        }
    }

    @Override
    public List<TGoodsClassfication> getSecondClassfication(String classId) throws Exception {
        return tGoodsClassficationDao.getSecondClassfication(classId);
    }

    @Override
    public PagingResult<OzTtAdPlListDto> getAllGoodsPriceInfoForAdmin(Pagination pagination) throws Exception {
        PagingResult<OzTtAdPlListDto> dtoList = tGoodsDao.getAllGoodsPriceInfoForAdmin(pagination);
        if (dtoList.getResultList() != null && dtoList.getResultList().size() > 0) {
            int i = 0;
            for (OzTtAdPlListDto detail : dtoList.getResultList()) {
                detail.setDetailNo(String.valueOf((dtoList.getCurrentPage() - 1) * dtoList.getPageSize() + ++i));
            }
        }
        return dtoList;

    }

    @Override
    public TGoodsPrice getGoodsSetPriceInfo(String goodsId) throws Exception {
        TGoodsPrice param = new TGoodsPrice();
        param.setGoodsid(goodsId);
        return tGoodsPriceDao.selectByParams(param);
    }

    @Override
    public void saveGoodsSetPrice(TGoodsPrice tGoodsPrice) throws Exception {
        //获取最大的priceNo
        TNoPrice maxTNoPrice = tNoPriceDao.getMaxPriceNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        Integer len = CommonConstants.ADD_NUMBER.length();
        String maxPriceNo;
        if (maxTNoPrice == null) {
            maxPriceNo = CommonConstants.PRICE_NO_SIGN + nowDateString + CommonConstants.ADD_NUMBER;
            // 订单号最大值的保存
            TNoPrice tNoPrice = new TNoPrice();
            tNoPrice.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoPrice.setMaxno(maxPriceNo);
            tNoPriceDao.insertSelective(tNoPrice);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE).equals(maxTNoPrice.getDate())) {
                // 属于同一天
                // 订单号最大值的保存
                maxPriceNo = CommonConstants.PRICE_NO_SIGN
                        + nowDateString
                        + StringUtils.leftPad(
                                String.valueOf(Integer.valueOf(maxTNoPrice.getMaxno().substring(10)) + 1), len, "0");
                maxTNoPrice.setMaxno(maxPriceNo);
                tNoPriceDao.updateByPrimaryKeySelective(maxTNoPrice);
            }
            else {
                maxPriceNo = CommonConstants.PRICE_NO_SIGN + nowDateString + CommonConstants.ADD_NUMBER;
                // 订单号最大值的保存
                TNoPrice tNoPrice = new TNoPrice();
                tNoPrice.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoPrice.setMaxno(maxPriceNo);
                tNoPriceDao.insertSelective(tNoPrice);
            }
        }
        tGoodsPrice.setPriceno(maxPriceNo);
        tGoodsPriceDao.insertSelective(tGoodsPrice);
    }

    @Override
    public void updateGoodsSetPrice(TGoodsPrice tGoodsPrice) throws Exception {
        tGoodsPriceDao.updateByPrimaryKeySelective(tGoodsPrice);
    }

    @Override
    public void saveGoodsSetGroup(TGoodsGroup tGoodsGroup) throws Exception {
        //获取最大的groupNo
        TNoGroup maxTNoGroup = tNoGroupDao.getMaxGroupNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        Integer len = CommonConstants.ADD_NUMBER.length();
        String maxGroupNo;
        if (maxTNoGroup == null) {
            maxGroupNo = CommonConstants.GROUP_NO_SIGN + nowDateString + CommonConstants.ADD_NUMBER;
            // 订单号最大值的保存
            TNoGroup tNoGroup = new TNoGroup();
            tNoGroup.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoGroup.setMaxno(maxGroupNo);
            tNoGroupDao.insertSelective(tNoGroup);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE).equals(maxTNoGroup.getDate())) {
                // 属于同一天
                // 订单号最大值的保存
                maxGroupNo = CommonConstants.GROUP_NO_SIGN
                        + nowDateString
                        + StringUtils.leftPad(
                                String.valueOf(Integer.valueOf(maxTNoGroup.getMaxno().substring(10)) + 1), len, "0");
                maxTNoGroup.setMaxno(maxGroupNo);
                tNoGroupDao.updateByPrimaryKeySelective(maxTNoGroup);
            }
            else {
                maxGroupNo = CommonConstants.GROUP_NO_SIGN + nowDateString + CommonConstants.ADD_NUMBER;
                // 订单号最大值的保存
                TNoGroup tNoGroup = new TNoGroup();
                tNoGroup.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoGroup.setMaxno(maxGroupNo);
                tNoGroupDao.insertSelective(tNoGroup);
            }
        }
        tGoodsGroup.setGroupno(maxGroupNo);
        tGoodsGroupDao.insertSelective(tGoodsGroup);
    }

    @Override
    public PagingResult<OzTtAdGcListDto> getAllGroupsInfoForAdmin(Pagination pagination) throws Exception {
        PagingResult<OzTtAdGcListDto> dtoList = tGoodsGroupDao.getAllGroupsInfoForAdmin(pagination);
        if (dtoList.getResultList() != null && dtoList.getResultList().size() > 0) {
            int i = 0;
            for (OzTtAdGcListDto detail : dtoList.getResultList()) {
                detail.setDetailNo(String.valueOf((dtoList.getCurrentPage() - 1) * dtoList.getPageSize() + ++i));
                detail.setIsOpen(CommonEnum.GroupOpenFlag.getEnumLabel(detail.getIsOpen()));
                detail.setIsTopUp(CommonEnum.ifOrNot.getEnumLabel(detail.getIsTopUp()));
                detail.setIsPre(CommonEnum.ifOrNot.getEnumLabel(detail.getIsPre()));
                detail.setIsInStock(CommonEnum.ifOrNot.getEnumLabel(detail.getIsInStock()));
                detail.setIsHot(CommonEnum.ifOrNot.getEnumLabel(detail.getIsHot()));
                detail.setIsDiamond(CommonEnum.ifOrNot.getEnumLabel(detail.getIsDiamond()));
                detail.setIsEn(CommonEnum.ifOrNot.getEnumLabel(detail.getIsEn()));
            }
        }
        return dtoList;
    }

    @Override
    public List<OzTtAdGcListDto> getAllGroupsInfoForAdminNoPage() throws Exception {
        List<OzTtAdGcListDto> dtoList = tGoodsGroupDao.getAllGroupsInfoForAdminNoPage();

        return dtoList;
    }

    @Override
    public void updateGoodsSetGroup(TGoodsGroup tGoodsGroup) throws Exception {
        tGoodsGroupDao.updateByPrimaryKeySelective(tGoodsGroup);
    }

    @Override
    public PagingResult<OzTtAdGlListDto> getAllGoodsInfoForAdmin(Pagination pagination) throws Exception {
        return tGoodsDao.getAllGoodsInfoForAdmin(pagination);
    }

    @Override
    public List<OzTtAdGlListDto> getAllGoodsInfoForAdminNoPage() throws Exception {
        return tGoodsDao.getAllGoodsInfoForAdminNoPage();
    }

    @Override
    public String saveGoodsForAdmin(TGoods tGoods) throws Exception {
        //获取最大的GoodId
        TNoGoods maxTNoGoods = tNoGoodsDao.getMaxGoodsNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        Integer len = CommonConstants.ADD_NUMBER.length();
        String maxGoodsNo;
        if (maxTNoGoods == null) {
            maxGoodsNo = CommonConstants.GOODS_NO_SIGN + nowDateString + CommonConstants.ADD_NUMBER;
            // 商品号最大值的保存
            TNoGoods tNoGoods = new TNoGoods();
            tNoGoods.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoGoods.setMaxno(maxGoodsNo);
            tNoGoodsDao.insertSelective(tNoGoods);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE).equals(maxTNoGoods.getDate())) {
                // 属于同一天
                // 订单号最大值的保存
                maxGoodsNo = CommonConstants.GOODS_NO_SIGN
                        + nowDateString
                        + StringUtils.leftPad(
                                String.valueOf(Integer.valueOf(maxTNoGoods.getMaxno().substring(10)) + 1), len, "0");
                maxTNoGoods.setMaxno(maxGoodsNo);
                tNoGoodsDao.updateByPrimaryKeySelective(maxTNoGoods);
            }
            else {
                maxGoodsNo = CommonConstants.GOODS_NO_SIGN + nowDateString + CommonConstants.ADD_NUMBER;
                // 商品号最大值的保存
                TNoGoods tNoGoods = new TNoGoods();
                tNoGoods.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoGoods.setMaxno(maxGoodsNo);
                tNoGoodsDao.insertSelective(tNoGoods);
            }
        }
        tGoods.setGoodsid(maxGoodsNo);
        tGoodsDao.insertSelective(tGoods);
        return maxGoodsNo;
    }

    @Override
    public void updateGoodsForAdmin(TGoods tGoods) throws Exception {
        tGoodsDao.updateByPrimaryKeySelective(tGoods);
    }

    @Override
    public GroupItemIdDto getGroupItemId(String groupId) throws Exception {
        return tGoodsDao.getGroupItemId(groupId);
    }

    @Override
    public void deleteGoodsSetGroup(TGoodsGroup tGoodsGroup) throws Exception {
        tGoodsGroupDao.deleteByPrimaryKey(tGoodsGroup.getNo());

    }

    @Override
    public List<String> getMainSearchTab() throws Exception {
        List<String> strList = new ArrayList<String>();
        String a = "3";
        strList.add(a);
        a = "5";
        strList.add(a);
        a = "7";
        strList.add(a);
        return strList;
    }

    @Override
    public void updateCartCanBuy(String customerNo, List<String> str) throws Exception {
        tConsCartDao.updateAllCartCannotBuy(customerNo);
        for (String groupno : str) {
            TConsCart record = new TConsCart();
            record.setGroupno(groupno);
            record.setCustomerno(customerNo);
            tConsCartDao.updateCartCanBuy(record);
        }
    }

    @Override
    public List<GroupItemDto> getTopPage() throws Exception {
        return tGoodsDao.getTopPage();
    }

    @Override
    public List<TTabInfo> getAllTabs() throws Exception {
        return tTabInfoDao.getAllTabs();

    }

    @Override
    public void saveTab(TTabInfo info) throws Exception {
        tTabInfoDao.insertSelective(info);

    }

    @Override
    public void updateTab(TTabInfo info) throws Exception {
        tTabInfoDao.updateByPrimaryKeySelective(info);
    }

    @Override
    public void deleteTab(TTabInfo info) throws Exception {
        tTabInfoDao.deleteByPrimaryKey(info.getId());
    }

    @Override
    public TTabInfo getOneTab(Long no) throws Exception {
        return tTabInfoDao.selectByPrimaryKey(no);
    }

    @Override
    public String getAllGoodsByTab(String tabId) throws Exception {
        String goods = tTabIndexDao.getAllGoodsByTab(tabId);
        return goods == null ? "" : goods;
    }

    @Override
    public void deleteTabIndexByTab(String tabId) throws Exception {
        tTabIndexDao.deleteByTab(tabId);
    }

    @Override
    public void saveTabIndexByTab(List<TTabIndex> list) throws Exception {
        if (list != null && list.size() > 0) {
            for (TTabIndex index : list) {
                tTabIndexDao.insertSelective(index);
            }
        }

    }

    @Override
    public Long getMaxTabId() throws Exception {
        return tTabInfoDao.getMaxTabId();
    }

    @Override
    public String getTabName(String tabId) throws Exception {
        TTabInfo info = tTabInfoDao.selectByPrimaryKey(Long.valueOf(tabId));
        return info.getTabname();
    }

    @Override
    public void deleteCanNotBuyGoodsByCustomer(String customerNo) throws Exception {
        List<TConsCart> consCarts = this.getAllContCart(customerNo);
        if (!CollectionUtils.isEmpty(consCarts)) {
            for (TConsCart dto : consCarts) {
                // 判断当前的这个商品是否已经过期，过期则删除
                TGoodsGroup tGoodsGroup = new TGoodsGroup();
                tGoodsGroup.setGroupno(dto.getGroupno());
                tGoodsGroup = getGoodPrice(tGoodsGroup);
                if (new Date().compareTo(tGoodsGroup.getValidperiodend()) > 0) {
                    tConsCartDao.deleteByPrimaryKey(dto.getNo());
                    continue;
                }
                
                // 判断是否已经满团，满团则删除
                if (tGoodsGroup.getGroupcurrentquantity() >= tGoodsGroup.getGroupmaxquantity()) {
                    tConsCartDao.deleteByPrimaryKey(dto.getNo());
                    continue;
                }
                
                // 判断是否加入购物车的数据，不符合现在最大可用数据，如果不符合更新成现在最多可购买的数量
                //单个团购，单个客户已经购买的数量取得
                Map<Object, Object> paramMap = new HashMap<Object, Object>();
                paramMap.put("customerNo", customerNo);
                paramMap.put("groupNo", tGoodsGroup.getGroupno());
                int alreadyPurchaseSum = orderService.getAleadyPurchaseCount(paramMap);
                Long maxBuy = 0L;
                if (dto.getQuantity() + tGoodsGroup.getGroupcurrentquantity() <= tGoodsGroup.getGroupmaxquantity()) {
                } else {
                    maxBuy = tGoodsGroup.getGroupmaxquantity() - tGoodsGroup.getGroupcurrentquantity();
                }
                
                if (dto.getQuantity() > tGoodsGroup.getGroupquantitylimit()) {
                    maxBuy = (maxBuy > tGoodsGroup.getGroupquantitylimit() || maxBuy == 0L) ? tGoodsGroup.getGroupquantitylimit() : maxBuy;
                }
                
                if(dto.getQuantity() + alreadyPurchaseSum > tGoodsGroup.getGroupquantitylimit()) {
                    maxBuy = ((maxBuy + alreadyPurchaseSum) > tGoodsGroup.getGroupquantitylimit() || maxBuy == 0L) ? (tGoodsGroup.getGroupquantitylimit() - alreadyPurchaseSum) : maxBuy;
                }
                
                if(maxBuy != 0 && maxBuy != dto.getQuantity()) {
                    // 更新购物车中的数据
                    dto.setQuantity(maxBuy);
                    tConsCartDao.updateByPrimaryKeySelective(dto);
                }
                 
            }
        }
    }
	@Override
	public PagingResult<OzTtAdGsListDto> getAllGoodsRInfoForAdmin(Pagination pagination) throws Exception {
		 PagingResult<OzTtAdGsListDto> dtoList = tGoodsGroupDao.getAllGoodsRInfoForAdmin(pagination);
	        if (dtoList.getResultList() != null && dtoList.getResultList().size() > 0) {

	            for (OzTtAdGsListDto detail : dtoList.getResultList()) {

	                detail.setGoodsId(CommonEnum.ifOrNot.getEnumLabel(detail.getGoodsId()));
	                detail.setOrderDate(CommonEnum.ifOrNot.getEnumLabel(detail.getOrderDate()));
	                detail.setOrderNo(CommonEnum.ifOrNot.getEnumLabel(detail.getOrderNo()));
	                detail.setQualitity(CommonEnum.ifOrNot.getEnumLabel(detail.getQualitity()));
	                detail.setCnGivenname(CommonEnum.ifOrNot.getEnumLabel(detail.getCnGivenname()));
	                detail.setCnSurname(CommonEnum.ifOrNot.getEnumLabel(detail.getCnSurname()));
	                detail.setEnFirstName(CommonEnum.ifOrNot.getEnumLabel(detail.getEnFirstName()));
	                detail.setEnLastName(CommonEnum.ifOrNot.getEnumLabel(detail.getEnLastName()));
	                detail.setEnMiddleName(CommonEnum.ifOrNot.getEnumLabel(detail.getEnMiddleName()));
	            }
	        }
	        return dtoList;
	}

}
