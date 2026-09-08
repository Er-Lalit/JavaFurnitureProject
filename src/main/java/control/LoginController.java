package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.UserService;

public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Prevent caching of the login page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        String username = request.getParameter("lusername");
        String password = request.getParameter("lpassword");

        UserService userService = new UserService();

        User user = new User();
        user.setName(username);
        user.setPassword(password);

        try {

            if (userService.CheckLoginUser(user)) {

                HttpSession session = request.getSession();
                session.setAttribute("username", username);

                // ADMIN LOGIN
                if (username.equals("luck") && password.equals("lucky@123")) {
                    response.sendRedirect("adminpannel.jsp");

                } else {

                    // NORMAL USER LOGIN
                    response.sendRedirect("index.jsp");
                }

            } else {

                response.sendRedirect("login.jsp?message=Invalid username or password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Login error"
            );
        }
    }
}