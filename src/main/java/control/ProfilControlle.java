package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.UserService;

import java.io.IOException;

public class ProfilControlle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProfilControlle() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
	    System.out.println("sessions is availabe");
		if (session != null && session.getAttribute("username") != null) {
			String username = (String) session.getAttribute("username");
			User u = new User();
			u.setName(username);
			UserService us = new UserService();
			
			
			try {
				us.ProfileDetail(u);
				System.out.println("call the service method");
				request.setAttribute("name", u.getName());
				request.setAttribute("email", u.getEmail());
				request.setAttribute("password", u.getPassword());
				System.out.println("data is set");
				//response.sendRedirect("Profile.jsp");
				 request.getRequestDispatcher("Profile.jsp").forward(request, response);
				System.out.println("redirect on profile page");
			} 
			
			catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
		} else {
			response.sendRedirect("login.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
