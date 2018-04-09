package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static de.twometer.protodesign.util.Utils.loginFailed;

@WebServlet(value = "/dashboard", name = "Dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            long userId = SessionManager.getUser(req);
            if (userId == 0) {
                loginFailed(resp);
                return;
            }

            User user = DbAccess.getUserDao().queryForId(userId);
            if (user == null) {
                loginFailed(resp);
                return;
            }

            List<ProtocolShareInfo> shareInfos = DbAccess.getProtocolShareInfoDao().queryForEq("sharedUserId", userId);
            List<Protocol> protocols = new ArrayList<>();

            for (ProtocolShareInfo shareInfo : shareInfos)
                protocols.add(DbAccess.getProtocolDao().queryForId(shareInfo.protocolId));

            protocols.sort((o1, o2) -> -Double.compare(o1.lastActive, o2.lastActive));

            req.setAttribute("protocols", protocols);
            req.setAttribute("username", user.email);
            req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
