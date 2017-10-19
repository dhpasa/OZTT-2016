package com.org.oztt.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.org.oztt.base.common.MyCategroy;
import com.org.oztt.base.common.MyMap;
import com.org.oztt.base.util.CommonUtils;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.base.util.MessageUtils;
import com.org.oztt.base.util.SendSMS;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.SysCodeConstants;
import com.org.oztt.dao.TGoodsClassficationDao;
import com.org.oztt.dao.TSuburbDeliverFeeDao;
import com.org.oztt.dao.TSysCodeDao;
import com.org.oztt.dao.TSysValidateMessageDao;
import com.org.oztt.entity.TGoodsClassfication;
import com.org.oztt.entity.TSuburbDeliverFee;
import com.org.oztt.entity.TSysCode;
import com.org.oztt.entity.TSysValidateMessage;
import com.org.oztt.service.BaseService;
import com.org.oztt.service.CommonService;

@Service
public class CommonServiceImpl extends BaseService implements CommonService {

    private static List<MyMap>     sexMapList            = null;

    private static List<MyMap>     educationMapList      = null;

    private static List<MyMap>     marriageMapList       = null;

    private static List<MyMap>     deliveryTimeMapList   = null;

    private static List<MyMap>     suburbList            = null;

    private static List<MyMap>     orderStatusList       = null;

    private static List<MyMap>     orderDetailStatusList = null;

    private static List<MyMap>     paymentList           = null;

    private static List<MyMap>     deliveryList          = null;

    private static List<MyMap>     openFlgList           = null;

    private static List<MyMap>     customerLevelList     = null;

    private static List<TSysCode>  powderStageList       = null;

    @Resource
    private TSysCodeDao            tSysCodeDao;

    @Resource
    private TGoodsClassficationDao tGoodsClassficationDao;

    @Resource
    private TSysValidateMessageDao tSysValidateMessageDao;

    @Resource
    private TSuburbDeliverFeeDao   tSuburbDeliverFeeDao;

    @Override
    public List<MyMap> getSex() throws Exception {
        if (sexMapList == null) {
            sexMapList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.SEX_CODE));
        }
        return sexMapList;
    }

    @Override
    public List<MyMap> getEducation() throws Exception {
        if (educationMapList == null) {
            educationMapList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.EDUCTION_CODE));
        }
        return educationMapList;
    }

    @Override
    public List<MyMap> getIsMarried() throws Exception {
        if (marriageMapList == null) {
            marriageMapList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.MARRIAGE_CODE));
        }
        return marriageMapList;
    }

    @Override
    public List<MyMap> getDeliveryTime() throws Exception {
        if (deliveryTimeMapList == null) {
            deliveryTimeMapList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.DELIVERY_TIME_CODE));
        }
        return deliveryTimeMapList;
    }

    @Override
    public List<MyMap> getOrderStatus() throws Exception {
        if (orderStatusList == null) {
            orderStatusList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.ORDER_STATUS));
        }
        return orderStatusList;
    }

    @Override
    public List<MyMap> getOrderDetailStatus() throws Exception {
        if (orderDetailStatusList == null || orderDetailStatusList.size() == 0) {
            orderDetailStatusList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.ORDER_DETAIL_STATUS));
        }
        return orderDetailStatusList;
    }

    @Override
    public List<MyMap> getPayment() throws Exception {
        if (paymentList == null) {
            paymentList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.PAYMETHOD));
        }
        return paymentList;
    }

    @Override
    public List<MyMap> getCustomerLevel() throws Exception {
        if (customerLevelList == null) {
            customerLevelList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.CUSTOMER_LEVEL));
        }
        return customerLevelList;
    }

    @Override
    public List<MyMap> getDelivery() throws Exception {
        if (deliveryList == null) {
            deliveryList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.DELIVERY_METHOD));
        }
        return deliveryList;
    }

    private List<MyMap> entityList2mapList(List<TSysCode> list) {
        List<MyMap> select = new ArrayList<MyMap>();
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                MyMap my = new MyMap();
                my.setKey(list.get(i).getCodedetailid());
                my.setValue(list.get(i).getCodedetailname());
                select.add(my);
            }
        }
        return select;
    }

    // 将目录分层结构取出
    private static List<MyCategroy> categoryList = new ArrayList<MyCategroy>();

    /**
     * 获取菜单目录结构
     */
    public List<MyCategroy> getMyCategroy() throws Exception {
        if (CollectionUtils.isEmpty(categoryList)) {
            List<TGoodsClassfication> faList = tGoodsClassficationDao.getAllFatherkey();
            if (!CollectionUtils.isEmpty(faList)) {
                for (TGoodsClassfication fa : faList) {
                    categoryList.add(getNextCategory(fa));
                }
            }
            return categoryList;
        }
        else {
            return categoryList;
        }
    }

    public MyCategroy getNextCategory(TGoodsClassfication classFication) {
        MyCategroy reCa = new MyCategroy();
        TGoodsClassfication copyDesc = new TGoodsClassfication();
        BeanUtils.copyProperties(classFication, copyDesc);
        reCa.setFatherClass(copyDesc);
        // 接着检索出子类信息
        List<TGoodsClassfication> childrenList = tGoodsClassficationDao.getChildrenKey(classFication.getClassid());
        List<MyCategroy> cList = new ArrayList<MyCategroy>();
        for (TGoodsClassfication c : childrenList) {
            MyCategroy ca1Child = new MyCategroy();
            ca1Child.setFatherClass(c);
            List<MyCategroy> childClass = getNextCategory(c).getChildrenClass();
            if (!CollectionUtils.isEmpty(childClass)) {
                ca1Child.setChildrenClass(childClass);
            }
            cList.add(ca1Child);
        }
        reCa.setChildrenClass(cList);
        return reCa;

    }

    @Override
    public boolean getPhoneVerifyCode(String phone) throws Exception {
        String msg = MessageUtils.getMessage("MESSAGE_TEMP", null);
        String random = CommonUtils.getRandomNum(6);
        logger.info(random);
        phone = phone.replaceAll(" ", "");
        String sendPhone = phone.startsWith("0") ? "61" + phone.substring(1) : phone;
        boolean sendStatus = SendSMS.SendMessages(CommonConstants.PHONEUNMER_FIRST + sendPhone,
                msg.replace(CommonConstants.MESSAGE_PARAM_ONE, random));
//        boolean sendStatus = true;
        if (sendStatus) {
            // 发送正确则插入数据
            TSysValidateMessage tSysValidateMessage = tSysValidateMessageDao.getInfoByPhone(phone);
            if (tSysValidateMessage == null) {
                tSysValidateMessage = new TSysValidateMessage();
                tSysValidateMessage.setTelnumber(phone);
                tSysValidateMessage.setValidatecode(random);
                tSysValidateMessage.setCreatetimestamp(new Date());
                tSysValidateMessageDao.insertSelective(tSysValidateMessage);
            }
            else {
                tSysValidateMessage.setValidatecode(random);
                tSysValidateMessage.setCreatetimestamp(new Date());
                tSysValidateMessageDao.updateByPrimaryKeySelective(tSysValidateMessage);
            }

        }
        else {
            return false;
        }

        return true;
    }

    @Override
    public boolean checkPhoneVerifyCode(String phone, String verifyCode) throws Exception {
        //根据手机获取手机验证吗
        TSysValidateMessage messageInfo = tSysValidateMessageDao.getInfoByPhone(phone);
        if (messageInfo == null)
            return false;
        String codeInvalidTime = super.getApplicationMessage("code_invalid_time", null);
        Date date = DateFormatUtils.addMinute(messageInfo.getCreatetimestamp(), Integer.valueOf(codeInvalidTime));

        //查询字段的服务器当前时间 - 最新记录时间 > 30分钟
        if (DateFormatUtils.dateCompare(date, DateFormatUtils.getCurrentDate())) {
            return false;
        }
        String verifyCodeFormDB = messageInfo.getValidatecode();
        if (verifyCode.equals(verifyCodeFormDB)) {
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public List<MyMap> getSuburbList() throws Exception {
        if (suburbList == null) {
            // 获取地址一览
            List<TSuburbDeliverFee> feeList = tSuburbDeliverFeeDao.getAllTSuburbDeliverFee();
            suburbList = new ArrayList<MyMap>();
            if (feeList != null && feeList.size() > 0) {
                for (int i = 0; i < feeList.size(); i++) {
                    MyMap my = new MyMap();
                    my.setKey(feeList.get(i).getNo().toString());
                    my.setValue(feeList.get(i).getSuburb());
                    suburbList.add(my);
                }
            }
        }

        return suburbList;
    }

    @Override
    public List<MyMap> getOpenFlg() throws Exception {
        if (openFlgList == null) {
            openFlgList = entityList2mapList(tSysCodeDao.selectByCodeId(SysCodeConstants.OPEN_FLG));
        }
        return openFlgList;
    }

    @Override
    public List<TSysCode> getPowderStage() throws Exception {
        if (powderStageList == null) {
            powderStageList = tSysCodeDao.selectByCodeId(SysCodeConstants.POWDER_STAGE);
        }
        return powderStageList;
    }

    @Override
    public List<MyCategroy> getSubCategory(String categoryId) throws Exception {
        getMyCategroy();
        List<MyCategroy> subItemList = new ArrayList<MyCategroy>();
        for (MyCategroy categoryItem : categoryList) {
            if (categoryId.equals(categoryItem.getFatherClass().getClassid())) {
                subItemList.add(categoryItem);
            }
        }
        return subItemList;
    }

    @Override
    public List<MyCategroy> getMainCategory() throws Exception {
        return getMyCategroy();
    }

}
