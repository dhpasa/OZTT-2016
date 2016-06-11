package com.org.oztt.base.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.StringTokenizer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 支付方法的接口
 * 
 * @author linliuan
 */
public class VpcHttpPayUtils {

    public static final String VPC_TXNRESPONSECODE = "vpc_TxnResponseCode";

    public static final String VPC_URL             = "https://migs.mastercard.com.au/vpcdps";

    public static final Log    logger              = LogFactory.getLog(VpcHttpPayUtils.class);

    public static Map<String, String> http(String url, Map<String, String> params) {
        HttpURLConnection httpConnection = null;
        DataOutputStream out = null;
        BufferedReader reader = null;
        String responseMessage = "";
        StringBuffer resposne = new StringBuffer();
        // 尝试发送请求  
        try {
            URL urlPost = new URL(VPC_URL);
            httpConnection = (HttpURLConnection) urlPost.openConnection();
            httpConnection.setDoOutput(true);
            httpConnection.setDoInput(true);
            // 参数长度太大，不能用get方式  
            httpConnection.setRequestMethod("POST");
            // 不使用缓存  
            httpConnection.setUseCaches(false);
            // URLConnection.setInstanceFollowRedirects是成员函数，仅作用于当前函数  
            httpConnection.setInstanceFollowRedirects(true);
            // 配置本次连接的Content-type，配置为application/x-www-form-urlencoded的  
            // 意思是正文是urlencoded编码过的form参数  
            httpConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            // 连接，从postUrl.openConnection()至此的配置必须要在connect之前完成，  
            // 要注意的是connection.getOutputStream会隐含的进行connect。  
            // 实际上只是建立了一个与服务器的tcp连接，并没有实际发送http请求。 
            StringBuffer sb = new StringBuffer();
            if (params != null) {
                for (Entry<String, String> e : params.entrySet()) {
                    sb.append(e.getKey());
                    sb.append("=");
                    sb.append(e.getValue());
                    sb.append("&");
                }
                sb.substring(0, sb.length() - 1);
            }

            httpConnection.connect();
            out = new DataOutputStream(httpConnection.getOutputStream());
            out.writeBytes(sb.substring(0, sb.length() - 1));
            // flush and close  
            out.flush();
            reader = new BufferedReader(new InputStreamReader(httpConnection.getInputStream()));
            while ((responseMessage = reader.readLine()) != null) {
                resposne.append(responseMessage);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error(e.toString());
        }
        finally {
            try {
                if (null != out) {
                    out.close();
                }
                if (null != reader) {
                    reader.close();
                }
                if (null != httpConnection) {
                    httpConnection.disconnect();
                }
            }
            catch (Exception e2) {
            }
        }

        // 读取返回内容  

        return createMapFromResponse(resposne.toString());
    }

    private static Map<String, String> createMapFromResponse(String queryString) {
        logger.error(queryString);
        Map<String, String> map = new HashMap<String, String>();
        StringTokenizer st = new StringTokenizer(queryString, "&");
        while (st.hasMoreTokens()) {
            String token = st.nextToken();
            int i = token.indexOf('=');
            if (i > 0) {
                try {
                    String key = token.substring(0, i);
                    String value = URLDecoder.decode(token.substring(i + 1, token.length()));
                    map.put(key, value);
                }
                catch (Exception ex) {
                }
            }
        }
        return map;
    }

    public static String null2unknown(String in, Map<String, String> responseFields) {
        if (in == null || in.length() == 0 || (String) responseFields.get(in) == null) {
            return "No Value Returned";
        }
        else {
            return (String) responseFields.get(in);
        }
    }
}
