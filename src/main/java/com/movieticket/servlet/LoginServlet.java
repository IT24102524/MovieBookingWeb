package main.java.com.movieticket.servlet;

import main.java.com.movieticket.dao.UserDAO;
import main.java.com.movieticket.model.User;
import main.java.com.movieticket.util.PasswordUtil;

import jakarta.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username"); // userId
        String password = req.getParameter("password");

        User user = userDAO.getUserById(username);
        if (user != null) {
            String hashedInput = PasswordUtil.hashPassword(password);
            if (user.getPasswordHash().equals(hashedInput)) {
                HttpSession session = req.getSession();
                session.setAttribute("currentUser", user);
                session.setAttribute("role", user.getRole());

                if ("admin".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
                } else {
                    // Redirect non-admin users to their profile page
                    resp.sendRedirect(req.getContextPath() + "/users/profile.jsp");
                }
                return;
            }
        }
        // Authentication failed
        resp.sendRedirect(req.getContextPath() + "/login.jsp?error=true");
    }
}
