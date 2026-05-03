package com.ecommerce.controller;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.models.ProductModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class AdminProductsServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        List<ProductModel> products = productDAO.getAllProducts();
        req.setAttribute("products", products);
        
        req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);
    }
}
