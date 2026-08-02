package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Shop_Product_Handle;

import java.io.IOException;

public class DeleteProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productIdParam = request.getParameter("productId");
        
        if (productIdParam != null) {
            try {
                int productId = Integer.parseInt(productIdParam);
                
                Shop_Product_Handle sph = new Shop_Product_Handle();
                boolean deleted = sph.deleteProduct(productId);
                
                if (deleted) {
                    // ✅ Success - Redirect back
                	response.sendRedirect(request.getContextPath() + "/adminpannel.jsp?page=admin_product_list.jsp&msg=deleted");
                } else {
                    // ❌ Failed
                	response.sendRedirect(request.getContextPath() + "/adminpannel.jsp?page=admin_product_list.jsp&msg=not deleted");                }
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("admin_product_list.jsp?msg=invalid");
            }
        } else {
            response.sendRedirect("admin_product_list.jsp?msg=missing");
        }
    }
}