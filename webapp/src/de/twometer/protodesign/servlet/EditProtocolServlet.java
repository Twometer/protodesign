package de.twometer.protodesign.servlet;


import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.db.Protocol;
import de.twometer.protodesign.db.ProtocolShareInfo;
import de.twometer.protodesign.db.User;
import de.twometer.protodesign.permissions.SessionManager;
import de.twometer.protodesign.permissions.UserManager;
import de.twometer.protodesign.theme.ThemeManager;
import de.twometer.protodesign.util.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/edit")
public class EditProtocolServlet extends HttpServlet {

    private static final String ACTION_EDIT = "edit";
    private static final String ACTION_DELETE = "delete";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String id_s = req.getParameter("id");
        long id;
        try {
            id = Utils.toLong(id_s);
        } catch (Exception e) {
            resp.sendError(400);
            return;
        }

        User user = SessionManager.tryAuthenticate(req, resp);
        if (user == null) return;

        Protocol protocol = UserManager.getProtocolAndCheck(resp, user, id);
        if (protocol == null) return;

        req.setAttribute("protocol", protocol);
        req.setAttribute("username", user.email);
        req.setAttribute("theme", ThemeManager.getThemeCode(user));
        req.getRequestDispatcher("/edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        try {
            User user = SessionManager.tryAuthenticate(req, resp);
            if (user == null) return;

            String action = req.getParameter("action");
            long protocolId = Utils.toLong(req.getParameter("protocolId"));
            if (action.equalsIgnoreCase(ACTION_EDIT)) {
                String title = req.getParameter("title");
                String desc = req.getParameter("description");
                String shared = req.getParameter("sharedUsers");
                if (title == null || desc == null || title.trim().length() == 0 || desc.trim().length() == 0 || protocolId == 0)
                    resp.sendError(400);

                Protocol protocol = UserManager.getProtocolAndCheck(resp, user, protocolId);
                if (protocol == null) return;

                protocol.title = title;
                protocol.description = desc;
                protocol.lastActive = System.currentTimeMillis();
                DbAccess.getProtocolDao().update(protocol);

                List<ProtocolShareInfo> shareInfos = new ArrayList<>();
                shareInfos.add(new ProtocolShareInfo(protocol.protocolId, user.userId));

                for (String s : shared.split(";")) {
                    long sharedUser = UserManager.findUser(s);
                    if (sharedUser != 0) shareInfos.add(new ProtocolShareInfo(protocol.protocolId, sharedUser));
                }

                DbAccess.getProtocolShareInfoDao().delete(DbAccess.getProtocolShareInfoDao().queryForEq("protocolId", protocolId));
                DbAccess.getProtocolShareInfoDao().create(shareInfos);

                resp.sendRedirect("view?id=" + Utils.toHex(protocolId));
            } else if (action.equalsIgnoreCase(ACTION_DELETE)) {
                Protocol protocol = UserManager.getProtocolAndCheck(resp, user, protocolId);
                if (protocol == null) return;
                DbAccess.getProtocolShareInfoDao().delete(DbAccess.getProtocolShareInfoDao().queryForEq("protocolId", protocolId));
                DbAccess.getProtocolDao().deleteById(protocolId);
                resp.sendRedirect("dashboard");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
