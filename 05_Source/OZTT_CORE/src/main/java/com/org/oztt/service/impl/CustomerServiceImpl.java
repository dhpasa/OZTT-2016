package com.org.oztt.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Service;

import com.org.oztt.base.page.Pagination;
import com.org.oztt.base.page.PagingResult;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.PassWordParseInMD5;
import com.org.oztt.base.util.PasswordEncryptSalt;
import com.org.oztt.base.util.PasswordEncryptSaltUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.dao.TConsOrderDao;
import com.org.oztt.dao.TConsOrderDetailsDao;
import com.org.oztt.dao.TCustomerBasicInfoDao;
import com.org.oztt.dao.TCustomerLoginHisDao;
import com.org.oztt.dao.TCustomerLoginInfoDao;
import com.org.oztt.dao.TCustomerMemberInfoDao;
import com.org.oztt.dao.TCustomerSecurityInfoDao;
import com.org.oztt.dao.TGoodsGroupDao;
import com.org.oztt.dao.TNoCustomerDao;
import com.org.oztt.entity.TConsOrderDetails;
import com.org.oztt.entity.TCustomerBasicInfo;
import com.org.oztt.entity.TCustomerLoginHis;
import com.org.oztt.entity.TCustomerLoginInfo;
import com.org.oztt.entity.TCustomerMemberInfo;
import com.org.oztt.entity.TCustomerSecurityInfo;
import com.org.oztt.entity.TGoodsGroup;
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

    @Resource
    private TConsOrderDao            tConsOrderDao;

    @Resource
    private TConsOrderDetailsDao     tConsOrderDetailsDao;

    @Resource
    private TCustomerMemberInfoDao   tCustomerMemberInfoDao;

    @Resource
    private TGoodsGroupDao           tGoodsGroupDao;

    public TCustomerLoginInfo userLogin(String loginId, String password) throws Exception {
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("username", loginId);
        TCustomerLoginInfo info = new TCustomerLoginInfo();
        info.setLoginid(loginId);
        info = tCustomerLoginInfoDao.selectByParams(info);
        if (info != null) {
            if (PasswordEncryptSaltUtils.checkIsSame(password, info.getSalt(), info.getLoginpass())) {
                return info;
            }
            else {
                return null;
            }
        }
        else {
            return null;
        }
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

        maxCustomer = "CS" + maxCustomer;
        // 可用登录信息的保存
        TCustomerLoginInfo tCustomerLoginInfo = new TCustomerLoginInfo();
        tCustomerLoginInfo.setAddtimestamp(new Date());
        tCustomerLoginInfo.setAdduserkey(maxCustomer);
        tCustomerLoginInfo.setCustomerno(maxCustomer);
        tCustomerLoginInfo.setDeleteflg(CommonConstants.IS_NOT_DELETE);
        tCustomerLoginInfo.setLoginid("00000");

        PasswordEncryptSalt returnEnti = PasswordEncryptSaltUtils.encryptPassword(ozTtTpReDto.getPassword());
        tCustomerLoginInfo.setLoginpass(returnEnti.getNewPassword());
        tCustomerLoginInfo.setSalt(returnEnti.getSalt());
        tCustomerLoginInfo.setCanlogin(CommonConstants.CAN_LOGIN);
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
        PasswordEncryptSalt returnEnti = PasswordEncryptSaltUtils.encryptPassword(ozTtTpFpDto.getNewPassword());
        info.setLoginpass(returnEnti.getNewPassword());
        info.setSalt(returnEnti.getSalt());
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
                dto.setLevel(CommonEnum.CustomerLevel.getEnumLabel(dto.getLevel()));
            }
        }
        return page;
    }

    @Override
    public void deleteRegister(String customerNo) throws Exception {
        TCustomerLoginInfo tCustomerLoginInfo = new TCustomerLoginInfo();
        tCustomerLoginInfo = tCustomerLoginInfoDao.selectByCustomerNo(customerNo);
        tCustomerLoginInfoDao.deleteByPrimaryKey(tCustomerLoginInfo.getNo());

        // 人员基本信息
        TCustomerBasicInfo tCustomerBasicInfo = new TCustomerBasicInfo();
        tCustomerBasicInfo = tCustomerBasicInfoDao.selectBaseInfoByCustomerNo(customerNo);
        tCustomerBasicInfoDao.deleteByPrimaryKey(tCustomerBasicInfo.getNo());

        // 插入用户登陆表
        TCustomerSecurityInfo tCustomerSecurityInfo = new TCustomerSecurityInfo();
        tCustomerSecurityInfo = tCustomerSecurityInfoDao.selectByCustomerNo(customerNo);
        tCustomerSecurityInfoDao.deleteByPrimaryKey(tCustomerSecurityInfo.getNo());
    }

    @Override
    public TCustomerLoginInfo userLoginForPhone(String phone, String password) throws Exception {
        TCustomerSecurityInfo param = new TCustomerSecurityInfo();
        param.setTelno(phone);
        param = tCustomerSecurityInfoDao.selectByParam(param);
        if (param == null) {
            return null;
        }
        else {
            TCustomerLoginInfo info = new TCustomerLoginInfo();
            info.setCustomerno(param.getCustomerno());
            info = tCustomerLoginInfoDao.selectByParams(info);
            if (!StringUtils.isEmpty(info.getSalt())) {
                if (PasswordEncryptSaltUtils.checkIsSame(password, info.getSalt(), info.getLoginpass())) {
                    return info;
                }
                else {
                    return null;
                }
            }
            else {
                // 不进行MD5加密处理
                if (PassWordParseInMD5.Md5(password).equals(info.getLoginpass())) {
                    return info;
                }
                else {
                    return null;
                }
            }

        }

    }

    @Override
    public TCustomerSecurityInfo getCustomerByPhone(String phone) throws Exception {
        TCustomerSecurityInfo param = new TCustomerSecurityInfo();
        param.setTelno(phone);
        return tCustomerSecurityInfoDao.selectByParam(param);
    }

    @Override
    public TCustomerSecurityInfo getCustomerSecurityByCustomerNo(String customerNo) throws Exception {
        TCustomerSecurityInfo param = new TCustomerSecurityInfo();
        param.setCustomerno(customerNo);
        return tCustomerSecurityInfoDao.selectByParam(param);
    }

    @Override
    public OzTtAdRlListDto getCustomerInfoForAdmin(String customerNo) throws Exception {
        OzTtAdRlListDto ozTtAdRlListDto = tCustomerBasicInfoDao.getCustomerInfoForAdmin(customerNo);
        if (ozTtAdRlListDto != null) {
            ozTtAdRlListDto
                    .setBirthday(DateFormatUtils.date2StringWithFormat(DateFormatUtils.string2DateWithFormat(
                            ozTtAdRlListDto.getBirthday(), DateFormatUtils.PATTEN_YMD_NO_SEPRATE),
                            DateFormatUtils.PATTEN_YMD2));
            ozTtAdRlListDto.setSex(CommonEnum.SexStatus.getEnumLabel(ozTtAdRlListDto.getSex()));
            ozTtAdRlListDto.setMarriage(CommonEnum.MarriageStatus.getEnumLabel(ozTtAdRlListDto.getMarriage()));
            ozTtAdRlListDto.setEducation(CommonEnum.EducationStatus.getEnumLabel(ozTtAdRlListDto.getEducation()));
            return ozTtAdRlListDto;
        }
        else {
            return null;
        }
    }

    @Override
    public void updateCustomerPointsAndLevels(String orderDetailNo, String customerNo) throws Exception {
        // 检索当前订单的产品
        boolean hasCurrentGroup = false;
        BigDecimal trueCurrentAmount = BigDecimal.ZERO;
        TConsOrderDetails detailDto = tConsOrderDetailsDao.selectByPrimaryKey(Long.valueOf(orderDetailNo));

        TGoodsGroup tGoodsGroup = new TGoodsGroup();
        tGoodsGroup.setGroupno(detailDto.getGroupno());
        tGoodsGroup = tGoodsGroupDao.selectByParams(tGoodsGroup);

        if ("1".equals(tGoodsGroup.getInstockflg())) {
            hasCurrentGroup = true;
            trueCurrentAmount = trueCurrentAmount.add(detailDto.getSumamount());
        }

        if (!hasCurrentGroup)
            return; // 没有现货就直接返回

        // 获取指定用户所有现货商品的总金额。
        String startDay = super.getApplicationMessage("cal_point_day", null);
        BigDecimal countBuy = tConsOrderDetailsDao.selectIsInStockGroupSumAmount(customerNo, startDay);
        if (getTSysConfig() == null) {
            // 参数没有直接退出
            return;
        }
        // 计算出积分有多少
        BigDecimal point = countBuy.divide(tSysConfig.getPointcalcamount(), 0, BigDecimal.ROUND_DOWN);

        // 级别是什么
        String level = getLevel(countBuy, tSysConfig.getLevelsumamount().split(","));

        // 更新会员信息表
        TCustomerMemberInfo memberInfo = tCustomerMemberInfoDao.selectByCustomerNo(customerNo);

        if (memberInfo == null) {
            // 插入
            memberInfo = new TCustomerMemberInfo();
            memberInfo.setAddTimestamp(new Date());
            memberInfo.setAddUserKey(customerNo);
            memberInfo.setCustomerNo(customerNo);
            memberInfo.setPoints(point.intValue());
            memberInfo.setLevel(level);
            memberInfo.setLeftAmount(countBuy.subtract(point.multiply(tSysConfig.getPointcalcamount())));
            memberInfo.setSumAmount(countBuy);
            tCustomerMemberInfoDao.insertSelective(memberInfo);
        }
        else {
            // 更新
            BigDecimal All = trueCurrentAmount.add(memberInfo.getLeftAmount());
            memberInfo.setPoints(memberInfo.getPoints()
                    + All.divide(tSysConfig.getPointcalcamount(), 0, BigDecimal.ROUND_DOWN).intValue());
            memberInfo.setLeftAmount(All.subtract(All.divide(tSysConfig.getPointcalcamount(), 0, BigDecimal.ROUND_DOWN)
                    .multiply(tSysConfig.getPointcalcamount())));
            // 级别应该是
            level = getLevel(memberInfo.getSumAmount().add(trueCurrentAmount), tSysConfig.getLevelsumamount()
                    .split(","));
            memberInfo.setSumAmount(memberInfo.getSumAmount().add(trueCurrentAmount));
            if (!CommonEnum.CustomerLevel.DIAMOND.getCode().equals(memberInfo.getLevel())) {
                memberInfo.setLevel(level);
            }
            tCustomerMemberInfoDao.updateByPrimaryKeySelective(memberInfo);
        }
    }

    /**
     * 获取积分级别
     * 
     * @param point
     * @param levelArr
     * @return
     */
    private String getLevel(BigDecimal sumAmount, String[] levelArr) {
        if (levelArr != null && levelArr.length > 0) {
            String returnstr = "0";
            for (int i = 0; i < levelArr.length; i++) {
                if (i == 0) {
                    // 第一个
                    if (sumAmount.compareTo(new BigDecimal(levelArr[i])) < 0) {
                        returnstr = "0";
                        break;
                    }
                }
                if (i < levelArr.length - 1 && sumAmount.compareTo(new BigDecimal(levelArr[i])) >= 0
                        && sumAmount.compareTo(new BigDecimal(levelArr[i + 1])) < 0) {
                    returnstr = String.valueOf(i + 1);
                    break;
                }
                if (i == levelArr.length - 1) {
                    // 最后一个
                    if (sumAmount.compareTo(new BigDecimal(levelArr[i])) >= 0) {
                        returnstr = "3";
                        break;
                    }
                }

            }
            return returnstr;
        }
        else {
            return "0";
        }

    }

    @Override
    public TCustomerMemberInfo getCustomerMemberInfo(String customerNo) throws Exception {
        return tCustomerMemberInfoDao.selectByCustomerNo(customerNo);
    }

    @Override
    public void saveTCustomerMemberInfo(TCustomerMemberInfo info) throws Exception {
        tCustomerMemberInfoDao.insertSelective(info);
    }

    @Override
    public void updateTCustomerMemberInfo(TCustomerMemberInfo info) throws Exception {
        tCustomerMemberInfoDao.updateByPrimaryKeySelective(info);
    }

    @Override
    public void updateCustomerPointsAndLevelsBatch(String orderNo, String customerNo) throws Exception {
        
        List<TConsOrderDetails> detailList = tConsOrderDetailsDao.selectDetailsByOrderId(orderNo);
        for (TConsOrderDetails detail : detailList) {
            this.updateCustomerPointsAndLevels(detail.getNo().toString(), customerNo);
        }
    }

}
