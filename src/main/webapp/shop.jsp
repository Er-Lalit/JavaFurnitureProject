	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	
	<%@ page import="java.util.*" %>
	<%@ page import="service.Shop_Product_Handle" %>
	<%@ page import="model.product" %>
	
	<!doctype html>
	<html lang="en">
	<head>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	  <title>Shop</title>
	
	  <!-- ✅ FAVICON (FIXES THE ISSUE) -->
	  <link rel="shortcut icon"
	        href="<%= request.getContextPath() %>/favicon.png">
	
	  <!-- CSS -->
	  <link href="css/bootstrap.min.css" rel="stylesheet">
	
	  <!-- FONT AWESOME -->
	  <link rel="stylesheet"
	        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	
	  <link href="css/tiny-slider.css" rel="stylesheet">
	  <link href="css/style.css" rel="stylesheet">
	</head>
	
	
	<body>
	
	<!-- ================= HEADER ================= -->
	<jsp:include page="header.jsp" />
	
	<!-- ================= HERO SECTION ================= -->
	<div class="hero">
	  <div class="container">
	    <div class="row justify-content-between">
	      <div class="col-lg-5">
	        <div class="intro-excerpt">
	          <h1>Shop</h1>
	          <p class="mb-4">Browse our furniture collection.</p>
	        </div>
	      </div>
	      <div class="col-lg-7">
	        <div class="hero-img-wrap">
	          <img src="images/couch.png" class="img-fluid">
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
	    // Fetch products (as you wanted)
	    Shop_Product_Handle sp = new Shop_Product_Handle();
	    List<product> products = sp.getAllProduct();
	
	    if (products != null && !products.isEmpty()) {
	        for (product p : products) {
	%>
	
	      <div class="col-12 col-md-4 col-lg-3 mb-5">
	        <div class="product-item">
	
	          <img src="images/<%= p.getProduct_Image() %>"
	               class="img-fluid product-thumbnail"
	               alt="<%= p.getProduct_Name() %>">
	
	          <h3 class="product-title">
	            <%= p.getProduct_Name() %>
	          </h3>
	
	          <strong class="product-price">
	            ₹ <%= p.getProduct_productPrice() %>
	          </strong>
	
	          <a href="AddToCartController?pid=<%= p.getProduct_Id() %>">
	          <span class="icon-cross">
	          <img src="images/cross.svg" class="img-fluid">
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
	
	<!-- JS -->
	<script src="js/bootstrap.bundle.min.js"></script>
	<script src="js/tiny-slider.js"></script>
	<script src="js/custom.js"></script>
	
	</body>
	</html>
