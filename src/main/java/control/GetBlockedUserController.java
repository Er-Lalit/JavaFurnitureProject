package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import service.UserService;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class GetBlockedUserController
 */
public class GetBlockedUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public GetBlockedUserController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		try
		{
			UserService us=new UserService();
			List<User> user=us.getBlockedUser();
			request.setAttribute("user", user);
			request.getRequestDispatcher("blocked_users.jsp").forward(request, response);
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	

}
