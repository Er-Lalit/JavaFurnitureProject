package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import connection.DbConnection;

public class ResetPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ResetPasswordController() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession(false);  // Get existing session
			if (session == null || session.getAttribute("number") == null) {
				response.sendRedirect("login.jsp?message=Session Expired. Please Try Again.");
				return;
			}

			String number = (String) session.getAttribute("number");
			String N_Password = request.getParameter("new_password");
			String CN_Password = request.getParameter("confirm_new_password");

			if (!N_Password.equals(CN_Password)) {
				response.sendRedirect("Forget_Password_Number.jsp?message=Password does not match");
				return;
			}

			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("UPDATE user SET password=? WHERE contact=?");
			ps.setString(1, N_Password);
			ps.setString(2, number);
			int result = ps.executeUpdate();

			if (result > 0) {
				session.invalidate();  // ✅ **Destroy session to prevent revisiting reset page**
				response.sendRedirect("login.jsp?message=Password Updated Successfully");
			} else {
				response.sendRedirect("Forget_Password_Number.jsp?message=Something went wrong. Try again.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("Forget_Password_Number.jsp?message=An error occurred. Try again.");
		}
	}
}
