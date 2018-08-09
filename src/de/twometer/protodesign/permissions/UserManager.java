package de.twometer.protodesign.permissions;

import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.db.Protocol;
import de.twometer.protodesign.db.ProtocolShareInfo;
import de.twometer.protodesign.db.User;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class UserManager {

    public static long findUser(String email) throws SQLException {
        List<User> users = DbAccess.getUserDao().queryForEq("email", email);
        if (users.size() == 0) return 0;
        else return users.get(0).userId;
    }

    public static boolean isAuthorized(long userId, Protocol protocol) throws SQLException {
        if (protocol.ownerId != userId) {
            List<ProtocolShareInfo> infoList = DbAccess.getProtocolShareInfoDao().queryForEq("protocolId", protocol.protocolId);
            for (ProtocolShareInfo info : infoList)
                if (info.sharedUserId == userId) return true;
            return false;
        }
        return true;
    }

    public static Protocol getProtocolAndCheck(HttpServletResponse resp, User user, long protocolId) throws IOException {
        try {
            Protocol protocol = DbAccess.getProtocolDao().queryForId(protocolId);
            if (protocol == null) {
                resp.sendError(404);
                return null;
            }
            if (UserManager.isAuthorized(user.userId, protocol)) return protocol;
            else {
                resp.sendError(403);
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
            return null;
        }
    }

}
