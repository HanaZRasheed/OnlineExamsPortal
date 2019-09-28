import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dbConnect.*;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/AdminServlet")
/*
 * annotation is used to annotate a servlet class in order to handle
 * multipart/form-data requests and configure various upload settings.
 * 
 * 
 */
@MultipartConfig
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String[] file;
	// Directory on the server side to store the uploaded file
	private final String UPLOAD_DIRECTORY = "C:\\temp";
	private String filePath, name, examDate, examStartTime, examEndTime;
	private int numberOfQuestions, totalMarks;
	static DBConnection c = new DBConnection();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Type of content that will be added which is html
		response.setContentType("text/html");
		response.getWriter();
		PrintWriter out = response.getWriter();
		// Read Course name
		// String examName = request.getParameter("SelectExam");
		HttpSession session = request.getSession();
		String ExamId = session.getAttribute("ExamID").toString();
		String ExamName = session.getAttribute("ExamName").toString();

		// checks the we have file upload request.
		if (ServletFileUpload.isMultipartContent(request)) {
			try { /*
					 * FileItem represents a file or form item that was received within a
					 * multipart/form-data POST request. org.apache.commons.fileupload
					 * ServletFileUpload: handles multiple files per single HTML client side.
					 * DiskFileItemFactory: creates FileItem instances which keep their content
					 * either in memory, for smaller items, or in a temporary file on disk, for
					 * larger items. parseRequest: to acquire a list of FileItems associated with a
					 * given HTML client side.
					 */

				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				for (FileItem item : multiparts) {
					if (!item.isFormField()) { // upload the file on the specified director
						name = new File(item.getName()).getName();
						// File.separator: String value that OS used to separate file path
						item.write(new File(UPLOAD_DIRECTORY + File.separator + name));
					} else { // get the fields of the form
						if (item.getFieldName().equals("ExamDate")) {
							examDate = item.getString();
							
						}
						if (item.getFieldName().equals("ExamStartTime")) {
							examStartTime = item.getString();
							
						}
						if (item.getFieldName().equals("ExamEndTime")) {
							examEndTime = item.getString();
						
						}
						if (item.getFieldName().equals("questionNum")) {
							numberOfQuestions = Integer.parseInt(item.getString());
						
						}
						if (item.getFieldName().equals("TotalMark")) {
							totalMarks = Integer.parseInt(item.getString());
							
						}
					}
				}
				// specifies the file path
				filePath = UPLOAD_DIRECTORY + File.separator + name;
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/AdminHome.jsp");
				out.println("<div class=\"alert alert-success alert-dismissible\">"
						+ "  <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>"
						+ "  <strong>Exam is uplaoded Successfully!</strong> ." + "</div>");
				requestDispatcher.include(request, response);

			} catch (Exception e) {
				System.out.println("File Upload Failed due to " + e);
			}
		} else {
			System.out.println("Sorry this Servlet only handles upload request");
		}

		// read the content of the file
		FileReader fr = new FileReader(filePath);
		BufferedReader br = new BufferedReader(fr);
		String line = null;
		int questionsNum;

		PreparedStatement ps = null;
		PreparedStatement psAnswers = null;
		PreparedStatement psStudents = null;
		PreparedStatement QuestionRows = null;
		PreparedStatement answersRows = null;
		PreparedStatement insertExam = null;
		Connection con = null;

		try {
			con = c.getConnection();
			insertExam = con.prepareStatement("Update Exams set ExamDate=?,ExamStartTime=?, ExamEndTime=?,"
					+ "QuestionsNumber=?,TotalMark=? where ExamID=?");
			insertExam.setString(1, examDate);

			insertExam.setString(2, examStartTime);

			insertExam.setString(3, examEndTime);

			insertExam.setInt(4, numberOfQuestions);

			insertExam.setInt(5, totalMarks);

			insertExam.setString(6, ExamId);

			insertExam.execute();

		} catch (Exception e) {
			System.err.println("Error in Uploading exam data in exam table");
		}

		try {
			con = c.getConnection();
			ps = con.prepareStatement("Insert into Questions values (?,?,?)");
			psAnswers = con.prepareStatement("Insert into Answers values (?,?,?,?)");
			psStudents = con.prepareStatement("Insert into privilege values(?,?,?,?)");
			QuestionRows = con.prepareStatement("Select count(*) from Questions");
			answersRows = con.prepareStatement("Select count(*) from Answers");
			// breaks a given a string around matches of the given regular expression (,);
			while (((line = br.readLine()) != null)) {

				file = line.split(",");

			}
			// start question Id from 1, for the first insertion of questions
			int QID = 1;
			// get the Exam id from the session
			int EID = Integer.parseInt(ExamId);
			// Start Answer Id from 1, for the first insertion of answers
			int AID = 1;
			// the last question id in questions table
			int QmaxID = 1;
			// the last question id in aswers table
			int AmaxID = 1;
			// get the number of questions from index 0 of file ( Array of Strings)
			questionsNum = Integer.parseInt(file[0]);
			// get the index of the number of the students
			int studentsNumIndex = (questionsNum * 5) + 1;
			// get the id of the first student.
			int firstIndexOfStudentId = studentsNumIndex + 1;
			// get the number of students
			int students = Integer.parseInt(file[studentsNumIndex]);

			// number of rows in Questions table
			ResultSet rowsSet = QuestionRows.executeQuery();
			int rows = 0;
			if (rowsSet.next()) {
				rows = rowsSet.getInt(1); // index is the QuestionId column
			}

			if (rows == 0) {
				QID = 1;

			} else {
				String maxIdQueury = "Select max (QuestionID) as MaxId from questions;";
				Statement s = con.createStatement();
				ResultSet rs = s.executeQuery(maxIdQueury);
				if (rs.next()) {
					QmaxID = rs.getInt("MaxId"); // the maxId of questions
					// to add after the last id of questions
					QID = QmaxID + 1;

				}
			}
			// number of Answers Rows
			ResultSet rowsSetOfAnswers = answersRows.executeQuery();
			int rowsOfAnswers = 0;
			if (rowsSetOfAnswers.next()) {
				rowsOfAnswers = rowsSetOfAnswers.getInt(1);
			}

			if (rowsOfAnswers == 0) { // if answers table is empty the answer id is equal to 1
				AID = 1;
			} else { // select the last id of answers
				String maxIdQueury = "Select max (AnswerID) as MaxId from Answers;";
				Statement s = con.createStatement();
				ResultSet rs = s.executeQuery(maxIdQueury);
				if (rs.next()) {
					AmaxID = rs.getInt("MaxId");
					// to add after the last id of answers
					AID = AmaxID + 1;

				}
			}

			questionsNum = Integer.parseInt(file[0]);
			// get the questions and answers and insert them to the data base
			for (int i = 1; i <= questionsNum * 5; i++) { // get the questions text and insert it to the questions table
				if (i % 5 == 1) {

					ps.setInt(1, QID);
					ps.setString(2, file[i]);
					ps.setInt(3, EID);
					ps.execute();
					QID++;
					String maxIdQueury = "Select max (QuestionID) as MaxId from questions;";
					Statement s = con.createStatement();
					ResultSet rs = s.executeQuery(maxIdQueury);
					if (rs.next()) {
						QmaxID = rs.getInt("MaxId");

					}
				}

				else {
					// get the correct answer for the question and insert to the answers table
					if (i % 5 == 2) {
						
						psAnswers.setInt(1, AID);
						psAnswers.setString(2, file[i]);
						psAnswers.setInt(3, QmaxID);
						psAnswers.setInt(4, 1);
						AID++;
						psAnswers.execute();
					}
					// get the other wrong options and insert them to the answers table
					else {
					
						psAnswers.setInt(1, AID);
						psAnswers.setString(2, file[i]);
						psAnswers.setInt(3, QmaxID);
						psAnswers.setInt(4, 0);
						AID++;
						psAnswers.execute();
					}
				}

			} // Insert the students Ids to the privilege table
			for (int i = 0; i < students; i++) {
				psStudents.setInt(1, Integer.parseInt(file[firstIndexOfStudentId]));
				psStudents.setInt(2, EID);
				psStudents.setInt(3, 1);
				psStudents.setString(4, ExamName);
				firstIndexOfStudentId++;
				psStudents.execute();
			}

		}

		catch (Exception e) {
			System.err.println("Error " + e.getMessage());
		}

		finally {
			fr.close();
			try {
				ps.close();
				con.close();

			} catch (SQLException e) {

				System.err.println(e.getMessage());
			}

		}

	}

}
