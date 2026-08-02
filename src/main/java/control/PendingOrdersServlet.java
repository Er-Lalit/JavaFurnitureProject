package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;  // ✅ MUST IMPORT!
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Shop_Product_Handle;
import model.product;

import java.io.IOException;
import java.util.List;

public class PendingOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Shop_Product_Handle sph = new Shop_Product_Handle();
            List<product> pendingOrders = sph.getPendingOrders();
            
            request.setAttribute("orders", pendingOrders);
            request.setAttribute("orderType", "Pending");
            
            request.getRequestDispatcher("pending_orders.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminpannel.jsp?page=admin_orders.jsp&msg=error");
        }
    }
}