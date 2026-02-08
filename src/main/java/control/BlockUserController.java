package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import service.UserService;

import java.io.IOException;


public class BlockUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public BlockUserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try
		{
			System.out.println("we hit the servlet");
			User u=new User();
			int id=Integer.parseInt( request.getParameter("userId"));
			u.setId(id);
			UserService us=new UserService();
			us.blockUser(u);	
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
