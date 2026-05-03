<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - Auto Parts Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="../../components/navbar.jsp" %>

    <div class="admin-container">
        <div class="admin-sidebar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin-dashboard"><i class="fas fa-dashboard"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-products" class="active"><i class="fas fa-box"></i> Products</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-orders"><i class="fas fa-shopping-cart"></i> Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-users"><i class="fas fa-users"></i> Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-categories"><i class="fas fa-tags"></i> Categories</a></li>
            </ul>
        </div>

        <div class="admin-content">
            <div class="form-container" style="max-width:800px;">
                <h1><i class="fas fa-plus-circle"></i> Add New Product</h1>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/add-product" method="POST" enctype="multipart/form-data" class="modern-form">
                    <div class="form-group">
                        <label for="name">Product Name *</label>
                        <input type="text" id="name" name="name" required placeholder="e.g. Premium Brake Pad Set">
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">Price ($) *</label>
                            <input type="number" id="price" name="price" step="0.01" min="0" required placeholder="0.00">
                        </div>
                        <div class="form-group">
                            <label for="stockQuantity">Stock Quantity *</label>
                            <input type="number" id="stockQuantity" name="stockQuantity" min="0" required placeholder="0">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="categoryId">Category *</label>
                            <select id="categoryId" name="categoryId" required>
                                <option value="">-- Select Category --</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="manufacturer">Manufacturer</label>
                            <input type="text" id="manufacturer" name="manufacturer" placeholder="e.g. Bosch">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="modelCompatibility">Model Compatibility</label>
                        <input type="text" id="modelCompatibility" name="modelCompatibility" placeholder="e.g. Universal Fit, Toyota Corolla 2018+">
                    </div>

                    <div class="form-group">
                        <label for="image">Product Image</label>
                        <input type="file" id="image" name="image" accept="image/*" class="file-input">
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="4" placeholder="Detailed product description..."></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Product</button>
                        <a href="${pageContext.request.contextPath}/admin-products" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="../../components/footer.jsp" %>
</body>
</html>
