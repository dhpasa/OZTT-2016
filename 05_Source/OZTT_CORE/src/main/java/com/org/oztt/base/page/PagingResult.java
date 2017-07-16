/**   
 * Title: PagingResult.java
 * Package com.tiangou.me.core.support
 * All rights Reserved, Designed By soyo
 * Copyright: Copyright(C) 2010-2015
 * Company: soyo SuZhou LTD.
 * Create By shensuoyao
 * Create Date 2014年7月10日 下午4:10:36
 * Version V1.0
 */
package com.org.oztt.base.page;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: PagingResult
 * @Description: 分页结果
 */
public class PagingResult<T> {
	
	// 当前页
	private int currentPage;
	
	//总页数
	private int totalPage;
	
	// 总共记录条数
	private int totalSize;
	
	//每页显示数量
	private int pageSize;
	
	private int pageNoSize = 10;
	
	// 结果集
	private List<T> resultList = new ArrayList<T>();
	
	
	/** 
	* @Fields params : 查询条件
	*/ 
	private Map<String, Object> params;

	/**
	 * @return currentPage
	 */
	public int getCurrentPage() {
		return currentPage;
	}

	/**
	 * @param currentPage
	 *            要设置的 currentPage
	 */
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	/**
	 * @return totalSize
	 */
	public int getTotalSize() {
		return totalSize;
	}

	/**
	 * @param totalSize
	 *            要设置的 totalSize
	 */
	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}

	/**
	 * @return resultList
	 */
	public List<T> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList
	 *            要设置的 resultList
	 */
	public void setResultList(List<T> resultList) {
		this.resultList = resultList;
	}

	/** 
	 * @return totalPage
	 */
	public int getTotalPage() {
		if(this.totalPage > 0) {
			return this.totalPage;
		}
		this.totalPage = this.totalSize / this.pageSize;
		this.totalPage += 1; 
		return totalPage;
	}

	/** 
	 * @param totalPage 要设置的 totalPage
	 */
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	/** 
	 * @return pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}

	/** 
	 * @param pageSize 要设置的 pageSize
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	/** 
	* @Title: prevPage
	* @Description: 上一页页码
	* @author shensuoyao
	* @date 2014年7月11日 上午10:52:17
	* @return int
	* @throws 
	*/ 
	public int getPrevPage() {
		int p = this.currentPage - 1;
		if(p > 0) {
			return p;
		}
		return this.currentPage;
	}
	
	/** 
	* @Title: nextPage
	* @Description: 下一页页码
	* @return int
	* @throws 
	*/ 
	public int getNextPage() {
		int p = this.currentPage + 1;
		if(p > this.getTotalPage()) {
			return this.currentPage;
		}
		return p;
	}
	
	/** 
	* @Title: hasPrevPage
	* @Description: 是否有上一页
	* @return boolean
	* @throws 
	*/ 
	public boolean hasPrevPage() {
		return getPrevPage() < this.currentPage;
	}
	
	/** 
	* @Title: hasNext
	* @Description: 是否有下一页
	* @return boolean
	* @throws 
	*/ 
	public boolean hasNextPage() {
		return getNextPage() > this.currentPage;
	}
	
    /** get page no **/
    public long getFirstPage() {
        if ((currentPage - 1) > 0) {
            return 1;
        } else {
            return 0;
        }
    }
    
    public long getLastPage() {
        if ((currentPage + 1) <= getTotalPage()) {
            return (getTotalPage());
        } else {
            return 0;
        }
    }
	
	/** 
	* @Title: getResultSize
	* @Description: 获取结果集数量
	* @return int
	* @throws 
	*/ 
	public int getResultSize() {
		return this.resultList.size();
	}

	/** 
	 * @return params
	 */
	public Map<String, Object> getParams() {
		return params;
	}

	/** 
	 * @param params 要设置的 params
	 */
	public void setParams(Map<String, Object> params) {
		this.params = params;
	}
	
	

    public int getPageNoSize() {
        return pageNoSize;
    }

    public void setPageNoSize(int pageNoSize) {
        this.pageNoSize = pageNoSize;
    }

    public List<Integer> getPageList() {
		List<Integer> numberList = new ArrayList<Integer>();
		if(this.getTotalPage() <= pageNoSize){
	    	for(int i = 0; i < this.getTotalPage(); i++){
	    		numberList.add(i+1);
	    	}
	    }else {
	    	if(this.getCurrentPage() <= (pageNoSize/2)){
	        	for(int i = 0; i < pageNoSize; i++){
	        		numberList.add(i+1);
	        	}
	    	}else if(this.getCurrentPage() > (this.getTotalPage() - (pageNoSize/2))){
	    		for(int i = (int) this.getTotalPage()-10; i< this.getTotalPage(); i++){
	    			numberList.add(i+1);
	    		}
	    	}else{
	    		for(int i = (int) this.getCurrentPage()-(pageNoSize/2); i< this.getCurrentPage()+(pageSize/2); i++){
	    			numberList.add(i+1);
	    		}
	    	}
	    }
		
		return numberList;
	}


}
