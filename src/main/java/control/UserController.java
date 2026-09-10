package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;
import service.UserService;

import java.io.IOException;

public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UserController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("signup.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            UserService us = new UserService();

            User u = new User();

            u.setName(request.getParameter("username"));
            u.setPassword(request.getParameter("password"));
            u.setEmail(request.getParameter("email"));

            String number = request.getParameter("contact");
            String c_Code = request.getParameter("country_code");

            u.setContact(c_Code + number);
            u.setStatus(true);

            // Check username
            if (us.CheckUsername(u)) {

                response.sendRedirect(
                    "signup.jsp?message=Username already exists"
                );
            }

            // Check email
            else if (us.CheckEmail(u)) {

                response.sendRedirect(
                    "signup.jsp?message=Email already exists"
                );
            }

            // Check password match
            else if (!request.getParameter("password")
                    .equals(request.getParameter("confirm_password"))) {

                response.sendRedirect(
                    "signup.jsp?message=Passwords do not match"
                );
            }

            // Check phone number
            else if (us.checkMoblie(u)) {

                response.sendRedirect(
                    "signup.jsp?message=Phone number already exists"
                );
            }

            // Check password strength
            else if (!us.isvalidePassword(u)) {

                response.sendRedirect(
                    "signup.jsp?message=Password must be at least 8 characters and contain uppercase, lowercase, digit and special character"
                );
            }

            // Check email format
            else if (!us.isvalideMail(u)) {

                response.sendRedirect(
                    "signup.jsp?message=Invalid email address"
                );
            }

            // Check phone format
            else if (!us.isvalideNumber(u)) {

                response.sendRedirect(
                    "signup.jsp?message=Enter a valid phone number"
                );
            }

            else {

                System.out.println("Starting OTP generation");

                String generate_otp = us.GenerateOtp(u);

                System.out.println("Generated OTP: " + generate_otp);

                HttpSession session = request.getSession(true);

                session.setAttribute("Otp", generate_otp);
                session.setAttribute("user", u);

                System.out.println("Redirecting to OTP page");

                response.sendRedirect("otp.jsp");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "signup.jsp?message=Something went wrong. Please try again."
            );
        }
    }
}