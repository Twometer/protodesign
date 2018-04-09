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
import java.util.Random;

import static de.twometer.protodesign.util.Utils.findUser;
import static de.twometer.protodesign.util.Utils.loginFailed;

@WebServlet("/create")
public class CreateProtocolServlet extends HttpServlet {
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

            req.setAttribute("username", user.email);
            req.getRequestDispatcher("/create.jsp").forward(req, resp);
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

            String title = req.getParameter("title");
            String desc = req.getParameter("description");
            String shared = req.getParameter("sharedUsers");
            if (title == null || desc == null || title.trim().length() == 0 || desc.trim().length() == 0)
                resp.sendError(400);

            Protocol protocol = new Protocol();
            protocol.ownerId = user.userId;
            protocol.protocolId = findProtocolId();
            protocol.title = title;
            protocol.description = desc;
            protocol.latestRevision = -1;
            protocol.lastActive = System.currentTimeMillis();
            DbAccess.getProtocolDao().create(protocol);

            List<ProtocolShareInfo> shareInfos = new ArrayList<>();
            shareInfos.add(new ProtocolShareInfo(protocol.protocolId, user.userId));

            for (String s : shared.split(";")) {
                long sharedUser = findUser(s);
                if (sharedUser != 0) shareInfos.add(new ProtocolShareInfo(protocol.protocolId, sharedUser));
            }

            DbAccess.getProtocolShareInfoDao().create(shareInfos);

            resp.sendRedirect("dashboard");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private long findProtocolId() throws SQLException {
        Random random = new Random();
        long id = random.nextLong();
        while (true) {
            Protocol proto = DbAccess.getProtocolDao().queryForId(id);
            if (proto == null && id != 0) return id;
            id = random.nextLong();
        }
    }
}
