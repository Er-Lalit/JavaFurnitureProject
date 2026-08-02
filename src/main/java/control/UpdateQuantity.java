package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Shop_Product_Handle;

import java.io.IOException;

public class UpdateQuantity extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productIdParam = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity");
        
        if (productIdParam != null && quantityParam != null) {
            try {
                int productId = Integer.parseInt(productIdParam);
                int quantity = Integer.parseInt(quantityParam);
                
                Shop_Product_Handle sph = new Shop_Product_Handle();
                boolean updated = sph.updateProductQuantity(productId, quantity);
                
                if (updated) {
                    // ✅ Success - Redirect back
                	response.sendRedirect(request.getContextPath() + "/adminpannel.jsp?page=admin_product_list.jsp&msg=updated");
                } else {
                    // ❌ Failed
                	response.sendRedirect(request.getContextPath() + "/adminpannel.jsp?page=admin_product_list.jsp&msg=updated error");
                }
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("admin_product_list.jsp?msg=invalid");
            }
        } else {
            response.sendRedirect("admin_product_list.jsp?msg=missing");
        }
    }
}