package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.product;
import service.Shop_Product_Handle;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
  // or keep your original mapping
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB
    maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class Add_Product extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Read form fields (including the new quantity)
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int productQty = Integer.parseInt(request.getParameter("productQty"));  // NEW

        // 2. Handle image file upload
        Part filePart = request.getPart("productImage");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // simple name

        // 3. Save the file to your webapp/images/ folder
        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);   // saves the file

        // 4. Create product object and set all fields
        product p = new product();
        p.setProduct_Id(productId);
        p.setProduct_Name(productName);
        p.setProduct_productPrice(productPrice);
        p.setProduct_Image(fileName);   // store only the filename (or relative path)
        p.setProductQty(productQty);    // NEW

        // 5. Call service layer to insert into database
        Shop_Product_Handle sph = new Shop_Product_Handle();
        try {
            sph.Add_Product(p);
            response.sendRedirect("products");  // redirect after success
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add product");
        }
    }
}