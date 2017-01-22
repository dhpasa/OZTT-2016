package com.org.oztt.base.util;

import java.io.IOException;

import au.com.m4u.smsapi.SmsInterface;
import au.com.m4u.smsapi.ValidityPeriod;

public class SMSUtil {

    private static String       sms_username = "Vm2LDnIck1Y5TBapDqAhC425LK2SFKIWHb95TUmccrYWCWVsO6vv3MRCMIFtI3rbf6G1d3JzIhGI0O0LmU9v0mX7Od3";

    private static String       sms_passWord = "fgIkJC77WP9zFTcnanTawpLVCImuEfyUum6gW4waf0y";

    private final static String m4uUser      = StringDecode.paramDecode(sms_username);

    private final static String m4uPass      = StringDecode.paramDecode(sms_passWord);

    // ��SMS����
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
    public static boolean sendMessage(String phone, String message) {
        if (phone.substring(0, 1).equals("0"))
            phone = "+61" + phone.substring(1);
        if (phone.substring(0, 2).equals("86"))
            phone = "+" + phone;
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
            // logger.error("Send Messages failed to " + "+" + phone);
            //  logger.error("Response code = " + si.getResponseCode());
            return false;
        }
    }
}
