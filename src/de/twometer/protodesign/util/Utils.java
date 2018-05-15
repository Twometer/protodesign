package de.twometer.protodesign.util;

import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.db.Protocol;
import de.twometer.protodesign.db.ProtocolShareInfo;
import de.twometer.protodesign.db.User;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Utils {


    public static byte[] hash(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.update(input.getBytes("UTF-8"));
            return digest.digest();
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
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
        resp.sendRedirect("login?ref=session");
    }

    public static String formatMs(long ms) {
        Date date = new Date(ms);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMM dd yyyy HH:mm");
        return simpleDateFormat.format(date);
    }

    public static long findUser(String email) throws SQLException {
        List<User> users = DbAccess.getUserDao().queryForEq("email", email);
        if (users.size() == 0) return 0;
        else return users.get(0).userId;
    }

    public static boolean isUnauthorized(long userId, Protocol protocol) throws SQLException {
        if (protocol.ownerId != userId) {
            List<ProtocolShareInfo> infoList = DbAccess.getProtocolShareInfoDao().queryForEq("protocolId", protocol.protocolId);
            for (ProtocolShareInfo info : infoList)
                if (info.sharedUserId == userId) return false;
            return true;
        }
        return false;
    }

    public static String getFilePath(String fileName) {
        if (System.getProperty("os.name").startsWith("Windows")) return new File("D:\\" + fileName).getAbsolutePath();
        else return "/opt/tomcat/webapps/" + fileName;
    }
}
