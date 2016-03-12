package com.org.oztt.base.util;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

public class PasswordEncryptSaltUtils {

    private static RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();

    private static String algorithmName = "md5";

    private static int hashIterations = 2;
    
    public static PasswordEncryptSalt encryptPassword(String originPassword) {
        PasswordEncryptSalt returnEntity = new PasswordEncryptSalt();
        String salt = randomNumberGenerator.nextBytes().toHex();
        returnEntity.setSalt(salt);
        String newPassword = new SimpleHash(
                algorithmName,
                originPassword,
                ByteSource.Util.bytes(originPassword + salt),
                hashIterations).toHex();
        returnEntity.setNewPassword(newPassword);
        return returnEntity;
    }
}
