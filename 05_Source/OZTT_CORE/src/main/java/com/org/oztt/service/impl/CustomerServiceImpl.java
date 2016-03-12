package com.org.oztt.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Service;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.PasswordEncryptSalt;
import com.org.oztt.base.util.PasswordEncryptSaltUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.dao.TCustomerBasicInfoDao;
import com.org.oztt.dao.TCustomerLoginHisDao;
import com.org.oztt.dao.TCustomerLoginInfoDao;
import com.org.oztt.dao.TCustomerSecurityInfoDao;
import com.org.oztt.dao.TNoCustomerDao;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerLoginHis;
import com.org.oztt.entity.TCustomerLoginInfo;
import com.org.oztt.entity.TCustomerSecurityInfo;
import com.org.oztt.entity.TNoCustomer;
import com.org.oztt.formDto.OzTtAdRlListDto;
import com.org.oztt.formDto.OzTtTpFpDto;
import com.org.oztt.formDto.OzTtTpReDto;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.CustomerService;

@Service
public class CustomerServiceImpl extends BaseService implements CustomerService {

    @Resource
    private TCustomerLoginInfoDao    tCustomerLoginInfoDao;

    @Resource
    private TCustomerLoginHisDao     tCustomerLoginHisDao;

    @Resource
    private TNoCustomerDao           tNoCustomerDao;

    @Resource
    private TCustomerBasicInfoDao    tCustomerBasicInfoDao;

    @Resource
    private TCustomerSecurityInfoDao tCustomerSecurityInfoDao;

    public TCustomerLoginInfo userLogin(String loginId, String password) throws Exception {
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("username", loginId);
        paramMap.put("password", password);
        return tCustomerLoginInfoDao.userLogin(paramMap);

    }

    public boolean insertLoginHisAndUpdateStatus(TCustomerLoginHis tCustomerLoginHis) throws Exception {
        tCustomerLoginHis.setLogintimestamp(new Date());
        Integer records = tCustomerLoginHisDao.insert(tCustomerLoginHis);
        if (records <= 0) {
            return false;
        }
        // 改变登录状态
        TCustomerLoginInfo info = this.selectByCustomerNo(tCustomerLoginHis.getCustomerno());
        info.setLoginstatus(CommonConstants.HAS_LOGINED_STATUS);
        info.setUpdtimestamp(new Date());
        info.setUpdpgmid("OZ_TT_TP_LG");
        info.setUpduserkey(tCustomerLoginHis.getCustomerno());
        records = tCustomerLoginInfoDao.updateByPrimaryKey(info);
        if (records <= 0)
            return false;
        return true;
    }

    public boolean loginOut(String userId) throws Exception {
        // TODO Auto-generated method stub
        return false;
    }

    public String insertRegister(OzTtTpReDto ozTtTpReDto) throws Exception {

        String maxCustomer = "";
        // 获取最大的客户号
        TNoCustomer maxTNoCustomer = this.getMaxCustomerNo();
        String nowDateString = DateFormatUtils.getNowTimeFormat("yyyyMMdd");
        Integer len = CommonConstants.FIRST_NUMBER.length();
        if (maxTNoCustomer == null) {
            maxCustomer = nowDateString + CommonConstants.FIRST_NUMBER;
            // 客户号最大值的保存
            TNoCustomer tNoCustomer = new TNoCustomer();
            tNoCustomer.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
            tNoCustomer.setMaxno(maxCustomer);
            tNoCustomerDao.insertSelective(tNoCustomer);
        }
        else {
            if (DateFormatUtils.getDateFormatStr(DateFormatUtils.PATTEN_YMD_NO_SEPRATE)
                    .equals(maxTNoCustomer.getDate())) {
                // 属于同一天
                // 客户号最大值的保存
                maxCustomer = nowDateString
                        + StringUtils.leftPad(
                                String.valueOf(Integer.valueOf(maxTNoCustomer.getMaxno().substring(8)) + 1), len, "0");
                maxTNoCustomer.setMaxno(maxCustomer);
                tNoCustomerDao.updateByPrimaryKeySelective(maxTNoCustomer);
            }
            else {
                maxCustomer = nowDateString + CommonConstants.FIRST_NUMBER;
                // 客户号最大值的保存
                TNoCustomer tNoCustomer = new TNoCustomer();
                tNoCustomer.setDate(DateFormatUtils.getNowTimeFormat("yyyyMMdd"));
                tNoCustomer.setMaxno(maxCustomer);
                tNoCustomerDao.insertSelective(tNoCustomer);
            }
        }

        // 可用登录信息的保存
        TCustomerLoginInfo tCustomerLoginInfo = new TCustomerLoginInfo();
        tCustomerLoginInfo.setAddtimestamp(new Date());
        tCustomerLoginInfo.setAdduserkey(maxCustomer);
        tCustomerLoginInfo.setCustomerno(maxCustomer);
        tCustomerLoginInfo.setDeleteflg(CommonConstants.IS_NOT_DELETE);
        
        tCustomerLoginInfo.setLoginid(ozTtTpReDto.getEmail());
        tCustomerLoginInfo.setLoginpass(ozTtTpReDto.getPassword());

        PasswordEncryptSalt returnEnti = PasswordEncryptSaltUtils.encryptPassword(ozTtTpReDto.getPassword());
        
        tCustomerLoginInfo.setCanlogin(CommonConstants.CANNOT_LOGIN);
        tCustomerLoginInfo.setLoginstatus(CommonConstants.LOGIN_STATUS_NORMAL);
        tCustomerLoginInfoDao.insertSelective(tCustomerLoginInfo);

        // 人员基本信息
        TCustomerBasicInfo tCustomerBasicInfo = new TCustomerBasicInfo();
        tCustomerBasicInfo.setAddtimestamp(new Date());
        tCustomerBasicInfo.setAdduserkey(maxCustomer);
        tCustomerBasicInfo.setBirthday(ozTtTpReDto.getBirthday());
        tCustomerBasicInfo.setCngivenname(ozTtTpReDto.getCngivenname());
        tCustomerBasicInfo.setCnsurname(ozTtTpReDto.getCnsurname());
        tCustomerBasicInfo.setCustomerno(maxCustomer);
        tCustomerBasicInfo.setDeleteflg(CommonConstants.IS_NOT_DELETE);
        tCustomerBasicInfo.setEducation(ozTtTpReDto.getEducation());
        tCustomerBasicInfo.setEnfirstname(ozTtTpReDto.getEnfirstname());
        tCustomerBasicInfo.setEnlastname(ozTtTpReDto.getEnlastname());
        tCustomerBasicInfo.setEnmiddlename(ozTtTpReDto.getEnmiddlename());
        tCustomerBasicInfo.setHeadpic(ozTtTpReDto.getHeadpic());
        tCustomerBasicInfo.setIdcardno(ozTtTpReDto.getIdcardno());
        tCustomerBasicInfo.setMarriage(ozTtTpReDto.getMarriage());
        tCustomerBasicInfo.setNickname(ozTtTpReDto.getNickname());
        tCustomerBasicInfo.setOccupation(ozTtTpReDto.getOccupation());
        tCustomerBasicInfo.setPassportno(ozTtTpReDto.getPassportno());
        tCustomerBasicInfo.setSex(ozTtTpReDto.getSex());
        tCustomerBasicInfoDao.insertSelective(tCustomerBasicInfo);

        // 插入用户登陆表
        TCustomerSecurityInfo tCustomerSecurityInfo = new TCustomerSecurityInfo();
        tCustomerSecurityInfo.setAddtimestamp(new Date());
        tCustomerSecurityInfo.setAdduserkey(maxCustomer);
        tCustomerSecurityInfo.setCustomerno(maxCustomer);
        tCustomerSecurityInfo.setTelno(ozTtTpReDto.getPhone());
        tCustomerSecurityInfo.setEmailaddr(ozTtTpReDto.getEmail());
        tCustomerSecurityInfoDao.insertSelective(tCustomerSecurityInfo);

        return maxCustomer;
    }

    public TNoCustomer getMaxCustomerNo() throws Exception {
        TNoCustomer maxCustomer = tNoCustomerDao.getMaxCustomerNo();
        return maxCustomer;
    }

    public TCustomerLoginInfo selectByEmail(String email) throws Exception {
        return tCustomerLoginInfoDao.selectByEmail(email);
    }

    public TCustomerLoginInfo selectByCustomerNo(String customerNo) throws Exception {
        return tCustomerLoginInfoDao.selectByCustomerNo(customerNo);
    }

    public boolean updatePassword(OzTtTpFpDto ozTtTpFpDto) throws Exception {
        TCustomerLoginInfo info = this.selectByCustomerNo(ozTtTpFpDto.getCustomerNo());
        info.setLoginpass(ozTtTpFpDto.getNewPassword());
        info.setUpdtimestamp(new Date());
        info.setUpdpgmid("OZ_TT_TP_FP");
        info.setUpduserkey(ozTtTpFpDto.getCustomerNo());
        Integer records = tCustomerLoginInfoDao.updateByPrimaryKey(info);
        if (records == 0)
            return false;
        return true;
    }

    @Override
    public boolean updateTCustomerLoginInfo(TCustomerLoginInfo tCustomerLoginInfo) throws Exception {
        int upcount = tCustomerLoginInfoDao.updateByPrimaryKeySelective(tCustomerLoginInfo);
        if (upcount > 0) {
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public TCustomerBasicInfo selectBaseInfoByCustomerNo(String customerNo) throws Exception {
        return tCustomerBasicInfoDao.selectBaseInfoByCustomerNo(customerNo);
    }

    @Override
    public int updateTCustomerBasicInfo(TCustomerBasicInfo tCustomerBasicInfo) throws Exception {
        return tCustomerBasicInfoDao.updateByPrimaryKeySelective(tCustomerBasicInfo);
    }

    @Override
    public PagingResult<OzTtAdRlListDto> getAllCustomerInfoForAdmin(Pagination pagination) throws Exception {
        PagingResult<OzTtAdRlListDto> page = tCustomerBasicInfoDao.getAllCustomerInfoForAdmin(pagination);
        if (!CollectionUtils.isEmpty(page.getResultList())) {
            int i = 0;
            for (OzTtAdRlListDto dto : page.getResultList()) {
                dto.setDetailNo(String.valueOf((page.getCurrentPage() - 1) * page.getPageSize() + ++i));
                dto.setBirthday(DateFormatUtils.date2StringWithFormat(
                        DateFormatUtils.string2DateWithFormat(dto.getBirthday(), DateFormatUtils.PATTEN_YMD_NO_SEPRATE),
                        DateFormatUtils.PATTEN_YMD2));
                dto.setSex(CommonEnum.SexStatus.getEnumLabel(dto.getSex()));
                dto.setMarriage(CommonEnum.MarriageStatus.getEnumLabel(dto.getMarriage()));
                dto.setEducation(CommonEnum.EducationStatus.getEnumLabel(dto.getEducation()));
            }
        }
        return page;
    }

}
