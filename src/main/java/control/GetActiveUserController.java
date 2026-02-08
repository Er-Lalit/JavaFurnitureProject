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

public class GetActiveUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public GetActiveUserController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		try {
			System.out.println("did we can reach here");
		UserService us=new UserService();
		List<User> user= us.getActiveUser();
		request.setAttribute("user", user);
		request.getRequestDispatcher("active_users.jsp").forward(request, response);
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	
}
