package com.ecommerce.dao;

import com.ecommerce.models.CategoryModel;
import com.ecommerce.queries.Queries;
import com.ecommerce.utils.DatabaseConn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    
    public List<CategoryModel> getAllCategories() {
        List<CategoryModel> categories = new ArrayList<>();
        try (Connection conn = DatabaseConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(Queries.GET_ALL_CATEGORIES);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                CategoryModel cat = new CategoryModel();
                cat.setCategoryId(rs.getInt("category_id"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
                cat.setImageUrl(rs.getString("image_url"));
                cat.setPrice(rs.getDouble("price"));
                categories.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
}
