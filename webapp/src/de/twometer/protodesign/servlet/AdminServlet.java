package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.User;
import de.twometer.protodesign.permissions.SessionManager;
import de.twometer.protodesign.theme.ThemeManager;

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
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        User user = SessionManager.tryAuthenticate(req, resp);
        if (user == null) return;
        if (!SessionManager.getAdminAccounts().contains(user.email)) {
            resp.sendError(403);
            return;
        }
        sendDocument(user, req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        User user = SessionManager.tryAuthenticate(req, resp);
        if (user == null) return;
        if (!SessionManager.getAdminAccounts().contains(user.email)) {
            resp.sendError(403);
            return;
        }

        String action = req.getParameter("action");
        if (isNullHttpAware(action, resp)) return;

        switch (action) {
            case "whitelistDel": {
                String username = req.getParameter("username");
                if (isNullHttpAware(username, resp)) return;
                SessionManager.getWhiteList().remove(username);
                sendDocument(user, req, resp);
                return;
            }
            case "whitelistAdd": {
                String username = req.getParameter("username");
                if (isNullHttpAware(username, resp)) return;
                SessionManager.getWhiteList().add(username);
                sendDocument(user, req, resp);
                return;
            }
        }

        resp.sendError(400);
    }

    private void sendDocument(User user, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("whitelist", SessionManager.getWhiteList().getList());
        req.setAttribute("username", user.email);
        req.setAttribute("theme", ThemeManager.getThemeCode(user));
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
    }

    private boolean isNullHttpAware(String str, HttpServletResponse resp) throws IOException {
        if (str == null) {
            resp.sendError(400);
            return true;
        }
        return false;
    }
}
