package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.product;
import service.Shop_Product_Handle;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

/**
 * Servlet implementation class AddToCartController
 */
public class AddToCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter out=response.getWriter();
		try
		{
			product p=new product();
			p.setProduct_Id(Integer.parseInt(request.getParameter("pid")));
			Shop_Product_Handle sph=new Shop_Product_Handle();
			// create or get session here 
			HttpSession session=request.getSession();
			List<product> cart=(List<product>)session.getAttribute("cart");
			//if it is a new item in the cart
			if( cart==null || cart.isEmpty())
			{
				cart=new ArrayList<>();
				List<product> dbproduct=sph.addCart(p);
				if(dbproduct.isEmpty() || dbproduct==null)
				{
					out.print("error");
					return ;
					
				}
				cart.addAll(dbproduct);
			}
			if(cart!=null)
			{
				for(product item:cart)
				{
					if(Integer.parseInt( request.getParameter("pid"))==item.getProduct_Id()) {
					item.setProduct_cartCount(item.getProduct_cartCount()+1);
					//cart.add(item);
					
					}
					else//(Integer.parseInt( request.getParameter("pid"))!=item.getProduct_Id())
					{
						List<product> dbproduct= sph.addCart(p);
						if(dbproduct.isEmpty() || dbproduct==null)
						{
							out.print("error");
							return;
						}
						cart.addAll(dbproduct);
						
						
					}
					break;
				}
				
				
				
			}
				
			// add fetch product into cart
			
			session.setAttribute("cart", cart);
//			out.print("added");
//			out.print(cart.toString());
			response.sendRedirect("shop.jsp");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
