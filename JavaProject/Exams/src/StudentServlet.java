import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.util.*;

import dbConnect.*;

/**
 * Servlet implementation class StartExam
 */
@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
      // construct session
		HttpSession session = request.getSession();
		// get the input from selectExam from StudentExam.jsp
		String examId = request.getParameter("SelectExam");
		// Set ExamId in a session
		request.getSession().setAttribute("userExamId", examId);
		// get the userId from the session
		String userID = (String) session.getAttribute("userID");

		// construct Question object.
		Question objQ = new Question();
		// set the index of questions
		int index = 0;
		// create a list of Questions
		List<Question> questionsList = new ArrayList<Question>();
	
		// construct the database connection
		DBConnection c = new DBConnection();
		// establish connection to the database
		Connection con = null;
		try {
			con = c.getConnection();
			// select ExamId from Privilege table according to userId and flag equals 1 that
			// means he can do the exam
			Statement statement1 = con.createStatement();
			// select ExamName from Exams according to the Exam Id
			Statement statement2 = con.createStatement();
			/*
			 * select random questions from questions table according to Questions Number
			 * specified in AdminUploadExam of the exam from exams table
			 */
			Statement statement3 = con.createStatement();
			// select answers ordered randomly according to the question Id
			Statement statement4 = con.createStatement();
			// select number of questions from exams table
			Statement statement5 = con.createStatement();

			// ResultSet is java object that contains the results of executing sql query,
			// usually used with Statement
			ResultSet resultset = null;
			ResultSet getExamName = null;
			ResultSet getQuestions = null;
			ResultSet getAnswers = null;
			ResultSet getnumberOfQuestions = null;
			int QuestionNum = 0;

			resultset = statement1
					.executeQuery("select ExamID from Privilege where UserID= " + userID + " and flag = 1 ;");

			if (resultset.next()) {
				examId = resultset.getString("ExamID");
			}

			int QuestionId = 0;
			String QuestionText = null;
			int answerID = 0;
			String answerText = null;
			int correctAnswer = 0;
			getExamName = statement2.executeQuery("select ExamName from Exams where ExamID=" + examId);
			getnumberOfQuestions = statement5.executeQuery("select QuestionsNumber from Exams where ExamID=" + examId);

			if (getnumberOfQuestions.next()) {
				QuestionNum = getnumberOfQuestions.getInt("QuestionsNumber");
			}

			getQuestions = statement3.executeQuery("select top " + QuestionNum
					+ " QuestionID, QuestionText from Questions where ExamID=" + examId + "Order by NEWID()");
			request.getSession().setAttribute("userExamId", examId);
			while (getQuestions.next()) {
				Question objQuestion = new Question();
				objQuestion.setID(getQuestions.getInt("QuestionID"));
				objQuestion.setText(getQuestions.getString("QuestionText"));

				getAnswers = statement4
						.executeQuery("select AnswerID, AnswerText,correctAnswer from answers where QuestionId= "
								+ objQuestion.getID() + "Order by NEWID()");
				List<Answers> answersList = new ArrayList<Answers>();
				while (getAnswers.next()) {
					Answers objAnswer = new Answers();
					objAnswer.setAID(getAnswers.getInt("AnswerID"));
					objAnswer.setAnswerText(getAnswers.getString("AnswerText"));
					objAnswer.setIsCorrect(getAnswers.getInt("correctAnswer"));
					answersList.add(objAnswer);
				}

				objQuestion.SetAnswers(answersList);
				questionsList.add(objQuestion);

				objQ = questionsList.get(0);
			}

// Set the retrieved the questions and their corresponding answers from the database in QList and
//store the list in a session  
			request.getSession().setAttribute("QList", questionsList);

		} catch (Exception e) {
			e.printStackTrace();
		}

		// Redirect the user to Exam.jsp page where the students do their exam.
		response.sendRedirect("Exam.jsp");
	}
}