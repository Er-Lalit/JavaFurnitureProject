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

@WebServlet("/FP_generate_opt")
public class FP_generate_opt extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public FP_generate_opt() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Service and User instance
            UserService us = new UserService();
            User u = new User();

            // Get mobile number and country code
            String number = request.getParameter("mobile");
            String c_code = request.getParameter("code");
            String mobile_number = c_code + number;

            // Set user contact
            u.setContact(mobile_number);

            // Check if mobile number exists
            if (us.checkMoblie(u)) {
                // Generate OTP and set in session
                String generateOtp = us.GenerateOtp(u);
                System.out.println("Generated OTP is: " + generateOtp);

                HttpSession session = request.getSession(true);
                session.setAttribute("Otp", generateOtp);
                session.setAttribute("user", u);
                session.setAttribute("number", mobile_number);

                // Redirect to OTP page
                response.sendRedirect("P_otp.jsp");
                System.out.println("Redirected to P_otp.jsp");
            } else {
                // Redirect back to Forget_Password_Number.jsp with error message
                response.sendRedirect("Forget_Password_Number.jsp?message=Enter Correct Phone Number");
            }
        } catch (Exception e) {
            // Redirect back to Forget_Password_Number.jsp with exception message
            response.sendRedirect("Forget_Password_Number.jsp?message=" + e.getMessage());
        }
    }
}
