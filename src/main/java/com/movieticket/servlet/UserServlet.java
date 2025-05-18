package main.java.com.movieticket.servlet;

import main.java.com.movieticket.dao.UserDAO;
import main.java.com.movieticket.model.User;
import main.java.com.movieticket.util.PasswordUtil;

import jakarta.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "registerForm":
                req.getRequestDispatcher("users/register.jsp").forward(req, resp);
                break;

            case "editForm":
                String editId = req.getParameter("id");
                User userToEdit = userDAO.getUserById(editId);
                if (userToEdit == null) {
                    resp.sendRedirect("users");
                } else {
                    req.setAttribute("user", userToEdit);
                    req.getRequestDispatcher("users/edit_profile.jsp").forward(req, resp);
                }
                break;

            case "deleteConfirm":
                String deleteId = req.getParameter("id");
                User userToDelete = userDAO.getUserById(deleteId);
                if (userToDelete == null) {
                    resp.sendRedirect("users");
                } else {
                    req.setAttribute("user", userToDelete);
                    req.getRequestDispatcher("users/delete_account_confirm.jsp").forward(req, resp);
                }
                break;

            case "list":
            default:
                List<User> users = userDAO.getAllUsers();
                req.setAttribute("users", users);
                req.getRequestDispatcher("users/user_list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "register":
                registerUser(req, resp);
                break;

            case "update":
                updateUser(req, resp);
                break;

            case "delete":
                deleteUser(req, resp);
                break;

            default:
                resp.sendRedirect("users");
                break;
        }
    }

    private void registerUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userId = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        String hashedPassword = PasswordUtil.hashPassword(password);
        User user = new User(userId, name, email, hashedPassword, role);

        boolean created = userDAO.createUser(user);
        if (created) {
            resp.sendRedirect("login.jsp");
        } else {
            // handle error (not covered here)
            resp.sendRedirect("users?action=registerForm&error=true");
        }
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userId = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        String hashedPassword;
        if (password == null || password.trim().isEmpty()) {
            // Keep existing password hash if password not changed
            User existingUser = userDAO.getUserById(userId);
            if (existingUser == null) {
                // User not found, handle error (redirect or show message)
                resp.sendRedirect("users?action=editForm&id=" + userId + "&error=userNotFound");
                return;
            }
            hashedPassword = existingUser.getPasswordHash();
        } else {
            // Hash new password
            hashedPassword = PasswordUtil.hashPassword(password);
        }

        User updatedUser = new User(userId, name, email, hashedPassword, role);

        boolean success = userDAO.updateUser(updatedUser);
        if (success) {
            resp.sendRedirect("users");
        } else {
            // handle update failure
            resp.sendRedirect("users?action=editForm&id=" + userId + "&error=updateFailed");
        }
    }


    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userId = req.getParameter("userId");
        userDAO.deleteUser(userId);
        resp.sendRedirect("users");
    }
}
