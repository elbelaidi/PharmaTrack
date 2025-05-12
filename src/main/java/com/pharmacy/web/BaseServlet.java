package com.pharmacy.web;

import com.pharmacy.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public abstract class BaseServlet extends HttpServlet {
    protected static final String USER_SESSION_KEY = "user";

    protected boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute(USER_SESSION_KEY) != null;
    }

    protected User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (User) session.getAttribute(USER_SESSION_KEY) : null;
    }

    protected void requireAuthentication(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Add headers to prevent caching of protected pages
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        }
    }

    protected void forwardToJsp(HttpServletRequest request, HttpServletResponse response, String jspPath) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/" + jspPath).forward(request, response);
    }

    protected void redirect(HttpServletResponse response, String path) throws IOException {
        response.sendRedirect(path);
    }
}
