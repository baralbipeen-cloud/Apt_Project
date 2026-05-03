package com.ecommerce.controller;

import com.ecommerce.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DeleteProductServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int productId = Integer.parseInt(idStr);
            boolean success = productDAO.deleteProduct(productId);
            
            if (success) {
                req.getSession().setAttribute("successMsg", "Product deleted successfully!");
            } else {
                req.getSession().setAttribute("errorMsg", "Failed to delete product.");
            }
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin-products");
    }
}
