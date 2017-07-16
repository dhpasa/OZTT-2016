package com.org.oztt.service;

import java.util.List;

import com.org.oztt.base.common.MyCategroy;
import com.org.oztt.base.common.MyMap;
import com.org.oztt.entity.TSysCode;

/**
 * 共同模块的调用
 * 
 * @author linliuan
 */
public interface CommonService {

    public List<MyMap> getSex() throws Exception;

    public List<MyMap> getEducation() throws Exception;
    
    public List<MyMap> getIsMarried() throws Exception;
    
    public List<MyMap> getDeliveryTime() throws Exception;
    
    public List<MyMap> getOrderStatus() throws Exception;
    
    public List<MyMap> getOrderDetailStatus() throws Exception;
    
    public List<MyMap> getPayment() throws Exception;
    
    public List<MyMap> getDelivery() throws Exception;
    
    public List<MyMap> getOpenFlg() throws Exception;
    
    public List<MyMap> getCustomerLevel() throws Exception;
    
    public List<TSysCode> getPowderStage() throws Exception;

    /**
     * 检索出菜单项目
     * 
     * @return
     * @throws Exception
     */
    public List<MyCategroy> getMyCategroy() throws Exception;
    
    /**
     * 获取手机验证码
     * @param phone
     * @return
     * @throws Exception
     */
    public boolean getPhoneVerifyCode(String phone) throws Exception;
    
    /**
     * 验证手机验证码
     * @param phone
     * @return
     * @throws Exception
     */
    public boolean checkPhoneVerifyCode(String phone, String verifyCode) throws Exception;
    
    /**
     * 获取地区下拉列表
     * @return
     * @throws Exception
     */
    public List<MyMap> getSuburbList() throws Exception;
    
    /**
     * 通过分类ID获取自分类的项目
     * @param categoryId
     * @return
     * @throws Exception
     */
    public List<MyCategroy> getSubCategory(String categoryId) throws Exception;
    
    /**
     * 获取首页的分类项目
     * @return
     * @throws Exception
     */
    public List<MyCategroy> getMainCategory() throws Exception;
    

}
