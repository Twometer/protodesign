package de.twometer.protodesign.permissions;

import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.db.Protocol;
import de.twometer.protodesign.db.User;
import de.twometer.protodesign.util.Utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import static de.twometer.protodesign.util.Utils.loginFailed;

public class SessionManager {

    private static Map<String, Long> sessionIds = new ConcurrentHashMap<>();
    private static FileList<String> adminAccounts = new FileList<>(Utils.getFilePath("protodesign-admins.txt"));
    private static FileList<String> whiteList = new FileList<>(Utils.getFilePath("protodesign-whitelist.txt"));

    public static long getUser(HttpServletRequest request) {
        Long l = sessionIds.get(request.getSession().getId());
        if (l == null) return 0;
        return l;
    }

    public static void logonUser(HttpServletRequest request, long userId) {
        sessionIds.put(request.getSession().getId(), userId);
    }

    public static void logoffUser(HttpServletRequest request) {
        sessionIds.remove(request.getSession().getId());
    }

    public static User authenticate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            long userId = SessionManager.getUser(request);
            if (userId == 0) {
                loginFailed(response);
                return null;
            }

            User user = DbAccess.getUserDao().queryForId(userId);
            if (user == null) {
                loginFailed(response);
                return null;
            }
            return user;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Protocol getProtocol(HttpServletResponse resp, User user, long protocolId) throws IOException {
        try {
            Protocol protocol = DbAccess.getProtocolDao().queryForId(protocolId);
            if (protocol == null) {
                resp.sendError(404);
                return null;
            }

            if (!Utils.mayAccess(user.userId, protocol)) {
                resp.sendError(403);
                return null;
            }

            return protocol;
        }catch (SQLException  e) {
            e.printStackTrace();
            resp.sendError(500);
            return null;
        }
    }

    public static FileList<String> getAdminAccounts() {
        return adminAccounts;
    }

    public static FileList<String> getWhiteList() {
        return whiteList;
    }
}
