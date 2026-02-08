package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {

	private static final String url="jdbc:mysql://localhost:3306/furniture";
	private static final String username="root";
	private static final String password="";
	public static Connection getConnection()throws Exception{
		Connection connection=null;
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  connection=DriverManager.getConnection(url,username,password);
		  
		return connection;
		
	}
}
