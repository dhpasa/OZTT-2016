/**
 * 
 */
package com.org.oztt.service;

import com.org.oztt.entity.TSysConfig;
import com.org.oztt.formDto.OzTtAdScDto;

/**
 * @author x-wang
 *
 */
public interface SysConfigService {

	/**
	 * 根据主键系统配置信息
	 */
	public TSysConfig getByNo(Long no);
	
	/**
	 * 获取首页轮播图片
	 */
	public TSysConfig getTopPageAdPic();

	/**
	 * 获取待更新内容（1:【联系客服】、2:【商家合作】、3:【关于团团】）
	 */
	public TSysConfig getContent(int division);

	/**
	 * 更新内容
	 */
	public void update(OzTtAdScDto ozTtAdScDto);
}
