package com.org.oztt.dao;

import java.util.List;
import java.util.Map;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TGoods;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.formDto.GroupItemIdDto;
import com.org.oztt.formDto.OzTtAdGlListDto;
import com.org.oztt.formDto.OzTtAdPlListDto;

public interface TGoodsDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long no);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TGoods record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TGoods record);

    /**
     * 根据主键查询记录
     */
    TGoods selectByPrimaryKey(Long no);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TGoods record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TGoods record);

    /**
     * 根据商品ID获取商品信息
     */
    TGoods selectByGoodsId(String goodsId);

    /**
     * 根据商品ID获取商品信息
     */
    List<TGoods> selectByParams(TGoods record);

    /**
     * 获取新货的前三个
     * 
     * @return
     */
    List<TGoods> getFirstThreeNewArravail();

    /**
     * 获取新货
     * 
     * @return
     */
    List<GroupItemDto> getAllNewArravail();

    /**
     * 根据参数获取商品数据
     * 
     * @param map
     * @return
     */
    List<GroupItemDto> getGoodsListForMain(Map<String, String> map);

    /**
     * 分页获取商品信息
     * 
     * @param pagination
     * @return
     */
    PagingResult<GroupItemDto> getGoodsByParamForPage(Pagination pagination);

    /**
     * 热卖的前五个
     * 
     * @param record
     * @return
     */
    List<GroupItemDto> getFiveHotSeller(TGoods record);
    
    /**
     * 热卖
     * 
     * @param record
     * @return
     */
    List<GroupItemDto> getHotSeller(TGoods record);
    
    /**
     * 广告图
     * 
     * @param record
     * @return
     */
    List<GroupItemDto> getTopPage();

    /**
     * 检索商品
     * 
     * @param goodsParam
     * @return
     */
    List<GroupItemDto> getGoodsBySearchParam(String goodsParam);

    /**
     * 商品定价admin端获取
     * 
     * @param pagination
     * @return
     */
    PagingResult<OzTtAdPlListDto> getAllGoodsPriceInfoForAdmin(Pagination pagination);

    /**
     * 商品管理admin端获取
     * 
     * @param pagination
     * @return
     */
    PagingResult<OzTtAdGlListDto> getAllGoodsInfoForAdmin(Pagination pagination);
    
    /**
     * 获取团购属性的所有ID
     * @param groupId
     * @return
     */
    GroupItemIdDto getGroupItemId(String groupId);

}