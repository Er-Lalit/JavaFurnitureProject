package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import connection.DbConnection;
import java.sql.*;
/**
 * Servlet implementation class restoreStock
 */
public class restoreStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public restoreStock() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
		System.out.println("we are reach at the resote page ");
	    int orderId = Integer.parseInt(request.getParameter("orderId"));
	    Connection conn = null;
	    try {
	    	System.out.println("wer are reahc withing the try ");
	        conn = DbConnection.getConnection();
	        conn.setAutoCommit(false);

	        // 1. Restore product stock (as before)
	        PreparedStatement ps = conn.prepareStatement(
	            "SELECT product_id, qty FROM order_items WHERE order_id = ?");
	        ps.setInt(1, orderId);
	        ResultSet rs = ps.executeQuery();

	        // We'll also rebuild the cart to put back in session
	        HashMap<Integer, Integer> cart = new HashMap<>();
            System.out.println("wre are before the while ");
	        while (rs.next()) {
	            int pid = rs.getInt("product_id");
	            int qty = rs.getInt("qty");

	            // Restore stock
	            PreparedStatement upd = conn.prepareStatement(
	                "UPDATE product SET qty = qty + ? WHERE product_id = ?");
	            upd.setInt(1, qty);
	            upd.setInt(2, pid);
	            upd.executeUpdate();

	            // Build cart data for session
	          
	            cart.put(pid, qty);
	        }
	        System.out.println("we are after the while");

	        // 2. Mark order as CANCELLED
	        System.out.println("we are reach at the step 2");
	        PreparedStatement cancel = conn.prepareStatement(
	            "UPDATE orders SET status = 'CANCELLED' WHERE order_id = ?");
	        cancel.setInt(1, orderId);
	        cancel.executeUpdate();

	        conn.commit();
	        System.out.println("we are reach after step2 ");
	        HttpSession session = request.getSession();

	        System.out.println("Session ID = " + session.getId());
	        System.out.println("Cart Before Save = " + cart);

	        session.setAttribute("cart", cart);

	        System.out.println("Cart Saved In Session");
	        // 3. Put the cart back into session
	        session = request.getSession();
	        session.setAttribute("cart", cart);   // <-- now the cart is back

	        response.getWriter().write("{\"status\":\"ok\"}");
	    } catch (Exception e) {
	    	System.out.println(e.getMessage());
	        try { if (conn != null) conn.rollback(); } catch (SQLException ex) {}
	        response.getWriter().write("{\"status\":\"error\"}");
	    } finally {
	        try { if (conn != null) conn.close(); } catch (SQLException ex) {}
	    }
	}
}
