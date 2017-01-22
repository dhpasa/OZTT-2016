package com.org.oztt.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Locale;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.org.oztt.contants.CommonEnum;
import com.org.oztt.dao.TSysConfigDao;
import com.org.oztt.entity.TSysConfig;

/**
 * @ClassName: BaseService
 * @Description: 基础Service
 */
public class BaseService {

    @Resource
    private TSysConfigDao         tSysConfigDao;

    protected static final Logger logger     = LoggerFactory.getLogger(BaseService.class);

    public TSysConfig             tSysConfig = null;

    public TSysConfig getTSysConfig() {
        if (tSysConfig == null) {
            tSysConfig = tSysConfigDao.selectOne();
            return tSysConfig;
        }
        else {
            return tSysConfig;
        }
    }

    public static BigDecimal getCostPercent(String payMethod) {
        if (payMethod.equals(CommonEnum.PaymentMethod.ONLINE_PAY_CWB.getCode())) {
            // 用PayPal付款
            return new BigDecimal(getApplicationMessage("PAYPAL_PECENT", null));
        }
        return BigDecimal.ZERO;
    }

    public static String getApplicationMessage(String key, HttpSession session) {
        try {
            String language = "";
            if (session == null) {
                language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
            }
            else {
                Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
                if (locale == null) {
                    language = "zh_CN";
                }
                else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }

            FileInputStream messageStream;
            String s = BaseService.class.getResource("/").getPath().toString();
            s = java.net.URLDecoder.decode(s, "UTF-8");
            Properties properties = new Properties();
            if ("zh_CN".equals(language)) {
                messageStream = new FileInputStream(s + "/application_zh_CN.properties");
            }
            else if ("en_US".equals(language)) {
                messageStream = new FileInputStream(s + "/application_en_US.properties");
            }
            else {
                messageStream = new FileInputStream(s + "/application_zh_CN.properties");
            }
            properties.load(messageStream);
            if (properties.containsKey(key)) {
                String value = new String(properties.getProperty(key));
                return value;
            }
            else {
                return key;
            }
        }
        catch (FileNotFoundException ex) {
            return key;
        }
        catch (IOException ex) {
            return key;
        }
        catch (Exception e) {
            return "session超时处理";
        }
    }

    public static String getPageMessage(String key, HttpSession session) {
        try {

            String language = "";
            if (session == null) {
                language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
            }
            else {
                Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
                if (locale == null) {
                    language = "zh_CN";
                }
                else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }
            FileInputStream messageStream;
            String s = BaseService.class.getResource("/").getPath().toString();
            s = java.net.URLDecoder.decode(s, "UTF-8");
            Properties properties = new Properties();
            if ("zh_CN".equals(language)) {
                messageStream = new FileInputStream(s + "/page_zh_CN.properties");
            }
            else if ("en_US".equals(language)) {
                messageStream = new FileInputStream(s + "/page_en_US.properties");
            }
            else {
                messageStream = new FileInputStream(s + "/page_zh_CN.properties");
            }
            properties.load(messageStream);
            if (properties.containsKey(key)) {
                String value = new String(properties.getProperty(key));
                return value;
            }
            else {
                return key;
            }
        }
        catch (FileNotFoundException ex) {
            return key;
        }
        catch (IOException ex) {
            return key;
        }
        catch (Exception e) {
            return "session超时处理";
        }
    }
    
    public static String getMessage(String key, HttpSession session) {
        try {
            String language = "";
            if (session == null) {
                language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
            }
            else {
                Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
                if (locale == null) {
                    language = "zh_CN";
                }
                else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }

            FileInputStream messageStream;
            String s = BaseService.class.getResource("/").getPath().toString();
            s = java.net.URLDecoder.decode(s, "UTF-8");
            Properties properties = new Properties();
            if ("zh_CN".equals(language)) {
                messageStream = new FileInputStream(s + "/message_zh_CN.properties");
            }
            else if ("en_US".equals(language)) {
                messageStream = new FileInputStream(s + "/message_en_US.properties");
            }
            else {
                messageStream = new FileInputStream(s + "/message_zh_CN.properties");
            }
            properties.load(messageStream);
            if (properties.containsKey(key)) {
                String value = new String(properties.getProperty(key));
                return value;
            }
            else {
                return key;
            }
        }
        catch (FileNotFoundException ex) {
            return key;
        }
        catch (IOException ex) {
            return key;
        }
        catch (Exception e) {
            return "session超时处理";
        }
    }
}
