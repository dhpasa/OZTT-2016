package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TPowderOrder;
import com.org.oztt.formDto.PowderOrderInfo;

public interface TPowderOrderDao {
    int deleteByPrimaryKey(Long id);

    int insert(TPowderOrder record);

    int insertSelective(TPowderOrder record);

    TPowderOrder selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TPowderOrder record);

    int updateByPrimaryKey(TPowderOrder record);

    int selectAutoIncrement();

    TPowderOrder selectByParam(TPowderOrder record);

    List<TPowderOrder> getTPowderOrderInfoList(TPowderOrder tPowderOrder);

    PagingResult<PowderOrderInfo> getPowderOrderPageInfo(Pagination pagination);
    
    void deleteNoPayOrder();
}