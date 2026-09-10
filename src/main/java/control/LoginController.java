package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;
import service.UserService;
import connection.DbConnection;

public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

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

                // CHECK WHETHER USER IS BLOCKED
                Connection con = DbConnection.getConnection();

                String sql = "SELECT status FROM users WHERE name = ?";

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, username);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    int status = rs.getInt("status");

                    // USER IS BLOCKED
                    if (status == 0) {
                        response.sendRedirect(
                            "login.jsp?message=Your account has been blocked"
                        );
                        return;
                    }
                }

                rs.close();
                ps.close();
                con.close();

                // CREATE SESSION ONLY IF USER IS NOT BLOCKED
                HttpSession session = request.getSession();
                session.setAttribute("username", username);

                // ADMIN LOGIN
                if (username.equals("luck") && password.equals("lucky@123")) {

                    response.sendRedirect(
                        "adminpannel.jsp?status=Admin login successful"
                    );

                } else {

                    // NORMAL USER LOGIN
                    response.sendRedirect(
                        "index.jsp?status=Login successful"
                    );
                }

            } else {

                // INVALID LOGIN
                response.sendRedirect(
                    "login.jsp?message=Invalid username or password"
                );
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