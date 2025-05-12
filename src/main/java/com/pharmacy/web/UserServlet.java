package com.pharmacy.web;

import com.pharmacy.model.User;
import com.pharmacy.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/users/*")
public class UserServlet extends BaseServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        requireAuthentication(request, response);

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            String query = request.getParameter("q");
            List<User> users;
            if (query != null && !query.trim().isEmpty()) {
                users = userService.search(query.trim());
            } else {
                users = userService.findAll();
            }
            request.setAttribute("users", users);
            forwardToJsp(request, response, "users/list.jsp");
        } else if (pathInfo.equals("/new")) {
            // Show new user form
            // Ensure no user attribute is set so form is empty
            request.removeAttribute("user");
            forwardToJsp(request, response, "users/form.jsp");
        } else if (pathInfo.equals("/edit")) {
            // Show edit user form
            Long id = Long.parseLong(request.getParameter("id"));
            User user = userService.findById(id);
            request.setAttribute("user", user);
            forwardToJsp(request, response, "users/form.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // Create or update user
            User user = new User();
            user.setUsername(request.getParameter("username"));
            user.setFullName(request.getParameter("fullName"));
            user.setEmail(request.getParameter("email"));
            user.setRole(request.getParameter("role"));
            // Password handling should be added here securely

            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                userService.save(user);
            } else {
                user.setId(Long.parseLong(id));
                userService.update(user);
            }

            redirect(response, request.getContextPath() + "/users");
        } else if (pathInfo.equals("/delete")) {
            // Delete user
            Long id = Long.parseLong(request.getParameter("id"));
            userService.delete(id);
            redirect(response, request.getContextPath() + "/users");
        }
    }
}
