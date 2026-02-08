<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
<%@ page import="model.product" %>

<%
     List<product> sessionProduct=(List<product>)session.getAttribute("cart");


%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Cart | Furni</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
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
               if(sessionProduct!=null)
               {
            	   for(product p:sessionProduct)
            	   {
            		   
            	   
               
               
               %>
                <tr>
                    <td>
                        <img src="images/<%=p.getProduct_Image() %>" width="80">
                    </td>

                    <td><%=p.getProduct_Name() %></td>

                    <td><%=p.getProduct_productPrice() %></td>

                    <td>
                        <a href="UpdateCart?type=minus&id=PRODUCT_ID">−</a>
                        <%=p.getProduct_cartCount() %>
                        <a href="UpdateCart?type=plus&id=PRODUCT_ID">+</a>
                    </td>

                    <td>₹0</td>

                    <td>
                        <a href="RemoveFromCart?id=PRODUCT_ID"
                           class="btn btn-black btn-sm">
                           X
                        </a>
                    </td>
                    <%
            	   }
               }
            	
                    
                    %>
                </tr>
                <!-- END cart row -->

                <!-- Empty cart message -->
                <tr>
                    <td colspan="6" align="center">
                        <h4>Your cart is empty</h4>
                        <a href="shop.jsp" class="btn btn-black">
                            Shop Now
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- TOTAL SECTION -->
        <div align="right">
            <h4>Subtotal: ₹0</h4>
            <h4>Total: ₹0</h4>

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
