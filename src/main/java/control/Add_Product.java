package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.product;
import service.Shop_Product_Handle;

import java.io.IOException;

public class Add_Product extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public Add_Product() {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub		
		
		product p=new product();
		p.setProduct_Id(Integer.parseInt(request.getParameter("productId")));
		p.setProduct_Name(request.getParameter("productName"));
		p.setProduct_Image(request.getParameter("productImage"));
		p.setProduct_productPrice(Double.parseDouble(request.getParameter("productPrice")));

	System.out.println("all three paramter are successfully set");
	    Shop_Product_Handle sph=new Shop_Product_Handle();
	    System.out.println("shp object is created successfully ");
	    
	    try {
	    	System.out.println("go to the add product method");
			sph.Add_Product(p);
			 response.sendRedirect("products");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
