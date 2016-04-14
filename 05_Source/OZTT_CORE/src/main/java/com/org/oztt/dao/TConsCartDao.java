package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TConsCart;
import com.org.oztt.formDto.ContCartItemDto;

public interface TConsCartDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long no);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TConsCart record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TConsCart record);

    /**
     * 根据主键查询记录
     */
    TConsCart selectByPrimaryKey(Long no);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TConsCart record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TConsCart record);
    
    /**
     * 根据参数检索出数据
     * @param record
     * @return
     */
    TConsCart selectByParams(TConsCart record);
    
    /**
     * 删除所有购物车的数据
     * @param customerNo 用户号
     */
    void deleteAllContCard(String customerNo);
    
    /**
     * 取得所有购物车的数据
     * @param customerNo
     * @return
     */
    List<TConsCart> getAllContCart(String customerNo);
    
    /**
     * 取得所有购物车的数据Cookie用
     * @param customerNo
     * @return
     */
    List<ContCartItemDto> getAllContCartForCookie(String customerNo);
    
    /**
     * 取得购物车中这次要买的内容
     * @param customerNo
     * @return
     */
    List<ContCartItemDto> getAllContCartForBuy(String customerNo);
    
    /**
     * 生成订单时删除购物车中的数据
     * @param customerNo
     */
    void deleteCurrentBuyGoods(String customerNo);
    
    /**
     * 更新购物车数据不可以购买
     * @param customerNo
     */
    void updateAllCartCannotBuy(String customerNo);
    
    /**
     * 更新购物车数据可以购买
     * @param record
     */
    void updateCartCanBuy(TConsCart record);
    
    
}