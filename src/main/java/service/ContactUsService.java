package service;

import java.sql.Connection;
import java.sql.PreparedStatement;

import connection.DbConnection;
import model.ContactUs;
import repository.ContactRepository;

public class ContactUsService implements ContactRepository {
	public void SaveContact(ContactUs cu) throws Exception {
		Connection con=DbConnection.getConnection();
        if(con!=null) {
        	PreparedStatement ps=con.prepareStatement("insert into contact(first_name,last_name,email,message)values(?,?,?,?)");
        	ps.setString(1, cu.getFirstName());
        	ps.setString(2, cu.getLastName());
        	ps.setString(3, cu.getEmail());
        	ps.setString(4, cu.getMessage());
        	int result=ps.executeUpdate();
        	if(result>0) {
        		System.out.println("contact info save");
        		
        	}
        	else {
        		System.out.println("contact info is not save");
        	}
        }
        
	}

}
