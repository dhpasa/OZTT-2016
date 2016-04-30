package com.org.oztt.base.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.URLEncoder;
import java.security.cert.X509Certificate;
import java.util.Iterator;
import java.util.Map;

import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;

import com.sun.net.ssl.SSLContext;
import com.sun.net.ssl.X509TrustManager;

/**
 * 支付方法的接口
 * 
 * @author linliuan
 */
public class VpcSocketPayUtils {

    private final static String    proxyHost          = MessageUtils.getApplicationMessage("proxyHost");

    private final static String    proxyPort          = MessageUtils.getApplicationMessage("proxyPort");

    private final static String    vpc_Host           = MessageUtils.getApplicationMessage("vpc_Host");

    private final static String    vpc_Port           = MessageUtils.getApplicationMessage("vpc_Port");

    private final static String    vpc_Filename       = MessageUtils.getApplicationMessage("vpc_filename");

    @SuppressWarnings({ "deprecation", "restriction" })
    public static X509TrustManager s_x509TrustManager = null;

    public static SSLSocketFactory s_sslSocketFactory = null;

    static {
        s_x509TrustManager = new X509TrustManager() {
            public X509Certificate[] getAcceptedIssuers() {
                return new X509Certificate[] {};
            }

            public boolean isClientTrusted(X509Certificate[] chain) {
                return true;
            }

            public boolean isServerTrusted(X509Certificate[] chain) {
                return true;
            }
        };

        java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        try {
            SSLContext context = SSLContext.getInstance("TLS");
            context.init(null, new X509TrustManager[] { s_x509TrustManager }, null);
            s_sslSocketFactory = context.getSocketFactory();
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    @SuppressWarnings("resource")
    public static String doSocketPost(String data) throws Exception {
        InputStream is;
        OutputStream os;
        try {
            Socket s = new Socket(proxyHost, Integer.valueOf(proxyPort));
            os = s.getOutputStream();
            is = s.getInputStream();
            String msg = "CONNECT " + vpc_Host + ":" + vpc_Port + " HTTP/1.0\r\n" + "User-Agent: HTTP Client\r\n\r\n";
            os.write(msg.getBytes());
            byte[] buf = new byte[4096];
            int len = is.read(buf);
            String resconnect = new String(buf, 0, len);

            // check if a successful HTTP connection
            if (resconnect.indexOf("200") < 0) {
                throw new IOException("Proxy would now allow connection - " + resconnect);
            }

            SSLSocket ssl = (SSLSocket) s_sslSocketFactory.createSocket(s, vpc_Host, Integer.valueOf(vpc_Port), true);
            ssl.startHandshake();
            os = ssl.getOutputStream();
            // get response data from VPC
            is = ssl.getInputStream();

            String req = "POST " + vpc_Filename + " HTTP/1.0\r\n" + "User-Agent: HTTP Client\r\n"
                    + "Content-Type: application/x-www-form-urlencoded\r\n" + "Content-Length: " + data.length()
                    + "\r\n\r\n" + data;

            os.write(req.getBytes());
            String res = new String(readAll(is));

            // check if a successful connection
            if (res.indexOf("200") < 0) {
                throw new IOException("Connection Refused - " + res);
            }

            if (res.indexOf("404 Not Found") > 0) {
                throw new IOException("File Not Found Error - " + res);
            }

            int resIndex = res.indexOf("\r\n\r\n");
            String body = res.substring(resIndex + 4, res.length());
            return body;
        }
        catch (Exception e) {

        }
        finally {

        }

        return null;
    }

    /**
     * This method is for creating a byte array from input stream data.
     *
     * @param is - the input stream containing the data
     * @return is the byte array of the input stream data
     */
    private static byte[] readAll(InputStream is) throws IOException {

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buf = new byte[1024];

        while (true) {
            int len = is.read(buf);
            if (len < 0) {
                break;
            }
            baos.write(buf, 0, len);
        }
        return baos.toByteArray();
    }

    @SuppressWarnings({ "rawtypes", "deprecation" })
    public static String createPostDataFromMap(Map fields) {
        StringBuffer buf = new StringBuffer();

        String ampersand = "";

        // append all fields in a data string
        for (Iterator i = fields.keySet().iterator(); i.hasNext();) {

            String key = (String) i.next();
            String value = (String) fields.get(key);

            if ((value != null) && (value.length() > 0)) {
                // append the parameters
                buf.append(ampersand);
                buf.append(URLEncoder.encode(key));
                buf.append('=');
                buf.append(URLEncoder.encode(value));
            }
            ampersand = "&";
        }
        return buf.toString();
    }
}
