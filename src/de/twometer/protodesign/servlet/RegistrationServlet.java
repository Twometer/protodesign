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
import java.util.Random;

@WebServlet(value = "/register", name = "Registration")
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long userId = SessionManager.getUser(req);
        if (userId != 0) {
            resp.sendRedirect("dashboard");
            return;
        }
        req.setAttribute("commonError", false);
        req.setAttribute("hasPasswordFailed", false);
        req.setAttribute("hasRegisterFailed", false);
        req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        if (email != null && password != null && confirmPassword != null && email.trim().length() > 0 && password.trim().length() > 0 && confirmPassword.trim().length() > 0) {
            if (!SessionManager.getWhiteList().contains(email)) {
                req.setAttribute("commonError", true);
                req.setAttribute("hasPasswordFailed", false);
                req.setAttribute("hasRegisterFailed", false);
                req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            if (!password.equals(confirmPassword)) {
                req.setAttribute("commonError", false);
                req.setAttribute("hasPasswordFailed", true);
                req.setAttribute("hasRegisterFailed", false);
                req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            List<User> users = null;
            try {
                users = DbAccess.getUserDao().queryForEq("email", email);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (users != null && users.size() > 0) {
                req.setAttribute("commonError", false);
                req.setAttribute("hasPasswordFailed", false);
                req.setAttribute("hasRegisterFailed", true);
                req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            try {
                long id = findUserId();
                User user = new User(id, email, Utils.hash(password));
                DbAccess.getUserDao().create(user);
                resp.sendRedirect("login?ref=register");
                return;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        req.setAttribute("commonError", true);
        req.setAttribute("hasPasswordFailed", false);
        req.setAttribute("hasRegisterFailed", false);
        req.setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    private long findUserId() throws SQLException {
        Random random = new Random();
        long id = random.nextLong();
        while (true) {
            User user = DbAccess.getUserDao().queryForId(id);
            if (user == null && id != 0) return id;
            id = random.nextLong();
        }
    }
}
