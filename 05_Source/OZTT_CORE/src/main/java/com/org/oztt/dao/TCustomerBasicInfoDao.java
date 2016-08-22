package com.org.oztt.dao;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.formDto.OzTtAdRlListDto;

public interface TCustomerBasicInfoDao {
    /**
     * 根据主键删除记录
     */
    int deleteByPrimaryKey(Long no);

    /**
     * 保存记录,不管记录里面的属性是否为空
     */
    int insert(TCustomerBasicInfo record);

    /**
     * 保存属性不为空的记录
     */
    int insertSelective(TCustomerBasicInfo record);

    /**
     * 根据主键查询记录
     */
    TCustomerBasicInfo selectByPrimaryKey(Long no);

    /**
     * 根据主键更新属性不为空的记录
     */
    int updateByPrimaryKeySelective(TCustomerBasicInfo record);

    /**
     * 根据主键更新记录
     */
    int updateByPrimaryKey(TCustomerBasicInfo record);
    
    /**
     * 根据主键查询记录
     */
    TCustomerBasicInfo selectBaseInfoByCustomerNo(String customerNo);
    
    /**
     * 获取用户一览信息
     * @param pagination
     * @return
     */
    PagingResult<OzTtAdRlListDto> getAllCustomerInfoForAdmin(Pagination pagination);
    
    OzTtAdRlListDto getCustomerInfoForAdmin(String customerNo);
}