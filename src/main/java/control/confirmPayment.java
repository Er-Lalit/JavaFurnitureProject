package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import connection.DbConnection;
import org.json.JSONObject;

public class confirmPayment extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("we are enter in the confirm servlet portion");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResp = new JSONObject();

        // Read the JSON body
        StringBuilder sb = new StringBuilder();
        String line;
        BufferedReader reader = request.getReader();
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        try {
            JSONObject jsonRequest = new JSONObject(sb.toString());
            String razorpayPaymentId = jsonRequest.getString("razorpay_payment_id");
            // String razorpayOrderId = jsonRequest.getString("razorpay_order_id");
            // String razorpaySignature = jsonRequest.getString("razorpay_signature");
            int internalOrderId = jsonRequest.getInt("internalOrderId");

            // Optional: Verify payment signature here using Razorpay's Utils
            // if (!verifySignature(...)) { ... }

            // Update order status to PAID
            Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE orders SET status = 'PAID', payment_id = ? WHERE order_id = ?");
            ps.setString(1, razorpayPaymentId);
            ps.setInt(2, internalOrderId);
            int rows = ps.executeUpdate();
            conn.close();

            if (rows > 0) {
                jsonResp.put("status", "ok");
            } else {
                jsonResp.put("status", "error");
                jsonResp.put("message", "Order not found");
            }
        } catch (Exception e) {
            jsonResp.put("status", "error");
            jsonResp.put("message", e.getMessage());
        }
        out.print(jsonResp.toString());
    }
}