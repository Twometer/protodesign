package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.db.Protocol;
import de.twometer.protodesign.db.ProtocolRevision;
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
import java.util.Calendar;
import java.util.List;

@WebServlet("/view")
public class ViewProtocolServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String id_s = req.getParameter("id");
            String revision_s = req.getParameter("revision");

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

            long revision = revision_s != null && revision_s.length() > 0 ? Long.valueOf(revision_s) : protocol.latestRevision;

            List<ProtocolRevision> rev = DbAccess.getProtocolRevisionDao().queryBuilder().where().eq("protocolId", protocol.protocolId).and().eq("revisionNo", revision).query();

            ProtocolRevision revision1 = new ProtocolRevision();
            revision1.revisionNo = -1;

            req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
            req.setAttribute("protocolRev", rev.size() > 0 ? rev.get(0) : revision1);
            req.setAttribute("protocol", protocol);
            req.setAttribute("username", user.email);
            req.setAttribute("theme", ThemeManager.getThemeCode(user));
            req.getRequestDispatcher("/view.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}
