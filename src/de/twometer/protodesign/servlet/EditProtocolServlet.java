package de.twometer.protodesign.servlet;


import de.twometer.protodesign.db.*;
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

import static de.twometer.protodesign.util.Utils.findUser;
import static de.twometer.protodesign.util.Utils.loginFailed;

@WebServlet("/edit")
public class EditProtocolServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id_s = req.getParameter("id");
        long id;
        try {
            id = Long.parseLong(id_s);
        } catch (Exception e) {
            resp.sendError(400);
            return;
        }

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

            Protocol protocol = DbAccess.getProtocolDao().queryForId(id);

            if (protocol == null) {
                resp.sendError(404);
                return;
            }

            if (!Utils.mayAccess(userId, protocol)) {
                resp.sendError(403);
                return;
            }

            req.setAttribute("protocol", protocol);
            req.setAttribute("username", user.email);
            req.getRequestDispatcher("/edit.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

            long protocolId = Long.parseLong(req.getParameter("protocolId"));
            String title = req.getParameter("title");
            String desc = req.getParameter("description");
            String shared = req.getParameter("sharedUsers");
            if (title == null || desc == null || title.trim().length() == 0 || desc.trim().length() == 0 || protocolId == 0)
                resp.sendError(400);

            Protocol protocol = DbAccess.getProtocolDao().queryForId(protocolId);
            protocol.title = title;
            protocol.description = desc;
            protocol.lastActive = System.currentTimeMillis();
            DbAccess.getProtocolDao().update(protocol);

            List<ProtocolShareInfo> shareInfos = new ArrayList<>();
            shareInfos.add(new ProtocolShareInfo(protocol.protocolId, user.userId));

            for (String s : shared.split(";")) {
                long sharedUser = findUser(s);
                if (sharedUser != 0) shareInfos.add(new ProtocolShareInfo(protocol.protocolId, sharedUser));
            }

            DbAccess.getProtocolShareInfoDao().delete(DbAccess.getProtocolShareInfoDao().queryForEq("protocolId", protocolId));
            DbAccess.getProtocolShareInfoDao().create(shareInfos);

            resp.sendRedirect("view?id=" + protocolId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
