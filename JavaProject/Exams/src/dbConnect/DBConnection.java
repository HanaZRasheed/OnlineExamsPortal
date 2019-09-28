package dbConnect;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	 private static final String jdbcDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	 private static final String jdbcURL = "jdbc:sqlserver://localhost:1433;instanceName=MYSERVER;databasename=ExamsDB;integratedSecurity=true;";
	
	public DBConnection(){
		 
		 
	 } 
	 public static Connection getConnection()throws Exception
	{
	System.out.println("Inside connection");
		 try
		    {
		       Class.forName(jdbcDriver);
		       System.out.println("JDBC driver loaded");
		    }
		    catch (Exception err)
		    {
		       System.err.println("Error loading JDBC driver");
		       err.printStackTrace(System.err);
		       System.exit(0);
		    }
		 Connection databaseConnection = null;
		 try {
			 databaseConnection = DriverManager.getConnection(jdbcURL);
		      System.out.println("Connected to the database");
		     }
		 
		 catch (SQLException err)
		    {
		       System.err.println("Error connecting to the database");
		       err.printStackTrace(System.err);
		       System.exit(0);
		    }
		 
		 return databaseConnection;
	}
	 }


