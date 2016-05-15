package com.org.oztt.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Locale;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.org.oztt.contants.CommonEnum;

/**
 * @ClassName: BaseService
 * @Description: 基础Service
 */
public class BaseService {
    
    protected static final Logger logger = LoggerFactory.getLogger(BaseService.class);
    
    public static BigDecimal getCostPercent(String payMethod) {
        if (payMethod.equals(CommonEnum.PaymentMethod.CREDIT_CARD.getCode())) {
            // 用PayPal付款
            return new BigDecimal(getApplicationMessage("PAYPAL_PECENT"));
        }
        return BigDecimal.ZERO;
    }

    public static String getApplicationMessage(String key) {
        try {

            String language = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
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
}
