package control;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.product;
import service.Shop_Product_Handle;

import java.io.IOException;

/**
 * Servlet implementation class CheckoutController
 */
public class CheckoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public CheckoutController() {
        super();
        
    }

	
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);
        if(session == null){
            response.sendRedirect("shop.jsp");
            return;
        }

        HashMap<Integer,Integer> cart =
        (HashMap<Integer,Integer>)
        session.getAttribute("cart");

        Set<Integer> ids = cart.keySet();

        Shop_Product_Handle service =
                new Shop_Product_Handle();

        List<product> products = null;
		try {
			products = service.getProductsByIds(ids);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        request.setAttribute("products", products);
        request.setAttribute("cart", cart);

        request.getRequestDispatcher("checkout.jsp")
               .forward(request,response);
    }

	

}
