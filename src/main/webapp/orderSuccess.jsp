<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, connection.DbConnection" %>
<%
    // Get logged-in user from session
    String username = (String) session.getAttribute("username");
    if (username == null || username.equals("guest")) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 1. Check if a specific order is requested
    String orderIdParam = request.getParameter("orderId");
    int orderId = 0;
    if (orderIdParam != null) {
        try { orderId = Integer.parseInt(orderIdParam); } 
        catch (NumberFormatException e) { orderId = 0; }
    }

    // 2. Variables for single order detail
    String orderStatus = "";
    String orderDate = "";
    double totalAmount = 0.0;
    String paymentId = "";
    String customerName = "";
    String customerEmail = "";
    String customerPhone = "";
    String customerAddress = "";
    List<Map<String, Object>> orderItems = new ArrayList<>();

    // 3. Variables for order history list (only PAID)
    List<Map<String, Object>> allOrders = new ArrayList<>();

    boolean isPaidOrder = false;

    Connection conn = null;
    try {
        conn = DbConnection.getConnection();

        if (orderId > 0) {
            // Fetch single order
            PreparedStatement psOrder = conn.prepareStatement(
                "SELECT o.status, o.order_time, o.total_amount, o.payment_id, " +
                "       a.name, a.email, a.phone, a.address " +
                "FROM orders o LEFT JOIN order_address a ON o.order_id = a.order_id " +
                "WHERE o.order_id = ? AND o.username = ?");
            psOrder.setInt(1, orderId);
            psOrder.setString(2, username);
            ResultSet rsOrder = psOrder.executeQuery();
            if (rsOrder.next()) {
                orderStatus = rsOrder.getString("status");
                if ("PAID".equals(orderStatus)) {
                    isPaidOrder = true;
                    orderDate = rsOrder.getString("order_time");
                    totalAmount = rsOrder.getDouble("total_amount");
                    paymentId = rsOrder.getString("payment_id");
                    customerName = rsOrder.getString("name");
                    customerEmail = rsOrder.getString("email");
                    customerPhone = rsOrder.getString("phone");
                    customerAddress = rsOrder.getString("address");
                }
            }
            rsOrder.close();
            psOrder.close();

            if (isPaidOrder) {
                // Fetch items
                PreparedStatement psItems = conn.prepareStatement(
                    "SELECT oi.qty, oi.price, p.product_name, p.product_image " +
                    "FROM order_items oi JOIN product p ON oi.product_id = p.product_id " +
                    "WHERE oi.order_id = ?");
                psItems.setInt(1, orderId);
                ResultSet rsItems = psItems.executeQuery();
                while (rsItems.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("name", rsItems.getString("product_name"));
                    item.put("image", rsItems.getString("product_image"));
                    item.put("qty", rsItems.getInt("qty"));
                    item.put("price", rsItems.getDouble("price"));
                    item.put("total", rsItems.getInt("qty") * rsItems.getDouble("price"));
                    orderItems.add(item);
                }
                rsItems.close();
                psItems.close();
            }
        } else {
            // Fetch all PAID orders for history
            PreparedStatement psAll = conn.prepareStatement(
                "SELECT o.order_id, o.order_time, o.total_amount, " +
                "       a.name " +
                "FROM orders o LEFT JOIN order_address a ON o.order_id = a.order_id " +
                "WHERE o.username = ? AND o.status = 'PAID' " +
                "ORDER BY o.order_time DESC");
            psAll.setString(1, username);
            ResultSet rsAll = psAll.executeQuery();
            while (rsAll.next()) {
                Map<String, Object> ord = new HashMap<>();
                ord.put("orderId", rsAll.getInt("order_id"));
                ord.put("orderTime", rsAll.getString("order_time"));
                ord.put("total", rsAll.getDouble("total_amount"));
                ord.put("customerName", rsAll.getString("name"));
                allOrders.add(ord);
            }
            rsAll.close();
            psAll.close();
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= (orderId > 0 && isPaidOrder) ? "Order #" + orderId : "My Paid Orders" %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.png">
    <!-- Bootstrap & custom CSS -->
    <link href="<%= request.getContextPath() %>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

    <!-- Header -->
    <jsp:include page="header.jsp"></jsp:include>

    <!-- Hero Section (just like About page) -->
    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <% if (orderId > 0 && isPaidOrder) { %>
                            <h1>Order Confirmed</h1>
                            <p class="mb-4">Thank you for your purchase! Your order #<%= orderId %> has been placed successfully.</p>
                            <p><a href="shop.jsp" class="btn btn-secondary me-2">Continue Shopping</a><a href="orderSuccess.jsp" class="btn btn-white-outline">My Orders</a></p>
                        <% } else if (orderId > 0 && !isPaidOrder) { %>
                            <h1>Order Not Available</h1>
                            <p class="mb-4">The order you requested is either not found or hasn't been completed.</p>
                            <p><a href="orderSuccess.jsp" class="btn btn-secondary me-2">My Paid Orders</a></p>
                        <% } else { %>
                            <h1>My Paid Orders</h1>
                            <p class="mb-4">Here you can view all your successfully placed orders.</p>
                            <p><a href="shop.jsp" class="btn btn-secondary me-2">Shop Now</a></p>
                        <% } %>
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
    <!-- End Hero Section -->

    <!-- Main Content -->
    <div class="untree_co-section">
        <div class="container">

            <%-- Single paid order detail --%>
            <% if (orderId > 0 && isPaidOrder) { %>
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Order #<%= orderId %> <small class="text-muted">(PAID)</small></h5>
                                <small class="text-muted"><%= orderDate %></small>
                            </div>
                            <div class="card-body">
                                <h6>Shipping Address</h6>
                                <p>
                                    <strong><%= customerName %></strong><br>
                                    <%= customerAddress %><br>
                                    Phone: <%= customerPhone %><br>
                                    Email: <%= customerEmail %>
                                </p>

                                <h6>Items</h6>
                                <% if (orderItems.isEmpty()) { %>
                                    <div class="alert alert-warning">No items found for this order.</div>
                                <% } else { %>
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th>Product</th>
                                                    <th>Qty</th>
                                                    <th>Price</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Map<String, Object> item : orderItems) { %>
                                                    <tr>
                                                        <td><%= item.get("name") %></td>
                                                        <td><%= item.get("qty") %></td>
                                                        <td>₹<%= item.get("price") %></td>
                                                        <td>₹<%= item.get("total") %></td>
                                                    </tr>
                                                <% } %>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th colspan="3" class="text-right">Total</th>
                                                    <th>₹<%= totalAmount %></th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                <% } %>

                                <p><strong>Payment ID:</strong> <%= (paymentId != null ? paymentId : "N/A") %></p>
                            </div>
                        </div>
                    </div>
                </div>

            <%-- Order not PAID or not found --%>
            <% } else if (orderId > 0 && !isPaidOrder) { %>
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="alert alert-warning text-center">
                            <h4>⚠️ Order Not Available</h4>
                            <p>The order you requested doesn't belong to you or isn't a completed payment.</p>
                            <a href="orderSuccess.jsp" class="btn btn-primary">View My Paid Orders</a>
                        </div>
                    </div>
                </div>

            <%-- Order history --%>
            <% } else { %>
                <div class="row">
                    <div class="col-12">
                        <h2 class="mb-4">My Paid Orders</h2>
                        <% if (allOrders.isEmpty()) { %>
                            <div class="alert alert-info">You haven't placed any paid orders yet.</div>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Date</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Map<String, Object> ord : allOrders) { %>
                                            <tr>
                                                <td>#<%= ord.get("orderId") %></td>
                                                <td><%= ord.get("orderTime") %></td>
                                                <td>₹<%= ord.get("total") %></td>
                                                <td><span class="badge bg-success">PAID</span></td>
                                                <td>
                                                    <a href="orderSuccess.jsp?orderId=<%= ord.get("orderId") %>" 
                                                       class="btn btn-sm btn-outline-primary">View Details</a>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>
                    </div>
                </div>
            <% } %>

        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp"></jsp:include>

    <script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/js/tiny-slider.js"></script>
    <script src="<%= request.getContextPath() %>/js/custom.js"></script>
</body>
</html>