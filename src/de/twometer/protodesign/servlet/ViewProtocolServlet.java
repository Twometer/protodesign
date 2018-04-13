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
import java.util.Calendar;
import java.util.List;

import static de.twometer.protodesign.util.Utils.loginFailed;

@WebServlet("/view")
public class ViewProtocolServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id_s = req.getParameter("id");
        String revision_s = req.getParameter("revision");

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

            long revision = revision_s != null && revision_s.length() > 0 ? Long.parseLong(revision_s) : protocol.latestRevision;

            if (protocol == null) {
                resp.sendError(404);
                return;
            }

            if (!Utils.mayAccess(userId, protocol)) {
                resp.sendError(403);
                return;
            }

            List<ProtocolRevision> rev = DbAccess.getProtocolRevisionDao().queryBuilder().where().eq("protocolId", protocol.protocolId).and().eq("revisionNo", revision).query();

            ProtocolRevision revision1 = new ProtocolRevision();
            revision1.revisionNo = -1;

            req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
            req.setAttribute("protocolRev", rev.size() > 0 ? rev.get(0) : revision1);
            req.setAttribute("protocol", protocol);
            req.setAttribute("username", user.email);
            req.getRequestDispatcher("/view.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
