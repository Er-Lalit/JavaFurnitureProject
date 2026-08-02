package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Shop_Product_Handle;
import model.product;

import java.io.IOException;
import java.util.List;


public class CancelledOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Shop_Product_Handle sph = new Shop_Product_Handle();
            List<product> cancelledOrders = sph.getCancelledOrders();
            
            request.setAttribute("orders", cancelledOrders);
            request.setAttribute("orderType", "Cancelled");
            
            // ✅ Forward to JSP (stays inside admin panel)
            request.getRequestDispatcher("/cancelled_orders.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminpannel.jsp?page=admin_orders.jsp&msg=error");
        }
    }
}