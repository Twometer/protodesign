package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.*;
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

import static de.twometer.protodesign.util.Utils.loginFailed;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {

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

            List<ProtocolRevision> rev = DbAccess.getProtocolRevisionDao().queryForEq("protocolId", protocol.protocolId);
            rev.sort((o1, o2) -> -Double.compare(o1.revisionNo, o2.revisionNo));
            req.setAttribute("revisions", rev);
            req.setAttribute("username", user.email);
            req.getRequestDispatcher("/history.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
