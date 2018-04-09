package de.twometer.protodesign.db;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class SessionManager {

    private static Map<String, Long> sessionIds = new ConcurrentHashMap<>();

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
}
