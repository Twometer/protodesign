package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.DbAccess;
import de.twometer.protodesign.permissions.SessionManager;
import de.twometer.protodesign.db.User;
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
import java.util.Objects;

@WebServlet(value = "/login", name = "Login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long userId = SessionManager.getUser(req);
        if (Objects.equals(req.getParameter("ref"), "logoff")) {
            SessionManager.logoffUser(req);
            resp.sendRedirect("login");
            return;
        }
        if (userId != 0) {
            resp.sendRedirect("dashboard");
            return;
        }
        req.setAttribute("isSessionExpired", Objects.equals(req.getParameter("ref"), "session"));
        req.setAttribute("isRegisterInfo", Objects.equals(req.getParameter("ref"), "register"));
        req.setAttribute("hasAuthFailed", false);
        req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        if (email != null && password != null && email.trim().length() > 0 && password.trim().length() > 0) {
            List<User> users = null;
            try {
                users = DbAccess.getUserDao().queryForEq("email", email);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (users != null && users.size() > 0) {
                User user = users.get(0);
                byte[] passwordHash = Utils.hash(password);
                if (passwordHash != null && Utils.sequenceEqual(user.passwordHash, passwordHash)) {
                    SessionManager.logonUser(req, user.userId);
                    resp.sendRedirect("dashboard");
                    return;
                }
            }
        }
        req.setAttribute("isSessionExpired", false);
        req.setAttribute("isRegisterInfo", false);
        req.setAttribute("hasAuthFailed", true);
        req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
