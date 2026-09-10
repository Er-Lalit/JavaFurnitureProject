package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;

import java.io.IOException;

public class FP_OtpVerify extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public FP_OtpVerify() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.getWriter().append("Served at: ")
                .append(request.getContextPath());
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // DO NOT CALL doGet() HERE
            // doGet(request, response);   <-- REMOVED

            HttpSession session = request.getSession(false);

            if (session == null) {
                response.sendRedirect("P_otp.jsp?message=Session expired");
                return;
            }

            String get_otp = (String) session.getAttribute("Otp");

            String entered_otp = request.getParameter("otp");

            System.out.println("session is not null here");
            System.out.println("entered otp is " + entered_otp);
            System.out.println("generated otp " + get_otp);

            User userFromSession = (User) session.getAttribute("user");

            if (userFromSession != null) {
                System.out.println("userFromSession is available");
            }

            if (entered_otp != null && get_otp != null
                    && entered_otp.equals(get_otp)) {

                System.out.println(
                    "starting to send on the new password page"
                );

                response.sendRedirect("NewPasswordSet.jsp");

            } else {

                response.sendRedirect(
                    "P_otp.jsp?message=Incorrect%20OTP"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "P_otp.jsp?message=Something%20went%20wrong"
            );
        }
    }
}