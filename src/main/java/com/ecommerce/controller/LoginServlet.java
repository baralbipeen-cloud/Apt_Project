package com.ecommerce.controller;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.models.ResultModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Cookie;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Check for Remember Me cookie
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberMe".equals(cookie.getName())) {
                    String email = cookie.getValue();
                    // Auto-login logic could be here, but for simplicity we just pre-fill the email
                    req.setAttribute("rememberedEmail", email);
                    break;
                }
            }
        }
        
        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("rememberMe");
        
        ResultModel result = userDAO.loginUser(email, password);
        
        if (result.isSuccess()) {
            req.getSession().setAttribute("email", result.getEmail());
            req.getSession().setAttribute("role", result.getRole());
            req.getSession().setAttribute("active", result.getActive());
            
            if ("on".equals(remember)) {
                Cookie c = new Cookie("rememberMe", email);
                c.setMaxAge(60 * 60 * 24 * 30); // 30 days
                resp.addCookie(c);
            } else {
                Cookie c = new Cookie("rememberMe", "");
                c.setMaxAge(0);
                resp.addCookie(c);
            }
            
            if ("admin".equals(result.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/admin-dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/user-home");
            }
        } else {
            req.setAttribute("error", result.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        }
    }
}