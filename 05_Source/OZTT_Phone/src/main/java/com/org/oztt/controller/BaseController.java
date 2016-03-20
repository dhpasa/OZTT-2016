package com.org.oztt.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Locale;
import java.util.Properties;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.org.oztt.service.CommonService;

public class BaseController {

    protected static final Logger logger = LoggerFactory.getLogger("CONTROLLER");

    @Resource
    protected CommonService       commonService;

    public static String getApplicationMessage(String key) {
        try {

            String language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
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

    public static String getMessage(String key) {
        try {

            String language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
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

    public static String getPageMessage(String key) {
        try {

            String language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
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

}
