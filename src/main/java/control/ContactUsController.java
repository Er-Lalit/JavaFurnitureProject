package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ContactUs;
import service.ContactUsService;

import java.io.IOException;

public class ContactUsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ContactUsController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
		try {
			
		ContactUsService cus=new ContactUsService();
	    ContactUs us=new ContactUs();
	    us.setFirstName(request.getParameter("fname"));
	    us.setLastName(request.getParameter("lname"));
	    us.setEmail(request.getParameter("email"));
	    us.setMessage(request.getParameter("message"));
	    cus.SaveContact(us);
	}
		catch(Exception e) {
			System.out.println(e);
		}
	}
}
