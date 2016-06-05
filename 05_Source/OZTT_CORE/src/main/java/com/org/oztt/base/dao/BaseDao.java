package com.org.oztt.base.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.dao.DataAccessException;

import com.org.oztt.base.entity.BaseEntity;
import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;

/**
 * @ClassName: BaseDao
 * @Description: 数据库操作基本实现类
 */
public abstract class BaseDao extends SqlSessionDaoSupport {

    @Resource(name = "sqlSession")
    public SqlSessionTemplate sqlSession;

    @Override
    @Resource(name = "sqlSession")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSession) {
        super.setSqlSessionTemplate(sqlSession);
    }

    public Integer insert(String statementName, Object entity) {
        return sqlSession.insert(statementName, entity);
    }

    public Integer insertForBatch(String statementName, Object entity) {
        return sqlSession.insert(statementName, entity);
    }

    public Integer update(String statementName, Object entity) {
        return sqlSession.update(statementName, entity);
    }

    public Integer insertForBbs(String statementName, Object entity) {
        return sqlSession.insert(statementName, entity);
    }
    
    

    /**
     * 更新考虑排他
     * 
     * @param statementName
     * @param entity
     * @return
     */
    public Integer updateForConcurrent(String statementName, BaseEntity entity) {
        int updateCount = sqlSession.update(statementName, entity);
        if (updateCount == 0) {
            //throw new DBConcurrencyException(MessageUtils.getText("err.com.db.concurrent"));
        	//TODO
        	return 0;
        }
        else {
            return updateCount;
        }
    }

    public int delete(String statementName, BaseEntity entity) {
        return sqlSession.delete(statementName, entity);
    }
    
    public int deleteObj(String statementName, Object entity) {
        return sqlSession.delete(statementName, entity);
    }

    /**
     * 删除考虑并发
     * 
     * @param statementName
     * @param entity
     * @return
     */
    public int deleteForConcurrent(String statementName, BaseEntity entity) {
        int updateCount = sqlSession.delete(statementName, entity);
        if (updateCount == 0) {
            //throw new DBConcurrencyException(MessageUtils.getText("err.com.db.concurrent"));TODO
        	return 0;
        }
        else {
            return updateCount;
        }
    }

    public <T> PagingResult<T> selectPagination(String statementName, String countStatementName, Pagination pagination)
            throws RuntimeException {
        try {
            // 默认为第一页
            int page = pagination.getPage();
            // 默认每页15个
            int size = pagination.getSize();
            // 页码默认10
            int pageNoSize = pagination.getPageNoSize();

            RowBounds rowBounds = new RowBounds((page - 1) * size, size);

            Map<Object, Object> param = pagination.getParams();
            if (param != null) {
                param.put("orderColumn", pagination.getOrderColumn());
                param.put("orderTurn", pagination.getOrderTurn());
            }
            else {
                param = new HashMap<Object, Object>();
                param.put("orderColumn", pagination.getOrderColumn());
                param.put("orderTurn", pagination.getOrderTurn());
            }

            List<T> resultList = sqlSession.selectList(statementName, param, rowBounds);
            int totalSize = count(countStatementName, pagination.getParams());

            PagingResult<T> pagingResult = new PagingResult<T>();
            pagingResult.setCurrentPage(page);
            pagingResult.setTotalSize(totalSize);
            pagingResult.setPageSize(size);
            pagingResult.setResultList(resultList);
            pagingResult.setPageNoSize(pageNoSize);
            return pagingResult;
        }
        catch (DataAccessException e) {
            throw new RuntimeException(e);
        }
    }

    public <T> PagingResult<T> selectPagination(String statementName, Pagination pagination) throws RuntimeException {
        try {
            // 默认为第一页
            int page = pagination.getPage();
            // 默认每页15个
            int size = pagination.getSize();
            //页码默认10
            int pageNoSize = pagination.getPageNoSize();

            RowBounds rowBounds = new RowBounds((page - 1) * size, size);

            Map<Object, Object> param = pagination.getParams();
            if (param != null) {
                param.put("orderColumn", pagination.getOrderColumn());
                param.put("orderTurn", pagination.getOrderTurn());
            }
            else {
                param = new HashMap<Object, Object>();
                param.put("orderColumn", pagination.getOrderColumn());
                param.put("orderTurn", pagination.getOrderTurn());
            }

            List<T> resultList = sqlSession.selectList(statementName, param, rowBounds);
            int totalSize = select(statementName, param).size();

            PagingResult<T> pagingResult = new PagingResult<T>();
            pagingResult.setCurrentPage(page);
            pagingResult.setTotalSize(totalSize);
            pagingResult.setPageSize(size);
            pagingResult.setResultList(resultList);
            pagingResult.setPageNoSize(pageNoSize);
            return pagingResult;
        }
        catch (DataAccessException e) {
            throw new RuntimeException(e);
        }
    }

    public <T> T selectOne(String statementName, Object obj) throws RuntimeException {
        try {
            return sqlSession.selectOne(statementName, obj);
        }
        catch (DataAccessException e) {
            throw new RuntimeException(e);
        }
    }

    public int count(String statementName, Object param) throws RuntimeException {
        try {
            return sqlSession.selectOne(statementName, param);
        }
        catch (DataAccessException e) {
            throw new RuntimeException(e);
        }
    }

    public <T> List<T> select(String statementName) throws RuntimeException {
        try {
            return sqlSession.selectList(statementName);
        }
        catch (DataAccessException e) {
            throw new RuntimeException(e);
        }
    }

    public <T> List<T> select(String statementName, Object obj) throws RuntimeException {
        try {
            return sqlSession.selectList(statementName, obj);
        }
        catch (DataAccessException e) {
            throw new RuntimeException(e);
        }
    }

    public void executeSP(String statementName, Object param) {
        try {
            sqlSession.selectOne(statementName, param);
        }
        catch (DataAccessException e) {
            throw new RuntimeException(e);
        }
    }
}
