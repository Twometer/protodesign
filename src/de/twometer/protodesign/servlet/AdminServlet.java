package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.User;
import de.twometer.protodesign.permissions.SessionManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = SessionManager.authenticate(req, resp);
        if (user == null) return;
        if (!SessionManager.getAdminAccounts().contains(user.email)) {
            resp.sendError(401);
            return;
        }

        req.setAttribute("username", user.email);
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
    }
}
