package com.ecommerce.controller;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.models.CategoryModel;
import com.ecommerce.models.ProductModel;
import com.ecommerce.utils.ValidationUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class AddProductServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    private static final String UPLOAD_DIR = "images/products";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        List<CategoryModel> categories = categoryDAO.getAllCategories();
        req.setAttribute("categories", categories);
        
        req.getRequestDispatcher("/WEB-INF/views/admin/add-product.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String stockStr = req.getParameter("stockQuantity");
        String categoryIdStr = req.getParameter("categoryId");
        String manufacturer = req.getParameter("manufacturer");
        String modelCompatibility = req.getParameter("modelCompatibility");
        
        // Validation
        if (!ValidationUtils.isValidPrice(priceStr) || !ValidationUtils.isValidQuantity(stockStr)) {
            req.setAttribute("error", "Invalid price or stock quantity.");
            doGet(req, resp);
            return;
        }
        
        double price = Double.parseDouble(priceStr);
        int stockQuantity = Integer.parseInt(stockStr);
        int categoryId = Integer.parseInt(categoryIdStr);
        
        // File Upload Handling
        String imageUrl = "";
        Part filePart = req.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String applicationPath = req.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            File fileSaveDir = new File(uploadFilePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs();
            }
            
            filePart.write(uploadFilePath + File.separator + fileName);
            imageUrl = UPLOAD_DIR + "/" + fileName;
        }
        
        ProductModel product = new ProductModel();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);
        product.setCategoryId(categoryId);
        product.setManufacturer(manufacturer);
        product.setModelCompatibility(modelCompatibility);
        product.setImageUrl(imageUrl);
        
        boolean success = productDAO.addProduct(product);
        
        if (success) {
            req.getSession().setAttribute("successMsg", "Product added successfully!");
            resp.sendRedirect(req.getContextPath() + "/admin-products");
        } else {
            req.setAttribute("error", "Failed to add product. Please try again.");
            doGet(req, resp);
        }
    }
}
