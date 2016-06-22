package com.org.oztt.base.page;

import java.util.Map;

/**
 * @ClassName: Pagination
 * @Description: 分页对象
 */
public class Pagination {
	
	private Integer page = 1; // 目前是第几页
	
	private Integer size = 20; // 每页大小
	
	private Map<Object, Object> params; // 传入的参数
	
	private String orderColumn;
	
	private String orderTurn = "ASC";
	
	private Integer pageNoSize = 10;
	
	public Pagination() {super();}
	
	public Pagination(Integer _page) {
		if(_page != null) {
			this.page = _page;
		}
	}
	
	public Pagination(Integer _page, Integer _size) {
		this(_page);
		if(null != _size) {
			this.size = _size;
		}
	}
	
	/**
	 * @return page
	 */
	public Integer getPage() {
		return (null == page || 0 == page) ? 1 : page;
	}

	/**
	 * @param page
	 *            要设置的 page
	 */
	public void setPage(Integer page) {
		this.page = page;
	}

	/**
	 * @return size
	 */
	public Integer getSize() {
		return size;
	}

	/**
	 * @param size
	 *            要设置的 size
	 */
	public void setSize(Integer size) {
		this.size = size;
	}

	/**
	 * @return params
	 */
	public Map<Object, Object> getParams() {
		return params;
	}

	/**
	 * @param params
	 *            要设置的 params
	 */
	public void setParams(Map<Object, Object> params) {
		this.params = params;
	}

	/**
	 * @return orderColumn
	 */
	public String getOrderColumn() {
		return orderColumn;
	}

	/**
	 * @param orderColumn
	 *            要设置的 orderColumn
	 */
	public void setOrderColumn(String orderColumn) {
		this.orderColumn = orderColumn;
	}

	/**
	 * @return orderTurn
	 */
	public String getOrderTurn() {
		return orderTurn;
	}

	/**
	 * @param orderTurn
	 *            要设置的 orderTurn
	 */
	public void setOrderTurn(String orderTurn) {
		this.orderTurn = orderTurn;
	}

    public Integer getPageNoSize() {
        return pageNoSize;
    }

    public void setPageNoSize(Integer pageNoSize) {
        this.pageNoSize = pageNoSize;
    }
	
}
