package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.db.Protocol;
import de.twometer.protodesign.db.ProtocolRevision;
import de.twometer.protodesign.db.User;
import de.twometer.protodesign.permissions.SessionManager;
import de.twometer.protodesign.permissions.UserManager;
import de.twometer.protodesign.util.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/createRevision")
public class CreateRevisionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id_s = req.getParameter("id");
        long id;
        try {
            id = Utils.toLong(id_s);
        } catch (Exception e) {
            resp.sendError(400);
            return;
        }

        try {
            User user = SessionManager.tryAuthenticate(req, resp);
            if (user == null) return;

            Protocol protocol = UserManager.getProtocolAndCheck(resp, user, id);
            if (protocol == null) return;

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
            id = Utils.toLong(id_s);
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
            User user = SessionManager.tryAuthenticate(req, resp);
            if (user == null) return;

            Protocol protocol = UserManager.getProtocolAndCheck(resp, user, id);
            if (protocol == null) return;

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

            resp.sendRedirect("view?id=" + protocol.getHexId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
