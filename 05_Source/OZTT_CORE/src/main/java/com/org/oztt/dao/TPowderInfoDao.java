package com.org.oztt.dao;

import java.util.List;

import com.org.oztt.entity.TPowderInfo;
import com.org.oztt.formDto.PowderInfoViewDto;

public interface TPowderInfoDao {
    int deleteByPrimaryKey(Long id);

    int insert(TPowderInfo record);

    int insertSelective(TPowderInfo record);

    TPowderInfo selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TPowderInfo record);

    int updateByPrimaryKey(TPowderInfo record);

    List<PowderInfoViewDto> selectAllPowderInfoList();

    TPowderInfo selectByParam(TPowderInfo record);
}