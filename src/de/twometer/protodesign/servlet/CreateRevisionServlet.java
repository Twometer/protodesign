package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.*;
import de.twometer.protodesign.permissions.SessionManager;
import de.twometer.protodesign.util.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import static de.twometer.protodesign.util.Utils.loginFailed;

@WebServlet("/createRevision")
public class CreateRevisionServlet extends HttpServlet {

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

            List<ProtocolRevision> rev = DbAccess.getProtocolRevisionDao().queryBuilder().where().eq("protocolId", protocol.protocolId).and().eq("revisionNo", protocol.latestRevision).query();

            req.setAttribute("latestRevision", rev.size() > 0 ? rev.get(0) : new ProtocolRevision());
            req.setAttribute("protocol", protocol);
            req.setAttribute("username", user.email);
            req.getRequestDispatcher("/createRevision.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id_s = req.getParameter("protocolId");
        long id;
        try {
            id = Long.parseLong(id_s);
        } catch (Exception e) {
            resp.sendError(400);
            return;
        }

        String content = req.getParameter("content");
        String commitMessage = req.getParameter("commitMessage");

        if (content == null || commitMessage == null || content.trim().length() == 0 || commitMessage.trim().length() == 0) {
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

            protocol.latestRevision++;
            protocol.lastActive = System.currentTimeMillis();

            ProtocolRevision revision = new ProtocolRevision();
            revision.revisionNo = protocol.latestRevision;
            revision.commitMessages = commitMessage;
            revision.createdOn = System.currentTimeMillis();
            revision.createdBy = user.userId;
            revision.protocolId = protocol.protocolId;
            revision.contents = content;

            DbAccess.getProtocolDao().update(protocol);
            DbAccess.getProtocolRevisionDao().create(revision);

            resp.sendRedirect("view?id=" + protocol.protocolId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
