<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="model.product"%>

<%
List<product> products = (List<product>) request.getAttribute("products");
HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) request.getAttribute("cart");

double grandTotal = 0;

/*
 * STOCK VALIDATION
 *
 * Compare:
 * Cart Quantity
 *       >
 * Database Quantity
 *
 * If cart quantity is greater than DB quantity,
 * create an error message.
 */

String stockErrorMessage = "";

if (products != null && cart != null) {

    for (product p : products) {

        int cartQty = cart.get(p.getProduct_Id());
        int dbQty = p.getProductQty();

        if (cartQty > dbQty) {

            stockErrorMessage +=
                    p.getProduct_Name()
                    + " - Only " + dbQty
                    + " available. You selected " + cartQty
                    + ".\n";
        }
    }
}
%>

<!doctype html>

<html lang="en">

<head>

    <meta charset="utf-8">

    <base href="<%= request.getContextPath() %>/">

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

                    <h2 class="h3 mb-3 text-black">
                        Billing Details
                    </h2>

                    <div class="p-3 p-lg-5 border bg-white">

                        <div class="form-group row">

                            <div class="col-md-6">

                                <label class="text-black">
                                    First Name
                                </label>

                                <input type="text"
                                    class="form-control"
                                    id="c_fname"
                                    name="fname">

                            </div>


                            <div class="col-md-6">

                                <label class="text-black">
                                    Last Name
                                </label>

                                <input type="text"
                                    class="form-control"
                                    id="c_lname"
                                    name="lname">

                            </div>

                        </div>


                        <div class="form-group row mt-3">

                            <div class="col-md-12">

                                <label class="text-black">
                                    Address
                                </label>

                                <input type="text"
                                    class="form-control"
                                    id="c_address"
                                    name="address"
                                    placeholder="Street Address">

                            </div>

                        </div>


                        <div class="form-group row mt-3">

                            <div class="col-md-6">

                                <label class="text-black">
                                    Email
                                </label>

                                <input type="email"
                                    class="form-control"
                                    id="c_email"
                                    name="email">

                            </div>


                            <div class="col-md-6">

                                <label class="text-black">
                                    Phone
                                </label>

                                <input type="text"
                                    class="form-control"
                                    id="c_phone"
                                    name="phone">

                            </div>

                        </div>

                    </div>

                </div>


                <!-- Order Summary -->

                <div class="col-md-6">

                    <h2 class="h3 mb-3 text-black">
                        Your Order
                    </h2>

                    <div class="p-3 p-lg-5 border bg-white">

                        <table class="table site-block-order-table mb-5">

                            <thead>

                                <tr>

                                    <th>Product</th>

                                    <th>Quantity</th>

                                    <th>Total</th>

                                </tr>

                            </thead>


                            <tbody>

                                <%

                                if (products != null && cart != null && !products.isEmpty()) {

                                    for (product p : products) {

                                        int qty = cart.get(p.getProduct_Id());

                                        double total =
                                                p.getProduct_productPrice() * qty;

                                        grandTotal += total;

                                %>


                                <tr>

                                    <td>
                                        <%= p.getProduct_Name() %>
                                    </td>

                                    <td>
                                        <%= qty %>
                                    </td>

                                    <td>
                                        <%= total %>
                                    </td>

                                </tr>


                                <%

                                    }

                                %>


                                <tr>

                                    <td colspan="2"
                                        class="text-black font-weight-bold">

                                        <strong>
                                            Order Total
                                        </strong>

                                    </td>


                                    <td class="text-black font-weight-bold">

                                        <strong>
                                            ₹<%= grandTotal %>
                                        </strong>

                                    </td>

                                </tr>


                                <%

                                } else {

                                %>


                                <td colspan="3" align="center">

                                    <h4>
                                        No items available for checkout
                                    </h4>

                                    <p>
                                        Add products to your cart before
                                        proceeding to checkout.
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

        e.preventDefault();

        var btn = this;

        btn.disabled = true;


        let fname =
            document.getElementById("c_fname").value.trim();

        let lname =
            document.getElementById("c_lname").value.trim();

        let address =
            document.getElementById("c_address").value.trim();

        let email =
            document.getElementById("c_email").value.trim();

        let phone =
            document.getElementById("c_phone").value.trim();


        /*
         * BILLING DETAILS VALIDATION
         */

        if (!fname || !lname || !address || !email || !phone) {

            alert("Please fill all billing details.");

            btn.disabled = false;

            return;
        }


        /*
         * STOCK VALIDATION
         *
         * This value was prepared above from JSP.
         *
         * Example:
         *
         * Product_3 - Only 2 available. You selected 6.
         */

        let stockError = `<%= stockErrorMessage
                .replace("\\", "\\\\")
                .replace("`", "\\`")
                .replace("\r", "")
                .replace("\n", "\\n") %>`;


        /*
         * IF STOCK IS NOT AVAILABLE
         *
         * Stop checkout.
         * Razorpay will NOT open.
         */

        if (stockError) {

            alert(
                "Some products are not available in the required quantity:\n\n"
                + stockError
                + "\nPlease update your cart before proceeding."
            );

            btn.disabled = false;

            return;
        }


        /*
         * EVERYTHING IS OK
         *
         * Continue with existing checkout process.
         */

        let formData = new URLSearchParams();

        formData.append("fname", fname);

        formData.append("lname", lname);

        formData.append("address", address);

        formData.append("email", email);

        formData.append("phone", phone);


        fetch('<%= request.getContextPath() %>/initiateCheckout', {

            method: 'POST',

            body: formData

        })

        .then(res => res.json())

        .then(data => {


            /*
             * SERVER ERROR
             */

            if (data.error) {

                alert(data.error);

                btn.disabled = false;

                return;
            }


            console.log(
                "Checkout initiated, order ID:",
                data.internalOrderId
            );


            /*
             * RAZORPAY OPTIONS
             */

            var options = {

                "key": data.key,

                "amount": data.amount,

                "currency": data.currency,

                "name": "Furni Store",

                "description": "Furniture Payment",

                "order_id": data.razorpayOrderId,


                /*
                 * PAYMENT SUCCESS
                 */

                "handler": function(response) {

                    console.log(
                        "Payment success, confirming order..."
                    );


                    fetch(
                        '<%= request.getContextPath() %>/confirmPayment',
                        {

                            method: 'POST',

                            headers: {
                                'Content-Type':
                                    'application/json'
                            },

                            body: JSON.stringify({

                                razorpay_payment_id:
                                    response.razorpay_payment_id,

                                razorpay_order_id:
                                    response.razorpay_order_id,

                                razorpay_signature:
                                    response.razorpay_signature,

                                internalOrderId:
                                    data.internalOrderId

                            })

                        }
                    )

                    .then(res => res.json())

                    .then(result => {

                        console.log(
                            "Confirm response:",
                            result
                        );


                        /*
                         * Redirect after confirmation
                         */

                        window.location.href =
                            '<%= request.getContextPath() %>/shop.jsp';

                    })

                    .catch(err => {

                        console.error(
                            "Confirm error:",
                            err
                        );


                        /*
                         * Still go to shop if confirmation
                         * request fails.
                         */

                        window.location.href =
                            '<%= request.getContextPath() %>/shop.jsp';

                    });

                },


                /*
                 * PAYMENT CANCELLED
                 */

                "modal": {

                    "ondismiss": function() {

                        console.log(
                            "Payment cancelled, restoring stock..."
                        );


                        fetch(
                            '<%= request.getContextPath() %>/restoreStock?orderId='
                            + data.internalOrderId,
                            {
                                method: 'POST'
                            }
                        )

                        .then(() => {

                            console.log(
                                "Stock and cart restored, redirecting to checkout..."
                            );


                            window.location.href =
                                '<%= request.getContextPath() %>/CheckoutController';

                        })

                        .catch(err => {

                            console.error(
                                "Restore error:",
                                err
                            );


                            window.location.href =
                                '<%= request.getContextPath() %>/CheckoutController';

                        });

                    }

                }

            };


            /*
             * OPEN RAZORPAY
             */

            var rzp1 = new Razorpay(options);

            rzp1.open();

        })


        /*
         * FETCH ERROR
         */

        .catch(err => {

            console.error(
                "Initiate checkout error:",
                err
            );

            alert(
                "Something went wrong. Please try again."
            );

            btn.disabled = false;

        });

    };

    </script>


</body>

</html>