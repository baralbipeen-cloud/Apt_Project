<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Auto Parts Store</title>
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
            <div class="admin-header-flex">
                <h1>Manage Products</h1>
                <a href="${pageContext.request.contextPath}/add-product" class="btn btn-primary"><i class="fas fa-plus"></i> Add Product</a>
            </div>

            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success">${sessionScope.successMsg}</div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert-danger">${sessionScope.errorMsg}</div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.productId}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty product.imageUrl}">
                                        <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.name}" width="50" height="50" style="object-fit:cover; border-radius:5px;">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width:50px; height:50px; background:#eee; border-radius:5px; display:flex; align-items:center; justify-content:center;">
                                            <i class="fas fa-image" style="color:#aaa;"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${product.name}</td>
                            <td>${product.categoryName}</td>
                            <td>$${product.price}</td>
                            <td>
                                <span class="${product.stockQuantity < 10 ? 'text-danger' : ''}">${product.stockQuantity}</span>
                            </td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/update-product?id=${product.productId}" class="btn-icon btn-edit" title="Edit"><i class="fas fa-edit"></i></a>
                                <form action="${pageContext.request.contextPath}/delete-product" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this product?');">
                                    <input type="hidden" name="id" value="${product.productId}">
                                    <button type="submit" class="btn-icon btn-delete" title="Delete"><i class="fas fa-trash"></i></button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty products}">
                        <tr>
                            <td colspan="7" class="text-center">No products found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="../../components/footer.jsp" %>
</body>
</html>
