package com.org.oztt.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.org.oztt.base.dao.BaseDao;
import com.org.oztt.dao.TConsCartDao;
import com.org.oztt.entity.TConsCart;
import com.org.oztt.formDto.ContCartItemDto;

@Repository
public class TConsCartDaoImpl extends BaseDao implements TConsCartDao {

    @Override
    public int deleteByPrimaryKey(Long no) {
        return update("com.org.oztt.dao.TConsCartDao.deleteByPrimaryKey", no);
    }

    @Override
    public int insert(TConsCart record) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(TConsCart record) {
        return insert("com.org.oztt.dao.TConsCartDao.insertSelective", record);
    }

    @Override
    public TConsCart selectByPrimaryKey(Long no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(TConsCart record) {
        return update("com.org.oztt.dao.TConsCartDao.updateByPrimaryKeySelective", record);
    }

    @Override
    public int updateByPrimaryKey(TConsCart record) {
        return update("com.org.oztt.dao.TConsCartDao.updateByPrimaryKey", record);
    }

    @Override
    public TConsCart selectByParams(TConsCart record) {
        return selectOne("com.org.oztt.dao.TConsCartDao.selectByParams", record);
    }

    @Override
    public void deleteAllContCard(String customerNo) {
        update("com.org.oztt.dao.TConsCartDao.deleteAllContCard", customerNo);
    }

    @Override
    public List<TConsCart> getAllContCart(String customerNo) {
        return select("com.org.oztt.dao.TConsCartDao.getAllContCart", customerNo);
    }

    @Override
    public List<ContCartItemDto> getAllContCartForCookie(String customerNo) {
        return select("com.org.oztt.dao.TConsCartDao.getAllContCartForCookie", customerNo);
    }

    @Override
    public List<ContCartItemDto> getAllContCartForBuy(String customerNo) {
        return select("com.org.oztt.dao.TConsCartDao.getAllContCartForBuy", customerNo);
    }

    @Override
    public void deleteCurrentBuyGoods(String customerNo) {
        update("com.org.oztt.dao.TConsCartDao.deleteCurrentBuyGoods", customerNo);
    }

    @Override
    public void updateAllCartCannotBuy(String customerNo) {
        update("com.org.oztt.dao.TConsCartDao.updateAllCartCannotBuy", customerNo);
        
    }

    @Override
    public void updateCartCanBuy(TConsCart record) {
        update("com.org.oztt.dao.TConsCartDao.updateCartCanBuy", record);
    }

}
