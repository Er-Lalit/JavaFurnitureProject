package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.product;
import service.Shop_Product_Handle;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class EditProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get form data
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName");
            double productPrice = Double.parseDouble(request.getParameter("productPrice"));
            int productQty = Integer.parseInt(request.getParameter("productQty"));
            
            // Handle image
            String productImage = null;
            Part filePart = request.getPart("productImage");
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                productImage = "images/" + fileName;
            }
            // If no new image, productImage stays null → method keeps old image
            
            // Create product
            product p = new product();
            p.setProduct_Id(productId);
            p.setProduct_Name(productName);
            p.setProduct_productPrice(productPrice);
            p.setProductQty(productQty);
            p.setProduct_Image(productImage);  // null if no new image
            
            // Update
            Shop_Product_Handle sph = new Shop_Product_Handle();
            boolean updated = sph.editProduct(p);
            
            if (updated) {
            	response.sendRedirect(request.getContextPath() + "/adminpannel.jsp?page=admin_product_list.jsp&msg=updated");
            } else {
            	response.sendRedirect(request.getContextPath() + "/adminpannel.jsp?page=admin_product_list.jsp&msg=not updated");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/adminpannel.jsp?page=admin_product_list.jsp&msg=error");
        }
    }
}