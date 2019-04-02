package de.twometer.protodesign.util;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Utils {


    public static byte[] hash(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.update(input.getBytes(StandardCharsets.UTF_8));
            return digest.digest();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean sequenceEqual(byte[] b1, byte[] b2) {
        if (b1 == null || b2 == null) return false;
        if (b1.length != b2.length) return false;
        for (int i = 0; i < b1.length; i++) if (b1[i] != b2[i]) return false;
        return true;
    }

    public static void loginFailed(HttpServletResponse resp) throws IOException {
        resp.sendRedirect("/login?ref=session");
    }

    public static String formatMs(long ms) {
        Date date = new Date(ms);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMM dd yyyy HH:mm");
        return simpleDateFormat.format(date);
    }

    public static String toHex(long l) {
        return Long.toHexString(l);
    }

    public static long toLong(String hex) {
        return Long.parseUnsignedLong(hex, 16);
    }

    public static String getFilePath(String fileName) {
        if (System.getProperty("os.name").startsWith("Windows")) return new File("D:\\" + fileName).getAbsolutePath();
        else return "/opt/tomcat/webapps/" + fileName;
    }
}
