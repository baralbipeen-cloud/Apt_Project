package com.ecommerce.controller;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.models.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class AdminUsersServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        List<UserModel> users = userDAO.getAllUsers();
        req.setAttribute("users", users);
        
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String idStr = req.getParameter("userId");
        String action = req.getParameter("action");
        
        if (idStr != null && action != null) {
            int userId = Integer.parseInt(idStr);
            String newStatus = "ban".equals(action) ? "banned" : "active";
            
            boolean success = userDAO.updateUserStatus(userId, newStatus);
            if (success) {
                req.getSession().setAttribute("successMsg", "User status updated successfully.");
            } else {
                req.getSession().setAttribute("errorMsg", "Failed to update user status.");
            }
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin-users");
    }
}
