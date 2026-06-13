<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, connection.DbConnection" %>
<%
    // Get logged-in user from session
    String username = (String) session.getAttribute("username");
    if (username == null || username.equals("guest")) {
        response.sendRedirect("login.jsp");  // or shop.jsp if no login required
        return;
    }

    // 1. Check if a specific order is requested
    String orderIdParam = request.getParameter("orderId");
    int orderId = 0;
    if (orderIdParam != null) {
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            orderId = 0;
        }
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

    // 3. Variables for order history list
    List<Map<String, Object>> allOrders = new ArrayList<>();

    Connection conn = null;
    try {
        conn = DbConnection.getConnection();

        if (orderId > 0) {
            // ---- Fetch single order header + address ----
            PreparedStatement psOrder = conn.prepareStatement(
                "SELECT o.status, o.order_time, o.total_amount, o.payment_id, " +
                "       a.name, a.email, a.phone, a.address " +
                "FROM orders o " +
                "LEFT JOIN order_address a ON o.order_id = a.order_id " +
                "WHERE o.order_id = ? AND o.username = ?");
            psOrder.setInt(1, orderId);
            psOrder.setString(2, username);
            ResultSet rsOrder = psOrder.executeQuery();
            if (rsOrder.next()) {
                orderStatus = rsOrder.getString("status");
                orderDate = rsOrder.getString("order_time");
                totalAmount = rsOrder.getDouble("total_amount");
                paymentId = rsOrder.getString("payment_id");
                customerName = rsOrder.getString("name");
                customerEmail = rsOrder.getString("email");
                customerPhone = rsOrder.getString("phone");
                customerAddress = rsOrder.getString("address");
            }
            rsOrder.close();
            psOrder.close();

            // ---- Fetch order items ----
            if (!orderDate.isEmpty()) {   // only if order exists
                PreparedStatement psItems = conn.prepareStatement(
                    "SELECT oi.qty, oi.price, p.product_name, p.product_image " +
                    "FROM order_items oi " +
                    "JOIN products p ON oi.product_id = p.product_id " +
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
            // ---- Fetch all orders for the user (history) ----
            PreparedStatement psAll = conn.prepareStatement(
                "SELECT o.order_id, o.order_time, o.total_amount, o.status, " +
                "       a.name " +
                "FROM orders o " +
                "LEFT JOIN order_address a ON o.order_id = a.order_id " +
                "WHERE o.username = ? " +
                "ORDER BY o.order_time DESC");
            psAll.setString(1, username);
            ResultSet rsAll = psAll.executeQuery();
            while (rsAll.next()) {
                Map<String, Object> ord = new HashMap<>();
                ord.put("orderId", rsAll.getInt("order_id"));
                ord.put("orderTime", rsAll.getString("order_time"));
                ord.put("total", rsAll.getDouble("total_amount"));
                ord.put("status", rsAll.getString("status"));
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
<html>
<head>
    <meta charset="UTF-8">
    <title><%= (orderId > 0) ? "Order #" + orderId : "My Orders" %></title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="container" style="margin-top:50px;">

        <%-- Success Message (only when a specific order is shown) --%>
        <% if (orderId > 0 && !orderDate.isEmpty()) { %>
            <div class="alert alert-success text-center">
                <h2>🎉 Order Placed Successfully!</h2>
                <p>Thank you, <%= customerName %>! Your order #<%= orderId %> has been confirmed.</p>
            </div>

            <!-- Single Order Detail Card -->
            <div class="card mb-4">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Order #<%= orderId %> <small class="text-muted">(<%= orderStatus %>)</small></h5>
                    <small class="text-muted"><%= orderDate %></small>
                </div>
                <div class="card-body">
                    <!-- Shipping Address -->
                    <h6>Shipping Address</h6>
                    <p>
                        <%= customerName %><br>
                        <%= customerAddress %><br>
                        Phone: <%= customerPhone %><br>
                        Email: <%= customerEmail %>
                    </p>

                    <!-- Items Table -->
                    <h6>Items</h6>
                    <table class="table table-bordered">
                        <thead>
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

                    <p><strong>Payment ID:</strong> <%= paymentId %></p>
                </div>
            </div>

            <a href="orderSuccess.jsp" class="btn btn-outline-secondary">View All Orders</a>

        <% } else if (orderId > 0 && orderDate.isEmpty()) { %>
            <div class="alert alert-warning">Order not found or doesn't belong to you.</div>
            <a href="orderSuccess.jsp" class="btn btn-primary">See My Orders</a>

        <% } else { %>
            <!-- Order History List -->
            <h2>My Orders</h2>
            <% if (allOrders.isEmpty()) { %>
                <div class="alert alert-info">You haven't placed any orders yet.</div>
            <% } else { %>
                <table class="table table-striped">
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
                                <td><span class="badge bg-<%= ord.get("status").equals("PAID") ? "success" : "warning" %>"><%= ord.get("status") %></span></td>
                                <td><a href="orderSuccess.jsp?orderId=<%= ord.get("orderId") %>" class="btn btn-sm btn-outline-primary">View Details</a></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        <% } %>

        <br>
        <a href="shop.jsp" class="btn btn-primary">Continue Shopping</a>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>