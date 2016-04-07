package com.org.oztt.service;

import java.util.List;
import java.util.Map;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TConsCart;
import com.org.oztt.entity.TGoods;
import com.org.oztt.entity.TGoodsAppendItems;
import com.org.oztt.entity.TGoodsClassfication;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.entity.TGoodsPrice;
import com.org.oztt.entity.TGoodsProperty;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.formDto.GroupItemIdDto;
import com.org.oztt.formDto.OzTtAdClDto;
import com.org.oztt.formDto.OzTtAdGcListDto;
import com.org.oztt.formDto.OzTtAdGlListDto;
import com.org.oztt.formDto.OzTtAdPlListDto;

/**
 * 商品的服务
 * 
 * @author linliuan
 */
public interface GoodsService {

    /**
     * 通过商品ID获取商品的信息
     * 
     * @param goodsId
     * @return
     * @throws Exception
     */
    public TGoods getGoodsById(String goodsId) throws Exception;

    /**
     * 通过输入参数获取符合条件的所有商品
     * 
     * @param tGoods
     * @return
     * @throws Exception
     */
    public List<TGoods> getGoodsByParam(TGoods tGoods) throws Exception;

    /**
     * 获取热卖的前五个
     * 
     * @return
     * @throws Exception
     */
    public List<GroupItemDto> getFiveHotSeller(TGoods tGoods) throws Exception;
    
    /**
     * 获取所有热卖
     * 
     * @return
     * @throws Exception
     */
    public List<GroupItemDto> getHotSeller(TGoods tGoods) throws Exception;

    /**
     * 获取新货
     * 
     * @return
     * @throws Exception
     */
    public List<GroupItemDto> getAllNewArravail() throws Exception;

    /**
     * 主画面一栏用，这里暂时显示12个
     * 
     * @param tGoods
     * @return
     * @throws Exception
     */
    public List<GroupItemDto> getGoodsListForMain(Map<String, String> map) throws Exception;

    /**
     * 通过分类ID取得分类名称
     * 
     * @param classId
     * @return
     * @throws Exception
     */
    public TGoodsClassfication getGoodsClassficationByClassId(String classId) throws Exception;

    /**
     * 分页获取商品信息
     * 
     * @param pagination
     * @return
     * @throws Exception
     */
    public PagingResult<GroupItemDto> getGoodsByParamForPage(Pagination pagination) throws Exception;

    /**
     * 获取商品价格信息
     * 
     * @param tGoodsPrice
     * @return
     * @throws Exception
     */
    public TGoodsPrice getGoodPrice(TGoodsPrice tGoodsPrice) throws Exception;

    /**
     * 获取商品团购信息
     * 
     * @param tGoodsGroup
     * @return
     * @throws Exception
     */
    public TGoodsGroup getGoodPrice(TGoodsGroup tGoodsGroup) throws Exception;

    /**
     * 获取商品属性信息
     * 
     * @param tGoodsProperty
     * @return
     * @throws Exception
     */
    public List<TGoodsProperty> getGoodsProperty(TGoodsProperty tGoodsProperty) throws Exception;

    /**
     * 获取商品扩展属性信息
     * 
     * @param tGoodsAppendItems
     * @return
     * @throws Exception
     */
    public TGoodsAppendItems getGoodsAppendItems(TGoodsAppendItems tGoodsAppendItems) throws Exception;

    /**
     * 获取团购商品的所有属性
     * 
     * @param tGoodsAppendItems
     * @return
     * @throws Exception
     */
    public GoodItemDto getGoodAllItemDto(String groupId) throws Exception;
    
    /**
     * 获取商品的所有属性
     * 
     * @param tGoodsAppendItems
     * @return
     * @throws Exception
     */
    public GoodItemDto getGroupAllItemDtoForPreview(String groupId) throws Exception;

    /**
     * 加入购物车
     * 
     * @param list
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    public boolean addContCart(String customerNo, List list) throws Exception;

    /**
     * 同步购物车（替代已经存在的物品）
     * 
     * @param list
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    public boolean purchaseAsyncContCart(String customerNo, List list) throws Exception;

    /**
     * 删除购物车
     * 
     * @param list
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    public boolean deleteContCart(String customerNo, List list) throws Exception;

    /**
     * 清空购物车
     * 
     * @param list
     * @return
     * @throws Exception
     */
    public boolean deleteAllContCart(String customerNo) throws Exception;

    /**
     * 商品检索
     * 
     * @param tGoods
     * @return
     * @throws Exception
     */
    public List<GroupItemDto> getGoodsBySearchParam(String goodsParam) throws Exception;

    /**
     * 取得DB中购物车的数据
     * 
     * @param customerNo
     * @return
     * @throws Exception
     */
    public List<TConsCart> getAllContCart(String customerNo) throws Exception;

    /**
     * 取得DB中购物车的数据给前台Cookie用
     * 
     * @param customerNo
     * @return
     * @throws Exception
     */
    public List<ContCartItemDto> getAllContCartForCookie(String customerNo) throws Exception;

    /**
     * 取得DB中购物车的数据
     * 
     * @param customerNo
     * @return
     * @throws Exception
     */
    public List<ContCartItemDto> getAllContCartForBuy(String customerNo) throws Exception;

    //===================================================================================//
    /**
     * 获取所有的商品分类
     * 
     * @return
     * @throws Exception
     */
    public List<OzTtAdClDto> getAllClassficationForAdmin() throws Exception;

    /**
     * 通过分类号取得分类信息
     * 
     * @param no
     * @return
     * @throws Exception
     */
    public TGoodsClassfication getClassficationByNo(Long no) throws Exception;

    /**
     * 获取自分类
     * 
     * @param classId
     * @return
     * @throws Exception
     */
    public List<TGoodsClassfication> getChildrenClassfication(String classId) throws Exception;

    /**
     * 取得不是指定项目的子项目
     * 
     * @param classId
     * @return
     * @throws Exception
     */
    public List<TGoodsClassfication> getNotChildrenClassfication(String classId) throws Exception;

    /**
     * 保存商品分类信息
     * @param tGoodsClassfication
     * @throws Exception
     */
    public void saveClassFication(TGoodsClassfication tGoodsClassfication) throws Exception;

    /**
     * 更新商品分类信息
     * @param tGoodsClassfication
     * @throws Exception
     */
    public void updateClassFication(TGoodsClassfication tGoodsClassfication) throws Exception;
    
    /**
     * 获取最大的分类ID
     * @param fatherId
     * @throws Exception
     */
    public String getMaxClassNo(String fatherId) throws Exception;
    
    /**
     * 获取二级分类
     * @param classId
     * @return
     * @throws Exception
     */
    public List<TGoodsClassfication> getSecondClassfication(String classId) throws Exception;
    
    /**
     * admin端所有商品定价的获取
     * @param pagination
     * @return
     * @throws Exception
     */
    public PagingResult<OzTtAdPlListDto> getAllGoodsPriceInfoForAdmin(Pagination pagination) throws Exception;
    
    /**
     * 获取商品定价信息
     * @param goodsId
     * @return
     * @throws Exception
     */
    public TGoodsPrice getGoodsSetPriceInfo(String goodsId) throws Exception;
    
    /**
     * 商品定价保存
     * @param tGoodsPrice
     * @throws Exception
     */
    public void saveGoodsSetPrice(TGoodsPrice tGoodsPrice) throws Exception;
    
    /**
     * 商品定价更新
     * @param tGoodsPrice
     * @throws Exception
     */
    public void updateGoodsSetPrice(TGoodsPrice tGoodsPrice) throws Exception;
    
    /**
     * 商品团购保存
     * @param tGoodsGroup
     * @throws Exception
     */
    public void saveGoodsSetGroup(TGoodsGroup tGoodsGroup) throws Exception;
    
    /**
     * 商品团购更新
     * @param tGoodsGroup
     * @throws Exception
     */
    public void updateGoodsSetGroup(TGoodsGroup tGoodsGroup) throws Exception;
    
    /**
     * 商品团购删除
     * @param tGoodsGroup
     * @throws Exception
     */
    public void deleteGoodsSetGroup(TGoodsGroup tGoodsGroup) throws Exception;
    
    /**
     * 商品团购一览
     * @param pagination
     * @return
     * @throws Exception
     */
    public PagingResult<OzTtAdGcListDto> getAllGroupsInfoForAdmin(Pagination pagination) throws Exception;
    
    /**
     * 商品内容一览
     * @param pagination
     * @return
     * @throws Exception
     */
    public PagingResult<OzTtAdGlListDto> getAllGoodsInfoForAdmin(Pagination pagination) throws Exception;
    
    /**
     * 商品保存
     * @param tGoods
     * @throws Exception
     */
    public String saveGoodsForAdmin(TGoods tGoods) throws Exception;
    
    /**
     * 商品保存
     * @param tGoods
     * @throws Exception
     */
    public void updateGoodsForAdmin(TGoods tGoods) throws Exception;
    
    /**
     * 获取团购属性的所有ID
     * @param groupId
     * @return
     * @throws Exception
     */
    public GroupItemIdDto getGroupItemId(String groupId) throws Exception;
    
    /**
     * 获取
     * @return
     * @throws Exception
     */
    public List<String> getMainSearchTab() throws Exception;
}
