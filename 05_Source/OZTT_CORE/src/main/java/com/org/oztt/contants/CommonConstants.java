package com.org.oztt.contants;

import java.math.BigDecimal;

public final class CommonConstants {

    public static final String     ERROR_PAGE                 = "404";

    public static final String     FIRST_NUMBER               = "000001";

    public static final String     ADD_NUMBER                 = "000001";

    public static final String     IS_NOT_DELETE              = "0";                                    // 不是删除

    public static final String     IS_DELETE                  = "1";                                    //删除

    public static final String     LOGIN_STATUS_NORMAL        = "0";                                    //登录状态，正常

    public static final String     HAS_LOGINED_STATUS         = "1";                                    //已经登录的状态

    public static final String     SESSION_CUSTOMERNO         = "sessionUserId";                        // 用来保存的用户名

    public static final String     SESSION_CUSTOMER_AUTOID    = "sessionAutoNo";                        // 用来保存的自增序列

    public static final String     SESSION_CUSTOMERNAME       = "sessionUserName";                      // 用来保存的用户名

    public static final String     SESSION_DIAMOND_CUSTOMER   = "sessionDiamondCustomer";               // 用来保存的用户名

    public static final String     BELONG_FATHER_CLASS        = "0C0000";                               // 父分类

    public static final String     FATHER_CLASS               = "1C";                                   // 父分类

    public static final String     CHILDREN_CLASS             = "2C";                                   // 父分类

    public static final String     LIMIT_PARAM                = "limitParam";                           // SQL文中的限制参数

    public static final String     MAIN_LIST_COUNT            = "12";                                   // 主页面中显示的个数

    public static final String     MAIN_GOODS_LIST            = "6";                                    // 主页面中显示的个数

    public static final String     MAIN_TOPPAGE_LIST          = "2";                                    // 主页面中显示的个数

    public static final String     IS_HOT_SALE                = "1";                                    // 热卖

    public static final String     IS_NOT_HOT_SALE            = "0";                                    // 非热卖

    public static final String     IS_NOT_NEW_SALE            = "0";                                    // 非新货

    public static final String     IS_NEW_SALE                = "1";                                    // 非新货

    public static final String     IS_ON_SALE                 = "1";                                    // 在售

    public static final int        PRODUCT_INIT_COUNT         = 15;                                     // 默认显示15条数据

    public static final String     OPEN_FLAG_GROUP            = "1";                                    // 1:开放

    public static final String     OPEN_FLAG_OTHER            = "0";                                    // 0:开放

    public static final String     LEFT_INDICATE              = "&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;"; //右向箭头

    public static final String     UP_CART                    = "CART";                                 // 购物车

    public static final String     IS_GROUP                   = "1";                                    //是团购

    public static final String     PATH_SPLIT                 = "/";                                    //

    public static final String     MESSAGE_PARAM_ONE          = "{0}";

    public static final String     CAN_LOGIN                  = "1";                                    // 可以登录

    public static final String     CANNOT_LOGIN               = "0";                                    // 不可以登录

    public static final String     CURRENT_BUY                = "1";                                    // 当此需购买

    public static final String     OVER_GROUP_YES             = "1";                                    // 已经满团了

    public static final String     OVER_GROUP_NO              = "0";                                    // 没有满团

    public static final String     OVERTIME_GROUP_YES         = "1";                                    // 已经超过时间了

    public static final String     OVERTIME_GROUP_NO          = "0";                                    // 没有超过时间

    public static final String     HAS_SEND_INVOICE           = "1";                                    // 已经发送发票

    public static final String     HAS_NOT_SEND_INVOICE       = "0";                                    // 没有发送发票

    public static final String     TRANSACTION_OBJECT         = "CommonWealth";                         // CommonWealth定植

    public static final String     TRANSACTION_SERIAL_NO      = "vpc_ReceiptNo";                        // 收据号

    public static final String     TRANSACTION_SERIAL_NO_MOCK = "00000-00000";                          // 模拟收据号

    //##############admin端常量#################//

    public static final String     SESSION_ADMIN_USER_ID      = "sessionUserId";

    public static final String     OZTT_ADMIN_PROJECT         = "OZTT_ADMIN";

    public static final String     OPEN                       = "开放";

    public static final String     NO_OPEN                    = "不开放";

    public static final String     NO_OPEN_VALUE              = "1";

    public static final String     ADMIN_USERKEY              = "ADMIN";

    public static final String     PRICE_NO_SIGN              = "PR";

    public static final String     GROUP_NO_SIGN              = "GP";

    public static final String     GOODS_NO_SIGN              = "GD";

    public static final String     FILE_SPLIT                 = ".";

    public static final String     PHONEUNMER_FIRST           = "+";

    public static final String     DEFAULT_ADDRESS            = "1";

    public static final String     NOT_DEFAULT_ADDRESS        = "0";

    public static final String     CART_CANBUY                = "4";                                    //订单重复提交

    public static final String     IS_ON_WAY                  = "1";                                    // 即将销售

    public static final int        MAX_DAY                    = 999;

    public static final String     SELL_OUT_FLG               = "1";                                    // 即将售罄

    public static final String     WYSIHTML5                  = "wysihtml5_data";

    public static final int        STOCK_50                   = 50;

    public static final int        STOCK_100                  = 100;

    public static final BigDecimal POWDER_NUMBER              = new BigDecimal(3);

}
