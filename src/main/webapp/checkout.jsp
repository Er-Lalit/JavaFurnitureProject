<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
<%@ page import="model.product" %>   
<%
List<product> products = (List<product>) request.getAttribute("products");
HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) request.getAttribute("cart");
double grandTotal=0;

%>

<!doctype html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="shortcut icon" href="favicon.png">

<link href="css/bootstrap.min.css" rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

<link href="css/tiny-slider.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">

<title>Checkout</title>

</head>

<body>

	<!-- Header -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">

				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>Checkout</h1>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- Checkout Section -->
	<div class="untree_co-section">

		<div class="container">

			<div class="row">

				<!-- Billing Details -->
				<div class="col-md-6 mb-5 mb-md-0">

					<h2 class="h3 mb-3 text-black">Billing Details</h2>

					<div class="p-3 p-lg-5 border bg-white">

						<div class="form-group row">

							<div class="col-md-6">

								<label class="text-black">First Name</label>

								<input type="text" class="form-control"
									id="c_fname">

							</div>

							<div class="col-md-6">

								<label class="text-black">Last Name</label>

								<input type="text" class="form-control"
									id="c_lname">

							</div>

						</div>

						<div class="form-group row mt-3">

							<div class="col-md-12">

								<label class="text-black">Address</label>

								<input type="text" class="form-control"
									id="c_address"
									placeholder="Street Address">

							</div>

						</div>

						<div class="form-group row mt-3">

							<div class="col-md-6">

								<label class="text-black">Email</label>

								<input type="email" class="form-control"
									id="c_email">

							</div>

							<div class="col-md-6">

								<label class="text-black">Phone</label>

								<input type="text" class="form-control"
									id="c_phone">

							</div>

						</div>

					</div>

				</div>

				<!-- Order Summary -->
				<div class="col-md-6">

					<h2 class="h3 mb-3 text-black">Your Order</h2>

					<div class="p-3 p-lg-5 border bg-white">

						<table class="table site-block-order-table mb-5">

							<thead>
							 <tr>
							  <th>Product</th>
							   <th>Quantity</th>
							    <th>Total</th> </tr>
							     </thead>
							      <tbody>
<%
if (products != null && cart != null && !products.isEmpty()) {

    for (product p : products) {

        int qty = cart.get(p.getProduct_Id());
        double total = p.getProduct_productPrice() * qty;
        grandTotal+=total;
%>
							      <tr>
							       <td><%=p.getProduct_Name() %></td>
							        <td><%=qty %></td>
							         <td><%=total %></td>
							          </tr>
<%
    }
     
    %>
    <tr>

    <td colspan="2"
        class="text-black font-weight-bold">

        <strong>Order Total</strong>

    </td>

    <td
        class="text-black font-weight-bold">

        <strong>
            ₹<%=grandTotal %>
        </strong>

    </td>

</tr>
    <%
    
} else {
%>							         
<td colspan="3" align="center">

    <h4>No items available for checkout</h4>

    <p>
        Add products to your cart before proceeding to checkout.
    </p>


    <a href="shop.jsp"
       class="btn btn-black">

        Continue Shopping

    </a>

</td>
<%
}
%>

							                    </tbody>

						</table>

						<!-- Payment Button -->
						<div class="form-group">

							<button id="rzp-button1"
								class="btn btn-black btn-lg py-3 btn-block">

								Proceed To Payment

							</button>

						</div>

					</div>

				</div>

			</div>

		</div>

	</div>

	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	<!-- JS Files -->
	<script src="js/bootstrap.bundle.min.js"></script>
	<script src="js/tiny-slider.js"></script>
	<script src="js/custom.js"></script>

	<!-- Razorpay -->
	<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

	<script>

		document.getElementById('rzp-button1').onclick = function(e) {

			var options = {

				"key" : "YOUR_KEY_ID",

				"amount" : "400000",

				"currency" : "INR",

				"name" : "Furni Store",

				"description" : "Furniture Payment",

				"handler" : function(response) {

					alert("Payment Successful!");

					alert("Payment ID : "
							+ response.razorpay_payment_id);

					window.location = "thankyou.jsp";
				},

				"prefill" : {

					"name" : "Anchal Kansara",

					"email" : "anchal@gmail.com",

					"contact" : "9999999999"
				},

				"theme" : {

					"color" : "#000000"
				}
			};

			var rzp1 = new Razorpay(options);

			rzp1.open();

			e.preventDefault();
		}
	</script>

</body>

</html>