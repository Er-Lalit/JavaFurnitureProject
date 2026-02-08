package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.UserService;

import java.io.IOException;

public class OtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public OtpController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response); // This is causing the issue
        User u = new User();
        UserService us = new UserService();
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                String get_Otp = (String) session.getAttribute("Otp"); // Case sensitivity issue
                System.out.println("OTP from session: " + get_Otp);
                String enter_otp = request.getParameter("otp");
                System.out.println("Entered OTP: " + enter_otp);
                User userFromSession = (User) session.getAttribute("user");

                if (enter_otp.equals(get_Otp)) { // NullPointerException risk
                    us.SaveUser(userFromSession);
                    System.out.println("User saved successfully");
                    session.invalidate();
                    response.sendRedirect("login.jsp?status=Register successfully");
                   
                } else {
                    response.sendRedirect("otp.jsp?message=wrong otp");
                }
            } else {
                System.out.println("User not saved");
            }
        } catch (Exception e) {
            System.out.println("OTP generation failed");
            response.sendRedirect("otp.jsp?message=OTP generation failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}