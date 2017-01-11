package com.org.oztt.base.util;

import java.io.IOException;

import au.com.m4u.smsapi.SmsInterface;
import au.com.m4u.smsapi.ValidityPeriod;

public class SendSMS extends BaseUtils {

    private final static String m4uUser = StringDecode.paramDecode(MessageUtils.getApplicationMessage("sms_username", null));

    private final static String m4uPass = StringDecode.paramDecode(MessageUtils.getApplicationMessage("sms_passWord", null));

    // 打开SMS连接
    private static SmsInterface openConnection(boolean secureMode, boolean debug, String debugFile) {
        SmsInterface si = new SmsInterface(1);
        si.useSecureMode(secureMode);

        si.setDebug(debug);

        if (debugFile != "") {
            try {
                si.setDebug(debugFile);
            }
            catch (IOException e) {
                System.err.println("Could not write to debug output file '" + debugFile + "'");
            }
        }

        if (!si.connect(m4uUser, m4uPass, false)) {
            System.err.println("Failed to connect");
            return null;
        }

        return si;
    }

    //sending of messages.
    public static boolean SendMessages(String phone, String message) {

        boolean secureMode = false;
        boolean debug = false;
        String debugFile = "";
        SmsInterface si;
        if ((si = openConnection(secureMode, debug, debugFile)) == null)
            return false;
        si.addMessage(phone, message, 0, 0, ValidityPeriod.DEFAULT, false);

        if (si.sendMessages()) {
            return true;
        }
        else {
            logger.error("Send Messages failed to " + "+" + phone);
            logger.error("Response code = " + si.getResponseCode());
            return false;
        }
    }
}
