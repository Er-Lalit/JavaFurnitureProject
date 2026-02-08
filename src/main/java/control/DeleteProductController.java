package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.product;
import service.Shop_Product_Handle;

import java.io.IOException;


public class DeleteProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteProductController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			System.out.println("i am hi");
			product p=new product();
			String id=request.getParameter("productId");
			int id1=Integer.parseInt(id);
			p.setProduct_Id(id1);
			Shop_Product_Handle sph=new Shop_Product_Handle();
			sph.deletProduct(p);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
