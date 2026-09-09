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

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Map;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class EditProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Cloudinary cloudinary;

    @Override
    public void init() {
        cloudinary = new Cloudinary(
            ObjectUtils.asMap(
                "cloud_name", System.getenv("CLOUDINARY_CLOUD_NAME"),
                "api_key", System.getenv("CLOUDINARY_API_KEY"),
                "api_secret", System.getenv("CLOUDINARY_API_SECRET")
            )
        );
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // Get form data
            int productId = Integer.parseInt(request.getParameter("productId"));

            String productName = request.getParameter("productName");

            double productPrice =
                    Double.parseDouble(request.getParameter("productPrice"));

            int productQty =
                    Integer.parseInt(request.getParameter("productQty"));

            // Image
            String productImage = null;

            Part filePart = request.getPart("productImage");

            if (filePart != null && filePart.getSize() > 0) {

                String fileName =
                        Paths.get(filePart.getSubmittedFileName())
                              .getFileName()
                              .toString();

                // Create temporary file
                String tempDir = System.getProperty("java.io.tmpdir");

                String tempFilePath =
                        tempDir + File.separator
                        + System.currentTimeMillis()
                        + "_" + fileName;

                File tempFile = new File(tempFilePath);

                // Write uploaded image temporarily
                filePart.write(tempFilePath);

                // Upload to Cloudinary
                Map uploadResult = cloudinary.uploader().upload(
                        tempFile,
                        ObjectUtils.asMap(
                                "public_id",
                                "products/"
                                + System.currentTimeMillis()
                                + "_" + fileName
                        )
                );

                // Delete temporary file
                tempFile.delete();

                // Get permanent Cloudinary URL
                productImage =
                        (String) uploadResult.get("secure_url");
            }

            // Create product object
            product p = new product();

            p.setProduct_Id(productId);
            p.setProduct_Name(productName);
            p.setProduct_productPrice(productPrice);
            p.setProductQty(productQty);

            // If new image uploaded, use Cloudinary URL.
            // If no image uploaded, this remains null.
            p.setProduct_Image(productImage);

            // Update product
            Shop_Product_Handle sph =
                    new Shop_Product_Handle();

            boolean updated = sph.editProduct(p);

            if (updated) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/adminpannel.jsp?page=admin_product_list.jsp&msg=updated"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/adminpannel.jsp?page=admin_product_list.jsp&msg=not%20updated"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/adminpannel.jsp?page=admin_product_list.jsp&msg=error"
            );
        }
    }
}