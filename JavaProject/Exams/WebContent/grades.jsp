<%@ page import="dbConnect.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>



<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>

<%
	//allow access only if session exists
	String Role = (String) session.getAttribute("Role");
	if (session.getAttribute("user") == null) {
		response.sendRedirect("Login.jsp");
	} else {
		if (Role.equals("1")) {
			response.sendRedirect("Admin.jsp");
		}
	}
%>
<%
	List<Question> questionsList = (List<Question>) request.getSession().getAttribute("QList");
	int countCorrect = 0;
	int countWrong = 0;

	// count correct and wrong answers
	for (int i = 0; i < questionsList.size(); i++) {
		if (questionsList.get(i).isResult() == true) {
			countCorrect++;
		} else
			countWrong++;
	}
	double totalMark = 0;
	double grades = 0;
	String EID = (String) session.getAttribute("userExamId");
	String userId = (String) session.getAttribute("userID");
	DBConnection c = new DBConnection();
	Connection con = null;
	con = c.getConnection();
	Statement statement = con.createStatement();
	ResultSet markSet = null;
	markSet = statement.executeQuery("Select TotalMark from Exams where ExamID= " + EID);
	if (markSet.next()) {
		totalMark = markSet.getInt("TotalMark");
	}

	// Calculate the grade of the exam
	grades = (double) countCorrect / (double) questionsList.size() * (double) totalMark;
	String gradeValue = String.format("%.2f", grades);
	String TotalValue = String.format("%.2f", totalMark);
	// Insert grades to grade table
	PreparedStatement insertGrade = con
			.prepareStatement("Insert into Grade (StudentID, ExamId, grades) values(?,?,?)");

	insertGrade.setString(1, userId);
	insertGrade.setString(2, EID);
	insertGrade.setString(3, gradeValue);
	insertGrade.execute();
	// Change the privilege of the user on the exam to 0
	PreparedStatement updatePrivilege = con
			.prepareStatement("update privilege set Flag=? where UserID=? and ExamId=? ");
	updatePrivilege.setInt(1, 0);
	updatePrivilege.setString(2, userId);
	updatePrivilege.setString(3, EID);
	updatePrivilege.execute();
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Student Home Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href="StudentStyle.css" rel="stylesheet">
<link href="resultStyle.css" rel="stylesheet">


</head>


<body>

	<nav class="navbar navbar-light" style="background-color: #eee7ef;">
		<div class="container-fluid">
			<div class="navbar-header">
				<img src="/static/HomePage.jpg" height="40px" width="40px">
			</div>
			<div class="collapse navbar-collapse navbar-light " id="myNavbar"
				style="background-color: #eee7ef;">
				<ul class="nav navbar-nav navbar-light"
					style="background-color: #eee7ef;">
					<li class="active"><a href="StudentHome.jsp">Home</a></li>
					<li><a href="#">Exams Table</a></li>
					<li><a href="StudentGrade.jsp">Grades</a></li>
					<li><a href="StudentExam.jsp">Exams </a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="username"><%=session.getAttribute("userName")%></li>
					<li><a href="Logout.jsp"><span
							class="glyphicon glyphicon-log-out"></span> Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm-2 sidenav">
				<img src="/static/grades.jpg" style="width: 400px; height: 400px">


			</div>
			<div Style="margin-left: 250px; margin-top: 150px; font-size: 30px;">
				<label Style="color: #337ab7; font-weight: bold;"> Grade : <%=gradeValue%>
					/ <%=TotalValue%>
				</label> </br> <label Style="color: green; font-weight: bold;"> Correct
					Answers : <%=countCorrect%>
				</label></br> <label Style="color: red; font-weight: bold;"> Wrong
					Answers: <%=countWrong%>
				</label> </br>

			</div>
		</div>
	</div>

</body>
</html>
