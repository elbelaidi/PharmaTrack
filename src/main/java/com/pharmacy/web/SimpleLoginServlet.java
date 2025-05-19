package com.pharmacy.web;

import com.pharmacy.model.User;
import com.pharmacy.service.UserService;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class SimpleLoginServlet extends BaseServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.removeAttribute("error");
        forwardToJsp(request, response, "simple-login.jsp");
    }

    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username").trim();
    String password = request.getParameter("password").trim();

    User user = userService.findByUsername(username);

    if (user != null && BCrypt.checkpw(password, user.getPassword())) {
        HttpSession session = request.getSession();
        session.setAttribute(USER_SESSION_KEY, user);
        System.out.println("Session created for user: " + user.getUsername());
        response.sendRedirect(request.getContextPath() + "/dashboard");
    } else {
        request.setAttribute("error", "Invalid username or password");
        request.setAttribute("username", username);
        request.setAttribute("hasTriedLogin", true);
        forwardToJsp(request, response, "simple-login.jsp");
    }
}

}
