package control;

import jakarta.servlet.ServletException;
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

        response.sendRedirect("signup.jsp");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserService us = new UserService();

        try {

            HttpSession session = request.getSession(false);

            // Check session
            if (session == null) {

                response.sendRedirect(
                    "login.jsp?message=Session expired. Please register again."
                );

                return;
            }


            // Get user and OTP from session
            String get_Otp = (String) session.getAttribute("Otp");

            User userFromSession =
                    (User) session.getAttribute("user");


            if (get_Otp == null || userFromSession == null) {

                response.sendRedirect(
                    "login.jsp?message=Session expired. Please register again."
                );

                return;
            }


            // Check whether user clicked Resend OTP
            String action = request.getParameter("action");


            // =========================
            // RESEND OTP
            // =========================

            if ("resend".equals(action)) {

                String newOtp = us.GenerateOtp(userFromSession);

                // Replace old OTP with new OTP
                session.setAttribute("Otp", newOtp);

                response.sendRedirect(
                    "otp.jsp?message=New OTP sent successfully."
                );

                return;
            }


            // =========================
            // VERIFY OTP
            // =========================

            String enter_otp = request.getParameter("otp");


            if (enter_otp != null && enter_otp.equals(get_Otp)) {

                // Save user only after correct OTP
                us.SaveUser(userFromSession);

                // Destroy session
                session.invalidate();

                response.sendRedirect(
                    "login.jsp?status=Account created successfully"
                );

            } else {

                response.sendRedirect(
                    "otp.jsp?message=Invalid OTP. Please try again."
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "otp.jsp?message=Something went wrong. Please try again."
            );
        }
    }
}