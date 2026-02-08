package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.product;
import service.Shop_Product_Handle;

import java.io.IOException;

/**
 * Servlet implementation class EditProductController
 */

public class EditProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditProductController() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		try {
			System.out.println("hit the servlet");
			System.out.println("productId param = " + request.getParameter("productId"));
			System.out.println("productId param = " + request.getParameter("productName"));


		product p=new product();
		String id=request.getParameter("productId");
		int id1=Integer.parseInt(id);
		p.setProduct_Id(id1);
		p.setProduct_Name(request.getParameter("productName"));
		double price=Double.parseDouble(request.getParameter("productPrice"));
		p.setProduct_productPrice(price);
		p.setProduct_Image(request.getParameter("productImage"));
		Shop_Product_Handle sph=new Shop_Product_Handle ();
		sph.editProduct(p);
		}
		catch(Exception e)
		
		{
			System.out.println("there is any issue");
			e.printStackTrace();
			
		}
		
	}

}
