package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.formDto.OzTtAdGcListDto;
import com.org.oztt.formDto.OzTtAdGsListDto;

public interface TGoodsGroupDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long no);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TGoodsGroup record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TGoodsGroup record);

    /**
     * 根据主键查询记录
     */
    TGoodsGroup selectByPrimaryKey(Long no);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TGoodsGroup record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TGoodsGroup record);
    
    /**
     * 根据参数检索出数据
     * @param record
     * @return
     */
    TGoodsGroup selectByParams(TGoodsGroup record);
    
    /**
     * 购买产品后更新团购信息
     * @param record
     * @return
     */
    int updateCurrentQuantity(TGoodsGroup record);
    
    /**
     * 
     * @param pagination
     * @return
     */
    PagingResult<OzTtAdGcListDto> getAllGroupsInfoForAdmin(Pagination pagination);
    
    /**
     * 
     * @param pagination
     * @return
     */
    List<OzTtAdGcListDto> getAllGroupsInfoForAdminNoPage();
    
    /**
    *
    * @param pagination
    * @return
    */
   PagingResult<OzTtAdGsListDto> getAllGoodsRInfoForAdmin(Pagination pagination);
}