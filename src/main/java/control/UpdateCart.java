package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;

public class UpdateCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateCart() {
        super();
    }

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession(false);

            if (session == null) {
                response.sendRedirect("shop.jsp");
                return;
            }

            HashMap<Integer, Integer> cart =
                    (HashMap<Integer, Integer>) session.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("CartController");
                return;
            }

            int pid = Integer.parseInt(request.getParameter("id"));
            String type = request.getParameter("type");

            if (cart.containsKey(pid)) {
                int qty = cart.get(pid);

                if ("plus".equals(type)) {
                    cart.put(pid, qty + 1);
                } 
                else if ("minus".equals(type)) {
                    if (qty > 1) {
                        cart.put(pid, qty - 1);
                    } else {
                        cart.remove(pid);
                    }
                }
            }

            session.setAttribute("cart", cart);

            response.sendRedirect("CartController");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CartController");
        }
    }
}