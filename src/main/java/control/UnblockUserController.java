package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import service.UserService;

import java.io.IOException;


public class UnblockUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public UnblockUserController() {
        super();
        
    }

	
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            UserService us = new UserService();

            User u = new User();
            u.setId(Integer.parseInt(request.getParameter("userId")));

            us.unblockUser(u);

            // Success message
            response.sendRedirect("adminpannel.jsp?msg=unblocked");

        } catch (Exception e) {
            e.printStackTrace();

            // Error message
            response.sendRedirect("adminpannel.jsp?msg=unblockerror");
        }
    }

}
