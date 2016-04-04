package com.org.oztt.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.dao.TGoodsDao;
import com.org.oztt.entity.TGoods;
import com.org.oztt.formDto.GroupItemDto;
import com.org.oztt.formDto.GroupItemIdDto;
import com.org.oztt.formDto.OzTtAdGlListDto;
import com.org.oztt.formDto.OzTtAdPlListDto;

@Repository
public class TGoodsDaoImpl extends BaseDao implements TGoodsDao {

    public int deleteByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return 0;
    }

    public int insert(TGoods record) {
        // TODO Auto-generated method stub
        return 0;
    }

    public int insertSelective(TGoods record) {
        return insert("com.org.oztt.dao.TGoodsDao.insertSelective", record);
    }

    public TGoods selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    public int updateByPrimaryKeySelective(TGoods record) {
        return update("com.org.oztt.dao.TGoodsDao.updateByPrimaryKeySelective", record);
    }

    public int updateByPrimaryKey(TGoods record) {
        // TODO Auto-generated method stub
        return 0;
    }

    public TGoods selectByGoodsId(String goodsId) {
        return selectOne("com.org.oztt.dao.TGoodsDao.selectByGoodsId", goodsId);
    }

    public List<TGoods> selectByParams(TGoods record) {
        return select("com.org.oztt.dao.TGoodsDao.selectByParams", record);
    }

    public List<TGoods> getFirstThreeNewArravail() {
        return select("com.org.oztt.dao.TGoodsDao.getFirstThreeNewArravail");
    }

    public List<GroupItemDto> getAllNewArravail() {
        return select("com.org.oztt.dao.TGoodsDao.getAllNewArravail");
    }

    public List<GroupItemDto> getGoodsListForMain(Map<String, String> map) {
        return select("com.org.oztt.dao.TGoodsDao.getGoodsListForMain", map);
    }

    public PagingResult<GroupItemDto> getGoodsByParamForPage(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TGoodsDao.getGoodsByParamForPage",
                "com.org.oztt.dao.TGoodsDao.getGoodsByParamForPageCount", pagination);
    }

    @Override
    public List<GroupItemDto> getFiveHotSeller(TGoods record) {
        return select("com.org.oztt.dao.TGoodsDao.getFiveHotSeller", record);
    }
    
    @Override
    public List<GroupItemDto> getHotSeller(TGoods record) {
        return select("com.org.oztt.dao.TGoodsDao.getHotSeller", record);
    }

    @Override
    public List<GroupItemDto> getGoodsBySearchParam(String goodsParam) {
        return select("com.org.oztt.dao.TGoodsDao.getGoodsBySearchParam", goodsParam);
    }

    @Override
    public PagingResult<OzTtAdPlListDto> getAllGoodsPriceInfoForAdmin(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TGoodsDao.getAllGoodsPriceInfoForAdmin",
                "com.org.oztt.dao.TGoodsDao.getAllGoodsPriceInfoForAdminCount", pagination);
    }

    @Override
    public PagingResult<OzTtAdGlListDto> getAllGoodsInfoForAdmin(Pagination pagination) {
        return selectPagination("com.org.oztt.dao.TGoodsDao.getAllGoodsInfoForAdmin",
                "com.org.oztt.dao.TGoodsDao.getAllGoodsInfoForAdminCount", pagination);
    }

    @Override
    public GroupItemIdDto getGroupItemId(String groupId) {
        return null;
    }

}
