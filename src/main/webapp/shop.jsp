<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, service.Shop_Product_Handle, model.product" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <base href="<%= request.getContextPath() %>/">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Shop</title>

    <!-- Favicon – context path -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.png">

    <!-- CSS -->
    <link href="<%= request.getContextPath() %>/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="<%= request.getContextPath() %>/css/tiny-slider.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>

    <!-- ================= HEADER ================= -->
    <jsp:include page="header.jsp" />

    <!-- ================= HERO SECTION (just like About page) ================= -->
    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Shop</h1>
                        <p class="mb-4">Browse our furniture collection.</p>
                        <p><a href="shop.jsp" class="btn btn-secondary me-2">All Products</a><a href="orderSuccess.jsp" class="btn btn-white-outline">My Orders</a></p>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="hero-img-wrap">
                        <img src="<%= request.getContextPath() %>/images/couch.png" class="img-fluid" alt="Couch">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ================= PRODUCT SECTION ================= -->
    <div class="untree_co-section product-section before-footer-section">
        <div class="container">
            <div class="row">

                <%
                Shop_Product_Handle sp = new Shop_Product_Handle();
                List<product> products = sp.getAllProduct();

                if (products != null && !products.isEmpty()) {
                    for (product p : products) {
                %>

                <div class="col-12 col-md-4 col-lg-3 mb-5">
                    <div class="product-item">
                        <!-- Product Image – context path -->
                        <img src="<%= request.getContextPath() %>/images/<%= p.getProduct_Image() %>"
                             class="img-fluid product-thumbnail"
                             alt="<%= p.getProduct_Name() %>">

                        <h3 class="product-title"><%= p.getProduct_Name() %></h3>
                        <strong class="product-price">₹ <%= p.getProduct_productPrice() %></strong>

                        <!-- Add to cart icon – context path -->
                        <a href="<%= request.getContextPath() %>/AddToCartController?pid=<%= p.getProduct_Id() %>">
                            <span class="icon-cross">
                                <img src="<%= request.getContextPath() %>/images/cross.svg" class="img-fluid" alt="Add to cart">
                            </span>
                        </a>
                    </div>
                </div>

                <%
                    }
                } else {
                %>

                <div class="col-12 text-center">
                    <h4>No products found in database</h4>
                </div>

                <%
                }
                %>

            </div>
        </div>
    </div>

    <!-- ================= FOOTER ================= -->
    <jsp:include page="footer.jsp" />

    <!-- JS – context path -->
    <script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/js/tiny-slider.js"></script>
    <script src="<%= request.getContextPath() %>/js/custom.js"></script>

</body>
</html>