<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap" %>
<%
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Calculate total items in cart for the badge
    HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) session.getAttribute("cart");
    int totalItems = 0;
    if (cart != null) {
        for (int qty : cart.values()) {
            totalItems += qty;
        }
    }
%>

<nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" aria-label="Furni navigation bar">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Furni<span>.</span></a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
            aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsFurni">
            <!-- Navigation menu (unchanged) -->
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                <li class="nav-item <%= request.getRequestURI().contains("index.jsp") ? "active" : "" %>">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item <%= request.getRequestURI().contains("shop.jsp") ? "active" : "" %>">
                    <a class="nav-link" href="shop.jsp">Shop</a>
                </li>
                <li class="nav-item <%= request.getRequestURI().contains("about.jsp") ? "active" : "" %>">
                    <a class="nav-link" href="about.jsp">About us</a>
                </li>
                <li class="nav-item <%= request.getRequestURI().contains("services.jsp") ? "active" : "" %>">
                    <a class="nav-link" href="services.jsp">Services</a>
                </li>
                <li class="nav-item <%= request.getRequestURI().contains("blog.jsp") ? "active" : "" %>">
                    <a class="nav-link" href="blog.jsp">Blog</a>
                </li>
                <li class="nav-item <%= request.getRequestURI().contains("contact.jsp") ? "active" : "" %>">
                    <a class="nav-link" href="contact.jsp">Contact us</a>
                </li>
            </ul>

            <!-- User profile or login/signup options -->
            <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                <% if (username != null && !username.isEmpty()) { %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
                            data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="<%= request.getContextPath() %>/images/user.svg" alt="User"> <%= username %>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="Profile.jsp">Profile</a></li>
                            <li><a class="dropdown-item" href="LogOutController">Logout</a></li>
                             <li><a class="dropdown-item" href="orderSuccess.jsp">Orders</a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
                            data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="<%= request.getContextPath() %>/images/user.svg" alt="User">
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="signup.jsp">Sign Up</a></li>
                            <li><a class="dropdown-item" href="login.jsp">Login</a></li>
                        </ul>
                    </li>
                <% } %>

                <!-- Cart icon with notification badge -->
                <li class="nav-item position-relative">
                    <a class="nav-link" href="<%= request.getContextPath() %>/CartController">
                        <img src="<%= request.getContextPath() %>/images/cart.svg" alt="Cart" style="width:24px;">
                        <% if (totalItems > 0) { %>
                            <span class="badge bg-danger position-absolute top-0 start-100 translate-middle rounded-pill">
                                <%= totalItems %>
                            </span>
                        <% } %>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>