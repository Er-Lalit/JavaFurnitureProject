package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
		try {
			
			HttpSession session=request.getSession(false);
			if(session !=null) {
				String get_otp= (String) session.getAttribute("Otp");
				 
				System.out.println("session is not null here ");
				
				String entered_otp=request.getParameter("otp");
				
				System.out.println("entered otp is "+entered_otp);
				
				System.out.println("genreated otp"+get_otp);
				
				User userFromSession = (User) session.getAttribute("user"); 
				if(userFromSession !=null) {
					System.out.println("not userFromSession issue");
				}
				
				if(entered_otp.equals(get_otp)) {
					System.out.println("starting to sending on the newpassword page");
					response.sendRedirect("NewPasswordSet.jsp");
				}
				else {
					response.sendRedirect("P_otp.jsp?message=Incorrect otp");
					
				}
			}
		
		}
		catch(Exception e)
		{
			response.sendRedirect("P_otp.jsp?message"+e.getMessage());
		}
	}

}
