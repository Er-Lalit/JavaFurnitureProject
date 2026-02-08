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
import java.io.PrintWriter;

public class UserController extends HttpServlet {
       
    public UserController() {
        super();
       
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
		
try {
			
			UserService us=new UserService();
		User u=new User();
		u.setName(request.getParameter("username"));
		u.setPassword(request.getParameter("password"));
		u.setEmail(request.getParameter("email"));
		String number=request.getParameter("contact");
		String c_Code=request.getParameter("country_code");
		u.setContact(c_Code+number);
		u.setStatus(true);
		if(us.CheckUsername(u)) {
			response.sendRedirect("signup.jsp?message=username is already exist");
		}
			else if(us.CheckEmail(u)) {
			response.sendRedirect("signup.jsp?message=email already exist");
			}
			else if(!request.getParameter("password").equals(request.getParameter("confirm_password"))){
			response.sendRedirect("signup.jsp?message=password not match");
		}
			else if(us.checkMoblie(u)) {
				response.sendRedirect("signup.jsp?message=phone number already exist");
			}
			else if(us.isvalidePassword(u)==false) {
				response.sendRedirect("signup.jsp?message=length of password should min 8 and contain at least one upercase,lowecase,digit and special charactor");
				
			}
			else if(us.isvalideMail(u)==false) {
				response.sendRedirect("signup.jsp?message=invalide Mail");
			}
			else if(us.isvalideNumber(u)==false) {
				response.sendRedirect("signup.jsp?message=Enter valide phone number");
			}
		else {
		//us.SaveUser(u);
			System.out.println("start the calling to generate otp");
		String generate_otp=us.GenerateOtp(u);
		
		System.out.println("generate otp"+generate_otp);
		
		HttpSession session=request.getSession(true);
		if(session!=null)
		{
		
		session.setAttribute("Otp", generate_otp);
		
		session.setAttribute("user", u);
		
		System.out.println("calling to otp generater");
		
		response.sendRedirect("otp.jsp");
		
		System.out.println("redirect on the otp page");
		}
		else {
			System.out.println("session is null");
		}
		}
		}
		catch(Exception e){
			System.out.println("not working");
			response.sendRedirect("signup.jsp?message="+e.getMessage());
		}
	}
		
	}
	


