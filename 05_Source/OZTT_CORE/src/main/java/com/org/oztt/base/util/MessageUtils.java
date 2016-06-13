package com.org.oztt.base.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Locale;
import java.util.Properties;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.i18n.SessionLocaleResolver;

public class MessageUtils {

    public static String getApplicationMessage(String key, HttpSession session) {
        try {

            String language = "";
            if (session == null) {
                language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
            } else {
                Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
                if (locale == null) {
                    language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
                } else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }
            FileInputStream messageStream;
            String s = MessageUtils.class.getClassLoader().getResource("/").getPath().toString();
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
                    language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
                } else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }
            
            FileInputStream messageStream;
            String s = MessageUtils.class.getClassLoader().getResource("/").getPath().toString();
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
                    language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
                } else {
                    language = locale.getLanguage() + "_" + locale.getCountry();
                }
            }
            
            FileInputStream messageStream;
            String s = MessageUtils.class.getClassLoader().getResource("/").getPath().toString();
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
}
