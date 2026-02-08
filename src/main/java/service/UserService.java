package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.cj.protocol.Resultset;
import com.twilio.Twilio;
import com.twilio.http.Request;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

import connection.DbConnection;
import jakarta.servlet.http.HttpSession;
import model.User;
import repository.UserRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.*;

public class UserService implements UserRepository{

	
	public void SaveUser(User u)throws Exception {
		Connection con=DbConnection.getConnection();
		if(con==null) {
			System.out.println("failed to establish a database connection");
		} 
		else {
		PreparedStatement ps=con.prepareStatement("insert into users(name,password,contact,email,status)values(?,?,?,?,?)");
		ps.setString(1, u.getName());
		ps.setString(2, u.getPassword());
        ps.setString(3, u.getContact());
        ps.setString(4, u.getEmail());
        ps.setBoolean(5, u.isStatus());
        int result = ps.executeUpdate();
        if(result>0) {
        	System.out.println("user saved successufully");
        	
        }
        else {
        	System.out.println("failed to save user");
        }
		
        ps.close();
        con.close();
		}
	}

	
	public boolean CheckEmail(User u) throws Exception {
		Connection con=DbConnection.getConnection();
		boolean exist=false;
		if(con!=null) {
			PreparedStatement ps=con.prepareStatement("select * from users where email=?");
			ps.setString(1, u.getEmail());
			ResultSet rs= ps.executeQuery();
			if(rs.next()) {
				exist=true;
			}
			else {
				exist=false;
			}
			ps.close();
			con.close();
		}
	return exist;
}
	@Override
	public boolean checkMoblie(User u) throws Exception {
		Connection con=DbConnection.getConnection();
		boolean exist=false;
		if(con!=null) {
			PreparedStatement ps=con.prepareStatement("select * from users where contact=?");
			ps.setString(1,u.getContact());
			ResultSet re=ps.executeQuery();
			if(re.next())
			{
				exist=true;
			}
			else {
				exist=false;
			}
			ps.close();
			con.close();
		}
		return exist;
	}

			
	public boolean CheckLoginUser(User u) throws Exception {
		Connection con=DbConnection.getConnection();
		boolean exist=false;
		if(con!=null) {
			PreparedStatement ps=con.prepareStatement("select name, password from users where name=? and password=?");
			ps.setString(1, u.getName());
			ps.setString(2,u.getPassword());
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				exist=true;
			}
			else {
			exist=false;	
			}
			ps.close();
			con.close();
		}
		return exist;
		
	}


	@Override
	public boolean CheckUsername(User u) throws Exception {
		boolean exist=false;
		Connection con=DbConnection.getConnection();
		if(con!=null) {
			PreparedStatement ps=con.prepareStatement("select * from users where name=?");
			ps.setString(1,u.getName());
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				exist= true;
			}
			else {
				exist=false;
			}
			}
		return exist;
	}


	
	 public User ProfileDetail(User u) throws Exception {
	        Connection con = DbConnection.getConnection();
	        System.out.println("database connect");
	        try {
	            if (con != null) {
	                PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE name = ?");
	                ps.setString(1, u.getName());
	                ResultSet rs = ps.executeQuery();
	                System.out.println("execute query");
	                if (rs.next()) {
	                	System.out.println("rs get something");
	                    u.setName(rs.getString("name"));
	                    u.setEmail(rs.getString("email"));
	                    u.setPassword(rs.getString("password"));
	                }
	            } else {
	                System.out.println("Problem with the connection");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            con.close();
	        }
	        return u;
	    }

//	 public static final String ACCOUNT_SID = "";
//	  public static   final String AUTH_TOKEN = "";
//	  public static final String Twilio_Number=" ";
	 
	@Override
	 public String GenerateOtp(User u) throws Exception {
//        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
       String otp = generateOtp();
      System.out.println(u.getContact());
        System.out.println("start working");
//        Message message = Message.creator(
//                new PhoneNumber(u.getContact()), // To phone number
//                new PhoneNumber(Twilio_Number),  // From Twilio phone number
//                "Your OTP code is: " + otp)
//                .create();
        System.out.println("OTP sent: " + otp);
        return otp;
    }

    // Helper method to generate OTP
    private static String generateOtp() {
        int otp = (int) (Math.random() * 9000) + 1000;
        return String.valueOf(otp);
    }

	public boolean isvalidePassword(User u) throws Exception {
		boolean valide;
		if(u==null) {
			System.out.println("u is null");
		}
		String Password=u.getPassword();
		System.out.println(Password);
		String pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
		Pattern compiledpatter=Pattern.compile(pattern);
		Matcher matcher=compiledpatter.matcher(Password);
		if(matcher.find()) {
			valide=true;
			System.out.println("strong password");
		}else {
			valide=false;
			System.out.println("week password");
		}
		return valide;
	}


	@Override
	public boolean isvalideMail(User u) throws Exception {
         String mail=u.getEmail();
         String pattern="^^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
         Pattern compiledpattern=Pattern.compile(pattern);
         Matcher match=compiledpattern.matcher(mail);
         boolean status;
         if(match.find()) {
        	 status=true;
         }
         else {
        	 status=false;
         }
         return status;
	}


	@Override
	public boolean isvalideNumber(User u) throws Exception {
		String phone=u.getContact();
		String pattern="^\\+?[0-9]{10,15}$";
		Pattern compiledpattern=Pattern.compile(pattern);
		Matcher match=compiledpattern.matcher(phone);
		boolean status;
		if(match.find())
		{ 
			status=true;
		}
		else {
			status=false;
		}
		return status;
	}


	public List<User> getActiveUser() throws Exception {
		List<User> list=new ArrayList<>();
		try
		{
			System.out.println("we are reach at the method");
			Connection con=DbConnection.getConnection();
			if(con==null)
			{
				return null;
			}
			else
			{
				PreparedStatement ps=con.prepareStatement("Select * from users where status=1");
				ResultSet rs = ps.executeQuery();
				while(rs.next())
				{
						User us=new User();
						us.setId(rs.getInt("id"));
						us.setName(rs.getNString("name"));
						us.setEmail(rs.getString("email"));
						us.setContact(rs.getString("contact"));
						list.add(us);
					}
					rs.close();
					ps.close();
					con.close();
				}
			}
			
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
		
	}


	@Override
	public void blockUser(User u) throws Exception {
		try 
		{
			Connection con=DbConnection.getConnection();
			if(con==null)
			{
				return ;
			}
			else
			{
				con.setAutoCommit(false);
      			PreparedStatement ps=con.prepareStatement("update users set status=False where id=?");
				ps.setInt(1,u.getId());
				ps.executeUpdate();
				con.commit();
				ps.close();
				con.close();
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}


	public List<User> getBlockedUser() throws Exception {
		List<User> user=new ArrayList<>();
		try
		{
			Connection con=DbConnection.getConnection();
			if(con==null)
			{
				return null;
			}
			else
			{
				PreparedStatement ps=con.prepareStatement("select * from  users where status=0");
				ResultSet rs=ps.executeQuery();
				while(rs.next())
				{
					User u=new User();
					u.setId(rs.getInt("id"));
					u.setName(rs.getString("name"));
					u.setEmail(rs.getString("email"));
					u.setContact(rs.getString("contact"));
					user.add(u);
					
				}
				ps.close();
				rs.close();
				con.close();
			}
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return user;
	}


	@Override
	public void unblockUser(User u) throws Exception {
		try {
			Connection con=DbConnection.getConnection();
			if(con==null)
			{
				return;
			}
			else
			{
				PreparedStatement ps=con.prepareStatement("update users set status=True where id=?");
				ps.setInt(1, u.getId());
				ps.executeUpdate();
				ps.close();
				con.close();
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
}