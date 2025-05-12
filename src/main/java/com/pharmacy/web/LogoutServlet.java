package com.pharmacy.web;

import com.pharmacy.model.User;
import com.pharmacy.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet to handle user logout by updating last login, invalidating the session, and redirecting to login page.
 */
import javax.servlet.annotation.WebServlet;

@WebServlet("/logout")
public class LogoutServlet extends BaseServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = getCurrentUser(request);
        if (user != null) {
            // Directly update last_login column in the database without try-catch logging
            userService.updateLastLogin(user.getId());
            System.out.println("Session closed for user: " + user.getUsername());
            System.out.println("Logout successful for user: " + user.getUsername());
            System.out.flush();
        }
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // Redirect to localhost:8081/login as requested
        response.sendRedirect("http://localhost:8081/login");
    }
}
