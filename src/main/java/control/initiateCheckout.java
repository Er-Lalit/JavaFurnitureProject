package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.*;
import java.util.HashMap;

import org.json.JSONObject;

import com.razorpay.RazorpayClient;

import connection.DbConnection;
import java.util.Map.Entry;

/**
 * Servlet implementation class initiateCheckout
 */
public class initiateCheckout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public initiateCheckout() {
        super();
        // TODO Auto-generated constructor stub
    }

	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("we can reach at the intialchekout");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResp = new JSONObject();

        HttpSession session = request.getSession();
        HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            jsonResp.put("error", "Cart is empty");
            out.print(jsonResp.toString());
            return;
        }

        // Billing form values
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String fullName = fname + " " + lname;   // will go into order_address.name

        // Username (if logged in). Replace with your session logic.
        String username = (String) session.getAttribute("username");
        if (username == null) {
            username = "guest";  // or you can ask for login
        }

        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);

            double total = 0.0;

            // 1. Check stock and deduct (column qty in products)
            for (Entry<Integer, Integer> entry : cart.entrySet()) {
                int pid = entry.getKey();
                int qtyNeeded = entry.getValue();

                PreparedStatement ps = conn.prepareStatement(
                    "UPDATE product SET qty = qty - ? WHERE product_id = ? AND qty >= ?");
                ps.setInt(1, qtyNeeded);
                ps.setInt(2, pid);
                ps.setInt(3, qtyNeeded);

                if (ps.executeUpdate() == 0) {
                    conn.rollback();
                    jsonResp.put("error", "Not enough stock for product ID " + pid);
                    out.print(jsonResp.toString());
                    return;
                }

                // Get product price
                PreparedStatement pricePs = conn.prepareStatement(
                    "SELECT product_price FROM product WHERE product_id = ?");
                pricePs.setInt(1, pid);
                ResultSet rs = pricePs.executeQuery();
                if (rs.next()) {
                    double price = rs.getDouble("product_price");
                    total += price * qtyNeeded;
                }
            }

            // 2. Insert into orders table
            PreparedStatement orderPs = conn.prepareStatement(
                "INSERT INTO orders (username, total_amount, status, order_time) VALUES (?, ?, 'PENDING', NOW())",
                Statement.RETURN_GENERATED_KEYS);
            orderPs.setString(1, username);
            orderPs.setDouble(2, total);
            orderPs.executeUpdate();
            ResultSet generatedKeys = orderPs.getGeneratedKeys();
            int orderId = -1;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            // 3. Insert into order_address
            PreparedStatement addrPs = conn.prepareStatement(
                "INSERT INTO order_address (order_id, name, email, phone, address) VALUES (?,?,?,?,?)");
            addrPs.setInt(1, orderId);
            addrPs.setString(2, fullName);
            addrPs.setString(3, email);
            addrPs.setString(4, phone);
            addrPs.setString(5, address);
            addrPs.executeUpdate();

            // 4. Insert into order_items (including price snapshot)
            PreparedStatement itemPs = conn.prepareStatement(
                "INSERT INTO order_items (order_id, product_id, qty, price) VALUES (?,?,?,?)");
            for (Entry<Integer, Integer> entry : cart.entrySet()) {
                int pid = entry.getKey();
                int qty = entry.getValue();
                // get product price again (or you could store from earlier)
                double price = 0;
                PreparedStatement pricePs = conn.prepareStatement(
                    "SELECT product_price FROM product WHERE product_id = ?");
                pricePs.setInt(1, pid);
                ResultSet rs = pricePs.executeQuery();
                if (rs.next()) {
                    price = rs.getDouble("product_price");
                }
                itemPs.setInt(1, orderId);
                itemPs.setInt(2, pid);
                itemPs.setInt(3, qty);
                itemPs.setDouble(4, price);
                itemPs.executeUpdate();
            }

            // 5. Create Razorpay order
            RazorpayClient razorpay = new RazorpayClient("rzp_test_T0JyYwdMzH5TbH", "8oEIvtR2r22DIEnUHGvW3HEF");
            JSONObject razorpayReq = new JSONObject();
            razorpayReq.put("amount", (int)(total * 100)); // paise
            razorpayReq.put("currency", "INR");
            razorpayReq.put("receipt", "txn_" + orderId);
            com.razorpay.Order razorpayOrder = razorpay.orders.create(razorpayReq);

            // 6. Commit everything
            conn.commit();

            // Clear cart
            session.removeAttribute("cart");

            // Success response
            jsonResp.put("razorpayOrderId", razorpayOrder.get("id").toString()); // make it a String explicitly
            jsonResp.put("amount", ((Number) razorpayOrder.get("amount")).intValue()); // cast to int
            jsonResp.put("currency", "INR");
            jsonResp.put("key", "rzp_test_T0JyYwdMzH5TbH");
            jsonResp.put("internalOrderId", orderId);

        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) {}
            jsonResp.put("error", "Checkout error: " + e.getMessage());
        } finally {
            try { if (conn != null) conn.close(); } catch (SQLException ex) {}
            out.print(jsonResp.toString());
        }
    }

}
