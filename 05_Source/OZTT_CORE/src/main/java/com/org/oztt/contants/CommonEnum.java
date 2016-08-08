package com.org.oztt.contants;

import java.util.ArrayList;
import java.util.List;

import com.org.oztt.base.common.MyMap;

public final class CommonEnum {

    /** 不提供构造函数 */
    private CommonEnum()
    {
    }

    /**
     * 订单处理标志
     */
    public enum HandleFlag implements IEnum {
        /** 未付款 */
        NOT_PAY("未付款", "0"),
        /** 下单成功 */
        PLACE_ORDER_SU("下单成功", "1"),
        /** 商品派送中 */
        SENDING("商品派送中", "2"),
        /** 订单已完成 */
        COMPLATE("订单已完成", "3"),
        /** 订单部分完成 */
        PART_COMPLATE("订单部分完成", "4"),
        /** 删除 */
        DELETED("订单已取消", "9");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "HandleFlag";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private HandleFlag(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (HandleFlag c : HandleFlag.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (HandleFlag c : HandleFlag.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (HandleFlag c : HandleFlag.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    
    /**
     * 运送方式
     */
    public enum DeliveryMethod implements IEnum {
        /** 默认 */
        DEFAULT("默认", "0"),
        /** 送货上门 */
        HOME_DELIVERY("送货上门", "1"),
        /** 来店自提 */
        PICK_INSTORE("来店自提", "2");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "DeliveryMethod";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private DeliveryMethod(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (DeliveryMethod c : DeliveryMethod.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (DeliveryMethod c : DeliveryMethod.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (DeliveryMethod c : DeliveryMethod.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }

    /**
     * 付款方式
     */
    public enum PaymentMethod implements IEnum {
        /** 在线付款_澳洲联邦 */
        ONLINE_PAY_CWB("在线付款", "1"),
        /** 货到付款 */
        COD("货到付款", "2"),  
        /** 来店付款 */
        PAY_INSTORE("来店付款", "3");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "PaymentMethod";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private PaymentMethod(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (PaymentMethod c : PaymentMethod.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (PaymentMethod c : PaymentMethod.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (PaymentMethod c : PaymentMethod.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 配送时间
     */
    public enum DeliveryTime implements IEnum {
        /** 9:00～～12:00 */
        T_9_12("9:00～～12:00", "01"),
        /** 12:00～～15:00 */
        T_12_15("12:00～～15:00", "02"),
        /** 15:00～～18:00 */
        T_15_18("15:00～～18:00", "03");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "DeliveryTime";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private DeliveryTime(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (DeliveryTime c : DeliveryTime.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (DeliveryTime c : DeliveryTime.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (DeliveryTime c : DeliveryTime.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 婚姻状况
     */
    public enum MarriageStatus implements IEnum {
        /** 未婚 */
        HAS("未婚", "0"),
        /** 已婚 */
        NOTHAS("已婚", "1"),
        /** 保密 */
        SECRIT("保密", "9");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "MarriageStatus";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private MarriageStatus(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (MarriageStatus c : MarriageStatus.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (MarriageStatus c : MarriageStatus.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (MarriageStatus c : MarriageStatus.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 教育程度
     */
    public enum EducationStatus implements IEnum {
        /** 初中 */
        CHUZHONG("初中", "10"),
        /** 高中 */
        GAOZHONG("高中", "20"),
        /** 中专 */
        ZHONGZHUAN("中专", "30"),
        /** 大专 */
        DAZHUAN("大专", "40"),
        /** 本科 */
        BENKE("本科", "50"),
        /** 硕士 */
        SHUOSHI("硕士", "60"),
        /** 博士 */
        BOSHI("博士", "70"),
        /** 其他 */
        QITA("其他", "80");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "EducationStatus";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private EducationStatus(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (EducationStatus c : EducationStatus.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (EducationStatus c : EducationStatus.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (EducationStatus c : EducationStatus.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 性别
     */
    public enum SexStatus implements IEnum {
        /** 男 */
        MALE("男", "1"),
        /** 女 */
        FEMALE("女", "2"),
        /** 保密 */
        SECRIT("保密", "9");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "SexStatus";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private SexStatus(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (SexStatus c : SexStatus.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (SexStatus c : SexStatus.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (SexStatus c : SexStatus.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 团购开放标志
     */
    public enum GroupOpenFlag implements IEnum {
        /** 未发布 */
        NOTOPEN("未发布", "0"),
        /** 团购中 */
        OPENING("团购中", "1"),
        /** 下架 */
        CLOSED("下架", "2"),
        /** 删除 */
        DELETE("删除", "9");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "GroupOpenFlag";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private GroupOpenFlag(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (GroupOpenFlag c : GroupOpenFlag.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (GroupOpenFlag c : GroupOpenFlag.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (GroupOpenFlag c : GroupOpenFlag.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 检索画面的模式
     */
    public enum SearchModeFlag implements IEnum {
        /** 销量 */
        SALECOUNT("销量", "1"),
        /** 新品 */
        NEWGOODS("新品", "2"),
        /** 价格 */
        PRICE("价格", "3"),
        /** 分类 */
        CLASS("分类", "4");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "SearchModeFlag";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private SearchModeFlag(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (SearchModeFlag c : SearchModeFlag.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (SearchModeFlag c : SearchModeFlag.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (SearchModeFlag c : SearchModeFlag.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 发票标识
     */
    public enum InvoiceFlg implements IEnum {
        /** 未生成 */
        UN_CREATE("未生成", "0"),
        /** 已生成 */
        CREATED("已生成", "1");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "InvoiceFlg";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private InvoiceFlg(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (InvoiceFlg c : InvoiceFlg.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (InvoiceFlg c : InvoiceFlg.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (InvoiceFlg c : InvoiceFlg.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 是否
     */
    public enum ifOrNot implements IEnum {
        /** 是 */
        YES("是", "1"),
        /** 否 */
        NO(" ", "0");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "ifOrNot";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private ifOrNot(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (ifOrNot c : ifOrNot.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (ifOrNot c : ifOrNot.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (ifOrNot c : ifOrNot.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
    /**
     * 订单详细处理标志
     */
    public enum OrderDetailHandleFlag implements IEnum {
        
        /** 下单成功 */
        PLACE_ORDER_SU("下单成功", "1"),
        /** 商品派送中 */
        SENDING("商品派送中", "2"),
        /** 完成 */
        COMPLATE("完成", "3"),
        /** 取消 */
        CANCEL("取消", "9");

        /** 值 */
        private String label;

        /** 键 */
        private String code;

        /**
         * 取得枚举区分
         * 
         * @return String
         */
        public String getEnumName() {
            return "OrderDetailHandleFlag";
        }

        /**
         * 构造函数
         * 
         * @param label String
         * @param code String
         */
        private OrderDetailHandleFlag(String label, String code)
        {
            this.label = label;
            this.code = code;
        }

        /**
         * 根据键取得值
         * 
         * @param code String
         * @return String
         */
        public static String getEnumLabel(String code) {
            for (OrderDetailHandleFlag c : OrderDetailHandleFlag.values()) {
                if (c.getCode().equals(code)) {
                    return c.label;
                }
            }
            return null;
        }

        /**
         * 根据值取得第一个匹配的键
         * 
         * @param label String
         * @return String
         */
        public static String getEnumCode(String label) {
            for (OrderDetailHandleFlag c : OrderDetailHandleFlag.values()) {
                if (c.getLabel().equals(label)) {
                    return c.code;
                }
            }
            return null;
        }

        /**
         * 取得下拉框列表
         * 
         * @return List
         */
        public static List<MyMap> getList() {
            List<MyMap> resultList = new ArrayList<MyMap>();
            for (OrderDetailHandleFlag c : OrderDetailHandleFlag.values()) {
                MyMap dto = new MyMap();
                dto.setKey(c.getCode());
                dto.setValue(c.getLabel());
                resultList.add(dto);
            }
            return resultList;
        }

        /**
         * get
         * 
         * @return String
         */
        public String getLabel() {
            return label;
        }

        /**
         * set
         * 
         * @return String
         */
        public String getCode() {
            return code;
        }

        /**
         * String转换，中间加横杠
         * 
         * @return String
         */
        @Override
        public String toString() {
            return this.label;
        }

        /**
         * 转换成value
         * 
         * @return String
         */
        public String toValueString() {
            return String.valueOf(this.code);
        }

        /**
         * 转换成label
         * 
         * @return String
         */
        public String toLabelString() {
            return String.valueOf(this.label);
        }
    }
    
}
