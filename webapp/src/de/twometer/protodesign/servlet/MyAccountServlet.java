package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.db.User;
import de.twometer.protodesign.permissions.SessionManager;
import de.twometer.protodesign.theme.ThemeManager;
import de.twometer.protodesign.util.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(value = "/account", name = "My Account")
public class MyAccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = SessionManager.tryAuthenticate(req, resp);
        if (user == null) return;
        forwardDocument(req, resp, user, -1, "");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = SessionManager.tryAuthenticate(req, resp);
        if (user == null) return;

        String action = req.getParameter("action");

        if (action.equals("change-password")) {
            String oldPass = req.getParameter("oldPass");
            String newPass = req.getParameter("newPass");
            String confPass = req.getParameter("confPass");

            if (oldPass == null || newPass == null || !Utils.sequenceEqual(user.passwordHash, Utils.hash(oldPass)) || !newPass.equals(confPass)) {
                forwardDocument(req, resp, user, 1, "");
                return;
            }

            user.passwordHash = Utils.hash(newPass);
            try {
                DbAccess.getUserDao().update(user);
            } catch (SQLException e) {
                forwardDocument(req, resp, user, 3, "DBERR_" + e.getErrorCode());
                return;
            }

            forwardDocument(req, resp, user, 2, null);
        } else if (action.equals("change-theme")) {
            try {
                ThemeManager.changeTheme(user, req.getParameter("theme"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
            forwardDocument(req, resp, user, -1, "");
        }
    }

    private void forwardDocument(HttpServletRequest req, HttpServletResponse resp, User user, int err, String code) throws ServletException, IOException {
        req.setAttribute("errorType", err);
        req.setAttribute("errorCode", code);
        req.setAttribute("username", user.email);
        req.setAttribute("availableThemes", ThemeManager.getAvailableThemes());
        req.setAttribute("theme", ThemeManager.getThemeCode(user));
        req.getRequestDispatcher("/account.jsp").forward(req, resp);
    }
}
