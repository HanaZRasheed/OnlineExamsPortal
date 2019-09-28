
//---------------------------------------------
// Servlet Imports
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import dbConnect.User;

/**
 * Servlet implementation class LoginCheck
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	// JDBC Driver
	private static final String jdbcDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	// Database URL OF SQL SERVER
	private static final String jdbcURL = "jdbc:sqlserver://localhost:1433;instanceName=MYSERVER;databasename=ExamsDB;integratedSecurity=true;";
	User user = new User();

	public LoginServlet() {
		super();

		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	// doPost() method is used for sending information to the server.
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Sets the content type of response being sent to the client.
		response.setContentType("text/html");
		// returns a PrintWriter object that can send character text to the client.
		PrintWriter out = response.getWriter();

		// gets the input from of username field
		String uname = request.getParameter("username");
		// gets the input of password field
		String password = request.getParameter("password");

		// returns true if the user exists and construct User object
		// return false the user doesn't exist
		if (Auth(uname, password)) {

			// Creates session of the user object that is created in Auth method
			HttpSession session = request.getSession();

			// setting the session to the user object
			session.setAttribute("user", user);
			session.setAttribute("userName", user.getUserName());
			session.setAttribute("userID", user.getUserID());
			session.setAttribute("ExamID", user.getExamID());
			session.setAttribute("Role", user.getRoleID());
			session.setAttribute("ExamName", user.getExamName());

			// sendRedirect method of HttpServletResponse interface can be used to redirect
			// response to another resource. (html, servlet, JSP)
			// if role of the user is equal 1 then he will be redirected to admin home page
			// jsp( Assuming that admin is the instructor)
			if (user.getRoleID().equals("1")) {

				response.sendRedirect("AdminHome.jsp");
			}
			// if role of the user is equal 2 then he will be redirected to Student home
			// page jsp
			else if (user.getRoleID().equals("2")) {
				response.sendRedirect("StudentHome.jsp");
			}

		}
		// user doesn't exist Auth method returned false
		else {
			// RequestDispatcher is used to include response of a resource to jsp
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/Login.jsp");
			out = response.getWriter();

			// show pop-up message Invalid user name or password
			out.println("<div class=\"alert  alert-danger alert-dismissible\">"
					+ "  <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>"
					+ "  <strong> Incorrect username or password </strong>" + "</div>");

			requestDispatcher.include(request, response);
		}
	} // end of doPost

	// Auth method connects to the database and calls Auth stored procedure to check
	// if username and password are in the database
	// the stored procedure returns -1 as userID, null as username, examId, exam
	// name from users Table in database
	// and returns userID, username ,examId, examName from users table in database
	protected boolean Auth(String username, String password) {
		boolean userExists = false;
		System.out.println("Program started");
		try { // To load the JDBC driver
			Class.forName(jdbcDriver);
			System.out.println("JDBC driver loaded");
		} catch (Exception err) {
			System.err.println("Error loading JDBC driver in Auth method in LoginServlet");
			err.printStackTrace(System.err);
			System.exit(0);
		}
		// create Connection variable in order to connect to our database.
		Connection databaseConnection = null;
		try {
			// Connect to the database
			databaseConnection = DriverManager.getConnection(jdbcURL);
			ResultSet rs = null;
			// call the stored procedure in the database
			CallableStatement cs = null;
			cs = databaseConnection.prepareCall("{call dbo.AUTH(?,?)}",
					// ResultSet can be navigated (scrolled) both forward and backwards.
					// You can also jump to a position relative to the current position,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					// means that the ResultSet can only be read.
					ResultSet.CONCUR_READ_ONLY);

			// send parameters to the call able statement of stored procedure
			cs.setString("username", username); // HanaRasheed
			cs.setString("password", password);// Aa@123

			// execute the callable statement of AUTH sp
			boolean results = cs.execute();
			int rowsAffected = 0;

			// Protects against lack of SET NOCOUNT in stored prodedure
			while (results || rowsAffected != -1) {
				if (results) {
					// rs is a results set of the callable statement of AUTH sp
					rs = cs.getResultSet();
					break;
				} else {
					rowsAffected = cs.getUpdateCount();
				}
				results = cs.getMoreResults();
			}

			// print a header row
			System.out.println("UserID   ||   RoleId       ||userName");
			System.out.println("---------||----------------||------------");

			// loop through the result set and call method to print the result set row
			while (rs.next()) {
				printResultSetRow(rs);
				// check the results of Auth sp if returned values are -1 and null that means
				// user doesn't exist
				if (rs.getString("UserId") == "-1" || rs.getString("RoleID") == null) {
					userExists = false;
				} else { // userID does not equal -1 and RoleID does not equal null which means that user
							// exists

					String userID = rs.getString("UserId");
					String RoleID = rs.getString("RoleID");
					String UserName = rs.getString("UserName");
					String examID = rs.getString("ExamID");
					String examName = rs.getString("ExamName");
					user.setUserID(userID);
					user.setRoleID(RoleID);
					user.setUserName(UserName);
					user.setExamID(examID);
					user.setExamName(examName);
					userExists = true;

				}

			}

			// close the result set
			rs.close();
			System.out.println("Closing database connection");

			// close the database connection
			databaseConnection.close();
		} catch (SQLException err) {
			System.err.println("Error connecting to the database in LoginServlet");
			err.printStackTrace(System.err);
			System.exit(0);
		}
		System.out.println("Program finished");

		return userExists;
	}

	// this method is used to display the retrieved data from database
	public static void printResultSetRow(ResultSet rs) throws SQLException {
		// Use the column name alias as specified in the above query
		String userID = rs.getString("UserID");
		String userName = rs.getString("UserName");
		String roleID = rs.getString("RoleID");
		System.out.println(userID + "\t ||\t" + roleID + "\t   ||\t" + userName);

	}

}
