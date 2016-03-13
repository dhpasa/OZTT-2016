package com.org.oztt.dao.impl;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.dao.TCustomerBasicInfoDao;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.formDto.OzTtAdRlListDto;

@Repository
public class TCustomerBasicInfoDaoImpl extends BaseDao implements TCustomerBasicInfoDao {

    public int deleteByPrimaryKey(Long no) {
        return update("com.org.oztt.dao.TCustomerBasicInfoDao.deleteByPrimaryKey", no);
    }

    public int insert(TCustomerBasicInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    public int insertSelective(TCustomerBasicInfo record) {
        return insert("com.org.oztt.dao.TCustomerBasicInfoDao.insertSelective", record);
    }

    public TCustomerBasicInfo selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    public int updateByPrimaryKeySelective(TCustomerBasicInfo record) {
        return update("com.org.oztt.dao.TCustomerBasicInfoDao.updateByPrimaryKeySelective", record);
    }

    public int updateByPrimaryKey(TCustomerBasicInfo record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TCustomerBasicInfo selectBaseInfoByCustomerNo(String customerNo) {
        return selectOne("com.org.oztt.dao.TCustomerBasicInfoDao.selectBaseInfoByCustomerNo", customerNo);
    }

    @Override
    public PagingResult<OzTtAdRlListDto> getAllCustomerInfoForAdmin(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TCustomerBasicInfoDao.getAllCustomerInfoForAdminForPage",
                "com.org.oztt.dao.TCustomerBasicInfoDao.getAllCustomerInfoForAdminForPageCount", pagination);
    }

}
