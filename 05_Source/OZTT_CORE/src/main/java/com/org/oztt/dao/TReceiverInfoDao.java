package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TReceiverInfo;

public interface TReceiverInfoDao {
    int deleteByPrimaryKey(Long id);

    int insert(TReceiverInfo record);

    int insertSelective(TReceiverInfo record);

    TReceiverInfo selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TReceiverInfo record);

    int updateByPrimaryKey(TReceiverInfo record);
    
    List<TReceiverInfo> selectReceiveList(String customerId);
    
    PagingResult<TReceiverInfo> selectReceivePageList(Pagination pagination);
    
}