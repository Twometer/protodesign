package de.twometer.protodesign.servlet;

import de.twometer.protodesign.db.SessionManager;
import de.twometer.protodesign.parsers.ParserManager;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/format")
public class FormatServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        long userId = SessionManager.getUser(req);
        if (userId == 0) {
            resp.sendError(401);
            return;
        }

        StringBuilder builder = new StringBuilder();
        String line;
        BufferedReader reader = req.getReader();
        while ((line = reader.readLine()) != null) builder.append(line).append("\n");
        resp.getWriter().write(ParserManager.getInstance().parse(builder.toString()));
    }
}
