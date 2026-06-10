package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {

	private static final String url = System.getenv("DB_URL");
	private static final String username = System.getenv("DB_USER");
	private static final String password = System.getenv("DB_PASSWORD");
	public static Connection getConnection()throws Exception{
		Connection connection=null;
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  connection=DriverManager.getConnection(url,username,password);
		  
		return connection;
		
	}
}
