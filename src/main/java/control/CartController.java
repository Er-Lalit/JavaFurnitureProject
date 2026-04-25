package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.product;
import service.Shop_Product_Handle;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CartController() {
        super();
    }

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession(false);

            HashMap<Integer, Integer> cart = null;

            if (session != null) {
                cart = (HashMap<Integer, Integer>) session.getAttribute("cart");
            }

            if (cart == null || cart.isEmpty()) {
                request.setAttribute("message", "Your cart is empty");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            // get all product ids from cart
            Set<Integer> ids = cart.keySet();

            // call service method
            Shop_Product_Handle service = new Shop_Product_Handle();
            List<product> cartProducts = service.getProductsByIds(ids);

            // send data to cart.jsp
            request.setAttribute("products", cartProducts);
            request.setAttribute("cart", cart);

            request.getRequestDispatcher("cart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("shop.jsp");
        }
    }
}