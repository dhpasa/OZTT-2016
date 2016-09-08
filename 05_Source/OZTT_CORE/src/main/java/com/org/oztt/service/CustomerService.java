package com.org.oztt.service;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerLoginHis;
import com.org.oztt.entity.TCustomerLoginInfo;
import com.org.oztt.entity.TCustomerMemberInfo;
import com.org.oztt.entity.TCustomerSecurityInfo;
import com.org.oztt.entity.TNoCustomer;
import com.org.oztt.formDto.OzTtAdRlListDto;
import com.org.oztt.formDto.OzTtTpFpDto;
import com.org.oztt.formDto.OzTtTpReDto;

/**
 * 用户登录注册调用的服务
 * 
 * @author linliuan
 */
public interface CustomerService {

    // 检测用户，密码是否正确
    public TCustomerLoginInfo userLogin(String loginId, String password) throws Exception;

    // 检测用户，密码是否正确
    public TCustomerLoginInfo userLoginForPhone(String phone, String password) throws Exception;

    // 插入登录历史记录
    public boolean insertLoginHisAndUpdateStatus(TCustomerLoginHis tCustomerLoginHis) throws Exception;

    // 用户登出时更新登出记录
    public boolean loginOut(String userId) throws Exception;

    // 用户注册用
    public String insertRegister(OzTtTpReDto ozTtTpReDto) throws Exception;

    // 伤处用户注册信息
    public void deleteRegister(String customerNo) throws Exception;

    // 取得最新的客户号
    public TNoCustomer getMaxCustomerNo() throws Exception;

    // 取得用户
    public TCustomerLoginInfo selectByEmail(String email) throws Exception;

    // 取得用户
    public TCustomerLoginInfo selectByCustomerNo(String customerNo) throws Exception;

    // 更新密码
    public boolean updatePassword(OzTtTpFpDto ozTtTpFpDto) throws Exception;

    // 更新用户登陆信息表
    public boolean updateTCustomerLoginInfo(TCustomerLoginInfo tCustomerLoginInfo) throws Exception;

    // 取得用户
    public TCustomerBasicInfo selectBaseInfoByCustomerNo(String customerNo) throws Exception;

    // 更新用户基本信息
    public int updateTCustomerBasicInfo(TCustomerBasicInfo tCustomerBasicInfo) throws Exception;

    /**
     * 获取所有用户的信息
     * 
     * @param pagination
     * @return
     * @throws Exception
     */
    public PagingResult<OzTtAdRlListDto> getAllCustomerInfoForAdmin(Pagination pagination) throws Exception;

    public OzTtAdRlListDto getCustomerInfoForAdmin(String customerNo) throws Exception;

    // 通过手机号取得客户号
    public TCustomerSecurityInfo getCustomerByPhone(String phone) throws Exception;

    // 取得客户信息
    public TCustomerSecurityInfo getCustomerSecurityByCustomerNo(String customerNo) throws Exception;

    /**
     * 更新客户的积分和级别
     * 
     * @param customerNo
     * @throws Exception
     */
    public void updateCustomerPointsAndLevels(String orderDetailNo, String customerNo) throws Exception;
    
    public void updateCustomerPointsAndLevelsBatch(String orderNo, String customerNo) throws Exception;
    

    /**
     * 取得当前客户的会员信息
     * 
     * @param customerNo
     * @return
     * @throws Exception
     */
    public TCustomerMemberInfo getCustomerMemberInfo(String customerNo) throws Exception;

    public void saveTCustomerMemberInfo(TCustomerMemberInfo info) throws Exception;

    public void updateTCustomerMemberInfo(TCustomerMemberInfo info) throws Exception;
}
