package com.org.oztt.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Locale;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.org.oztt.service.CommonService;

public class BaseController {

    protected static final Log logger = LogFactory.getLog(BaseController.class);
    
    
    // 保存的图片地址
    protected static final String imgUrl = getApplicationMessage("saveImgUrl", null);

    @Resource
    protected CommonService       commonService;
    
    public static String getApplicationMessage(String key, HttpSession session) {
        try {
            
            String language = "";
            if (session == null) {
                language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
            } else {
                Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
                if (locale == null) {
                    language = "zh_CN";
                } else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }
            
            FileInputStream messageStream;
            String s = BaseController.class.getResource("/").getPath().toString();
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

    public static String getMessage(String key, HttpSession session) {
        try {

            String language = "";
            if (session == null) {
                language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
            } else {
                Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
                if (locale == null) {
                    language = "zh_CN";
                } else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }
            
            FileInputStream messageStream;
            String s = BaseController.class.getResource("/").getPath().toString();
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

    public static String getPageMessage(String key, HttpSession session) {
        try {

            String language = "";
            if (session == null) {
                language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
            } else {
                Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
                if (locale == null) {
                    language = "zh_CN";
                } else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }
            
            FileInputStream messageStream;
            String s = BaseController.class.getResource("/").getPath().toString();
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
    
    public static String[] getShopCartPro() {
        return new String[]{"3","5","7"};
    }

}
