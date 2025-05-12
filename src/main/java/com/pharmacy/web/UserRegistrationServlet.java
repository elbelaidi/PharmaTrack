package com.pharmacy.web;

import com.pharmacy.model.User;
import com.pharmacy.service.UserService;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

/**
 * Servlet for user registration.
 */
@WebServlet("/register")
public class UserRegistrationServlet extends BaseServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Registration page should be accessible without login
        forwardToJsp(request, response, "register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || username.isEmpty() || password == null || password.isEmpty() ||
            fullName == null || fullName.isEmpty() || email == null || email.isEmpty() || role == null || role.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            forwardToJsp(request, response, "register.jsp");
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            forwardToJsp(request, response, "register.jsp");
            return;
        }

        if (userService.findByUsername(username) != null) {
            request.setAttribute("error", "Username already exists.");
            forwardToJsp(request, response, "register.jsp");
            return;
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setRole(role);
        newUser.setPassword(password); // Password will be hashed in DAO
        newUser.setActive(true);
        newUser.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        userService.save(newUser);

        // Redirect to login page after successful registration
        redirect(response, request.getContextPath() + "/login");
    }
}
