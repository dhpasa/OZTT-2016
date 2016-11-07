package com.org.oztt.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.dao.TGoodsGroupDao;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.formDto.OzTtAdGcListDto;
import com.org.oztt.formDto.OzTtAdGsListDto;

@Repository
public class TGoodsGroupDaoImpl extends BaseDao implements TGoodsGroupDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        return update("com.org.oztt.dao.TGoodsGroupDao.deleteByPrimaryKey", no);
    }

    @Override
    public int insert(TGoodsGroup record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TGoodsGroup record) {
        return insert("com.org.oztt.dao.TGoodsGroupDao.insertSelective", record);
    }

    @Override
    public TGoodsGroup selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TGoodsGroup record) {
        return update("com.org.oztt.dao.TGoodsGroupDao.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TGoodsGroup record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public TGoodsGroup selectByParams(TGoodsGroup record) {
        return selectOne("com.org.oztt.dao.TGoodsGroupDao.selectByParams", record);
    }

    @Override
    public int updateCurrentQuantity(TGoodsGroup record) {
        return update("com.org.oztt.dao.TGoodsGroupDao.updateCurrentQuantity", record);
    }

    @Override
    public PagingResult<OzTtAdGcListDto> getAllGroupsInfoForAdmin(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TGoodsGroupDao.getAllGroupsInfoForAdmin",
                "com.org.oztt.dao.TGoodsGroupDao.getAllGroupsInfoForAdminCount", pagination);
    }
    
    @Override
    public List<OzTtAdGcListDto> getAllGroupsInfoForAdminNoPage() {
        return select("com.org.oztt.dao.TGoodsGroupDao.getAllGroupsInfoForAdmin", new HashMap<Object, Object>());
    }
	@Override
	public PagingResult<OzTtAdGsListDto> getAllGoodsRInfoForAdmin(Pagination pagination) {
		 return selectPagination("com.org.oztt.dao.TGoodsGroupDao.searchGoodsView",
	                "com.org.oztt.dao.TGoodsGroupDao.searchGoodsViewCount", pagination);
	}
	@Override
	public Object getProductsCount(Map<Object, Object> param) {
		return selectOne("com.org.oztt.dao.TGoodsGroupDao.searchProductsCount", param);
	}
}
