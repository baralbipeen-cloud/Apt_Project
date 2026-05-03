package com.ecommerce.filter;

import com.ecommerce.models.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/*"})
public class BanFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        if (session != null && session.getAttribute("email") != null) {
            String activeStatus = (String) session.getAttribute("active");
            if ("banned".equals(activeStatus)) {
                session.invalidate();
                request.setAttribute("error", "Your account has been banned. Please contact the administrator.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }
        }
        
        chain.doFilter(req, res);
    }
}
