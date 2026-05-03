<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Auto Parts Store</title>
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
                <li><a href="${pageContext.request.contextPath}/admin-products"><i class="fas fa-box"></i> Products</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-orders"><i class="fas fa-shopping-cart"></i> Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-users" class="active"><i class="fas fa-users"></i> Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-categories"><i class="fas fa-tags"></i> Categories</a></li>
            </ul>
        </div>

        <div class="admin-content">
            <div class="admin-header-flex">
                <h1>Manage Users</h1>
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
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Joined</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.firstName} ${user.lastName}</td>
                            <td>${user.email}</td>
                            <td><span class="badge role-${user.role}">${user.role}</span></td>
                            <td><fmt:formatDate value="${user.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <span class="status-badge status-${user.active == 'active' ? 'delivered' : 'cancelled'}">${user.active}</span>
                            </td>
                            <td class="actions">
                                <c:if test="${user.role != 'admin'}">
                                    <form action="${pageContext.request.contextPath}/admin-users" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.userId}">
                                        <c:choose>
                                            <c:when test="${user.active == 'active'}">
                                                <input type="hidden" name="action" value="ban">
                                                <button type="submit" class="btn-icon btn-danger" title="Ban User" onclick="return confirm('Are you sure you want to ban this user?');"><i class="fas fa-ban"></i></button>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="action" value="unban">
                                                <button type="submit" class="btn-icon btn-success" title="Unban User"><i class="fas fa-check-circle"></i></button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </c:if>
                                <c:if test="${user.role == 'admin'}">
                                    <span class="text-muted"><i class="fas fa-shield-alt"></i></span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="7" class="text-center">No users found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="../../components/footer.jsp" %>
</body>
</html>
