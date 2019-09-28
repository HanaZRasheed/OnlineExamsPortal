
import java.io.IOException;
import java.io.PrintWriter;

import dbConnect.*;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UpdatePrivilege
 */
@WebServlet("/UpdatePrivilege")
public class UpdatePrivilege extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Sets the content type of response being sent to the client.
		response.setContentType("text/html");
		// returns a PrintWriter object that can send character text to the client.
		response.getWriter();
		PrintWriter out = response.getWriter();
		// get The ExamID from jsp page by name
		String examId = request.getParameter("ExamID");

		DBConnection c = new DBConnection();
		Connection con = null;
		try {
			con = c.getConnection();
			
			// sub interface of statement, used to execute a query that has parameters
			PreparedStatement updatePrivilege = con
					.prepareStatement("Update Privilege set Flag = ? where userID =? and ExamId=?");
			PreparedStatement deleteGrade = con.prepareStatement("delete from grade where StudentID =? and ExamId=?");
			String userID = null;
			/* for  get the checked values of input type check box name is privilege.
			 getting a multiple values for any input parameter, this method will retrieve all of it values and store as
			 array of Strings */
			String[] checked = request.getParameterValues("privilege");
			for (int i = 0; i < checked.length; i++) {

				userID = checked[i];
				System.out.println("********");
                 // Set the parameters value by calling setter methods 
				updatePrivilege.setInt(1, 1); // change the flag to 1 
				updatePrivilege.setString(2, userID); // of the user id 
				updatePrivilege.setString(3, examId);// on specific exam
				// execute is a method of statement interface, that may return multiple results.
				updatePrivilege.execute();
				deleteGrade.setString(1, userID); // delete the grade of the userID
				deleteGrade.setString(2, examId);// on specific exam
				// execute is a method of statement interface, that may return multiple results.
				deleteGrade.execute();
			}
		} catch (Exception e) {
			System.out.println("error in statement Execution updateprivilege servlet" + e.getMessage());
		}
		RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/examPrivilege.jsp");
		out.println("<div class=\"alert alert-success alert-dismissible\">"
				+ "  <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>"
				+ "  <strong>Privilege is updated Successfully!</strong> ." + "</div>");
		requestDispatcher.include(request, response);

	}
}
