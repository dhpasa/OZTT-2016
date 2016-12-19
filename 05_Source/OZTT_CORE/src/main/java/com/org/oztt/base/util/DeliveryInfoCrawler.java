package com.org.oztt.base.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DeliveryInfoCrawler {

    private String url;

    private String parameters;

    private String regex;

    private int    splitIndex;

    public DeliveryInfoCrawler(String configurationPath)
    {
        try {
            Properties prop = new Properties();
            InputStream inputStream;
            inputStream = new FileInputStream(configurationPath);
            prop.load(inputStream);
            url = prop.getProperty("url").trim();
            parameters = prop.getProperty("parameters").trim();
            regex = prop.getProperty("regex").trim();
            splitIndex = Integer.parseInt(prop.getProperty("splitIndex").trim());
        }
        catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public LinkedHashMap<String, String> getDeliveryInfo(String deliveryId) {
        LinkedHashMap<String, String> infos = new LinkedHashMap<String, String>();
        parameters += deliveryId;
        String htmlContent = getHtmlContent(url, parameters);
        htmlContent = htmlContent.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\"", "")
                .replaceAll("&nbsp;", "").replaceAll("        ", "");
        regex = regex.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\"", "").replaceAll("&nbsp;", "")
                .replaceAll("        ", "");
        Pattern pa = Pattern.compile(regex, Pattern.CANON_EQ);
        Matcher ma = pa.matcher(htmlContent);
        while (ma.find()) {
            String info = outTag(ma.group()).trim();
            infos.put(info.substring(0, splitIndex), info.substring(splitIndex));
            //  System.out.println(info.substring(0,splitIndex)+"||"+info.substring(splitIndex));
        }

        if (infos.size() == 0)
            infos.put((new Date()).toString(), "对不起，没有该快递单号的物流信息。");
        return infos;
    }

    private String getHtmlContent(String url, String parameters) {
        String result = "";// 返回的结果
        BufferedReader in = null;// 读取响应输入流
        PrintWriter out = null;
        StringBuffer sb = new StringBuffer();// 处理请求参数
        try {
            // 编码请求参数

            // 创建URL对象
            java.net.URL connURL = new java.net.URL(url);
            // 打开URL连接
            java.net.HttpURLConnection httpConn = (java.net.HttpURLConnection) connURL.openConnection();
            // 设置通用属性
            httpConn.setRequestProperty("Accept", "*/*");
            httpConn.setRequestProperty("Connection", "Keep-Alive");
            httpConn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1)");
            httpConn.setRequestProperty("Accept-Charset", "GBK");
            httpConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=gbk");
            // 设置POST方式
            httpConn.setDoInput(true);
            httpConn.setDoOutput(true);
            // 获取HttpURLConnection对象对应的输出流
            out = new PrintWriter(httpConn.getOutputStream());
            // 发送请求参数
            out.write(parameters);
            // flush输出流的缓冲
            out.flush();
            // 定义BufferedReader输入流来读取URL的响应，设置编码方式
            in = new BufferedReader(new InputStreamReader(httpConn.getInputStream(), "GBK"));
            String line;
            // 读取返回的内容
            while ((line = in.readLine()) != null) {
                result += line + "\r\n";
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (in != null) {
                    in.close();
                }
            }
            catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    private String outTag(String input) {
        return input.replaceAll("<.*?>", "");
    }
}
