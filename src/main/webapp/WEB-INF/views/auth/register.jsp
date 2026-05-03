<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Auto Parts Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="../../components/navbar.jsp" %>

    <div class="auth-container">
        <div class="auth-card" style="max-width: 600px;">
            <h2>Create an Account</h2>

            <c:if test="${not empty param.error}">
                <div class="alert alert-error">${param.error}</div>
            </c:if>
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-error">${requestScope.error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">
                <div class="form-row">
                    <div class="form-group" style="flex: 1;">
                        <label for="firstName">First Name *</label>
                        <div class="input-group">
                            <i class="fas fa-user"></i>
                            <input type="text" id="firstName" name="firstName" value="${requestScope.firstName}" placeholder="First Name" required>
                        </div>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label for="lastName">Last Name *</label>
                        <div class="input-group">
                            <i class="fas fa-user"></i>
                            <input type="text" id="lastName" name="lastName" value="${requestScope.lastName}" placeholder="Last Name" required>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email Address *</label>
                    <div class="input-group">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" value="${requestScope.email}" placeholder="Enter your email" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group" style="flex: 1;">
                        <label for="password">Password *</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="password" name="password" placeholder="Create a password" minlength="6" required>
                        </div>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label for="confirmPassword">Confirm Password *</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" minlength="6" required>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <div class="input-group">
                        <i class="fas fa-phone"></i>
                        <input type="tel" id="phone" name="phone" placeholder="Your phone number">
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Shipping Address</label>
                    <div class="input-group">
                        <i class="fas fa-map-marker-alt"></i>
                        <input type="text" id="address" name="address" placeholder="Your shipping address">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-block">Register</button>
            </form>

            <div class="auth-footer">
                <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
                <a href="${pageContext.request.contextPath}/index.jsp">Back to Home</a>
            </div>
        </div>
    </div>

    <%@ include file="../../components/footer.jsp" %>
</body>
</html>
