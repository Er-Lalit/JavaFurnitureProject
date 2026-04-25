<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
<%@ page import="model.product" %>

<%
List<product> products = (List<product>) request.getAttribute("products");
HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) request.getAttribute("cart");

double grandTotal = 0;
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Fix paths -->
    <base href="<%= request.getContextPath() %>/">

    <!-- Favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.png">

    <title>Cart | Furni</title>

    <!-- CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="css/tiny-slider.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

<!-- HEADER -->
<jsp:include page="header.jsp"/>

<!-- HERO -->
<div class="hero">
    <div class="container">
        <h1>Cart</h1>
    </div>
</div>

<!-- CART -->
<div class="untree_co-section before-footer-section">
    <div class="container">

        <table class="table">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Remove</th>
                </tr>
            </thead>

            <tbody>

<%
if (products != null && cart != null && !products.isEmpty()) {

    for (product p : products) {

        int qty = cart.get(p.getProduct_Id());
        double total = p.getProduct_productPrice() * qty;
        grandTotal += total;
%>

<tr>
    <td>
        <img src="images/<%= p.getProduct_Image() %>" width="80">
    </td>

    <td><%= p.getProduct_Name() %></td>

    <td>₹<%= p.getProduct_productPrice() %></td>

    <td>
        <a href="UpdateCart?type=minus&id=<%= p.getProduct_Id() %>">−</a>
        <%= qty %>
        <a href="UpdateCart?type=plus&id=<%= p.getProduct_Id() %>">+</a>
    </td>

    <td>₹<%= total %></td>

    <td>
        <a href="RemoveFromCart?id=<%= p.getProduct_Id() %>"
           class="btn btn-black btn-sm">
           X
        </a>
    </td>
</tr>

<%
    }
} else {
%>

<tr>
    <td colspan="6" align="center">
        <h4>Your cart is empty</h4>
        <a href="shop.jsp" class="btn btn-black">
            Shop Now
        </a>
    </td>
</tr>

<%
}
%>

            </tbody>
        </table>

        <!-- TOTAL SECTION -->
        <div align="right">
            <h4>Subtotal: ₹<%= grandTotal %></h4>
            <h4>Total: ₹<%= grandTotal %></h4>

            <a href="Checkout" class="btn btn-black btn-lg">
                Proceed To Checkout
            </a>
        </div>

    </div>
</div>

<!-- FOOTER -->
<jsp:include page="footer.jsp"/>

<script src="js/bootstrap.bundle.min.js"></script>


</body>
</html>