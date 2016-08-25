package com.org.oztt.dao;

import com.org.oztt.entity.TCustomerMemberInfo;

public interface TCustomerMemberInfoDao {
    int deleteByPrimaryKey(Long no);

    int insert(TCustomerMemberInfo record);

    int insertSelective(TCustomerMemberInfo record);

    TCustomerMemberInfo selectByPrimaryKey(Long no);

    int updateByPrimaryKeySelective(TCustomerMemberInfo record);

    int updateByPrimaryKey(TCustomerMemberInfo record);
    
    TCustomerMemberInfo selectByCustomerNo(String customer);
}